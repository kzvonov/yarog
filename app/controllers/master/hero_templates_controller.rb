module Master
  class HeroTemplatesController < BaseController
    before_action :hero_template, except: [ :index, :new ]

    def index
      @templates = HeroTemplate.order(id: :desc)
    end

    def show
    end

    def new
    end

    def create
    end

    def update
    end

    def destroy
    end

    def hero_template
      @hero_template = HeroTemplate.find(params[:id])
    end

    def hero_template_params
      params.require(:hero_template).permit() # todo: add params
    end
  end
end
