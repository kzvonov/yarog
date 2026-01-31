module Master
  class GamesController < BaseController
    before_action :set_game, only: [ :show, :settings, :edit, :update, :destroy, :manage_hero, :update_notes, :toggle_active ]

    def index
      @games = Game.order(created_at: :desc)
    end

    def show
      @heroes = @game.heroes.includes(:game_heroes).order("game_heroes.game_index")
    end

    def settings
    end

    def new
      @game = Game.new
    end

    def edit
    end

    def create
      @game = Game.new(game_params)

      if @game.save
        redirect_to master_game_path(@game), notice: "Game created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @game.update(game_params)
        redirect_to master_game_path(@game), notice: "Game updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @game.destroy
      redirect_to master_games_path, notice: "Game deleted successfully."
    end

    def manage_hero
      result = if params[:master_action].to_s == "remove"
        @game.remove_hero_by_code(params[:hero_code])
      else
        @game.add_hero_by_code(params[:hero_code])
      end

      if result[:success]
        redirect_to settings_master_game_path(@game), notice: "Hero added to game."
      else
        redirect_to settings_master_game_path(@game), alert: result[:error]
      end
    end

    def update_notes
      if @game.update(notes: params[:notes])
        head :ok
      else
        head :unprocessable_entity
      end
    end

    def toggle_active
      new_state = !@game.active

      if new_state
        # Activate this game and deactivate all other games with shared heroes
        @game.activate!
        redirect_to settings_master_game_path(@game), notice: "Game activated successfully."
      else
        # Deactivate this game
        @game.update(active: false)
        redirect_to settings_master_game_path(@game), notice: "Game deactivated successfully."
      end
    end

    private

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:name, :notes)
    end
  end
end
