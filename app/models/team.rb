class Team < ApplicationRecord
  self.table_name = "teams"
  self.primary_key = "Team"
  alias_attribute :name, :Team
  alias_attribute :wins, :W
  alias_attribute :losses, :L
  alias_attribute :ties, :T
  alias_attribute :forfeits, :F
  alias_attribute :division, :Division
  alias_attribute :active, :Active
  alias_attribute :franchise_id, :Franchise_ID

  scope :active, -> { where(Active: true) }

  # Winning percentage helper
  def win_percentage
    total_games = wins.to_i + losses.to_i + ties.to_i
    return 0 if total_games.zero?

    ((wins.to_f + (ties.to_f * 0.5)) / total_games).round(3)
  end

  def standings_points
    (wins.to_i * 2) + ties.to_i - (forfeits.to_i * 2)
  end
  def logo_path
    "/images/logos/nextOuting_#{name.gsub(/\s+/, '').downcase}.png"
  end
end
