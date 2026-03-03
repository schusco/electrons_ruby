class HistoryPresenter
  def self.wrap(history)
    case history.category
    when "Franchise"
      FranchiseHistoryPresenter.new(history)
    when "Stadium"
      StadiumHistoryPresenter.new(history)
    when "Result"
      ResultsHistoryPresenter.new(history)
    when "Retired"
      RetiredNumberHistoryPresenter.new(history)
    else
      HistoryPresenter.new(history)
    end
  end
  attr_reader :history
  delegate :to_param, :model_name, :persisted?, to: :history
  delegate :category, :data, :year_start, :year_end, :years, :record, :manager, :finish, to: :history
  def initialize(history)
    @history = history
  end
  def to_param
    history.to_param
  end
  def table_headers
    []
  end
  def display_fields
    []
  end
  def seasons; "N/A"; end
  def total_years; nil; end
  def category_name; category; end
end
