class DocumentPackage < ActiveRecord::Base
  validates_length_of :package_key, :allow_nil => true, :maximum => 100
  validates_length_of :package_name, :allow_nil => true, :maximum => 100
end
