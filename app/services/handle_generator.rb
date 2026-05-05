class HandleGenerator
  ADJECTIVES = %w[
    ancient arcane blazing bold brave bright crimson crystal dark dawn
    deep divine dread dusk elder eternal fading fallen flame frost
    gilded grim golden gray hidden high holy hollow ice iron
    jade light lost lunar midnight mystic night noble obsidian radiant
    raging royal runic sacred shadow silent silver sky stark steel
    storm swift thorn thunder twilight void wandering wild wise ashen
    azure blessed broken burning celestial clouded cobalt copper cursed dancing
    dawning dire drifting dusky dusty ebon echoing electric emerald enchanted
    endless fabled feral fiery fleeting flying forged forgotten frozen gentle
    ghostly gleaming glimmering glorious glowing green hallowed haunted howling icy
    infernal ivory jagged keen kindled magical molten moonlit mortal murky
    oaken pale phoenix platinum pristine pure raven red rising risen
    roaring ruby rustic scarlet serene shaded shattered shimmering shining singing
    smoldering soaring solemn spectral starlit steadfast stormy sunlit thunderous towering
    tranquil umbral undying vengeful verdant violet warded waxing weary whirling
    white wicked winged winter withered woven wrathful zealous amber astral
    barren black bleak blighted blue bone bound brass breaking brilliant
    bronze carved chained charmed chill chosen clouded cold colossal constant
    coral crowned daring darkened deathless defiant diamond dim dormant draconic
    dreaming dreadful dying earthen ebony eldritch elegant enraged ethereal
    exalted fair faithful fated fearless fierce final first flaming flickering
    flowing forbidden forsaken fractured free frigid frostbound furious glittering grand
    granite grave great grieving guarded heavenly hoary honored humble hungry
    immortal imperial infinite inner kingly lasting legendary lethal lone loyal
    lurking maddening marble marked mighty mirrored misty mournful nameless nether
    northern ochre onyx opal oracle outer pearl phantom primal reckless
    regal relentless restless righteous rogue rolling running savage scorched secret
    shadowed shielded sleeping sorcerous stalwart star steeped still stone strange
    strong sundered sunken supreme sworn tarnished tempest threaded thundering timeless
    topaz veiled vigilant waning wary weathered western whispering writhing
    yielding zephyr amber angry arcane ashen astral barbed battle bitter
    blazing bleeding blessed blinding blissful bloody blue bold bone brazen
    bright brittle bronze brutal burning calm carved charred chill cloaked
    coiled crimson cruel cunning cursed daring deadly deft demonic dim
    doomed dripping dull dusky dusty dying eager earthen ebon elder
    elven endless errant ethereal fading fateful fearsome fertile fierce final
    fire flaming fleeting flowing forgotten foul fractured free frigid frozen
    furious gilded gleaming gloomy glowing golden granite grasping grave grim
    guarded hallowed hanging harsh haunted heavy hidden hoary hollow holy
    horned howling humble hungry icy immortal infernal inner ivory jagged
    keen kindled lasting laughing lethal lonely lost loyal lunar lurking
    mad majestic marble marked martial mighty mindful mirrored misty molten
    moon moonlit mortal moss mourning murky mystic nameless nether northern
    oaken obsidian ochre onyx opal oracle outer pale patient pearl
    phantom piercing platinum primal pristine proud purple pure radiant raging
    raven reckless regal relentless restless righteous risen roaring rogue rolling
    rotting royal ruby ruined runic running sacred sapphire savage scarlet scorched
    sealed secret serene shadowed shattered shielded shimmering shining shrouded silent singing
    sleeping slumbering smoldering soaring solemn somber sorcerous spectral stained stalwart starlit
    steadfast steep steeped stellar still stone stormy stout strange striding strong
    sublime sundered sunken sunlit supreme surging sworn tainted tarnished tattered tempered
    tempest terrible thorn thorned threaded thundering timeless topaz towering tranquil trembling
    true twilight twisted umbral undying unearthly unending unfading unholy unknown unseen
    untamed unyielding vain valiant vast veiled vengeful verdant vigilant vigorous violet
    vital vivid waking wandering waning wanted warded warped wary wasted waxing
    weary weathered weeping western whirling whispering white wicked wild windy winged
    winter wise withered woeful wooden worn wounded woven wrathful writhing wrought
    yielding young zealous
  ].freeze

  PROFESSIONS = %w[
    alchemist archer arcanist artificer assassin astrologer augur avenger axeman balladeer
    bandit barbarian bard beastlord beastmaster berserker blacksmith bladedancer blademaster bladeweaver
    bloodmage bomber bounty brewer brewmaster brigand buccaneer butcher caller cannoneer
    captain cartographer carver castellan cavalier channeler charlatan chemist chieftain chronicler
    cleric colonist conjurer conjuror conqueror corsair courtesan craftsman crossbowman crusader
    cutthroat dancer darkmage dawnbringer dawnseeker deadeye deathknight defender demonhunter dervish
    diplomat diviner doomsayer dragonknight dragonslayer dreadknight dreadlord dreamwalker druid duelist
    dungeoneer earthshaper elder emissary enchanter enforcer engineer envoy executioner exile
    exorcist explorer fabricator falconer farseer firebrand flamecaller flamedancer fencer fighter
    forager forgemaster fortune founder frostmage frostwarden gaoler gardener geomancer gladiator
    glyphkeeper godslayer gravekeeper gravedigger guardian gunslinger hangman harbinger harpooner haruspex
    healer hellknight herbalist herald hermit hero hexblade hierophant highlander horseman hunter
    icemage illusionist inquisitor invoker ironclad jester juggler justicar keeper kingslayer
    knightmare knight lancer lantern leatherworker liberator lightbearer lightbringer lionheart lookout
    lorebinder lorekeeper loremaster machinist mage mageslayer magistrate marauder marksman marshal
    martyr mason mastermind mayor mender mercenary merchant messenger mindbreaker miner minstrel
    monk moonkeeper mountaineer mystic mysticblade necromancer nethermancer nightblade nomad occultist
    oathbreaker oathkeeper oracle outlaw outrider overlord paladin pathfinder pathseeker peacekeeper
    performer philosopher physician pilgrim pioneer pirate pitfighter plaguebearer planeswalker poisoner
    portent potionmaster preacher priest prophet protector provost pugilist pyromancer questant
    raider ranger ravager reaper rebel reclaimer recluse renegade revenant rider rifleman
    riftwalker ritualist ronin rogue runeblade runecarver runekeeper runemaster runesmith runescribe
    saboteur sage samurai savant scavenger scholar scoundrel scout scribe sculptor sellsword
    sentinel sentry sergeant shadowblade shadowcaster shadowdancer shadowhunter shadowmancer shadowrunner shaman
    shamankeeper shaman shaper sharpshooter shepherd shieldbearer shieldbreaker shipwright singer skald
    skirmisher skyguard slayer slayerblade smith smuggler sniper soldier soothsayer sorcerer
    soulbinder soulkeeper soultaker sovereign spearman spellblade spellbreaker spellcaster spellkeeper spellslinger
    spellsword spellweaver spiritkeeper spy stalker starcaller stargazer starseeker steward stonebreaker
    stonekeeper stonemason stoneshaper stormbringer stormcaller stormchaser stormrider stormseeker storyteller strategist
    striker summoner sunbringer suncaller sunkeeper sunseeker surgeon survivalist swordbearer sworddancer swordmaster
    swordsage tactician tamer taskmaster templar thaumaturge thief thundercaller tidecaller tidekeeper
    timekeeper tinker torchbearer tracker trader trapper traveler treasure trickster troubadour vagabond
    vanguard veteran villager vindicator vinter wanderer warden warlock warlord warpriest warrior
    warsinger watcher watchman watchtower wavebreaker wavebringer wayfarer weaponmaster weaver whaler wildshaper
    wildstalker windrider witch witchhunter wizard wordkeeper wordsmith wright zealot acrobat admiral
    advocate analyst anchor angler annalist apothecary arbiter archmage armorer armsmaster architect
    artist baker banker binder boatman boatswain bowman brandisher broker burglar buyer
    caller cantor carpenter caster catcher chanter charmer chef chronicler cleaver climber
    clothier cobbler collector commander composer cook cooper counselor courier crafter crier
    cultivator curator dealer designer diplomat distiller diver doctor dowser draper drifter
    driver drummer dyer elder embalmer embroiderer enchanter engraver entertainer escort evaluator
    excavator farmer farrier ferryman fiddler fisher fletcher florist forester founder friar
    gambler gatherer gilder glazier gleaner governor grinder grocer guide hacker handler
    harvester hauler hawker healer herder hirer historian hoarder hostler huntsman hussar
    illustrator innovator inspector inventor jeweler jongleur journeyman judge juggler keeper laborer
    leader legislator librarian linguist locksmith logician lookout lumberjack magician magistrate maker
    manager mariner mason mediator mentor miller miner mixer navigator negotiator observer
    officer orator organizer overseer packmaster painter patcher pathmaker patron peddler performer
    pharmacist piper planner planter poet porter potter preserver procurer producer provisioner
    quartermaster racer rancher receiver recordkeeper rector regent registrar regulator researcher rider
    rigger runner saddler sailor sayer scaler sealer seaman searcher seer selector
    sender settler sewer shaper shepherd shipper shopper sider sighter singer skinner
    slinger smith snarer soarer speaker spinner squire stablehand stamper starter stationer
    stitcher stockman storer striker stringmaster supplier surveyor sweeper swimmer tailor tanner
    taxer teacher tender tester thatcher thinker tiler timer tinkerer toiler toolmaker
    torturer tosser trader trainer trawler traveler treasurer treader trimmer tuner turner
    tutor undertaker urchin usher valet validator vendor vintner violinist visitor voyager wainwright
    walker wanderer warder warrior washer watcher weaver weigher whaler wheelwright whisperer
    winner worker writer
  ].freeze

  def self.generate_for(identity)
    base_handle = extract_base_handle(identity)
    ensure_unique(base_handle)
  end

  private

  def self.extract_base_handle(identity)
    handle = case identity.provider
    when "telegram"
      identity.data["username"] || generate_fantasy_handle
    when "email", "google"
      email = identity.data["email"]
      email&.split("@")&.first || generate_fantasy_handle
    else
      generate_fantasy_handle
    end

    clean(handle)
  end

  def self.generate_fantasy_handle
    "#{ADJECTIVES.sample}_#{PROFESSIONS.sample}"
  end

  def self.clean(handle)
    handle.downcase.gsub(/[^a-z0-9_]/, '')
  end

  def self.ensure_unique(base_handle)
    return base_handle unless Account.exists?(handle: base_handle)

    10.times do
      code = format("%04d", rand(10000))
      handle_with_code = "#{base_handle}_#{code}"
      return handle_with_code unless Account.exists?(handle: handle_with_code)
    end

    "#{base_handle}_#{Time.now.to_i % 10000}"
  end
end
