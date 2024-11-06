# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  allow_browser versions: :modern
  before_action :set_locale

  def update_locale
    if current_user && params[:locale].in?(I18n.available_locales.map(&:to_s))
      current_user.update(locale: params[:locale])
      I18n.locale = params[:locale]
      flash[:notice] = "#{I18n.t('controllers.application.locale_updated')} #{params[:locale].upcase}"
    end
    head :ok
  end

  private

  def set_locale
    I18n.locale = current_user&.locale || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
