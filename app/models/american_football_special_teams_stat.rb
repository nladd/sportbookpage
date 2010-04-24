class AmericanFootballSpecialTeamsStat < ActiveRecord::Base
  validates_length_of :returns_punt_total, :allow_nil => true, :maximum => 100
  validates_length_of :returns_punt_yards, :allow_nil => true, :maximum => 100
  validates_length_of :returns_punt_average, :allow_nil => true, :maximum => 100
  validates_length_of :returns_punt_longest, :allow_nil => true, :maximum => 100
  validates_length_of :returns_punt_touchdown, :allow_nil => true, :maximum => 100
  validates_length_of :returns_kickoff_total, :allow_nil => true, :maximum => 100
  validates_length_of :returns_kickoff_yards, :allow_nil => true, :maximum => 100
  validates_length_of :returns_kickoff_average, :allow_nil => true, :maximum => 100
  validates_length_of :returns_kickoff_longest, :allow_nil => true, :maximum => 100
  validates_length_of :returns_kickoff_touchdown, :allow_nil => true, :maximum => 100
  validates_length_of :returns_total, :allow_nil => true, :maximum => 100
  validates_length_of :returns_yards, :allow_nil => true, :maximum => 100
  validates_length_of :punts_total, :allow_nil => true, :maximum => 100
  validates_length_of :punts_yards_gross, :allow_nil => true, :maximum => 100
  validates_length_of :punts_yards_net, :allow_nil => true, :maximum => 100
  validates_length_of :punts_longest, :allow_nil => true, :maximum => 100
  validates_length_of :punts_inside_20, :allow_nil => true, :maximum => 100
  validates_length_of :punts_inside_20_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :punts_average, :allow_nil => true, :maximum => 100
  validates_length_of :punts_blocked, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_total, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_total_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_kickoffs, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_kickoffs_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_punts, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_punts_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_interceptions, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_interceptions_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :fair_catches, :allow_nil => true, :maximum => 100
end
