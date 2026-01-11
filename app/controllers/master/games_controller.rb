module Master
  class GamesController < BaseController
    before_action :set_game, only: [ :show, :edit, :update, :destroy, :add_hero, :update_notes ]

    def index
      @games = Game.order(created_at: :desc)
    end

    def show
      @heroes = @game.heroes.includes(:game_heroes).order("game_heroes.game_index")
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

    def add_hero
      result = @game.add_hero_by_code(params[:hero_code])

      if result[:success]
        # Broadcast update to game view via Turbo Stream
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.append(
              "game_heroes",
              partial: "master/games/hero_card",
              locals: { hero: result[:hero], game: @game }
            )
          end
          format.html { redirect_to master_game_path(@game), notice: "Hero added to game." }
        end
      else
        redirect_to master_game_path(@game), alert: result[:error]
      end
    end

    def update_notes
      if @game.update(notes: params[:notes])
        head :ok
      else
        head :unprocessable_entity
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
