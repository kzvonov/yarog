# frozen_string_literal

module Dw
  module Hero
    class Serializer
      SCHEMA = [
        :hp_current,
        :hp_max,
        :damage,
        :armor,
        :coins,
        :weapons,
        :equipment,
        :bonds,
        :notes,
        :look,
        :moves,
        *::Hero::STATS.values.flat_map do
          [
            "stat_#{it}",
            "deb_#{it}",
            "dice_mod_#{it}"
          ]
        end
      ]

      def call(obj)
        {
          name: obj.name,
          origin: I18n.t("hero.origin.#{obj.origin}", default: obj.origin.humanize),
          klass: I18n.t("hero.klass.#{obj.klass}", default: obj.klass.humanize),
          level: obj.level,
          xp: obj.xp
        }.merge(SCHEMA.to_h { [ it, obj.send(it) ] })
      end
    end
  end
end
