class Admin::BaseHistoriesController < ApplicationController
  before_action :set_history, only: %i[ edit update destroy show ]
  before_action :authenticate_admin!
  # This controller can be used as a base for other history controllers to share common functionality if needed.
  # PATCH/PUT /histories/1 or /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to history_index_path, notice: "History was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end
  # DELETE /histories/1 or /histories/1.json
  def destroy
    @history.destroy!

    respond_to do |format|
      format.html { redirect_to history_index_path, notice: "History was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def check_uniqueness
    exists = History.exists?(YearStart: params[:year], Category: params[:category])
    render json: { available: !exists }
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params.expect(:id))
    end
    def history_params
      model_name = @history.class.name.underscore.to_sym
      # If that fails (e.g., on a generic History object), fall back to :history
      param_key = params.has_key?(model_name) ? model_name : :history
      params.require(param_key).permit(:YearStart, :YearEnd, :Data, :Finish)
    end
end
