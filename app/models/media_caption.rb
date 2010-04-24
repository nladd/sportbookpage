class MediaCaption < ActiveRecord::Base
  validates_length_of :caption_type, :allow_nil => true, :maximum => 100
  validates_length_of :caption, :allow_nil => true, :maximum => 100
  validates_length_of :language, :allow_nil => true, :maximum => 100
  validates_length_of :caption_size, :allow_nil => true, :maximum => 100
end
