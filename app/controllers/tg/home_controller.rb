module Tg
  class HomeController < Tg::BaseController
    allow_unauthenticated_access only: [ :index, :auth ]
    before_action :skip_if_authenticated, only: [ :index, :auth ]

    def index
      @test = params["test"] == "ok"
    end

    def auth
      # TODO: spec for this path
      init_data = params["init_data"].to_s
      if params["test"]
        init_data = "query_id=AAHZfRIEAAAAANl9EgQncsiO&user=%7B%22id%22%3A68320729%2C%22first_name%22%3A%22Kirill%22%2C%22last_name%22%3A%22%22%2C%22username%22%3A%22kzvonov%22%2C%22language_code%22%3A%22en%22%2C%22is_premium%22%3Atrue%2C%22allows_write_to_pm%22%3Atrue%2C%22photo_url%22%3A%22https%3A%5C%2F%5C%2Ft.me%5C%2Fi%5C%2Fuserpic%5C%2F320%5C%2FuOBzKTWPG77Bdp3e8IdAdjmg6G3FmfWAzI98vla4kPg.svg%22%7D&auth_date=1778051912&signature=R-FGTkTlGVoNHuAaUjdzWficgFfUAVOjHvXXGmAooiyL35Q-TV4dc20GTuILtmgHC4vvSKO7HhbnKnOsQw6JBQ&hash=a43c968d191caf245a835bb294d5f8f75a0da78651cf6d965c85139aa7cbb6ed"
      end

      # TODO: validate expiry
      @result = Tg::Auth.validate(init_data)
      render :index and return if @result.invalid?

      # TODO: what to do if the below fails?
      identity = Identity.find_or_create_from_auth!("telegram", @result.user_data["id"], @result.user_data)
      # TODO: i think we should start the new session based on identity
      start_new_session_for(identity.account)
      redirect_to tg_account_path
    end

    def logout
      terminate_session
      redirect_to :index
    end

    private

    def skip_if_authenticated
      redirect_to tg_account_path if authenticated?
    end
  end
end
