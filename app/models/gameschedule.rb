class Gameschedule < ApplicationRecord
  alias_attribute :hv, :HV
  alias_attribute :opponent, :Opponent
  alias_attribute :notes, :Notes
  alias_attribute :game_date, :Game_Date
  self.table_name = "gameschedule"
  self.primary_key = "Game_ID"
  belongs_to :location, foreign_key: "LocationId", optional: true
  has_many :hitting_stats, foreign_key: "Game_ID", primary_key: "Game_ID"
  has_many :pitching_stats, foreign_key: "Game_ID", primary_key: "Game_ID"
  has_many :innings, foreign_key: "GameId", primary_key: "Game_ID", dependent: :destroy

  def home_logo
    get_path("H")
  end

  # Returns the path to the away logo asset
  def away_logo
    get_path("V")
  end

  def home_team
    hv == "H" ? "Electrons" : opponent
  end
  def away_team
    hv == "V" ? "Electrons" : opponent
  end
  def date_and_location
    "#{game_date.utc.strftime("%A, %B %-d, %Y %-I:%M %p")} @ #{location.field_name}, #{location.city_state}"
  end
  def home_total_runs; innings.sum(:Hruns); end
  def away_total_runs; innings.sum(:Aruns); end

  def home_total_hits; innings.sum(:Hhits); end
  def away_total_hits; innings.sum(:Ahits); end

  def home_total_errors; innings.sum(:Herrors); end
  def away_total_errors; innings.sum(:Aerrors); end

  def total_innings_to_display
    # Get the highest inning number from the association
    max_inning = innings.maximum(:Inning) || 0
    # Always show at least 7
    [ max_inning, 7 ].max
  end

  private

  def get_path(home_away)
    if home_away == hv
      "/images/logos/nextOuting_electrons.png"
    else
      "/images/logos/nextOuting_#{opponent.gsub(/\s+/, '').downcase}.png"
    end
  end
end
