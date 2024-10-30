# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: %i[edit update]

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def edit; end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path, notice: t("roles.created")
    else
      render :new
    end
  end

  def update
    if @role.update(role_params)
      redirect_to roles_path, notice: t("roles.updated")
    else
      render :edit
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
