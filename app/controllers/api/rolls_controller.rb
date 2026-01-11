module Api
  class RollsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # POST /api/roll
    def create
      code = params[:code]
      dice = params[:dice]

      hero = Hero.find_by(code: code)

      unless hero
        return render json: {
          status: "error",
          message: "Герой не найден"
        }, status: :not_found
      end

      # Parse dice notation (e.g., "2d6", "d10")
      match = dice.match(/(\d*)d(\d+)/)
      unless match
        return render json: {
          status: "error",
          message: "Неверный формат кубика"
        }, status: :bad_request
      end

      count = match[1].present? ? match[1].to_i : 1
      sides = match[2].to_i

      # Roll dice
      rolls = count.times.map { rand(1..sides) }
      total = rolls.sum

      # Create log entry
      log = hero.logs.create!(
        log_type: "dice_roll",
        data: {
          dice: dice,
          rolls: rolls,
          total: total
        }.to_json
      )

      # Broadcast to DM dashboard
      broadcast_roll(hero, log)

      render json: {
        status: "ok",
        dice: dice,
        rolls: rolls,
        total: total
      }
    rescue => e
      Rails.logger.error("Error rolling dice: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))

      render json: {
        status: "error",
        message: "Ошибка броска"
      }, status: :internal_server_error
    end

    private

    def broadcast_roll(hero, log)
      # Reload hero to ensure fresh data (including new log)
      hero.reload

      # Broadcast via Turbo Stream to all games this hero belongs to
      hero.games.each do |game|
        # Replace entire hero card to update logs and log count
        Turbo::StreamsChannel.broadcast_replace_to(
          "game_#{game.id}",
          target: "hero_card_#{hero.id}",
          partial: "master/games/hero_card",
          locals: { hero: hero, game: game }
        )
      end
    end
  end
end
