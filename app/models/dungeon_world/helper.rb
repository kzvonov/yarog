module DungeonWorld
  module Helper
    module_function

    def stat_modifier(stat_value)
      case stat_value
      when ..3 then -3
      when 4..5 then -2
      when 6..8 then -1
      when 9..12 then 0
      when 13..15 then 1
      when 16..17 then 2
      else 3
      end
    end
  end
end
