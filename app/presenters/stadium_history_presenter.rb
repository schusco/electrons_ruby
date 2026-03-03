class StadiumHistoryPresenter < HistoryPresenter
  include DateCalculatable
  def category_name
    "Stadium History"
  end
  def table_headers
    [ "Stadium", "Years", "Seasons" ]
  end
end
