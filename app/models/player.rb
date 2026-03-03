class Player < ApplicationRecord
  self.table_name = "players"
  self.primary_key = "Player_ID"
  alias_attribute :first_name, :First_Name
  alias_attribute :last_name, :Last_Name
  alias_attribute :current, :Current
  alias_attribute :bats, :Bats
  alias_attribute :throws, :Throws
  alias_attribute :pos1, :POS1
  alias_attribute :pos2, :POS2
  alias_attribute :pos3, :POS3
  alias_attribute :nickname, :Nickname
  alias_attribute :hometown, :Hometown
  alias_attribute :divorces, :Divorces
  alias_attribute :dob, :DOB
  alias_attribute :height, :Height
  alias_attribute :weight, :Weight
  alias_attribute :image, :Image
  has_many :awards, foreign_key: "Player_id", dependent: :destroy
  has_many :hitting_stats, foreign_key: "Player_ID", dependent: :destroy
  has_many :pitching_stats, foreign_key: "Player_ID", dependent: :destroy
  enum :bats, { L: "L", R: "R", S: "S" }, prefix: true
  enum :throws, { L: "L", R: "R" }, prefix: true
  POSITIONS = { P: "P", C: "C", "1B": "1B", "2B": "2B", "3B": "3B", SS: "SS", OF: "OF", IF: "IF" }.freeze
  enum :pos1, POSITIONS, prefix: true
  enum :pos2, POSITIONS, prefix: true
  enum :pos3, POSITIONS, prefix: true
  scope :current, -> { where(Current: true) }

  def full_name
    nickname.present? ? "#{first_name} \"#{nickname}\" #{last_name}" : "#{first_name} #{last_name}"
  end
  def name_last_first
    "#{last_name}, #{first_name}"
  end
  def short_name
    "#{first_name[0]}. #{last_name}"
  end
  def short_name_last_first
    "#{last_name}, #{first_name[0]}."
  end
  def height_string
    "#{height/12}' #{height%12}\""
  end
  def weight_string
    "#{weight} lbs."
  end
  def position_string
    [ pos1, pos2, pos3 ].compact_blank.join(", ")
  end
  def year_display
    if current
      "Current Player"
    else
      years = []
      years << "Debut: #{dob.year}" if dob.present?
      years << "Final: #{dob.year + 20}" if dob.present? # Assuming a 20-year career for display purposes
      years.join(" | ")
    end
  end
  def years_played
    hitting_years = hitting_stats.joins(:gameschedule).distinct.pluck("YEAR(gameschedule.Game_Date)")
    pitching_years = pitching_stats.joins(:gameschedule).distinct.pluck("YEAR(gameschedule.Game_Date)")
    all_years = (hitting_years + pitching_years).uniq.sort

    return "N/A" if all_years.empty?
    current_year = Time.now.year
    ranges = all_years.chunk_while { |prev, curr| curr == prev + 1 }.to_a

    formatted_ranges = ranges.map do |range|
      start_yr = range.first
      end_yr = range.last

      if start_yr == end_yr
        # Handle single years (e.g., "2018")
        start_yr == current_year ? current_year.to_s : start_yr.to_s
      else
        # Handle ranges (e.g., "2018-2019")
        # If the range ends this year, use "Present"
        display_end = (end_yr == current_year) ? "Present" : end_yr
        "#{start_yr}-#{display_end}"
      end
    end
    ranges_string = formatted_ranges.join(", ")

    if all_years.length == 1 && all_years.first == current_year
      "Rookie"
    elsif all_years.length == 1
      "1 year (#{all_years.first})"
    else
      "#{all_years.length} years (#{ranges_string})"
    end
  end
  def rookie_year
    hitting_years = hitting_stats.joins(:gameschedule).distinct.pluck("YEAR(gameschedule.Game_Date)")
    pitching_years = pitching_stats.joins(:gameschedule).distinct.pluck("YEAR(gameschedule.Game_Date)")
    all_years = (hitting_years + pitching_years).uniq.sort

    return "N/A" if all_years.empty?
    all_years.min
  end
end
