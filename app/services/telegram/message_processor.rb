module Telegram
  module MessageProcessor
    class << self
      def call(bot, message)
        begin
          # Find or create user
          user = User.find_or_create_by(telegram_id: message.from.id) do |u|
            u.first_name = message.from.first_name
            u.last_name = message.from.last_name
            u.username = message.from.username
          end

          # Process the command
          result = process_message(bot, user, message)

          # Log the result
          puts "Processed message from #{user.username || user.first_name}: #{result}"
        rescue => e
          # TODO: log error
          puts "Error processing message: #{e.message}"
          puts e.backtrace.join("\n")
        end
      end

      def process_message(bot, user, message)
        return unless message.is_a?(Telegram::Bot::Types::Message)
        return unless message.text

        chat_id = message.chat.id
        text = message.text

        command, *args = text.split

        response = case command
        when "/start"
            "Welcome to the D&D Telegram Bot! You can create a new game with /create_game [name] or join an existing game with /join [code]."
        when "/help"
            help_text
        when "/create_game"
            create_game(user, args.join(" "))
        when "/join"
            join_game(user, args[0])
        when "/create_character"
            create_character(user, args)
        when "/status"
            game_status(user)
        else
            "Unknown command. Use /help to see available commands."
        end

        bot.api.send_message(chat_id: chat_id, text: response)

        "Sent: #{response}"
      end

      # Helper method to process incoming messages

      def help_text
        <<~HELP
          Available commands:
          /start - Start the bot
          /help - Show this help message
          /create_game [name] - Create a new game session
          /join [code] - Join an existing game
          /create_character [name] [class] - Create a character (warrior, mage, or rogue)
          /status - Check your current game status
        HELP
      end

      def create_game(user, name)
        return "Please provide a game name: /create_game [name]" if name.blank?

        # Generate a unique join code
        code = SecureRandom.alphanumeric(6).upcase

        game = GameSession.create(
          name: name,
          host: user,
          join_code: code,
          status: :waiting,
          progress: :village
        )

        "Game \"#{name}\" created! Share this code with your friends: #{code}"
      end

      def join_game(user, code)
        return "Please provide a game code: /join [code]" unless code

        game = GameSession.find_by(join_code: code.upcase)
        return "Game not found. Check the code and try again." unless game

        "You've joined #{game.name}! Create your character with /create_character [name] [class]"
      end

      def create_character(user, args)
        return "Usage: /create_character [name] [class]" if args.size < 2

        name = args[0]
        character_class = args[1].downcase

        unless %w[warrior mage rogue].include?(character_class)
          return "Invalid class. Choose from: warrior, mage, rogue"
        end

        game = user.game_sessions.where(status: :waiting).last
        return "Join a game first with /join [code]" unless game

        character = Character.create(
          name: name,
          character_class: character_class,
          user: user,
          game_session: game
        )

        "Character #{name} the #{character_class.capitalize} created successfully!"
      end

      def game_status(user)
        game = user.game_sessions.last
        return "You haven't joined any games yet." unless game

        character = user.characters.where(game_session: game).last

        status = "Game: #{game.name}\n"
        status += "Status: #{game.status}\n"
        status += "Location: #{game.progress}\n"

        if character
          status += "\nYour character: #{character.name} the #{character.character_class.capitalize}\n"
          status += "Health: #{character.health}\n"
          status += "Fed: #{character.has_eaten ? 'Yes' : 'No'}\n"
          status += "Rested: #{character.has_slept ? 'Yes' : 'No'}"
        end

        status
      end
    end
  end
end
