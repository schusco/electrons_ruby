class PlayerProfileView
  attr_reader :player
  def initialize(player)
    @player = player
  end
  def self.wrap(player)
    new(player)
  end
  delegate :full_name, :position_string, :height_string, :years_played, :dob, :divorces, :bats, :throws, :hometown, :awards, to: :player
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
  def weight_string
    "#{@player.weight} lbs."
  end
  def player_photo_path
    file_name= "/images/players/#{@player.last_name.gsub(/\s+/, '')}#{@player.first_name.gsub(/\s+/, '')}_Magnified.png"
    path = File.join(Rails.public_path, file_name)
    puts(path)
    if File.exist?(path)
        file_name
    else
        "/images/players/NotAvailable.png"
    end
  end
end
