# frozen_string_literal: true

class RoleFunctions
  MENU_ABILITY_MODELS = [
    %w[Hesaplar users_path],
    %w[Roller roles_path],
    %w[Takımlar teams_path]
  ].freeze

  def self.menu_ability_models
    MENU_ABILITY_MODELS
  end
end
