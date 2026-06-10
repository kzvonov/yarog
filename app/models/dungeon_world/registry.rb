module DungeonWorld
  module Registry
    REGISTRY = {
      # =========================================================================
      # LANGUAGES
      # =========================================================================
      "lang:common"      => { text: "" },
      "lang:dwarf"       => { text: "" },
      "lang:elf"         => { text: "" },
      "lang:undercommon" => { text: "" },
      "lang:gnome"       => { text: "" },
      "lang:orc"         => { text: "" },
      "lang:troll"       => { text: "" },
      "lang:goblin"      => { text: "" },
      "lang:tauren"      => { text: "" },
      "lang:infernal"    => { text: "" },
      "lang:frog"        => { text: "" },
      "lang:turtle"      => { text: "" },
      "lang:yar"         => { text: "" },

      # =========================================================================
      # RACIAL TRAITS
      # =========================================================================
      "racial:human"        => { text: "" },
      "racial:dwarf"        => { text: "" },
      "racial:elf"          => { text: "" },
      "racial:dark_elf"     => { text: "" },
      "racial:high_elf"     => { text: "" },
      "racial:gnome"        => { text: "" },
      "racial:orc"          => { text: "" },
      "racial:troll"        => { text: "" },
      "racial:goblin"       => { text: "" },
      "racial:tauren"       => { text: "" },
      "racial:tiefling"     => { text: "" },
      "racial:frog_folk"    => { text: "" },
      "racial:turtle_folk"  => { text: "" },
      "racial:yar_human"    => { text: "" },
      "racial:yar_dog_folk" => { text: "" },
      "racial:yar_elf"      => { text: "" },

      # =========================================================================
      # SHARED MULTICLASS MOVES
      # =========================================================================
      "move:multiclass_dabbler"  => { text: "" },
      "move:multiclass_initiate" => { text: "", requires: "move:multiclass_dabbler" },
      "move:multiclass_master"   => { text: "", requires: "move:multiclass_initiate" },

      # =========================================================================
      # BARD MOVES
      # =========================================================================
      "move:arcane_art"                    => { text: "" },
      "move:bardic_lore"                   => { text: "" },
      "move:charming_and_open"             => { text: "" },
      "move:port_in_the_storm"             => { text: "" },
      "move:healing_song"                  => { text: "" },
      "move:vicious_cacophony"             => { text: "" },
      "move:it_goes_to_eleven"             => { text: "" },
      "move:metal_hurlant"                 => { text: "" },
      "move:a_little_help_from_my_friends" => { text: "" },
      "move:eldritch_tones"                => { text: "" },
      "move:duelist_parry"                 => { text: "" },
      "move:bamboozle"                     => { text: "" },
      "move:healing_chorus"                => { text: "", replaces: "move:healing_song" },
      "move:vicious_blast"                 => { text: "", replaces: "move:vicious_cacophony" },
      "move:unforgettable_face"            => { text: "" },
      "move:reputation"                    => { text: "" },
      "move:eldritch_chord"                => { text: "", replaces: "move:eldritch_tones" },
      "move:an_ear_for_magic"              => { text: "" },
      "move:devious"                       => { text: "" },
      "move:duelist_block"                 => { text: "", replaces: "move:duelist_parry" },
      "move:con"                           => { text: "", replaces: "move:bamboozle" },

      # =========================================================================
      # PRIEST MOVES
      # =========================================================================
      "move:deity"                    => { text: "" },
      "move:divine_guidance"          => { text: "" },
      "move:turn_undead"              => { text: "" },
      "move:commune"                  => { text: "" },
      "move:cast_a_spell"             => { text: "" },
      "move:chosen_one"               => { text: "" },
      "move:invigorate"               => { text: "" },
      "move:scales_of_life_and_death" => { text: "" },
      "move:serenity"                 => { text: "" },
      "move:first_aid"                => { text: "" },
      "move:divine_intervention"      => { text: "" },
      "move:penitent"                 => { text: "" },
      "move:empower"                  => { text: "" },
      "move:orison_for_guidance"      => { text: "" },
      "move:divine_protection"        => { text: "" },
      "move:devoted_healer"           => { text: "" },
      "move:anointed"                 => { text: "", requires: "move:chosen_one" },
      "move:apotheosis"               => { text: "" },
      "move:reaper"                   => { text: "" },
      "move:providence"               => { text: "", replaces: "move:serenity" },
      "move:greater_first_aid"        => { text: "", requires: "move:first_aid" },
      "move:divine_invincibility"     => { text: "", replaces: "move:divine_intervention" },
      "move:martyr"                   => { text: "", replaces: "move:penitent" },
      "move:divine_armor"             => { text: "", replaces: "move:divine_protection" },
      "move:greater_empower"          => { text: "", replaces: "move:empower" },

      # =========================================================================
      # DRUID MOVES
      # =========================================================================
      "move:born_of_the_soil"      => { text: "" },
      "move:by_nature_sustained"   => { text: "" },
      "move:spirit_tongue"         => { text: "" },
      "move:shapeshifter"          => { text: "" },
      "move:studied_essence"       => { text: "" },
      "move:hunters_brother"       => { text: "" },
      "move:red_of_tooth_and_claw" => { text: "" },
      "move:communion_of_whispers" => { text: "" },
      "move:barkskin"              => { text: "" },
      "move:eyes_of_the_tiger"     => { text: "" },
      "move:shed"                  => { text: "" },
      "move:thing_talker"          => { text: "" },
      "move:formcrafter"           => { text: "" },
      "move:elemental_mastery"     => { text: "" },
      "move:balance"               => { text: "" },
      "move:embracing_no_form"     => { text: "" },
      "move:doppelgangers_dance"   => { text: "" },
      "move:blood_and_thunder"     => { text: "", replaces: "move:red_of_tooth_and_claw" },
      "move:the_druid_sleep"       => { text: "" },
      "move:world_talker"          => { text: "", requires: "move:thing_talker" },
      "move:stalkers_sister"       => { text: "" },
      "move:formshaper"            => { text: "", requires: "move:formcrafter" },
      "move:chimera"               => { text: "" },
      "move:weather_weaver"        => { text: "" },

      # =========================================================================
      # FIGHTER MOVES
      # =========================================================================
      "move:bend_bars_lift_gates" => { text: "" },
      "move:armored"              => { text: "" },
      "move:signature_weapon"     => { text: "" },
      "move:merciless"            => { text: "" },
      "move:heirloom"             => { text: "" },
      "move:armor_mastery"        => { text: "" },
      "move:improved_weapon"      => { text: "" },
      "move:seeing_red"           => { text: "" },
      "move:interrogator"         => { text: "" },
      "move:scent_of_blood"       => { text: "" },
      "move:iron_hide"            => { text: "" },
      "move:blacksmith"           => { text: "" },
      "move:bloodthirsty"         => { text: "", replaces: "move:merciless" },
      "move:armored_perfection"   => { text: "", replaces: "move:armor_mastery" },
      "move:evil_eye"             => { text: "", requires: "move:seeing_red" },
      "move:taste_of_blood"       => { text: "", replaces: "move:scent_of_blood" },
      "move:steel_hide"           => { text: "", replaces: "move:iron_hide" },
      "move:through_deaths_eyes"  => { text: "" },
      "move:eye_for_weaponry"     => { text: "" },
      "move:superior_warrior"     => { text: "" },

      # =========================================================================
      # PALADIN MOVES
      # =========================================================================
      "move:lay_on_hands"          => { text: "" },
      "move:i_am_the_law"          => { text: "" },
      "move:quest"                 => { text: "" },
      "move:divine_favor"          => { text: "" },
      "move:bloody_aegis"          => { text: "" },
      "move:smite"                 => { text: "" },
      "move:exterminatus"          => { text: "" },
      "move:charge"                => { text: "" },
      "move:staunch_defender"      => { text: "" },
      "move:setup_strike"          => { text: "" },
      "move:holy_protection"       => { text: "" },
      "move:voice_of_authority"    => { text: "" },
      "move:hospitaller"           => { text: "" },
      "move:evidence_of_faith"     => { text: "", requires: "move:divine_favor" },
      "move:holy_smite"            => { text: "", replaces: "move:smite" },
      "move:ever_onward"           => { text: "", replaces: "move:charge" },
      "move:impervious_defender"   => { text: "", replaces: "move:staunch_defender" },
      "move:tandem_strike"         => { text: "", replaces: "move:setup_strike" },
      "move:divine_protection_pal" => { text: "", replaces: "move:holy_protection" },
      "move:divine_authority"      => { text: "", replaces: "move:voice_of_authority" },
      "move:perfect_hospitaller"   => { text: "", replaces: "move:hospitaller" },
      "move:indomitable"           => { text: "" },
      "move:perfect_knight"        => { text: "" },

      # =========================================================================
      # RANGER MOVES
      # =========================================================================
      "move:hunt_and_track"        => { text: "" },
      "move:called_shot"           => { text: "" },
      "move:animal_companion"      => { text: "" },
      "move:command"               => { text: "" },
      "move:half_elven"            => { text: "" },
      "move:wild_empathy"          => { text: "" },
      "move:familiar_prey"         => { text: "" },
      "move:vipers_strike"         => { text: "" },
      "move:camouflage"            => { text: "" },
      "move:mans_best_friend"      => { text: "" },
      "move:blot_out_the_sun"      => { text: "" },
      "move:well_trained"          => { text: "" },
      "move:god_amidst_the_wastes" => { text: "" },
      "move:follow_me"             => { text: "" },
      "move:a_safe_place"          => { text: "" },
      "move:wild_speech"           => { text: "", replaces: "move:wild_empathy" },
      "move:hunters_prey"          => { text: "", replaces: "move:familiar_prey" },
      "move:vipers_fangs"          => { text: "", replaces: "move:vipers_strike" },
      "move:smaugs_belly"          => { text: "" },
      "move:strider"               => { text: "", replaces: "move:follow_me" },
      "move:a_safer_place"         => { text: "", replaces: "move:a_safe_place" },
      "move:observant"             => { text: "" },
      "move:special_trick"         => { text: "" },
      "move:unnatural_ally"        => { text: "" },

      # =========================================================================
      # THIEF MOVES
      # =========================================================================
      "move:trap_expert"          => { text: "" },
      "move:tricks_of_the_trade"  => { text: "" },
      "move:backstab"             => { text: "" },
      "move:flexible_morals"      => { text: "" },
      "move:poisoner"             => { text: "" },
      "move:cheap_shot"           => { text: "" },
      "move:cautious"             => { text: "" },
      "move:wealth_and_taste"     => { text: "" },
      "move:shoot_first"          => { text: "" },
      "move:poison_master"        => { text: "" },
      "move:envenom"              => { text: "" },
      "move:brewer"               => { text: "" },
      "move:underdog"             => { text: "" },
      "move:connections"          => { text: "" },
      "move:dirty_fighter"        => { text: "", replaces: "move:cheap_shot" },
      "move:extremely_cautious"   => { text: "", replaces: "move:cautious" },
      "move:alchemist"            => { text: "", replaces: "move:brewer" },
      "move:serious_underdog"     => { text: "", replaces: "move:underdog" },
      "move:evasion"              => { text: "" },
      "move:strong_arm_true_aim"  => { text: "" },
      "move:escape_route"         => { text: "" },
      "move:disguise"             => { text: "" },
      "move:heist"                => { text: "" },

      # =========================================================================
      # WIZARD MOVES
      # =========================================================================
      "move:spellbook"               => { text: "" },
      "move:prepare_spells"          => { text: "" },
      "move:spell_defense"           => { text: "" },
      "move:ritual"                  => { text: "" },
      "move:prodigy"                 => { text: "" },
      "move:empowered_magic"         => { text: "" },
      "move:fount_of_knowledge"      => { text: "" },
      "move:know_it_all"             => { text: "" },
      "move:expanded_spellbook"      => { text: "" },
      "move:enchanter"               => { text: "" },
      "move:logical"                 => { text: "" },
      "move:arcane_ward"             => { text: "" },
      "move:counterspell"            => { text: "" },
      "move:quick_study"             => { text: "" },
      "move:master"                  => { text: "", requires: "move:prodigy" },
      "move:greater_empowered_magic" => { text: "", replaces: "move:empowered_magic" },
      "move:enchanters_soul"         => { text: "", requires: "move:enchanter" },
      "move:highly_logical"          => { text: "", replaces: "move:logical" },
      "move:spell_augmentation"      => { text: "" },
      "move:self_powered"            => { text: "" },

      # =========================================================================
      # YAR BERSERK MOVES
      # =========================================================================
      "move:blood_price"  => { text: "" },
      "move:battle_rage"  => { text: "" },
      "move:thick_hide"   => { text: "" },
      "move:last_to_fall" => { text: "" },

      # =========================================================================
      # YAR PATH MASTER MOVES
      # =========================================================================
      "move:safe_passage" => { text: "" },
      "move:read_the_wild"=> { text: "" },
      "move:forest_step"  => { text: "" },
      "move:waymarker"    => { text: "" },

      # =========================================================================
      # YAR RUNE MASTER MOVES
      # =========================================================================
      "move:carve_rune"   => { text: "" },
      "move:runic_armor"  => { text: "" },
      "move:trigger_word" => { text: "" },
      "move:living_stone" => { text: "" },

      # =========================================================================
      # YAR EVIL HUNTER MOVES
      # =========================================================================
      "move:harvest_the_slain" => { text: "" },
      "move:brew_hunter_oil"   => { text: "" },
      "move:study_the_prey"    => { text: "" },
      "move:prepared_mind"     => { text: "" },

      # =========================================================================
      # EQUIPMENT — ARMOR
      # =========================================================================
      "obj:leather_armor"    => { text: "leather armor",   tags: [ :worn, :armor_1 ],                     weight: 1, uses: nil },
      "obj:chainmail"        => { text: "chainmail",        tags: [ :worn, :armor_1, :clumsy ],           weight: 1, uses: nil },
      "obj:scale_armor"      => { text: "scale armor",      tags: [ :worn, :armor_2, :clumsy ],           weight: 3, uses: nil },
      "obj:hide_armor"       => { text: "hide armor",       tags: [ :worn, :armor_1 ],                    weight: 1, uses: nil },
      "obj:shield"           => { text: "shield",           tags: [ :held, :armor_1 ],                    weight: 2, uses: nil },
      "obj:wooden_shield"    => { text: "wooden shield",    tags: [ :held, :armor_1 ],                    weight: 1, uses: nil },

      # =========================================================================
      # EQUIPMENT — WEAPONS (melee)
      # =========================================================================
      "obj:dueling_rapier"   => { text: "dueling rapier",   tags: [ :close, :precise ],                   weight: 2, uses: nil },
      "obj:short_sword"      => { text: "short sword",      tags: [ :close ],                             weight: 1, uses: nil },
      "obj:longsword"        => { text: "long sword",       tags: [ :close, :bonus_damage_1 ],            weight: 1, uses: nil },
      "obj:warhammer"        => { text: "warhammer",        tags: [ :close ],                             weight: 1, uses: nil },
      "obj:mace"             => { text: "mace",             tags: [ :close ],                             weight: 1, uses: nil },
      "obj:staff"            => { text: "staff",            tags: [ :close, :two_handed ],                weight: 1, uses: nil },
      "obj:shillelagh"       => { text: "shillelagh",       tags: [ :close ],                             weight: 2, uses: nil },
      "obj:spear"            => { text: "spear",            tags: [ :close, :thrown, :near ],             weight: 1, uses: nil },
      "obj:halberd"          => { text: "halberd",          tags: [ :reach, :two_handed, :bonus_damage_1 ], weight: 2, uses: nil },
      "obj:dagger"           => { text: "dagger",           tags: [ :hand ],                              weight: 1, uses: nil },
      "obj:hunting_knife"    => { text: "hunting knife",    tags: [ :hand ],                              weight: 1, uses: nil },
      "obj:great_axe"        => { text: "great axe",        tags: [ :reach, :two_handed, :messy ],        weight: 2, uses: nil },
      "obj:runic_warhammer"  => { text: "runic warhammer",  tags: [ :close ],                             weight: 1, uses: nil },
      "obj:signature_weapon" => { text: "signature weapon", tags: [ :signature ],                         weight: 2, uses: nil },

      # =========================================================================
      # EQUIPMENT — WEAPONS (ranged)
      # =========================================================================
      "obj:hunters_bow"      => { text: "hunter's bow",    tags: [ :near, :far ],                        weight: 1, uses: nil },
      "obj:worn_bow"         => { text: "worn bow",         tags: [ :near ],                              weight: 2, uses: nil },
      "obj:ragged_bow"       => { text: "ragged bow",       tags: [ :near ],                              weight: 2, uses: nil },
      "obj:arrows"           => { text: "bundle of arrows", tags: [ :ammo ],                              weight: 1, uses: 3   },
      "obj:throwing_daggers" => { text: "throwing daggers", tags: [ :thrown, :near ],                     weight: 0, uses: 3   },

      # =========================================================================
      # EQUIPMENT — CONSUMABLES
      # =========================================================================
      "obj:dungeon_rations"       => { text: "dungeon rations",     tags: [ :consumed ],           weight: 1, uses: 5 },
      "obj:dungeon_rations_extra" => { text: "dungeon rations",     tags: [ :consumed ],           weight: 1, uses: 5 },
      "obj:healing_potion"        => { text: "healing potion",      tags: [ :consumed ],           weight: 0, uses: 1 },
      "obj:antitoxin"             => { text: "antitoxin",           tags: [ :consumed ],           weight: 0, uses: 1 },
      "obj:bandages"              => { text: "bandages",            tags: [ :consumed ],           weight: 0, uses: 3 },
      "obj:poultices_and_herbs"   => { text: "poultices and herbs", tags: [ :consumed ],           weight: 1, uses: 2 },
      "obj:herbs_and_poultices"   => { text: "herbs and poultices", tags: [ :consumed ],           weight: 1, uses: 3 },
      "obj:halfling_pipeleaf"     => { text: "halfling pipeleaf",   tags: [ :consumed ],           weight: 0, uses: nil },
      "obj:monster_components"    => { text: "monster components",  tags: [ :consumed, :crafting ], weight: 1, uses: 2   },

      # =========================================================================
      # EQUIPMENT — POISONS
      # =========================================================================
      "obj:poison_oil_of_tagit"   => { text: "oil of tagit",      tags: [ :poison, :applied ],   weight: 0, uses: 1 },
      "obj:poison_bloodweed"      => { text: "bloodweed",         tags: [ :poison, :touch ],     weight: 0, uses: 1 },
      "obj:poison_goldenroot"     => { text: "goldenroot",        tags: [ :poison, :applied ],   weight: 0, uses: 1 },
      "obj:poison_serpents_tears" => { text: "serpent's tears",   tags: [ :poison, :touch ],     weight: 0, uses: 1 },
      "obj:poison_chosen"         => { text: "chosen poison",     tags: [ :poison ],             weight: 0, uses: 3 },

      # =========================================================================
      # EQUIPMENT — GEAR & TOOLS
      # =========================================================================
      "obj:adventuring_gear"     => { text: "adventuring gear",    tags: [ :gear ],               weight: 1, uses: nil },
      "obj:spellbook"            => { text: "spellbook",           tags: [ :gear, :fragile ],     weight: 1, uses: nil },
      "obj:bag_of_books"         => { text: "bag of books",        tags: [ :gear ],               weight: 2, uses: 5   },
      "obj:holy_symbol"          => { text: "holy symbol",         tags: [ :gear, :divine ],      weight: 0, uses: nil },
      "obj:mark_of_faith"        => { text: "mark of faith",       tags: [ :gear, :divine ],      weight: 0, uses: nil },
      "obj:land_token"           => { text: "land token",          tags: [ :gear ],               weight: 0, uses: nil },
      "obj:rune_chisels"         => { text: "rune chisels",        tags: [ :gear, :tools ],       weight: 0, uses: nil },
      "obj:rope"                 => { text: "rope",                tags: [ :gear ],               weight: 1, uses: nil },
      "obj:ostentatious_clothes" => { text: "ostentatious clothes", tags: [ :worn ],               weight: 0, uses: nil }
    }.freeze

    module_function

    def get(key)
      return nil unless REGISTRY.key?(key)

      {
        key: key,
        name: I18n.t("dungeon_world.registry.#{key.tr(':', '.')}.name"),
        description: I18n.t("dungeon_world.registry.#{key.tr(':', '.')}.description"),
        **REGISTRY[key]
      }
    end

    def exists?(key)
      REGISTRY.key?(key)
    end

    def all
      REGISTRY.keys.map { |key| get(key) }
    end

    def by_prefix(prefix)
      REGISTRY.keys.select { |key| key.start_with?("#{prefix}:") }.map { |key| get(key) }
    end
  end
end
