module Api
  class GamesController < ApplicationController
    skip_before_action :verify_authenticity_token

    before_action :preload_hero
    before_action :preload_game

    # GET /api/game/party
    def party
      unless @game
        return render json: {
          status: "ok",
          party: []
        }
      end

      party = @game.heroes.includes(:game_heroes).where.not(id: @hero.id).order("game_heroes.game_index")
      party_data = party.map do |member|
        {
          name: member.name,
          klass: I18n.t("hero.klass.#{member.klass}", default: member.klass.humanize),
          origin: I18n.t("hero.origin.#{member.origin}", default: member.origin.humanize),
          level: member.level,
          hp_current: member.hp_current || 10,
          hp_max: member.hp_max || 10,
          armor: member.armor || 0,
          damage: member.damage || "d6"
        }
      end

      render json: {
        status: "ok",
        party: party_data,
        game_name: @game.name
      }
    end

    # GET /api/game/logs
    # Params:
    #   - code: hero code (required)
    #   - after_id: get logs with id > after_id (optional, for polling new logs)
    #   - before_id: get logs with id < before_id (optional, for pagination)
    #   - limit: number of logs to return (default: 20, max: 50)
    def logs
      unless @game
        return render json: {
          status: "ok",
          logs: [],
          has_more: false
        }
      end

      after_id = params[:after_id]&.to_i
      before_id = params[:before_id]&.to_i
      limit = [ params[:limit]&.to_i || 20, 50 ].min

      query = @game.logs.includes(:hero)

      if after_id
        query = query.where("logs.id > ?", after_id).order(id: :asc)
      elsif before_id
        query = query.where("logs.id < ?", before_id).order(id: :desc)
      else
        query = query.order(id: :desc)
      end

      logs = query.limit(limit + 1).to_a
      has_more = logs.size > limit
      logs = logs.first(limit)

      logs.reverse! if after_id

      logs_data = logs.map do |log|
        {
          id: log.id,
          hero_name: log.hero.name,
          log_type: log.log_type,
          data: JSON.parse(log.data),
          created_at: log.created_at.iso8601
        }
      end

      render json: {
        status: "ok",
        logs: logs_data,
        has_more: has_more
      }
    rescue => e
      Rails.logger.error("Error fetching game logs: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))

      render json: {
        status: "error",
        message: "Error fetching logs"
      }, status: :internal_server_error
    end

    private

    def preload_hero
      code = params[:code]
      @hero = Hero.find_by(code: code)

      unless @hero
        render json: {
          status: "error",
          message: "Hero not found"
        }, status: :not_found
        throw :abort
      end
    end

    def preload_game
      return unless @hero

      @game = @hero.games.find_by(active: true)
    end
  end
end
