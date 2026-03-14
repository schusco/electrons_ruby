class LiveGameView
    attr_reader :home_box, :away_box, :recap, :game, :season_stats, :last_updated
    def initialize(game, game_recap_path)
      @game = game
      @last_updated = File.mtime(game_recap_path)
      @recap = JSON.parse(File.read(game_recap_path), object_class: OpenStruct)
      @season_stats = StatisticsReportService.season_hitting_stats(game.game_date.year, game.playoff, game.game_date)
      @home_box = BoxScoreView.new(home_hitting, home_pitching, home_team_image, home_team, @recap.home_risp, @game.home? ? @season_stats : nil)
      @away_box = BoxScoreView.new(away_hitting, away_pitching, away_team_image, away_team, @recap.away_risp, @game.visitor? ? @season_stats : nil)
    end
    def away_team
      @game.away_team
    end
    def home_team
      @game.home_team
    end
    def location_text
      @game.location.field_name || ""
    end
    def city_text
      @game.location.city_state || ""
    end
    def home_line
      @recap.GameLineScore.HomeLine
    end
    def away_line
      @recap.GameLineScore.AwayLine
    end
    def game_over?
      !@recap.EndTime.nil?
    end
    def away_hitting
      @recap.AwayTeamHitting
    end
    def home_hitting
      @recap.HomeTeamHitting
    end
    def away_pitching
      @recap.AwayTeamPitching
    end
    def home_pitching
      @recap.HomeTeamPitching
    end
    def home_team_image
      "/images/logos/nextOuting_#{@game.home_team.gsub(/\s+/, '').downcase}.png"
    end
    def away_team_image
      "/images/logos/nextOuting_#{@game.away_team.gsub(/\s+/, '').downcase}.png"
    end
    def game_summary
      @recap.GameSummary.reverse
    end
    def scoring_plays
      @recap.ScoringPlays.group_by { |play| play.InningNumber }
    end
    def ab_string
      @recap.GameSummary.last.Events.last.EvemtText
    end
    def current_pitcher_string
      if inning_half == "Bottom"
        "#{@recap.AwayTeamPitching.last.PlayerName} pitching"
      end
     "#{@recap.HomeTeamPitching.last.PlayerName} pitching"
    end
    def home_innings_map
      @recap.GameLineScore.HomeLine.InningLines.index_by(&:Number)
    end
    def pitching_image
      inning_half == "Top" ? home_team_image : away_team_image
    end
    def hitting_image
      inning_half == "Top" ? away_team_image : home_team_image
    end
    def away_innings_map
      @recap.GameLineScore.AwayLine.InningLines.index_by(&:Number)
    end
    def display_count
       [ self.away_line.InningLines.map(&:Number).max, 7 ].max
    end
    def previous_abs
      inning_abs.drop(1)
    end
    def current_ab
      inning_abs.first.EventText
    end
    def pitches
        @recap.current_ab.pitches
    end
    def balls
        @recap.current_ab.balls
    end
    def strikes
        @recap.current_ab.strikes
    end
    def outs
        @recap.current_ab.outs
    end
    def inning_number
        @recap.current_ab.inning_number
    end
    def inning_half
        @recap.current_ab.inning_half
    end
    def on_first
        @recap.current_ab.on_first
    end
    def on_second
        @recap.current_ab.on_second
    end
    def on_third
        @recap.current_ab.on_third
    end
    def started?
        !@recap.StartTime.nil?
    end
    def game_time
      "#Game Time: #{@recap.GameDate}"
    end
    private

    def inning_abs
      @recap.GameSummary.last.Events.reverse
    end
end
