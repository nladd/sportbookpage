class Stat < ActiveRecord::Base
  validates_length_of :stat_repository_type, :allow_nil => true, :maximum => 100
  validates_length_of :stat_holder_type, :allow_nil => true, :maximum => 100
  validates_length_of :stat_coverage_type, :allow_nil => true, :maximum => 100
  validates_presence_of :context
  validates_length_of :context, :allow_nil => false, :maximum => 40
end
