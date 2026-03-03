class Admin::PlayoffHistoriesController < Admin::BaseHistoriesController
  def new
    @playoff_history = PlayoffHistory.new
  end
  def show
    @playoff_history = PlayoffHistory.find(params[:id])
    @presenter = PlayoffHistoryPresenter.wrap(@playoff_history)
  end
  def create
    @playoff_history = PlayoffHistory.new(playoff_history_params)
    if @playoff_history.save
      redirect_to history_index_path, notice: "Playoff history created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def playoff_history_params
    params.require(:playoff_history).permit(:year_start, :year_end, :finish)
  end
end
