class GameschedulesController < ApplicationController
    before_action :set_next_game, only: [ :home ]
    before_action :set_month_games, only: [ :index ]
    before_action :set_game, only: [ :show ]
  # GET /gameschedules or /gameschedules.json
  def index
  end

  # GET /gameschedules/1 or /gameschedules/1.json
  def show
  end
  def home
    @jumbo_text = Rails.application.config_for(:announcement)[:jumbo_text] || "Welcome to the Electrons Baseball Club!"
  end
  # GET /gameschedules/new
  def new
    @gameschedule = Gameschedule.new
  end

  # GET /gameschedules/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_next_game
      @game = Gameschedule.where("Game_Date > ?", Time.current).order(:Game_Date).first
      @teams = Team.active.order(:Division, W: :desc, L: :asc)
    end
    def set_month_games
      @view = ScheduleView.new(params[:year].to_i, params[:month].to_i, view_context)
    end
    def set_game
      @game = Gameschedule.find(params[:id])
      @game_pitching_rows = @game.pitching_stats.map { |stat| PitchingStatsRow.from(stat) }
      @game_hitting_rows = @game.hitting_stats.map { |stat| HittingStatsRow.from(stat) }
    end
    # Only allow a list of trusted parameters through.
    def gameschedule_params
      params.expect(gameschedule: [ :Game_Date ])
    end
end
