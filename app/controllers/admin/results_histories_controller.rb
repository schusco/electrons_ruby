class Admin::ResultsHistoriesController < Admin::BaseHistoriesController
  def show
    @results_history = ResultsHistory.find(params[:id])
    @presenter = ResultsHistoryPresenter.wrap(@results_history)
  end
  def new
    @results_history = ResultsHistory.new
  end

  def create
    @results_history = ResultsHistory.new(results_history_params)
    if @results_history.save
      redirect_to history_index_path, notice: "Results history created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def results_history_params
    params.require(:results_history).permit(:YearStart, :YearEnd, :Data, :Finish)
  end
end
