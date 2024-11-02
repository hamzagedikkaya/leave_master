# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit]

  def index
    @user.generate_otp_secret if @user.otp_secret.blank?
  end

  def show; end

  def edit; end

  def two_factor_setup
    @user = current_user
    @user.generate_otp_secret if @user.otp_secret.blank?
  end

  def verify_two_factor
    @user = current_user
    if @user.verify_otp(params[:otp_code])
      redirect_to root_path
    else
      redirect_to two_factor_setup_path
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def permission?(action)
    current_user.permission?(action)
  end

  def user_params
    params.require(:user).permit(:email, :name_surname, :gsm, :date_of_birth)
  end
end
