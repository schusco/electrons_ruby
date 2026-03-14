class Admin::PlayerHistoriesController < Admin::BaseHistoriesController
  def show
    @player_history = PlayerHistory.find(params[:id])
    @presenter = PlayerHistoryPresenter.wrap(@results_history)
  end
  def new
    @player_history = PlayerHistory.new
  end

  def create
    @player_history = PlayerHistory.new(results_history_params)
    if @player_history.save
      redirect_to history_index_path, notice: "Player history created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def results_history_params
    params.require(:player_history).permit(:Data, :Finish)
  end
end
