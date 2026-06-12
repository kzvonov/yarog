class AccountController < ApplicationController
  def index
    @account = Current.session.account
  end

  def update
    @account = Current.session.account
    @account.update(input_params)
    if @account.invalid?
      # TODO: support errors
      render :index
    else
      flash[:success] = "settings are saved"
      redirect_to account_path
    end
  end

  private

  def input_params
    params.require(:account).permit(:locale, :theme)
  end
end
