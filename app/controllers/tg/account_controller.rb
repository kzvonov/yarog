module Tg
  class AccountController < Tg::BaseController
    def index
      @account = Current.session.account
    end
  end
end
