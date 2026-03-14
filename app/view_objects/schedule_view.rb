class ScheduleView
  def initialize(year, month, view)
    @year = year
    @month = month
    @context = view
  end
  def next_month
    (@month == 12 ? 1 : @month + 1).to_s.rjust(2, "0")
  end
  def next_year
    @month == 12 ? @year + 1 : @year
  end
  def last_month
    (@month == 1 ? 12 : @month - 1).to_s.rjust(2, "0")
  end
  def last_year
    @month == 1 ? @year - 1 : @year
  end
  def current_fields
    Location.active
  end
  def days_in_month
    Date.new(@year, @month, -1).day
  end
  def month
    @month
  end
  def year
    @year
  end
  def current_day_css(day_num)
    "currentDay" if day_num == Date.today.day && @year == Date.today.year && @month == Date.today.month
    ""
  end
  def cell_css(day_data)
    return "eventCss" if day_data[:events].any?

    if day_data[:games].any?
      game=day_data[:games].first
      return game.HV=="H" ? "homeGame" : "awayGame"
    end
    ""
  end
  def days
    days={}
    games_by_day = games.group_by { |g| g.Game_Date.day }
    events_by_day = Event.where("YEAR(date) = ? AND MONTH(date) = ?", @year, @month).group_by { |e| e.date.day }
    birthdays_by_day = Player.current.where("MONTH(DOB) = ?", @month).group_by { |p| p.dob.utc.day }
      (1..days_in_month).each do |day|
        days[day] = {
          games: games_by_day[day] || [],
          events: events_by_day[day] || [],
          birthdays: birthdays_by_day[day] || []
      }
    end
    days
  end
  def birthday_text(player)
    "#{player.first_name} #{player.last_name}'s Birthday (#{player.age_in(@year)})"
  end
  def days_to_skip
    Date.new(@year, @month, 1).wday
  end
  def games
    Gameschedule.where("YEAR(Game_Date) = ? AND MONTH(Game_Date) = ?", @year, @month).order(:Game_Date)
  end
  def month_text
        "#{Date::MONTHNAMES[@month]} #{@year}"
  end
  def game_text(game_data)
    return "" if game_data.nil?
    location_indicator = game_data.home? ? "vs. " : "@ "
    game_string = "#{game_data.opponent}"
    logo_path = game_data.home? ? game_data.away_logo : game_data.home_logo
    logo = @context.image_tag(logo_path, class: "team-logo me-2", height: 22)
    if game_data.Game_Date > Time.current
      time_and_location = " #{game_data.Game_Date.utc.strftime("%-I:%M %p")} #{game_data.location.ShortName}"
      @context.safe_join([ location_indicator, logo, game_string, time_and_location ])
    else
      electron_score = game_data.home? ? game_data.home_total_runs : game_data.away_total_runs
      opponent_score = game_data.home? ? game_data.away_total_runs : game_data.home_total_runs
      wlt = electron_score > opponent_score ? "W" : (electron_score < opponent_score ? "L" : "T")
      result = "#{wlt} #{electron_score}-#{opponent_score} "
      result_link = @context.link_to(result, @context.live_game_gameschedules_path(game_data.Game_ID))
      @context.safe_join([ location_indicator, logo, game_string, "&nbsp;".html_safe, result_link ])
    end
  end
end
