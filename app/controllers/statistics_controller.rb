class StatisticsController < ApplicationController
  before_action :get_stats_by_year, only: [ :index, :show ]
  def index
  end

  def records
    category = params[:hit].present? ? params[:hcategory] : params[:pcategory]
    if params[:hit].present?
      type = "hit"
      scope = params[:hscope]
    elsif params[:pitch].present?
      type = "pitch"
      scope = params[:scope]
    end

    @view = RecordsView.new(category, scope, type)
  end
  def export
    package = StatisticsReportService.export(params[:id].to_i, params[:playoffs].downcase == true)
    send_data package.to_stream.read,
              filename: "stats.xlsx",
              type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end
  private
    def get_stats_by_year
      @view = StatisticsView.new(params[:id].to_i, params[:playoffs].present?)
    end
end
