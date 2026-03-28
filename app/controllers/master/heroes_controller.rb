module Master
  class HeroesController < BaseController
    def index
      @heroes = Hero.order(created_at: :desc)

      if params[:search].present?
        search_term = params[:search].downcase
        klass_value = Hero.klasses.keys.find { |k| k.to_s.downcase == search_term }

        if klass_value
          @heroes = @heroes.where(
            "LOWER(code) = ? OR LOWER(name) = ? OR klass = ?",
            search_term, search_term, Hero.klasses[klass_value]
          )
        else
          @heroes = @heroes.where(
            "LOWER(code) = ? OR LOWER(name) = ?",
            search_term, search_term
          )
        end
      end
    end

    def show
      @hero = Hero.find(params[:id])
      @games = @hero.games.order(created_at: :desc)
    end

    def update
      @hero = Hero.find(params[:id])

      hero_params = params.require(:hero).permit(
        :name, :origin, :level, :xp, :hp_current, :armor, :damage, :coins,
        :weapons, :equipment, :notes,
        *Hero::STATS.keys.map { |stat| "stat_#{stat}".to_sym },
        *Hero::STATS.keys.map { |stat| "deb_#{stat}".to_sym },
        moves: [:name, :desc]
      )

      Hero::STATS.keys.each do |stat|
        @hero.send("deb_#{stat}=", false)
      end

      hero_params.each do |key, value|
        if key.to_s.start_with?('deb_')
          value = value == "true" || value == true
        end
        @hero.send("#{key}=", value) if @hero.respond_to?("#{key}=")
      end

      @hero.version += 1

      if @hero.save
        redirect_to master_hero_path(@hero), notice: "Hero updated successfully."
      else
        @games = @hero.games.order(created_at: :desc)
        flash.now[:alert] = "Failed to update hero."
        render :show
      end
    end

    def duplicate
      @original = Hero.find(params[:id])

      @hero = Hero.new(
        name: "Copy of #{@original.name}",
        origin: @original.origin,
        klass: @original.klass,
        level: @original.level,
        xp: @original.xp
      )

      @hero.data = @original.data.deep_dup

      if @hero.save
        redirect_to master_hero_path(@hero), notice: "Hero duplicated successfully. Code: #{@hero.code}"
      else
        redirect_to master_hero_path(@original), alert: "Failed to duplicate hero."
      end
    end

    def destroy
      @hero = Hero.find(params[:id])
      @hero.destroy

      redirect_to master_heroes_path, notice: "Hero '#{@hero.name}' was deleted."
    end
  end
end
