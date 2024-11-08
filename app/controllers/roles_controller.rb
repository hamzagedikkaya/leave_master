# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :authorize_user_access, only: %i[index new create edit update destroy]
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
      redirect_to roles_path, notice: t("controllers.roles.create.created")
    else
      render :new
    end
  end

  def update
    selected_abilities = params[:role][:ability] || {}
    ability_hash = {}

    selected_abilities.each do |path, actions|
      ability_hash[path] = actions
    end

    @role.ability = ability_hash

    if @role.update(role_params.except(:ability))
      redirect_to roles_path, notice: t("controllers.roles.update.updated")
    else
      render :edit
    end
  end

  def destroy; end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, :ability, menu: [])
  end

  def authorize_user_access
    path = "#{controller_name}_path"
    action = action_name.to_s

    user_roles = current_user.user_roles
    user_roles.each do |user_role|
      role = user_role.role
      abilities = role.ability

      return true if abilities[path]&.include?(action)
    end

    redirect_to root_path, alert: t("controllers.authorize_user_access")
  end
end
