module ApplicationHelper
  # Calculate DW ability modifier (same logic as in hero.html)
  def stat_modifier(value, debility = false)
    base_mod = if value <= 3
                 -3
               elsif value <= 5
                 -2
               elsif value <= 8
                 -1
               elsif value <= 12
                 0
               elsif value <= 15
                 1
               elsif value <= 17
                 2
               else
                 3
               end

    mod = debility ? base_mod - 1 : base_mod
    mod >= 0 ? "+#{mod}" : mod.to_s
  end

  # Debility names in Russian
  DEBILITY_NAMES = {
    'str' => 'Слаб',
    'dex' => 'Трясётся',
    'con' => 'Болен',
    'int' => 'Оглушён',
    'wis' => 'Растерян',
    'cha' => 'Травмирован'
  }.freeze
end
