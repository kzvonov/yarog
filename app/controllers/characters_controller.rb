class CharactersController < Tg::BaseController
  def index
    @characters = Current.account.characters.select(:id, :type, :origin, :klass, :name).order(id: :desc)
  end

  def show
    @character = Current.account.characters.find(params[:id])
    # TODO: move somewhere to DW related
    @dw_content_src = cookies[:dw_content_src] || dw_moves_path(character_param: @character)

    render @character.show_view
  end

  def new
    character_type = GameSystems.character_type(params[:system])
    @character = Character.new(type: character_type)
  end

  def create
    @character = Character.new(input_params)
    @character.account = Current.account
    @character.forge
    Rails.logger.info("#{@character.valid?}  #{@character.errors.map(&:full_message)}")
    if @character.valid? && @character.save
      redirect_to character_path(@character)
    else
      render :new
    end
  end

  private

  def input_params
    params.require(:character).permit(:type, :name, :klass, :origin).tap do |params|
      params[:origin] = params[:origin].to_sym
      params[:klass] = params[:klass].to_sym
    end
  end
end
