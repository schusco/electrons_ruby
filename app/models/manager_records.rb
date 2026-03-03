class ManagerRecords < ApplicationRecord
  self.table_name = "managerrecords"
  alias_attribute :manager, :Manager
  alias_attribute :years, :Years
  alias_attribute :record, :Record
  alias_attribute :seasons, :Seasons
  alias_attribute :games, :Games
  default_scope { order(years: :asc) }
  def category_name
    "Managerial History"
  end
end
