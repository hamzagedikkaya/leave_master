# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :check_two_factor_authentication
  allow_browser versions: :modern

  private

  def check_two_factor_authentication
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end

    if current_user.otp_required_for_login?
      redirect_to two_factor_setup_users_path
    else
      redirect_to root_path
    end
  end
end
