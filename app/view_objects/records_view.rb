class RecordsView
    ASCENDING_CATEGORIES = [ "H", "R", "ER", "ERA", "WHIP", "BB / 9" ]
    PITCHING_THRESHOLDS = { season: 25, career: 50, playoffs: 10 }
    HITTING_THRESHOLDS = { season: 50, career: 100, playoffs: 25 }
    THRESHOLD_CATEGORIES = ASCENDING_CATEGORIES + [ "BA", "SLG", "OBP", "OPS" ]

    def  initialize(category, scope, type)
      @category = category
      category = category&.downcase,
      @scope = scope
      @active = type || "hit"
      data = type == "pitch" ? filter_pitching : filter_hitting

      if data.any?
        data = data.sort_by { |r| r.public_send(category.first) }
        if sort_direction == "desc"
            data = data.reverse
        end
        @stats = data.first(15).map { |row| { name: row.name, year: row.year, value: row.public_send(category.first) } }
      end
    end
    def hitting_categories
      [ "AB", "R", "H", "Doubles", "Triples", "HR", "RBI", "BB", "HBP", "K", "SB", "CS", "SAC", "SF", "LOB", "BA", "SLG", "OBP", "OPS" ]
    end
    def pitching_categories
      [ "Wins", "Losses", "Saves", "SvO", "Games", "GS", "IP", "H", "R", "ER", "BB", "K", "HB", "HR", "BF", "CG", "ERA", "WHIP", "K / 9", "BB / 9" ]
    end
    def threshold
      vals = @active == "hit" ? HITTING_THRESHOLDS : PITCHING_THRESHOLDS
      vals[scope.downcase.to_sym]
    end
    def threshold_category
      !THRESHOLD_CATEGORIES.index(@category).nil?
    end
    def active
      @active
    end
    def scope
      @scope
    end
    def stats
      @stats
    end
    def sort_direction
      return "desc" if @category.blank?
      index = ASCENDING_CATEGORIES.index(@category)
      return "asc" if !index.nil?
      "desc"
    end
    def pitching_data
      Rails.cache.fetch("pitching_record_data", expires_in: 24.hours) do
        StatisticsReportService.pitching_records
      end
    end
    def filter_pitching
      if scope == "Playoffs"
        data = pitching_data.select { |x| x.playoff == 1 || x.playoff == true }
        if threshold_category
          data = data.select { |x| x.ip > threshold }
        end
      elsif scope == "Season"
        data = pitching_data.select { |x| x.playoff == 0 || x.playoff == false }
        if threshold_category
          data = data.select { |x| x.ip > threshold }
        end
      else
        groups = pitching_data.group_by { |g| g.name }
        data = groups.map { |key, g| StatisticsReportService.get_pitching_totals(g, key) }
        if threshold_category
          data = data.select { |x| x.ip > threshold }
        end
      end
      data
    end
    def hitting_data
      Rails.cache.fetch("hitting_record_data", expires_in: 24.hours) do
        StatisticsReportService.hitting_records
      end
    end
    def filter_hitting
      if scope == "Playoffs"
        data = hitting_data.select { |x| x.playoff == 1 || x.playoff == true }
        if threshold_category
          data = data.select { |x| x.ab > threshold }
        end
      elsif scope == "Season"
        data = hitting_data.select { |x| x.playoff == 0 || x.playoff == false }
        if threshold_category
          data = data.select { |x| x.ab > threshold }
        end
      else
        groups = hitting_data.group_by { |g| g.name }
        data = groups.map { |key, g| StatisticsReportService.get_hitting_totals(g, key) }
        if threshold_category
          data = data.select { |x| x.ab > threshold }
        end
      end
      data
    end
    def active_hitting
      "Season"
    end
    def active_pitching
      "Season"
    end
    def stat_header
      categories= @active == "hit" ? hitting_categories : pitching_categories
      index = categories.index(@category)
      categories[index]
    end
end
