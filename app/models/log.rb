class Log < ApplicationRecord
  belongs_to :hero, class_name: "Hero", foreign_key: "hero_id", optional: false

  LOG_TYPES = %w[dice_roll hero_change].freeze

  validates :log_type, presence: true, inclusion: { in: LOG_TYPES }
  validates :data, presence: true

  # Parse data as JSON
  def log_data
    @log_data ||= JSON.parse(data)
  end

  def log_data=(hash)
    @log_data = hash
    self.data = hash.to_json
  end

  # Format log entry for display
  def formatted_message
    case log_type
    when "dice_roll"
      format_dice_roll
    when "hero_change"
      format_hero_change
    else
      "Unknown log type"
    end
  end

  private

  def format_dice_roll
    roll_data = log_data
    dice = roll_data["dice"]
    rolls = roll_data["rolls"]
    total = roll_data["total"]

    if rolls.size == 1
      "🎲 Rolled #{dice}: #{total}"
    else
      "🎲 Rolled #{dice}: #{rolls.join(' + ')} = #{total}"
    end
  end

  def format_hero_change
    changes = log_data
    return "Hero data updated" if changes.empty?

    # Text fields that should be displayed vertically with preserved formatting
    text_fields = %w[condition notes weapons equipment look origin]

    formatted_changes = changes.map do |field, change|
      old_val = change["old"]
      new_val = change["new"]

      # Check if this is a text field (remove the nested key part for comparison)
      base_field = field.split(".").first

      if text_fields.include?(base_field)
        # Vertical format for text fields with <pre> to preserve formatting
        escaped_old = ERB::Util.html_escape(old_val.to_s)
        escaped_new = ERB::Util.html_escape(new_val.to_s)
        "#{field}:<pre>#{escaped_old}</pre> -> <pre>#{escaped_new}</pre>"
      else
        # Inline format for short fields
        "#{field}: #{old_val} → #{new_val}"
      end
    end

    "📝 #{formatted_changes.join(', ')}"
  end
end
