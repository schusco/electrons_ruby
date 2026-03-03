class ResultsHistoryPresenter < HistoryPresenter
  def initialize(history, live_record = nil)
    super(history)
    @live_record = live_record
  end
  def category_name
    "Year by Year Results"
  end
  def table_headers
    [ "Season", "Record", "Finish" ]
  end
  def display_fields
    [ :year_start, :data, :finish ]
  end
  def data(live_record = nil)
      if current_year? && live_record.present?
        live_record["record"]
      else
        @history.data
      end
  end

  private
  def current_year?
    @history.year_start == Time.current.year.to_s
  end
end
