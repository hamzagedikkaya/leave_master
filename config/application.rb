# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LeaveMaster
  class Application < Rails::Application
    config.load_defaults 7.2

    # TR = Turkish, EN = English, De = German, Fr = French, KA = Georgian
    # HR = Crotian, KK = Kazakh, LV = Latvian, MK = Macedonian, RU = Russian
    config.i18n.available_locales = %i[tr en de fr ka hr kk lv mk ru]
    config.i18n.default_locale = :en
    config.i18n.load_path += Rails.root.glob("config/locales/**/*.{rb,yml}")

    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = "Istanbul"

    # TODO: image eklerken hata veriyor.
    # config.active_job.queue_adapter = :sidekiq
    config.exceptions_app = routes

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
