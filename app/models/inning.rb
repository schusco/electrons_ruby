class Inning < ApplicationRecord
  self.primary_key = [ :GameId, :Inning ]

  belongs_to :gameschedule, foreign_key: "GameId"
  default_scope { order(Inning: :asc) }
end
