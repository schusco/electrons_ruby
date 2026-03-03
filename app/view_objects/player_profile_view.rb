class PlayerProfileView
  attr_reader :player
  def initialize(player)
    @player = player
  end
  def self.wrap(player)
    new(player)
  end
  delegate :full_name, :height_string, :weight_string, :position_string, :years_played, :dob, :divorces, :bats, :throws, :hometown, :awards, to: :player
  def career_pitching_stats
    StatisticsReportService.career_pitching_stats(@player)
  end
  def career_pitching_totals
    StatisticsReportService.career_pitching_totals(@player)
  end
  def career_hitting_stats
    StatisticsReportService.career_hitting_stats(@player)
  end
  def career_hitting_totals
    StatisticsReportService.career_hitting_totals(@player)
  end
  def player_photo_path
    file_name= "players/#{@player.last_name}#{@player.first_name}_Magnified.png"
    if Rails.root.join("app/assets/images", file_name).exist?
        file_name
    else
        "players/NotAvailable.png"
    end
  end
end
