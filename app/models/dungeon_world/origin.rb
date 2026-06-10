module DungeonWorld
  module Origin
    HUMAN = {
      vitals: {
        coins: 50
      },
      abilities: [
        "racial:human",
        "lang:common"
      ],
      inventory: {
        weapons: [],
        equipment: [ "adventuring_gear" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    DWARF = {
      vitals: {
        coins: 60
      },
      abilities: [
        "racial:dwarf",
        "lang:dwarf",
        "lang:common"
      ],
      inventory: {
        weapons: [],
        equipment: [ "mining_tools" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    ELF = {
      vitals: {
        coins: 45
      },
      abilities: [
        "racial:elf",
        "lang:elf",
        "lang:common"
      ],
      inventory: {
        weapons: [],
        equipment: [ "elven_cloak" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    DARK_ELF = {
      vitals: {
        coins: 40
      },
      abilities: [
        "racial:dark_elf",
        "lang:elf",
        "lang:undercommon"
      ],
      inventory: {
        weapons: [],
        equipment: [ "shadow_cloak" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    HIGH_ELF = {
      vitals: {
        coins: 70
      },
      abilities: [
        "racial:high_elf",
        "lang:elf",
        "lang:common"
      ],
      inventory: {
        weapons: [],
        equipment: [ "elven_book" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    GNOME = {
      vitals: {
        coins: 55
      },
      abilities: [
        "racial:gnome",
        "lang:gnome",
        "lang:common"
      ],
      inventory: {
        weapons: [],
        equipment: [ "tinker_tools" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    ORC = {
      vitals: {
        coins: 25
      },
      abilities: [
        "racial:orc",
        "lang:orc"
      ],
      inventory: {
        weapons: [],
        equipment: [ "tribal_trophy" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    TROLL = {
      vitals: {
        coins: 15
      },
      abilities: [
        "racial:troll",
        "lang:troll"
      ],
      inventory: {
        weapons: [],
        equipment: [ "bone_club" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    GOBLIN = {
      vitals: {
        coins: 20
      },
      abilities: [
        "racial:goblin",
        "lang:goblin",
        "lang:common"
      ],
      inventory: {
        weapons: [],
        equipment: [ "stolen_trinket" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    TAUREN = {
      vitals: {
        coins: 35
      },
      abilities: [
        "racial:tauren",
        "lang:tauren",
        "lang:common"
      ],
      inventory: {
        weapons: [],
        equipment: [ "tribal_totem" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    TIEFLING = {
      vitals: {
        coins: 40
      },
      abilities: [
        "racial:tiefling",
        "lang:common",
        "lang:infernal"
      ],
      inventory: {
        weapons: [],
        equipment: [ "infernal_charm" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    FROG_FOLK = {
      vitals: {
        coins: 30
      },
      abilities: [
        "racial:frog_folk",
        "lang:frog"
      ],
      inventory: {
        weapons: [],
        equipment: [ "fishing_net" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    TURTLE_FOLK = {
      vitals: {
        coins: 35
      },
      abilities: [
        "racial:turtle_folk",
        "lang:turtle"
      ],
      inventory: {
        weapons: [],
        equipment: [ "shell_polish" ]
      },
      story: {
        bonds: "",
        alignment: "",
        looks: "",
        notes: ""
      }
    }.freeze

    # Homebrew Yar setting races
    # YAR_HUMAN = {
    #   vitals: {
    #     coins: 10
    #   },
    #   abilities: [
    #     "racial:yar_human",
    #     "lang:yar",
    #     "lang:common"
    #   ],
    #   inventory: {
    #     weapons: [],
    #     equipment: ["yar_survival_kit"]
    #   },
    #   story: {
    #     bonds: "",
    #     alignment: "",
    #     looks: "",
    #     notes: ""
    #   }
    # }.freeze

    # YAR_DOG_FOLK = {
    #   vitals: {
    #     coins: 10
    #   },
    #   abilities: [
    #     "racial:yar_dog_folk",
    #     "lang:yar"
    #   ],
    #   inventory: {
    #     weapons: [],
    #     equipment: ["pack_marker"]
    #   },
    #   story: {
    #     bonds: "",
    #     alignment: "",
    #     looks: "",
    #     notes: ""
    #   }
    # }.freeze

    # YAR_ELF = {
    #   vitals: {
    #     coins: 10
    #   },
    #   abilities: [
    #     "racial:yar_elf",
    #     "lang:yar",
    #     "lang:common"
    #   ],
    #   inventory: {
    #     weapons: [],
    #     equipment: ["forest_charm"]
    #   },
    #   story: {
    #     bonds: "",
    #     alignment: "",
    #     looks: "",
    #     notes: ""
    #   }
    # }.freeze

    module_function

    def list
      constants.map(&:downcase).map(&:to_s).sort
    end

    def enum
      list.to_h { [ it, it ] }
    end

    def for_select
      list.map { [ I18n.t("dungeon_world.origin.#{it}"), it ] }
    end

    def get_template(klass)
      const_name = klass.to_s.upcase.to_sym
      raise "no such klass #{const_name} defined" unless constants.include?(const_name)

      const_get(const_name)
    end
  end
end
