class DepthChart < ApplicationRecord
  self.table_name = "dc"
  self.primary_key = "id"
  alias_attribute :position, :Position
  alias_attribute :rank, :Rank
  alias_attribute :player, :Player
  belongs_to :player, class_name: "Player", foreign_key: "Player", optional: true
  validates :Rank, presence: true
  validates :Position, presence: true
  validates :Rank, uniqueness: { scope: :Position, message: "Rank must be unique within the same position" }
  def position_name
    case position
    when 1
      "Starting Pitcher"
    when 10
      "Relief Pitcher"
    when 2
      "Catcher"
    when 3
      "First Base"
    when 4
      "Second Base"
    when 5
      "Third Base"
    when 6
      "Shortstop"
    when 7
      "Left Field"
    when 8
      "Center Field"
    when 9
      "Right Field"
    else
      "Unknown Position"
    end
  end
end
