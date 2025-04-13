namespace :telegram do
  desc "run Telegram bot polling process"
  task run_bot: :environment do
    require "telegram/bot"

    # Trap SIGTERM and SIGINT to gracefully shut down the bot
    %w[INT TERM].each do |sig|
      Signal.trap(sig) do
        puts "Exiting..."
        exit
      end
    end

    puts "Starting Telegram bot polling..."
    token = Rails.application.credentials.telegram.bot_token!

    Telegram::Bot::Client.run(token, logger: Logger.new($stdout)) do |bot|
      bot.listen do |message|
        Telegram::MessageProcessor.call(bot, message)
      end
    end
  end
end
