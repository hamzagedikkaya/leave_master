# frozen_string_literal: true

require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  configure_caching
  configure_active_storage
  configure_action_mailer
  configure_deprecation_warnings
  configure_database
  configure_assets
  configure_view_annotations
  configure_controller_errors
end

def configure_caching
  if Rails.root.join("tmp/caching-dev.txt").exist?
    enable_caching
  else
    disable_caching
  end
end

def enable_caching
  Rails.application.config.action_controller.perform_caching = true
  Rails.application.config.action_controller.enable_fragment_cache_logging = true
  set_memory_store
  set_cache_headers
end

def disable_caching
  Rails.application.config.action_controller.perform_caching = false
  Rails.application.config.cache_store = :null_store
end

def set_memory_store
  Rails.application.config.cache_store = :memory_store
end

def set_cache_headers
  Rails.application.config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{2.days.to_i}" }
end

def configure_active_storage
  Rails.application.config.active_storage.service = :local
end

def configure_action_mailer
  Rails.application.config.action_mailer.raise_delivery_errors = false
  Rails.application.config.action_mailer.perform_caching = false
  Rails.application.config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
end

def configure_deprecation_warnings
  Rails.application.config.active_support.deprecation = :log
  Rails.application.config.active_support.disallowed_deprecation = :raise
  Rails.application.config.active_support.disallowed_deprecation_warnings = []
end

def configure_database
  Rails.application.config.active_record.migration_error = :page_load
  Rails.application.config.active_record.verbose_query_logs = true
  Rails.application.config.active_job.verbose_enqueue_logs = true
end

def configure_assets
  Rails.application.config.assets.quiet = true
end

def configure_view_annotations
  Rails.application.config.action_view.annotate_rendered_view_with_filenames = true
end

def configure_controller_errors
  Rails.application.config.action_controller.raise_on_missing_callback_actions = true
end
