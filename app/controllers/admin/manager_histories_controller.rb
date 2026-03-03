class Admin::ManagerHistoriesController < Admin::BaseHistoriesController
  def new
    @manager_history = ManagerHistory.new
  end

  def show
    @manager_history = ManagerHistory.find(params[:id])
    @presenter = ManagerHistoryPresenter.wrap(@manager_history)
  end
end
