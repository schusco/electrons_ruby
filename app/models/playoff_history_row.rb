class PlayoffHistoryRow < ApplicationRecord
  self.table_name = "playoffhistory"
  alias_attribute :year, :Year
  alias_attribute :record, :Record
  alias_attribute :result, :Result
end
