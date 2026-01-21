module Api
  class PartyController < ApplicationController
    skip_before_action :verify_authenticity_token

    # GET /api/party
    def show
      code = params[:code]

      hero = Hero.find_by(code: code)

      unless hero
        return render json: {
          status: "error",
          message: "Hero not found"
        }, status: :not_found
      end

      # Find the active game that contains this hero
      active_game = hero.games.find_by(active: true)

      unless active_game
        return render json: {
          status: "ok",
          party: []
        }
      end

      # Get all heroes in the active game
      party = active_game.heroes.includes(:game_heroes).order("game_heroes.game_index")
      party_data = party.map do |member|
        hero_data = member.hero_data || {}
        {
          name: member.name,
          specialization: I18n.t("hero.spec.#{member.specialization}", default: member.specialization.humanize),
          level: member.level,
          hpCurrent: hero_data["hpCurrent"] || 10,
          hpMax: hero_data["hpMax"] || 10,
          armor: hero_data["armor"] || 0,
          damage: hero_data["damage"] || "d10"
        }
      end

      render json: {
        status: "ok",
        party: party_data,
        gameName: active_game.name
      }
    end
  end
end
