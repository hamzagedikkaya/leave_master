# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[show edit update destroy]

  def index
    @teams = Team.all
  end

  def show; end

  def new
    @team = Team.new
  end

  def edit; end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to teams_path, notice: t("controllers.teams.create.created")
    else
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to team_path(@team), notice: t("controllers.teams.update.updated")
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path, notice: t("controllers.teams.destroy.deleted")
  end

  private

  def set_team
    @team = Team.find_by(id: params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
