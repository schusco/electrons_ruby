class ResultsHistory < History
  validates :YearStart, uniqueness: {
    scope: :Category,
    message: "A record for this season already exists. Please edit the existing record instead."
  }
  def self.sti_name
    "Result"
  end
  def category_name
    "Year by Year Results"
  end
end
