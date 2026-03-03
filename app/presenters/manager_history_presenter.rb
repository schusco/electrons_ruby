class ManagerHistoryPresenter
  def self.wrap(history)
    ManagerHistoryPresenter.new(history)
  end
  attr_reader :history
  def initialize(history)
    @history = history
  end
  delegate :years, :record, :manager, :seasons, to: :history
  def category_name
    "Managerial History"
  end
  def table_headers
    [ "Manager", "Years", "Record" ]
  end
  def display_fields
    [ :manager, :years, :record ]
  end
  def seasons
    history.seasons
  end
end
