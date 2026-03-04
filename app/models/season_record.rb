class SeasonRecord < ApplicationRecord
  self.table_name = "seasonrecords"
  alias_attribute :playoff, :Playoff
  alias_attribute :year, :Year
  alias_attribute :wins, :W
  alias_attribute :losses, :L
  alias_attribute :ties, :T
  def record
    if ties > 0
      "#{wins}-#{losses}-#{ties}"
    else
      "#{wins}-#{losses}"
    end
  end
  def self.current
    SeasonRecord.find_by(Year: Time.current.year)
  end
end
