module DateCalculatable
  def seasons
    s = year_start.presence
    e = year_end.presence
    return "N/A" if s.nil?
    return s if e == "x"
    return "#{s} - Present" if e.nil? || e == "Present"
    return s if s == e
    "#{s} - #{e}"
  end

  def total_years
    # The same math logic we perfected earlier
    last = (year_end.presence == "Present" || year_end.blank?) ? Time.now.year : year_end.to_i
    first = year_start.to_i
    count = last - first + 1
    "#{count} #{'Season'.pluralize(count)}"
  end

  def display_fields
    [ :data, :seasons, :total_years ]
  end
end
