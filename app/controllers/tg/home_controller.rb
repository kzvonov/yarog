module Tg
  class HomeController < Tg::BaseController
    def index; end

    def auth
      @result = Tg::Auth.validate(params["init_data"].to_s)
      pp @result
      redirect_to tg_account_path and return if @result.valid?

      render :index
    end
  end
end
