class DocumentClass < ActiveRecord::Base
  validates_length_of :name, :allow_nil => true, :maximum => 100
end
