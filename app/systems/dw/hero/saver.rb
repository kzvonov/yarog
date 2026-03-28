# frozen_string_literal

module Dw
  module Hero
    class Saver
      INPUT = [
        # :name,
        # :klass,
        # :origin,
        :level,
        :xp,
        :hp_current,
        :armor,
        :damage,
        :coins,
        *::Hero::STATS.values.flat_map do
          [
            "stat_#{it}",
            "deb_#{it}"
          ]
        end,
        :weapons,
        :equipment,
        :bonds,
        :notes,
        :look,
        { moves: [ :name, :desc ] }
      ]

      def call(hero, params)
        input_data = params.to_h.deep_symbolize_keys
        current_data = hero.data.merge(
          level: hero.level,
          xp: hero.xp,
          hp_current: hero.hp_current
        )
        diff = deep_diff(current_data, input_data)
        return [ hero, nil ] if diff.empty?

        updates = extract_updates_from_diff(diff)
        log = ApplicationRecord.transaction do
          hero.update!(updates)
          hero.logs.create!(
            log_type: "hero_change",
            data: diff.to_json
          )
        end
        [ hero, log ]
      end

      def deep_diff(old_data, new_data, prefix = nil)
        diff = {}
        to_ignore = [ nil, "", false ]

        new_data.each do |key, new_value|
          old_value = old_data[key]
          current_key = prefix ? "#{prefix}.#{key}" : key

          if old_value.is_a?(Hash) && new_value.is_a?(Hash)
            nested_diff = deep_diff(old_value, new_value, current_key)
            diff.merge!(nested_diff)
          elsif old_value.is_a?(Array) && new_value.is_a?(Array)
            if old_value != new_value
              diff[current_key] = { "old" => old_value, "new" => new_value }
            end
          elsif to_ignore.include?(old_value) && to_ignore.include?(new_value)
            next
          elsif  old_value.to_s != new_value.to_s
            diff[current_key] = { "old" => old_value, "new" => new_value }
          end
        end

        diff
      end

      def extract_updates_from_diff(diff)
        diff.map do |key, value|
          [ key, value["new"] ]
        end.to_h
      end
    end
  end
end
