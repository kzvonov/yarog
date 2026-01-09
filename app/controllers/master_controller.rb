class MasterController < ApplicationController
  http_basic_authenticate_with name: ENV.fetch("DM_USERNAME", "dm"), password: ENV.fetch("DM_PASSWORD", "password")

  def index
    @heroes = Hero.includes(:logs).order(created_at: :desc)
  end

  def add_hero
    code = params[:code]&.strip

    if code.blank?
      flash[:error] = "Код героя не может быть пустым"
      redirect_to master_path
      return
    end

    hero = Hero.find_by(code: code)

    if hero
      flash[:success] = "Герой #{hero.name} (#{hero.code}) уже существует"
    else
      flash[:error] = "Герой с кодом #{code} не найден. Герой будет добавлен при первом сохранении с клиента."
    end

    redirect_to master_path
  end
end
