class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update ]
  before_action :authenticate_admin!
  # GET /awards or /awards.json
  def index
    @teams = Team.all.order(:active).reverse
  end

  # GET /awards/1 or /awards/1.json
  def show
  end

  # GET /awards/new
  def new
    @team = Team.new
  end

  # GET /awards/1/edit
  def edit
  end
  def clear
    TeamService.clear(Team.active)
    redirect_to teams_path, notice: "Team records cleared."
  end
  # POST /awards or /awards.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to teams_path, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /awards/1 or /awards/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: "Team was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params.expect(:id))
    end
    # Only allow a list of trusted parameters through.
    def team_params
      params.expect(team: [ :team, :name, :wins, :losses, :ties, :forfeits, :division, :active ])
    end
end
