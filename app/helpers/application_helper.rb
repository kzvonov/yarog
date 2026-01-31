module ApplicationHelper
  def stat_modifier(value, debility: false)
    mod = cacl_modifier(value)

    mod -= 1 if debility
    return mod if mod.zero?

    mod.positive? ? "+#{mod}" : mod.to_s
  end

  def cacl_modifier(value)
    case value.to_i
    when ..3
      -3
    when 4..5
      -2
    when 6..8
      -1
    when 9..12
      0
    when 13..15
      1
    when 16..18
      2
    else
      3
    end
  end

  # Debility names in Russian
  DEBILITY_NAMES = {
    "str" => "\u0421\u043B\u0430\u0431",
    "dex" => "\u0422\u0440\u044F\u0441\u0451\u0442\u0441\u044F",
    "con" => "\u0411\u043E\u043B\u0435\u043D",
    "int" => "\u041E\u0433\u043B\u0443\u0448\u0451\u043D",
    "wis" => "\u0420\u0430\u0441\u0442\u0435\u0440\u044F\u043D",
    "cha" => "\u0422\u0440\u0430\u0432\u043C\u0438\u0440\u043E\u0432\u0430\u043D"
  }.freeze
end
