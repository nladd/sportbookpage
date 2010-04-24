class MediaContent < ActiveRecord::Base
  validates_length_of :object, :allow_nil => true, :maximum => 100
  validates_length_of :format, :allow_nil => true, :maximum => 100
  validates_length_of :mime_type, :allow_nil => true, :maximum => 100
  validates_length_of :height, :allow_nil => true, :maximum => 100
  validates_length_of :width, :allow_nil => true, :maximum => 100
  validates_length_of :duration, :allow_nil => true, :maximum => 100
  validates_length_of :file_size, :allow_nil => true, :maximum => 100
  validates_length_of :resolution, :allow_nil => true, :maximum => 100
end
