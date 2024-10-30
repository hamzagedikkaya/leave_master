# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def permission?(action)
    current_user.permission?(action)
  end
end
