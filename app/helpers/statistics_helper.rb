module StatisticsHelper
  def table_css(all)
    all ? "tronTable tablesorter" : "tronTable"
  end
  def stat_label(display)
    if display == "Player"
      return "Year"
    end
    "Player"
  end
  def display_year_and_playoff(stat)
    playoff_value = stat.playoff
    is_playoff = playoff_value == 1 || playoff_value == "1" || playoff_value == true || playoff_value.to_s.downcase == "true"
    is_playoff ? "#{stat.year} (Playoffs)" : stat.year.to_s
  end
end
