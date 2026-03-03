class PitchingStat < ApplicationRecord
  self.table_name = "pitchingstats"
  belongs_to :player, foreign_key: "Player_ID", primary_key: :Player_ID
  belongs_to :gameschedule, foreign_key: "Game_ID", primary_key: :Game_ID
  alias_attribute :player_id, :Player_ID
  alias_attribute :decision, :Decision
  alias_attribute :gs, :GS
  alias_attribute :ip, :IP
  alias_attribute :bf, :BF
  alias_attribute :h, :H
  alias_attribute :r, :R
  alias_attribute :er, :ER
  alias_attribute :bb, :BB
  alias_attribute :k, :K
  alias_attribute :hb, :HB
  alias_attribute :hr, :HR
  def year
    gameschedule.Game_Date.year
  end
  def wins
    [ "W", "BS,W" ].include?(decision) ? 1 : 0
  end
  def losses
    [ "L", "BS,L" ].include?(decision) ? 1 : 0
  end
  def saves
    decision == "S" ? 1 : 0
  end
  def saves_opportunities
    [ "S", "BS,L", "BS,W" ].include?(decision) ? 1 : 0
  end
  def games
    1
  end
end
