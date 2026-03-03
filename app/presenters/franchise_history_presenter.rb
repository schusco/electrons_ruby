class FranchiseHistoryPresenter < HistoryPresenter
  include DateCalculatable
  def category_name
    "Franchise History"
  end
  def table_headers
    [ "Team Name", "Years", "Seasons" ]
  end
end
