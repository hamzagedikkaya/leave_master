# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  allow_browser versions: :modern
  before_action :set_locale

  private

  def set_locale
    I18n.locale = current_user&.locale || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
