class RetiredNumberHistory < History
  def self.sti_name
    "Retired"
  end
  def category_name
    "Retired Numbers"
  end
end
