module GameSystems
  LIST = [
    :dungeon_world,
    :mork_borg,
    :dnd5e
  ].freeze

  module_function

  def character_type(system)
    if LIST.include?(system.to_s.to_sym)
      "#{system.to_s.camelize}::Character".constantize
    end
  end
end
