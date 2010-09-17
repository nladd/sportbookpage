# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  @@display_names = NameLookup.new()

  def names
    @@display_names
  end
 


end
