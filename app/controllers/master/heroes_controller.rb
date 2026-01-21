module Master
  class HeroesController < BaseController
    def index
      @heroes = Hero.order(created_at: :desc)

      # Simple search by code, name, or specialization (lowercase exact match)
      if params[:search].present?
        search_term = params[:search].downcase
        @heroes = @heroes.where(
          "LOWER(code) = ? OR LOWER(name) = ? OR LOWER(specialization) = ?",
          search_term, search_term, search_term
        )
      end
    end

    def show
      @hero = Hero.find(params[:id])
      @games = @hero.games.order(created_at: :desc)
    end

    def update
      @hero = Hero.find(params[:id])

      # Extract hero_data fields
      hero_data_params = params.require(:hero).permit(
        :name, :level, :xp,
        :hpCurrent, :hpMax, :armor, :damage, :coins,
        :look, :weapons, :equipment, :bonds, :notes,
        stats: {}, debilities: {}, moves: [ :name, :desc ]
      )

      # Build updated hero_data
      current_data = @hero.hero_data || {}

      # Update hero_data with all fields
      new_data = current_data.merge({
        "hpCurrent" => hero_data_params[:hpCurrent],
        "hpMax" => hero_data_params[:hpMax],
        "armor" => hero_data_params[:armor],
        "damage" => hero_data_params[:damage],
        "coins" => hero_data_params[:coins],
        "look" => hero_data_params[:look],
        "weapons" => hero_data_params[:weapons],
        "equipment" => hero_data_params[:equipment],
        "bonds" => hero_data_params[:bonds],
        "notes" => hero_data_params[:notes],
        "stats" => hero_data_params[:stats] || {},
        "debilities" => hero_data_params[:debilities] || {},
        "moves" => hero_data_params[:moves] || []
      }.compact)

      @hero.hero_data = new_data
      @hero.level = hero_data_params[:level] if hero_data_params[:level].present?
      @hero.xp = hero_data_params[:xp] if hero_data_params[:xp].present?

      # For master interface, allow name changes by skipping validation
      if hero_data_params[:name].present? && hero_data_params[:name] != @hero.name
        @hero.name = hero_data_params[:name]
        @hero.save(validate: false)
      else
        @hero.save
      end

      if @hero.persisted?
        redirect_to master_hero_path(@hero), notice: "Hero updated successfully."
      else
        @games = @hero.games.order(created_at: :desc)
        flash.now[:alert] = "Failed to update hero."
        render :show
      end
    end
  end
end
