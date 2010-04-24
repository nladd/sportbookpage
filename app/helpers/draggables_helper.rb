module DraggablesHelper

  def more_less_html(j, drop_id, league_abbr)
    html = ""
  
    if ( j == 0 ) then
        html = "<div id=\"#{drop_id}_hide_#{league_abb}_#{j}\">"
    elsif (j % 8) == 0
      html = "<div id=\"#{drop_id}_more_#{league_abbr}_#{j}\" class=\"row\" style=\"width: 96%\">"
      if j != 8 then
        html += "<a href=\"javascript:void(0);\" 
           style=\"text-align: left\" 
           onclick=\"Effect.SlideUp('#{drop_id}_hide_#{league_abbr}_#{j-8}', 'slide' ); 
           $('#{drop_id}_more_#{league_abbr}_#{j}').hide(); 
           $('#{drop_id}_more_#{league_abbr}_#{j-8}').show(); \">Less...</a>"
      end
      html += "<a href=\"javascript:void(0);\" 
           style=\"text-align: right\" 
           onclick=\"Effect.SlideDown('#{drop_id}_hide_#{league_abb}_#{j}', 'slide' ); 
           $('#{drop_id}_more_#{league_abb}_#{j}').hide(); 
           $('#{drop_id}_more_#{league_abb}_#{ (j+8) > @games[i].size ? @games[i].size : (j+8) } %>').show(); \">More...</a>

      </div>
      
      
      </div> <!-- close <hide_#> -->
      <div id=\"#{drop_id}_hide_#{league_abbr}_#{j} %>\" style=\"display:none\">"
    end
  
    return html
  end


end
