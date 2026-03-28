module Api
  class HeroesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def load
      hero = Hero.find_by(code: params[:code])
      if hero
        render json: {
          status: "ok",
          version: hero.version,
          hero: Dw::Hero::Serializer.new.call(hero),
          updatedAt: hero.updated_at.iso8601
        }
      else
        render json: {
          status: "error",
          message: "Герой не найден"
        }, status: :not_found
      end
    end

    def save
      hero = Hero.find_by(code: params[:code].to_s)
      if hero.nil?
        return render json: {
          status: "error",
          message: "Герой не найден"
        }, status: :not_found
      end

      client_version = params[:version].to_i
      if client_version != hero.version
        return render json: {
          status: "conflict",
          version: hero.version,
          hero: Dw::Hero::Serializer.new.call(hero),
          updatedAt: hero.updated_at.iso8601
        }, status: :conflict
      end

      hero, log = Dw::Hero::Saver.new.call(hero, hero_params)
      broadcast_hero_update(hero, log) if log

      render json: {
        status: "ok",
        version: hero.version,
        hero: Dw::Hero::Serializer.new.call(hero),
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
      hero.games.each do |game|
        Turbo::StreamsChannel.broadcast_replace_to(
          "game_#{game.id}",
          target: "hero_card_#{hero.id}",
          partial: "master/games/hero_card",
          locals: { hero: hero, game: game }
        )
      end
    end

    def hero_params
      params.require(:hero).permit(*Dw::Hero::Saver::INPUT)
    end
  end
end
