class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    redirect_to account_path if authenticated?
  end

  def create
    redirect_to new_session_path, alert: "Authentication method not implemented yet."
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
