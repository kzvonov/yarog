module Api
  class HeroesController < ApplicationController
    skip_before_action :verify_authenticity_token

    # POST /api/heroes/load
    def load
      code = params[:code]

      hero = Hero.find_by(code: code)

      if hero
        render json: {
          status: "ok",
          version: hero.version,
          hero: {
            **hero.hero_data,
            name: hero.name,
            level: hero.level,
            specialization: I18n.t("hero.spec.#{hero.specialization}", default: hero.specialization.humanize),
            xp: hero.xp
          },
          updatedAt: hero.updated_at.iso8601
        }
      else
        render json: {
          status: "error",
          message: "Герой не найден"
        }, status: :not_found
      end
    end

    # POST /api/heroes/save
    def save
      code = params[:code].to_s
      client_version = params[:version].to_i
      hero_data = hero_params.to_h.except("name", "specialization")

      hero = Hero.find_by(code: code)

      if hero.nil?
        return render json: {
          status: "error",
          message: "Герой не найден"
        }, status: :not_found
      end

      if client_version != hero.version
        return render json: {
          status: "conflict",
          version: hero.version,
          hero: hero.hero_data,
          updatedAt: hero.updated_at.iso8601
        }, status: :conflict
      end

      diff = hero.calculate_diff(hero_data)
      if diff.present?
        log = ApplicationRecord.transaction do
          hero.update_hero_data!(hero_data)
          hero.logs.create!(
            log_type: "hero_change",
            data: diff.to_json
          )
        end
        broadcast_hero_update(hero, log)
      end

      render json: {
        status: "ok",
        version: hero.version,
        updatedAt: hero.updated_at.iso8601
      }
    rescue => e
      Rails.logger.error("Error saving hero: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))

      render json: {
        status: "error",
        message: "Ошибка сохранения"
      }, status: :internal_server_error
    end

    private

    def broadcast_hero_update(hero, log)
      # Reload hero to ensure fresh data
      hero.reload

      # Broadcast to game-specific channels
      hero.games.each do |game|
        # Replace entire hero card to update stats and logs
        Turbo::StreamsChannel.broadcast_replace_to(
          "game_#{game.id}",
          target: "hero_card_#{hero.id}",
          partial: "master/games/hero_card",
          locals: { hero: hero, game: game }
        )
      end
    end

    def hero_params
      params.require(:hero).permit(
        :specialization,
        :name,
        :look,
        :origin,
        :level,
        :xp,
        :hpCurrent,
        :hpMax,
        :armor,
        :damage,
        :condition,
        :weapons,
        :equipment,
        :notes,
        stats: [ :str, :dex, :con, :int, :wis, :cha ],
        debilities: [ :str, :dex, :con, :int, :wis, :cha ],
        moves: [ :name, :desc ]
      )
    end
  end
end
