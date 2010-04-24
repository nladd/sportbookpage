class BasketballTeamStat < ActiveRecord::Base
  validates_length_of :timeouts_left, :allow_nil => true, :maximum => 100
  validates_length_of :largest_lead, :allow_nil => true, :maximum => 100
  validates_length_of :fouls_total, :allow_nil => true, :maximum => 100
  validates_length_of :turnover_margin, :allow_nil => true, :maximum => 100
end
