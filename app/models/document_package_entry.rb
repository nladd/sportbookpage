class DocumentPackageEntry < ActiveRecord::Base
  validates_length_of :rank, :allow_nil => true, :maximum => 100
  validates_length_of :headline, :allow_nil => true, :maximum => 100
  validates_length_of :short_headline, :allow_nil => true, :maximum => 100
end
