# frozen_string_literal: true

namespace :role_management do
  desc "Create or update the Super User role with full abilities and menu"
  task create_or_update_super_user_role: :environment do
    role = Role.first

    menu_ability_models = RoleFunctions::MENU_ABILITY_MODELS
    ability = {}
    RoleFunctions::ALL_ABILITY_MODELS.each do |path, actions|
      ability[path] = actions.map(&:last)
    end

    if role
      role.update(
        name: "Super User",
        menu: menu_ability_models.map(&:last),
        ability: ability
      )
      puts "Super User role updated."
    else
      Role.create(
        name: "Super User",
        menu: menu_ability_models.map(&:last),
        ability: ability
      )
      puts "Super User role created."
    end
  end
end
