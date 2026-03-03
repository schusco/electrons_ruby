class PlayoffHistoryPresenter
  attr_reader :history
  attr_reader :display_data
  delegate :to_param, :model_name, :persisted?, to: :history
  delegate :year, :record, :result, to: :display_data

  def initialize(history, display_data = nil)
    @display_data = display_data
    @history = history
  end

  def self.wrap(history)
    new(history)
  end
  def category_name
    "Championship History"
  end
  def table_headers
    [ "Season", "Record", "Result" ]
  end
  def display_fields
    [ :year, :record, :result ]
  end
  def to_param
    history.to_param
  end
end
