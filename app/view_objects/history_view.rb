class HistoryView
  attr_reader :history_data

  def initialize
  end
  def manager_playoff_records
    HistoryReportService.playoff_records
  end
  def stadium_history
    StadiumHistory.all.map  { |h| StadiumHistoryPresenter.wrap(h) }
  end
  def franchise_history
    FranchiseHistory.all.map { |h| FranchiseHistoryPresenter.wrap(h) }
  end
  def manager_history
    all_manager_history.reject { |h| h.manager == "Total" }
  end
  def manager_total
    all_manager_history.find { |h| h.manager == "Total" }
  end
  def playoff_history
    PlayoffHistoryRow.all.map do |h|
      real_record=PlayoffHistory.find_by(year_start: h.year)
      PlayoffHistoryPresenter.new(real_record, h)
    end
  end
  def current_season_record
    HistoryReportService.current_season_record
  end
  def results_history
    results_history = ResultsHistory.all.map { |h| ResultsHistoryPresenter.wrap(h) }
    current_year_row = results_history.find { |h| h.year_start == Time.current.year.to_s }
    if current_year_row.present? && current_season_record.present?
      current_year_row.history.data = current_season_record.record
    end
    results_history
  end
  def retired_numbers
    RetiredNumberHistory.all.map do |h| RetiredNumberHistoryPresenter.new(h) end
  end

  def notable_players
    PlayerHistory.all.map do |h| NotablePlayerPresenter.new(h) end
  end
  private

  def all_manager_history
    ManagerRecords.all.map do |h| ManagerHistoryPresenter.new(h) end
  end
end
