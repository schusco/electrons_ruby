class BoxScoreView
    attr_reader :pitching_stats, :hitting_stats, :image, :team, :risp, :season_data
    def initialize(hitting_stats, pitching_stats, image, team_name, risp, season_stats)
      @hitting_stats = hitting_stats
      @pitching_stats = pitching_stats
      @image = image
      @team = team_name
      @risp = risp
      @season_data = season_stats
    end
end
