class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update ]
  before_action :authenticate_admin!, only: [ :new, :create, :edit, :update ]

  # GET /players or /players.json
  def index
    @players = Player.current.order(:uniform)
  end

  # GET /players/1 or /players/1.json
  def show
  end

  def new
    @player = Player.new
  end
  # POST /players or /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: "Player was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @view = PlayerProfileView.new(Player.find(params.expect(:id)))
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.expect(player: [ :Player_ID, :First_Name, :Last_Name, :Current, :Bats, :Throws, :POS1, :POS2, :POS3, :Nickname, :Hometown, :Divorces, :DOB, :Height, :Weight, :Image, :uniform, :email ])
    end
end
