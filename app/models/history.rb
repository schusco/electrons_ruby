class History < ApplicationRecord
  self.table_name = "history"
  alias_attribute :category, :Category
  alias_attribute :data, :Data
  alias_attribute :year_start, :YearStart
  alias_attribute :year_end, :YearEnd
  alias_attribute :finish, :Finish
  self.primary_key = "id"
  self.inheritance_column = :Category
  def self.find_sti_class(type_name)
    case type_name
    when "Stadium" then StadiumHistory
    when "Franchise" then FranchiseHistory
    when "Championship" then PlayoffHistory
    when "Result" then ResultsHistory
    when "Manage" then ManagerHistory
    when "Retired" then RetiredNumberHistory
    else
      super
    end
  end
end
