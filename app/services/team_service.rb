class TeamService
  def self.clear(teams)
    teams.update_all(wins: 0, losses: 0, ties: 0, forfeits: 0)
  end
end
