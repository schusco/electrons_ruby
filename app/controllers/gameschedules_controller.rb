require "ostruct"

class GameschedulesController < ApplicationController
    before_action :set_next_game, only: [ :home ]
    before_action :set_month_games, only: [ :index ]
    before_action :set_game, only: [ :show, :edit, :update, :live ]
  # GET /gameschedules or /gameschedules.json
  def index
  end

  # GET /gameschedules/1 or /gameschedules/1.json
  def show
  end
  def home
    @jumbo_text = Rails.configuration.settings[:announcement] || "Welcome to the Electrons Baseball Club!"
  end
  # GET /gameschedules/new
  def new
    @gameschedule = Gameschedule.new
  end
  def live
    game_recap_path=Rails.root.join("public", "data", "recaps", "game_recap_#{@game.id}.json")
    if File.exist?(game_recap_path)
      @view = LiveGameView.new(@game, game_recap_path)
      render layout: "recap"
    else
      render "show"
    end
  end
  def last_updated
    recap_path = Rails.root.join("public", "data", "recaps", "game_recap_#{params[:id]}.json")

    if File.exist?(recap_path)
      # Return the Unix timestamp (seconds since epoch)
      render json: { timestamp: File.mtime(recap_path).to_i }
    else
      render json: { timestamp: 0 }, status: :not_found
    end
  end
  def get_id
    opponent = params[:opponent]
    game = Gameschedule.where(opponent: opponent).order(game_date: :desc).first
    render json: { game_id: game.id }
  end
  def create
    @game = Gameschedule.new(gameschedule_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /gameschedules/1/edit
  def edit
  end
  def update
    respond_to do |format|
      if @game.update(gameschedule_params)
        format.html { redirect_to @game, notice: "Game was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_next_game
      @game = Gameschedule.where("Game_Date > ?", Time.current).order(:Game_Date).first
      @teams = Team.active.order(:Division, W: :desc, L: :asc)
    end
    def set_month_games
      year = params[:year].present? ? params[:year].to_i : Date.current.year
      month = params[:month].present? ? params[:month].to_i : Date.current.month
      @view = ScheduleView.new(year, month, view_context)
    end
    def set_game
      @game = Gameschedule.find_by("Game_ID = #{params[:id]}")
      if @game.nil?
        set_next_game
        render "home"
      end
      @game_pitching_rows = @game.pitching_stats.map { |stat| PitchingStatsRow.from(stat) }
      @game_hitting_rows = @game.hitting_stats.map { |stat| HittingStatsRow.from(stat) }
    end
    # Only allow a list of trusted parameters through.
    def gameschedule_params
      params.expect(gameschedule: [ :game_date, :opponent, :HV, :Playoff, :Finals, :Wood, :Manager, :notes, :LocationId ])
    end
end
