PitchingStatsRow = Data.define(:name, :year, :wins, :losses, :saves, :saves_opportunities, :games, :gs, :ip, :h, :r, :er, :bb, :k, :hb, :hr, :bf, :cg, :player_id, :decision, :playoff) do
  def era
    return 0 if ip.to_f.zero?
    era_val=((r.to_f / ip) * 7).round(2)
    format_stat(era_val)
  end

  def whip
    return 0 if ip.to_f.zero?
    whip_val = ((bb.to_f + h) / ip).round(2)
    format_stat(whip_val)
  end

  def k_per_nine
    return 0 if ip.to_f.zero?
    k9=((k.to_f / ip) * 7).round(2)
    format_stat(k9)
  end

  def bb_per_nine
    return 0 if ip.to_f.zero?
    bbp9=((bb.to_f / ip) * 7).round(2)
    format_stat(bbp9)
  end
  def innings
    return ip if ip.nil?
    whole_innings = ip.to_i
    fractional_innings = ((ip - whole_innings) * 3).round
    if fractional_innings == 3
      whole_innings += 1
      fractional_innings = 0
    end
    "#{whole_innings}.#{fractional_innings}"
  end
  def self.from(source)
    if source.is_a?(Hash)
      new(
        source["name"],
        source["year"],
        source["wins"].to_i,
        source["losses"].to_i,
        source["saves"].to_i,
        source["saves_opportunities"].to_i,
        source["games"].to_i,
        source["gs"].to_i,
        source["ip"].to_f,
        source["h"].to_i,
        source["r"].to_i,
        source["er"].to_i,
        source["bb"].to_i,
        source["k"].to_i,
        source["hb"].to_i,
        source["hr"].to_i,
        source["bf"].to_i,
        source["cg"].to_i,
        source["Player_ID"].to_i,
        source["decision"],
        source["playoff"] ? 1 : 0
      )
    else
      new(
        source.player.short_name,
        source.year,
        source.wins.to_i,
        source.losses.to_i,
        source.saves.to_i,
        source.saves_opportunities.to_i,
        source.games.to_i,
        source.gs.to_i,
        source.ip.to_f,
        source.h.to_i,
        source.r.to_i,
        source.er.to_i,
        source.bb.to_i,
        source.k.to_i,
        source.hb.to_i,
        source.hr.to_i,
        source.bf.to_i,
        source.cg.to_i,
        source.Player_ID.to_i,
        source.decision,
        source.gameschedule.Playoff ? 1 : 0
      )
    end
  end

  private
    def format_stat(value)
      return "0.00" if value.blank? || value.zero?

      # 1. Format to 3 decimal places using sprintf
      sprintf("%.2f", value)
    end
end
