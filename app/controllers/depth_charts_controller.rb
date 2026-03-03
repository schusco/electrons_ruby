class DepthChartsController < ApplicationController
  before_action :set_depth_chart, only: %i[ show destroy ]
  before_action :authenticate_admin!, except: %i[ index show ]
  # GET /depth_charts or /depth_charts.json
  def index
    @depth_charts = DepthChart.all
    @positions = @depth_charts.includes(:player).order(:Position, :Rank).group_by(&:position)
    @current_year = Time.current.year
  end


  # GET /depth_charts/1 or /depth_charts/1.json
  def show
  end

  # GET /depth_charts/new
  def new
    @depth_chart = DepthChart.new
  end

  # GET /depth_charts/1/edit
  def edit_position
    @position = params[:position]
    @depth_charts = DepthChart.where(Position: @position).includes(:player).order(:Rank)
  end

  # POST /depth_charts or /depth_charts.json
  def create
    @depth_chart = DepthChart.new(depth_chart_params)

    respond_to do |format|
      if @depth_chart.save
        format.html { redirect_to @depth_chart, notice: "Depth chart was successfully created." }
        format.json { render :show, status: :created, location: @depth_chart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @depth_chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /depth_charts/1 or /depth_charts/1.json
  def update_position
    puts "DEBUG: Params received: #{params[:depth_charts].inspect}"
    updates = params.require(:depth_charts).to_unsafe_h
    # Convert empty strings to nil
    ActiveRecord::Base.transaction do
      updates.each do |id, attrs|
        DepthChart.find(id).update_column(:Rank, attrs["Rank"].to_i + 1000)
      end

      # Pass 2: Move everyone to their REAL intended Rank
      updates.each do |id, attrs|
        DepthChart.find(id).update_column(:Rank, attrs["Rank"])
      end
      updates.each do |id, attrs|
        player_id = attrs["Player"].presence
        record = DepthChart.find(id)
        record.update_column(:Player, player_id) # Use update_column to skip validations and callbacks
        record.save!
      end
    end
    respond_to do |format|
      format.html { redirect_to depth_charts_path, notice: "Depth charts updated successfully." }
      format.json { render json: { status: "success" }, status: :ok }
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "DepthChart Update Failed: #{e.message}"
    redirect_to depth_charts_path, alert: "Update failed: #{e.message}"
  end

  # DELETE /depth_charts/1 or /depth_charts/1.json
  def destroy
    @depth_chart.destroy!

    respond_to do |format|
      format.html { redirect_to depth_charts_path, notice: "Depth chart was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_depth_chart
      @depth_chart = DepthChart.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def depth_chart_params
      params.require(:depth_chart).permit(:Position, :Rank, :Player)
    end
end
