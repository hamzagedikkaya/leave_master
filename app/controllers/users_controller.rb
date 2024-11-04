# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit]

  def index
    @user.generate_otp_secret if @user.otp_secret.blank?
  end

  def show; end

  def edit; end

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
