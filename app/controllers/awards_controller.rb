class AwardsController < ApplicationController
  before_action :set_award, only: %i[ show edit update destroy ]
  before_action :set_player, only: [ :new, :create ]
  before_action :authenticate_admin!
  # GET /awards or /awards.json
  def index
    @player = Player.find(params[:player_id])
    @awards = @player.awards
  end

  # GET /awards/1 or /awards/1.json
  def show
  end

  # GET /awards/new
  def new
    @award = @player.awards.new
  end

  # GET /awards/1/edit
  def edit
    @award = @player.awards.find(params[:id])
    @player = @award.player
  end

  # POST /awards or /awards.json
  def create
    @player = Player.find(params[:player_id])
    @award = @player.awards.build(award_params)

    respond_to do |format|
      if @award.save
        format.html { redirect_to player_path(@player), notice: "Award was successfully created." }
        format.json { render :show, status: :created, location: @award }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /awards/1 or /awards/1.json
  def update
    respond_to do |format|
      if @award.update(award_params)
        format.html { redirect_to @award, notice: "Award was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @award }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awards/1 or /awards/1.json
  def destroy
    @award.destroy!

    respond_to do |format|
      format.html { redirect_to player_awards_path(@award.player), notice: "Award was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_award
      @award = Award.find(params.expect(:id))
    end
    def set_player
      @player = Player.find(params[:player_id])
    end
    # Only allow a list of trusted parameters through.
    def award_params
      params.expect(award: [ :award, :Player_id ])
    end
end
