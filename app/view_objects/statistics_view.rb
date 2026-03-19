class StatisticsView
  attr_reader :year, :playoffs
    def initialize(year, playoffs)
      @year = year.to_i if year.present?
      @year ||= Time.current.year
      @playoffs = playoffs
      if !pitching_stats.any? && !hitting_stats.any?
          @year = @year-1
      end
    end

    def year
        @year
    end
    def playoffs
      @playoffs
    end
    def pitching_stats
      StatisticsReportService.season_pitching_stats(@year, playoffs)
    end

    def pitching_totals
      StatisticsReportService.season_pitching_totals(@year, playoffs)
    end

    def hitting_stats
      StatisticsReportService.season_hitting_stats(@year, playoffs)
    end

    def hitting_totals
      StatisticsReportService.season_hitting_totals(@year, playoffs)
    end
end
