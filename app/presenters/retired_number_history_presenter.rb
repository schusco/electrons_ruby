class RetiredNumberHistoryPresenter < HistoryPresenter
  def category_name
    "Retired Numbers"
  end
  def self.wrap(h)
    RetiredNumberHistoryPresenter.new(h)
  end
  def table_headers
    [ "Player", "Number", "Years" ]
  end
  def years
    first = history.year_start
    last = history.year_end
    return "Present" if last.nil?
    return first.to_s if first == last
    "#{first} - #{last}"
  end
  def display_fields
    [ :finish, :data, :years ]
  end
end
