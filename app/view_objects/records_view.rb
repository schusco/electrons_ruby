class RecordsView
    ASCENDING_CATEGORIES = [ "h", "r", "er", "era", "whip", "bb_per_nine" ]
    PITCHING_THRESHOLDS = { season: 25, career: 50, playoffs: 10 }
    HITTING_THRESHOLDS = { season: 50, career: 100, playoffs: 25 }
    HITTING_THRESHOLD_CATEGORIES = [ "ba", "slg", "obp", "ops" ]

    def  initialize(category, scope, type)
      @category = category
      @type = type
      @scope = scope
      @active = type || "hit"
      data = type == "pitch" ? filter_pitching : filter_hitting
      if @category.blank?
        return
      end
      if data.any?
        sort_category = @category == "innings" ? "ip" : @category
        data = data.sort_by { |r| r.public_send(sort_category) }
        if sort_direction == "desc"
            data = data.reverse
        end
        @stats = data.first(15).map { |row| { name: row.name, year: row.year, value: row.public_send(@category) } }
      end
    end
    def hitting_categories
      [ [ "AB", "ab" ], [ "R", "r" ], [ "H", "h" ], [ "Doubles", "doubles" ], [ "Triples", "triples" ], [ "HR", "hr" ], [ "RBI", "rbi" ], [ "BB", "bb" ], [ "HBP", "hbp" ],
        [ "K", "k" ], [ "SB", "sb" ], [ "CS", "cs" ], [ "SAC", "sac" ], [ "SF", "sf" ], [ "LOB", "lob" ], [ "BA", "ba" ], [ "SLG", "slg" ], [ "OBP", "obp" ], [ "OPS", "ops" ]
    ]
    end
    def pitching_categories
      [ [ "Wins", "wins" ], [ "Losses", "losses" ], [ "Saves", "saves" ], [ "SvO", "saves_opportunities" ], [ "Games", "games" ], [ "GS", "gs" ], [ "IP", "innings" ], [ "H", "h" ],
      [ "R", "r" ], [ "ER", "er" ], [ "BB", "bb" ], [ "K", "k" ],  [ "HB", "hb" ], [ "HR", "hr" ], [ "BF", "bf" ], [ "CG", "cg" ], [ "ERA", "era" ],  [ "WHIP", "whip" ],
      [ "K / 9", "k_per_nine" ], [ "BB / 9", "bb_per_nine" ] ]
    end
    def threshold
      vals = @active == "hit" ? HITTING_THRESHOLDS : PITCHING_THRESHOLDS
      vals[scope.downcase.to_sym]
    end
    def threshold_category
      category_list = @type == "hit" ? HITTING_THRESHOLD_CATEGORIES : ASCENDING_CATEGORIES
      !category_list.index(@category).nil?
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
      return "desc" if @category.blank? || @type == "hit"
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
      category_array = categories.find { |x| x[1] == @category }
      category_array[0]
    end
end
