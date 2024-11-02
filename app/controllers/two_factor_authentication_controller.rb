# frozen_string_literal: true

class TwoFactorAuthenticationController < ApplicationController
  def verify
    if current_user.validate_and_consume_otp!(params[:otp_code])
      redirect_to root_path, notice: t("controllers.two_factor_authentication.success")
    else
      flash.now[:alert] = t("controllers.two_factor_authentication.invalid_code")
      render :two_factor
    end
  end
end
