class TurnTracker < ApplicationRecord
  belongs_to :game, foreign_key: "game_session_id"
  belongs_to :current_character, class_name: "Character", optional: true

  validates :turn_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  attribute :turn_number, :integer, default: 0
  attribute :day_number, :integer, default: 1

  # Get the next character in turn order
  def next_character
    characters = game.characters.order(:id)
    return nil if characters.empty?

    current_index = current_character.present? ? characters.index(current_character) : -1
    next_index = (current_index + 1) % characters.size

    characters[next_index]
  end

  # Advance to the next turn
  def advance_turn
    next_char = next_character

    if next_char == game.characters.order(:id).first
      self.turn_number += 1

      # New day if we've had 3 turn cycles (each character has had 3 turns)
      if turn_number > 0 && (turn_number % (game.characters.count * 3)) == 0
        self.day_number += 1

        # Reset eating and sleeping status for new day
        game.characters.update_all(has_eaten: false, has_slept: false)
      end
    end

    self.current_character = next_char
    save
  end

  # Is it night time?
  def night?
    # Night is the last third of turns in a day
    turn_cycle_position = turn_number % (game.characters.count * 3)
    turn_cycle_position >= (game.characters.count * 2)
  end
end
