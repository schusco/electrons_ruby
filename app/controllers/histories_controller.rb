class HistoriesController < ApplicationController
  # GET /histories or /histories.json
  def index
    @view = HistoryView.new
  end

  private

    # Only allow a list of trusted parameters through.
    def history_params
      params.expect(history: [ :Category, :Data, :YearStart, :YearEnd, :Finish ])
    end
end
