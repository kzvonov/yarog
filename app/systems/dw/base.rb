module Dw
  module Base
    CHAR_MIN = 1
    CHAR_MAX = 18
    MODIFIERS = {
      1..3 => -3,
      4..5 => -2,
      6..8 => -1,
      9..12 => 0,
      13..15 => 1,
      16..18 => 2,
      18 => 3
    }.freeze

    def self.modifier(stat)
      stat = stat.to_i.abs.clamp(CHAR_MIN, CHAR_MAX)

      MODIFIERS.each do |range, mod|
        return mod if range.include?(stat)
      end
      0
    end
  end
end
