class HittingStat < ApplicationRecord
  self.table_name = "hittingstats"
  belongs_to :player, foreign_key: "Player_ID", primary_key: :Player_ID
  belongs_to :gameschedule, foreign_key: "Game_ID", primary_key: :Game_ID
  alias_attribute :game_id, :Game_ID
  alias_attribute :player_id, :Player_ID
  alias_attribute :at_bats, :AB
  alias_attribute :runs, :R
  alias_attribute :hits, :H
  alias_attribute :doubles, :'2B'
  alias_attribute :triples, :'3B'
  alias_attribute :home_runs, :HR
  alias_attribute :runs_batted_in, :RBI
  alias_attribute :walks, :BB
  alias_attribute :hit_by_pitch, :HBP
  alias_attribute :strikeouts, :K
  alias_attribute :stolen_bases, :SB
  alias_attribute :caught_stealing, :CS
  alias_attribute :sacrifice_bunts, :SAC
  alias_attribute :sacrifice_flies, :SF
  alias_attribute :left_on_base, :LOB
  alias_attribute :bitching, :Bitching
  alias_attribute :putouts, :PO
  alias_attribute :assists, :A
  alias_attribute :defensive_errors, :E
  def games
    1
  end
end
