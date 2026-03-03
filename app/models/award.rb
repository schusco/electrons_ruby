class Award < ApplicationRecord
  belongs_to :player, foreign_key: "Player_id"
  scope :player, -> { where(Player_id: params[:player_id]) }
end
