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

      # Allow all hero_data params since it's stored as JSON
      hero_params = params.require(:hero).permit!

      # Build updated hero_data
      current_data = @hero.hero_data || {}
      new_data = current_data.deep_merge(hero_params[:hero_data].to_h)

      # Update hero_data (this sets the JSON data field)
      @hero.hero_data = new_data

      # Update level and xp from the new data
      @hero.level = hero_params[:level] if hero_params[:level].present?
      @hero.xp = hero_params[:xp] if hero_params[:xp].present?

      # For master interface, allow name changes by skipping validation
      if hero_params[:name].present? && hero_params[:name] != @hero.name
        @hero.name = hero_params[:name]
        @hero.save(validate: false) # Skip immutable_fields validation for DM
      else
        @hero.save
      end

      if @hero.persisted?
        head :ok
      else
        head :unprocessable_entity
      end
    end
  end
end
