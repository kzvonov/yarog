module DungeonWorld
  module Klass
    # -------------------------------------------------------------------------
    # BARD
    # HP: 6+CON  |  Damage: d6  |  Load: 9+STR
    # -------------------------------------------------------------------------
    BARD = {
      vitals: {
        hp_base:     6,
        armor:       1,
        damage:      "d6",
        xp:          0,

        load_base:   9,
        str:         9,
        dex:         13,
        con:         12,
        int:         15,
        wis:         8,
        cha:         16,
        str_debility: 0,
        dex_debility: 0,
        con_debility: 0,
        int_debility: 0,
        wis_debility: 0,
        cha_debility: 0
      },
      abilities: [
        "move:arcane_art",
        "move:bardic_lore",
        "move:charming_and_open",
        "move:port_in_the_storm"
      ],
      advanced_moves: {
        "2-5": [
          "move:healing_song",
          "move:vicious_cacophony",
          "move:it_goes_to_eleven",
          "move:metal_hurlant",
          "move:a_little_help_from_my_friends",
          "move:eldritch_tones",
          "move:duelist_parry",
          "move:bamboozle",
          "move:multiclass_dabbler",
          "move:multiclass_initiate"
        ],
        "6-10": [
          "move:healing_chorus",        # replaces: healing_song
          "move:vicious_blast",         # replaces: vicious_cacophony
          "move:unforgettable_face",
          "move:reputation",
          "move:eldritch_chord",        # replaces: eldritch_tones
          "move:an_ear_for_magic",
          "move:devious",
          "move:duelist_block",         # replaces: duelist_parry
          "move:con",                   # replaces: bamboozle
          "move:multiclass_master"
        ]
      },
      inventory: {
        weapons: [
          "dueling_rapier"              # close, precise, 2 weight
        ],
        equipment: [
          "dungeon_rations",            # 5 uses, 1 weight
          "lute",                       # fine lute, 0 weight for bard
          "leather_armor",              # 1 armor, 1 weight
          "adventuring_gear"            # 1 weight
        ]
      },
      story: {
        bonds:     "",
        alignment: "",                  # Good / Neutral / Chaotic
        looks:     "",
        notes:     ""
      }
    }.freeze

    # -------------------------------------------------------------------------
    # CLERIC
    # HP: 8+CON  |  Damage: d6  |  Load: 10+STR
    # -------------------------------------------------------------------------
    CLERIC = {
      vitals: {
        hp_base:     8,
        armor:       1,
        damage:      "d6",
        xp:          0,

        load_base:   10,
        str:         13,
        dex:         9,
        con:         12,
        int:         8,
        wis:         16,
        cha:         15,
        str_debility: 0,
        dex_debility: 0,
        con_debility: 0,
        int_debility: 0,
        wis_debility: 0,
        cha_debility: 0
      },
      abilities: [
        "move:deity",
        "move:divine_guidance",
        "move:turn_undead",
        "move:commune",
        "move:cast_a_spell"
      ],
      advanced_moves: {
        "2-5": [
          "move:chosen_one",
          "move:invigorate",
          "move:scales_of_life_and_death",
          "move:serenity",
          "move:first_aid",
          "move:divine_intervention",
          "move:penitent",
          "move:empower",
          "move:orison_for_guidance",
          "move:divine_protection",
          "move:devoted_healer",
          "move:multiclass_dabbler"
        ],
        "6-10": [
          "move:anointed",              # requires: chosen_one
          "move:apotheosis",
          "move:reaper",
          "move:providence",            # replaces: serenity
          "move:greater_first_aid",     # requires: first_aid
          "move:divine_invincibility",  # replaces: divine_intervention
          "move:martyr",                # replaces: penitent
          "move:divine_armor",          # replaces: divine_protection
          "move:greater_empower"        # replaces: empower
        ]
      },
      inventory: {
        weapons: [
          "warhammer"                   # close, 1 weight
        ],
        equipment: [
          "dungeon_rations",            # 5 uses, 1 weight
          "holy_symbol",                # 0 weight
          "chainmail",                  # 1 armor, 1 weight
          "adventuring_gear",           # 1 weight
          "dungeon_rations_extra"       # 5 uses, 1 weight (bonus choice)
        ]
      },
      story: {
        bonds:     "",
        alignment: "",                  # Good / Lawful / Evil
        looks:     "",
        notes:     ""
      }
    }.freeze

    # -------------------------------------------------------------------------
    # DRUID
    # HP: 6+CON  |  Damage: d6  |  Load: 6+STR
    # -------------------------------------------------------------------------
    DRUID = {
      vitals: {
        hp_base:     6,
        armor:       1,
        damage:      "d6",
        xp:          0,

        load_base:   6,
        str:         9,
        dex:         13,
        con:         15,
        int:         8,
        wis:         16,
        cha:         12,
        str_debility: 0,
        dex_debility: 0,
        con_debility: 0,
        int_debility: 0,
        wis_debility: 0,
        cha_debility: 0
      },
      abilities: [
        "move:born_of_the_soil",
        "move:by_nature_sustained",
        "move:spirit_tongue",
        "move:shapeshifter",
        "move:studied_essence"
      ],
      advanced_moves: {
        "2-5": [
          "move:hunters_brother",       # take one ranger move
          "move:red_of_tooth_and_claw",
          "move:communion_of_whispers",
          "move:barkskin",
          "move:eyes_of_the_tiger",
          "move:shed",
          "move:thing_talker",
          "move:formcrafter",
          "move:elemental_mastery",
          "move:balance"
        ],
        "6-10": [
          "move:embracing_no_form",
          "move:doppelgangers_dance",
          "move:blood_and_thunder",     # replaces: red_of_tooth_and_claw
          "move:the_druid_sleep",
          "move:world_talker",          # requires: thing_talker
          "move:stalkers_sister",       # take one ranger move
          "move:formshaper",            # requires: formcrafter
          "move:chimera",
          "move:weather_weaver"
        ]
      },
      inventory: {
        weapons: [
          "staff"                       # close, two-handed, 1 weight
        ],
        equipment: [
          "land_token",                 # token of your land, 0 weight
          "hide_armor",                 # 1 armor, 1 weight
          "adventuring_gear"            # 1 weight
        ]
      },
      story: {
        bonds:     "",
        alignment: "",                  # Chaotic / Good / Neutral
        looks:     "",
        notes:     ""
      }
    }.freeze

    # -------------------------------------------------------------------------
    # FIGHTER
    # HP: 10+CON  |  Damage: d10  |  Load: 12+STR
    # -------------------------------------------------------------------------
    FIGHTER = {
      vitals: {
        hp_base:     10,
        armor:       1,
        damage:      "d10",
        xp:          0,

        load_base:   12,
        str:         16,
        dex:         13,
        con:         15,
        int:         8,
        wis:         9,
        cha:         12,
        str_debility: 0,
        dex_debility: 0,
        con_debility: 0,
        int_debility: 0,
        wis_debility: 0,
        cha_debility: 0
      },
      abilities: [
        "move:bend_bars_lift_gates",
        "move:armored",
        "move:signature_weapon"
      ],
      advanced_moves: {
        "2-5": [
          "move:merciless",
          "move:heirloom",
          "move:armor_mastery",
          "move:improved_weapon",
          "move:seeing_red",
          "move:interrogator",
          "move:scent_of_blood",
          "move:multiclass_dabbler",
          "move:iron_hide",
          "move:blacksmith"
        ],
        "6-10": [
          "move:bloodthirsty",          # replaces: merciless
          "move:armored_perfection",    # replaces: armor_mastery
          "move:evil_eye",              # requires: seeing_red
          "move:taste_of_blood",        # replaces: scent_of_blood
          "move:multiclass_initiate",   # requires: multiclass_dabbler
          "move:steel_hide",            # replaces: iron_hide
          "move:through_deaths_eyes",
          "move:eye_for_weaponry",
          "move:superior_warrior"
        ]
      },
      inventory: {
        weapons: [
          "signature_weapon"            # custom, base + 2 enhancements, 2 weight
        ],
        equipment: [
          "dungeon_rations",            # 5 uses, 1 weight
          "chainmail",                  # 1 armor, 1 weight
          "adventuring_gear"            # 1 weight
        ]
      },
      story: {
        bonds:     "",
        alignment: "",                  # Good / Neutral / Evil
        looks:     "",
        notes:     ""
      }
    }.freeze

    # -------------------------------------------------------------------------
    # PALADIN
    # HP: 10+CON  |  Damage: d10  |  Load: 12+STR
    # -------------------------------------------------------------------------
    PALADIN = {
      vitals: {
        hp_base:     10,
        armor:       3,
        damage:      "d10",
        xp:          0,
        load_base:   12,
        str:         16,
        dex:         9,
        con:         15,
        int:         8,
        wis:         13,
        cha:         12,
        str_debility: 0,
        dex_debility: 0,
        con_debility: 0,
        int_debility: 0,
        wis_debility: 0,
        cha_debility: 0
      },
      abilities: [
        "move:lay_on_hands",
        "move:armored",
        "move:i_am_the_law",
        "move:quest"
      ],
      advanced_moves: {
        "2-5": [
          "move:divine_favor",
          "move:bloody_aegis",
          "move:smite",
          "move:exterminatus",
          "move:charge",
          "move:staunch_defender",
          "move:setup_strike",
          "move:holy_protection",
          "move:voice_of_authority",
          "move:hospitaller"
        ],
        "6-10": [
          "move:evidence_of_faith",     # requires: divine_favor
          "move:holy_smite",            # replaces: smite
          "move:ever_onward",           # replaces: charge
          "move:impervious_defender",   # replaces: staunch_defender
          "move:tandem_strike",         # replaces: setup_strike
          "move:divine_protection_pal", # replaces: holy_protection
          "move:divine_authority",      # replaces: voice_of_authority
          "move:perfect_hospitaller",   # replaces: hospitaller
          "move:indomitable",
          "move:perfect_knight"
        ]
      },
      inventory: {
        weapons: [
          "longsword",                  # close, +1 damage, 1 weight
          "shield"                      # +1 armor, 2 weight
        ],
        equipment: [
          "dungeon_rations",            # 5 uses, 1 weight
          "scale_armor",                # 2 armor, 3 weight
          "mark_of_faith",              # 0 weight
          "adventuring_gear"            # 1 weight
        ]
      },
      story: {
        bonds:     "",
        alignment: "",                  # Lawful / Good
        looks:     "",
        notes:     ""
      }
    }.freeze

    # -------------------------------------------------------------------------
    # RANGER
    # HP: 8+CON  |  Damage: d8  |  Load: 11+STR
    # -------------------------------------------------------------------------
    RANGER = {
      vitals: {
        hp_base:     8,
        armor:       1,
        damage:      "d8",
        xp:          0,
        load_base:   11,
        str:         13,
        dex:         16,
        con:         12,
        int:         8,
        wis:         15,
        cha:         9,
        str_debility: 0,
        dex_debility: 0,
        con_debility: 0,
        int_debility: 0,
        wis_debility: 0,
        cha_debility: 0
      },
      abilities: [
        "move:hunt_and_track",
        "move:called_shot",
        "move:animal_companion",
        "move:command"
      ],
      advanced_moves: {
        "2-5": [
          "move:half_elven",            # first advancement only
          "move:wild_empathy",
          "move:familiar_prey",
          "move:vipers_strike",
          "move:camouflage",
          "move:mans_best_friend",
          "move:blot_out_the_sun",
          "move:well_trained",
          "move:god_amidst_the_wastes",
          "move:follow_me",
          "move:a_safe_place"
        ],
        "6-10": [
          "move:wild_speech",           # replaces: wild_empathy
          "move:hunters_prey",          # replaces: familiar_prey
          "move:vipers_fangs",          # replaces: vipers_strike
          "move:smaugs_belly",
          "move:strider",               # replaces: follow_me
          "move:a_safer_place",         # replaces: a_safe_place
          "move:observant",
          "move:special_trick",
          "move:unnatural_ally"
        ]
      },
      inventory: {
        weapons: [
          "hunters_bow",                # near/far, 1 weight
          "short_sword"                 # close, 1 weight
        ],
        equipment: [
          "dungeon_rations",            # 5 uses, 1 weight
          "leather_armor",              # 1 armor, 1 weight
          "arrows",                     # bundle, 3 ammo, 1 weight
          "adventuring_gear",           # 1 weight
          "dungeon_rations_extra"       # 1 weight (bonus choice)
        ]
      },
      story: {
        bonds:     "",
        alignment: "",                  # Chaotic / Good / Neutral
        looks:     "",
        notes:     ""
      }
    }.freeze

    # -------------------------------------------------------------------------
    # THIEF
    # HP: 6+CON  |  Damage: d8  |  Load: 9+STR
    # -------------------------------------------------------------------------
    THIEF = {
      vitals: {
        hp_base:     6,
        armor:       1,
        damage:      "d8",
        xp:          0,

        load_base:   9,
        str:         9,
        dex:         16,
        con:         12,
        int:         15,
        wis:         8,
        cha:         13,
        str_debility: 0,
        dex_debility: 0,
        con_debility: 0,
        int_debility: 0,
        wis_debility: 0,
        cha_debility: 0
      },
      abilities: [
        "move:trap_expert",
        "move:tricks_of_the_trade",
        "move:backstab",
        "move:flexible_morals",
        "move:poisoner"
      ],
      advanced_moves: {
        "2-5": [
          "move:cheap_shot",
          "move:cautious",
          "move:wealth_and_taste",
          "move:shoot_first",
          "move:poison_master",
          "move:envenom",
          "move:brewer",
          "move:underdog",
          "move:connections"
        ],
        "6-10": [
          "move:dirty_fighter",         # replaces: cheap_shot
          "move:extremely_cautious",    # replaces: cautious
          "move:alchemist",             # replaces: brewer
          "move:serious_underdog",      # replaces: underdog
          "move:evasion",
          "move:strong_arm_true_aim",
          "move:escape_route",
          "move:disguise",
          "move:heist"
        ]
      },
      inventory: {
        weapons: [
          "dagger",                     # hand, 1 weight
          "short_sword",                # close, 1 weight
          "throwing_daggers"            # thrown/near, 3 uses, 0 weight
        ],
        equipment: [
          "dungeon_rations",            # 5 uses, 1 weight
          "leather_armor",              # 1 armor, 1 weight
          "poison_chosen",              # 3 uses of chosen poison
          "adventuring_gear"            # 1 weight
        ]
      },
      story: {
        bonds:     "",
        alignment: "",                  # Chaotic / Neutral / Evil
        looks:     "",
        notes:     ""
      }
    }.freeze

    # -------------------------------------------------------------------------
    # WIZARD
    # HP: 4+CON  |  Damage: d4  |  Load: 7+STR
    # -------------------------------------------------------------------------
    WIZARD = {
      vitals: {
        hp_base:     4,
        armor:       0,
        damage:      "d4",
        xp:          0,
        load_base:   7,
        str:         8,
        dex:         13,
        con:         9,
        int:         16,
        wis:         15,
        cha:         12,
        str_debility: 0,
        dex_debility: 0,
        con_debility: 0,
        int_debility: 0,
        wis_debility: 0,
        cha_debility: 0
      },
      abilities: [
        "move:spellbook",
        "move:prepare_spells",
        "move:cast_a_spell",
        "move:spell_defense",
        "move:ritual"
      ],
      advanced_moves: {
        "2-5": [
          "move:prodigy",
          "move:empowered_magic",
          "move:fount_of_knowledge",
          "move:know_it_all",
          "move:expanded_spellbook",
          "move:enchanter",
          "move:logical",
          "move:arcane_ward",
          "move:counterspell",
          "move:quick_study"
        ],
        "6-10": [
          "move:master",                # requires: prodigy
          "move:greater_empowered_magic", # replaces: empowered_magic
          "move:enchanters_soul",       # requires: enchanter
          "move:highly_logical",        # replaces: logical
          "move:spell_augmentation",
          "move:self_powered",
          "move:multiclass_dabbler",
          "move:multiclass_initiate",
          "move:multiclass_master"
        ]
      },
      inventory: {
        weapons: [
          "dagger"                      # hand, 1 weight
        ],
        equipment: [
          "dungeon_rations",            # 5 uses, 1 weight
          "spellbook",                  # 1 weight
          "leather_armor",              # 1 armor, 1 weight
          "healing_potion"              # 0 weight
        ]
      },
      story: {
        bonds:     "",
        alignment: "",                  # Good / Neutral / Evil
        looks:     "",
        notes:     ""
      }
    }.freeze

    # =========================================================================
    # YAR CLASSES — Northern frontier homebrew
    # Merged with a YAR race block (yar_human, yar_dog_folk, yar_elf).
    # Advanced moves are placeholders — fill in as you design the class.
    # =========================================================================

    # -------------------------------------------------------------------------
    # YAR BERSERK
    # Spends own HP as a resource to deal devastating damage.
    # HP: 10+CON  |  Damage: d10  |  Load: 12+STR
    # -------------------------------------------------------------------------
    # YAR_BERSERK = {
    #   vitals: {
    #     hp_base:     10,
    #
    #     load_base:   12
    #   },
    #   abilities: [
    #     "move:blood_price",
    #     "move:battle_rage",
    #     "move:thick_hide",
    #     "move:last_to_fall"
    #   ],
    #   advanced_moves: {
    #     "2-5": [
    #       "move:berserker_advance_1",   # TODO
    #       "move:berserker_advance_2",   # TODO
    #       "move:berserker_advance_3",   # TODO
    #       "move:berserker_advance_4",   # TODO
    #       "move:berserker_advance_5"    # TODO
    #     ],
    #     "6-10": [
    #       "move:berserker_master_1",    # TODO
    #       "move:berserker_master_2",    # TODO
    #       "move:berserker_master_3"     # TODO
    #     ]
    #   },
    #   inventory: {
    #     weapons: [
    #       "great_axe"                   # two-handed, reach, messy
    #     ],
    #     equipment: [
    #       "dungeon_rations",
    #       "hide_armor",
    #       "bandages"
    #     ]
    #   },
    #   story: {
    #     bonds:     "",
    #     alignment: "",                  # Chaotic / Neutral
    #     looks:     "",
    #     notes:     ""
    #   }
    # }.freeze

    # -------------------------------------------------------------------------
    # YAR PATH MASTER
    # Wilderness guide of the northern wilds. Party never gets lost.
    # HP: 8+CON  |  Damage: d8  |  Load: 10+STR
    # -------------------------------------------------------------------------
    # YAR_PATH_MASTER = {
    #   vitals: {
    #     hp_base:     8,
    #
    #     load_base:   10
    #   },
    #   abilities: [
    #     "move:safe_passage",
    #     "move:read_the_wild",
    #     "move:forest_step",
    #     "move:waymarker"
    #   ],
    #   advanced_moves: {
    #     "2-5": [
    #       "move:path_master_advance_1", # TODO
    #       "move:path_master_advance_2", # TODO
    #       "move:path_master_advance_3", # TODO
    #       "move:path_master_advance_4", # TODO
    #       "move:path_master_advance_5"  # TODO
    #     ],
    #     "6-10": [
    #       "move:path_master_master_1",  # TODO
    #       "move:path_master_master_2",  # TODO
    #       "move:path_master_master_3"   # TODO
    #     ]
    #   },
    #   inventory: {
    #     weapons: [
    #       "hunters_bow",
    #       "hunting_knife"               # hand, light, 1 weight
    #     ],
    #     equipment: [
    #       "dungeon_rations",
    #       "leather_armor",
    #       "arrows",
    #       "rope",
    #       "adventuring_gear"
    #     ]
    #   },
    #   story: {
    #     bonds:     "",
    #     alignment: "",                  # Neutral / Good
    #     looks:     "",
    #     notes:     ""
    #   }
    # }.freeze

    # -------------------------------------------------------------------------
    # YAR RUNE MASTER
    # Melee tank. Carves trigger runes on weapons, armor, and terrain.
    # HP: 10+CON  |  Damage: d8  |  Load: 11+STR
    # -------------------------------------------------------------------------
    # YAR_RUNE_MASTER = {
    #   vitals: {
    #     hp_base:     10,
    #
    #     load_base:   11
    #   },
    #   abilities: [
    #     "move:carve_rune",
    #     "move:runic_armor",
    #     "move:trigger_word",
    #     "move:living_stone"
    #   ],
    #   advanced_moves: {
    #     "2-5": [
    #       "move:rune_master_advance_1", # TODO
    #       "move:rune_master_advance_2", # TODO
    #       "move:rune_master_advance_3", # TODO
    #       "move:rune_master_advance_4", # TODO
    #       "move:rune_master_advance_5"  # TODO
    #     ],
    #     "6-10": [
    #       "move:rune_master_master_1",  # TODO
    #       "move:rune_master_master_2",  # TODO
    #       "move:rune_master_master_3"   # TODO
    #     ]
    #   },
    #   inventory: {
    #     weapons: [
    #       "runic_warhammer"             # close, 1 weight, inscribed
    #     ],
    #     equipment: [
    #       "dungeon_rations",
    #       "chainmail",
    #       "rune_chisels",               # tools, 0 weight
    #       "adventuring_gear"
    #     ]
    #   },
    #   story: {
    #     bonds:     "",
    #     alignment: "",                  # Lawful / Neutral
    #     looks:     "",
    #     notes:     ""
    #   }
    # }.freeze

    # -------------------------------------------------------------------------
    # YAR EVIL HUNTER
    # Harvests creature components. Brews oils and uses herbs as a resource.
    # Gains damage bonuses against studied creature types.
    # HP: 8+CON  |  Damage: d8  |  Load: 10+STR
    # -------------------------------------------------------------------------
    # YAR_EVIL_HUNTER = {
    #   vitals: {
    #     hp_base:     8,
    #
    #     load_base:   10
    #   },
    #   abilities: [
    #     "move:harvest_the_slain",
    #     "move:brew_hunter_oil",
    #     "move:study_the_prey",
    #     "move:prepared_mind"
    #   ],
    #   advanced_moves: {
    #     "2-5": [
    #       "move:evil_hunter_advance_1", # TODO
    #       "move:evil_hunter_advance_2", # TODO
    #       "move:evil_hunter_advance_3", # TODO
    #       "move:evil_hunter_advance_4", # TODO
    #       "move:evil_hunter_advance_5"  # TODO
    #     ],
    #     "6-10": [
    #       "move:evil_hunter_master_1",  # TODO
    #       "move:evil_hunter_master_2",  # TODO
    #       "move:evil_hunter_master_3"   # TODO
    #     ]
    #   },
    #   inventory: {
    #     weapons: [
    #       "hunters_bow",
    #       "short_sword"
    #     ],
    #     equipment: [
    #       "dungeon_rations",
    #       "leather_armor",
    #       "herbs_and_poultices",        # 3 uses, 1 weight — core resource
    #       "monster_components",         # 2 uses to start
    #       "adventuring_gear"
    #     ]
    #   },
    #   story: {
    #     bonds:     "",
    #     alignment: "",                  # Neutral / Good
    #     looks:     "",
    #     notes:     ""
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
      list.map { [ I18n.t("dungeon_world.klass.#{it}"), it ] }
    end

    def get_template(klass)
      const_name = klass.to_s.upcase.to_sym
      raise "no such klass #{const_name} defined" unless constants.include?(const_name)

      const_get(const_name)
    end
  end
end
