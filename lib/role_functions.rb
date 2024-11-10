# frozen_string_literal: true

class RoleFunctions
  MENU_ABILITY_MODELS = [
    %w[Hesaplar users_path],
    %w[Roller roles_path]
  ].freeze

  USER_ABILITY_MODELS = [%w[Görüntüleme index], %w[Oluşturma new], %w[Güncelleme create], %w[Düzenleme edit], %w[Güncelleme update], %w[Silme destroy]].freeze
  ROLE_ABILITY_MODELS = [%w[Görüntüleme index], %w[Oluşturma new], %w[Güncelleme create], %w[Düzenleme edit], %w[Güncelleme update], %w[Silme destroy]].freeze

  ALL_ABILITY_MODELS = {
    "users_path" => USER_ABILITY_MODELS,
    "roles_path" => ROLE_ABILITY_MODELS
  }.freeze

  def self.get_abilities_for_path(path)
    ALL_ABILITY_MODELS[path] || []
  end

  def self.menu_ability_models
    MENU_ABILITY_MODELS
  end
end
