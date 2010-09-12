var timeout	= 400;
var closetimer	= 0;
var parentTimer = 0;
var selected	= 0;
var openMenu = 0;

function CloseMenu(id)
{
  if(id) {
   	$(id).hide();  
  }
}

//timed out, close menu
function StartTimer(id)
{
	closetimer = setTimeout("CloseMenu('" + id + "')", timeout)
}

//Clear closetimer
function StopTimer()
{
	if(closetimer)
	{
		window.clearTimeout(closetimer);
		closetimer = null;
	}
}

//timed out, close menu
function StartParentTimer(id)
{
	parentTimer = setTimeout("CloseAllMenus('" + id + "')", timeout)
}

//Clear closetimer
function StopParentTimer()
{
	if(parentTimer)
	{
		window.clearTimeout(parentTimer);
		parentTimer = null;
	}
}

/*
 * Show a nested menu
 *
 * Parameters:
 * 	-id - the id of the menu to show
 * 	-menuItem - the id of the menuItem being hovered over
 */
function ShowNestedMenu(id, menuItem)
{
  if (openMenu){
    $(openMenu).hide();
  }
  
  var offset = $('nav-low').cumulativeOffset();
  
  var leftOffset = 0;
  if (menuItem == null) {
	leftOffset = offset[0];
  } else {
	leftOffset = $(menuItem).cumulativeOffset()[0];
  }
  
  openMenu = id;
  
  $(id).setStyle({
	left: leftOffset + 'px',
	top: (offset[1] - $(id).getHeight() - 2) + 'px'
  });
  
  $(id).show();
}

function CloseAllMenus(id)
{
  if(id) {
   	$(id).hide();
  }
  if(openMenu) {
   	$(openMenu).hide();
  }
}

var openCollegeTeams;

function toggleCollegeTeams(conference, menuItem) {
  
  if (openCollegeTeams != null) {
	$(openCollegeTeams + "_sub").hide();
	$(openCollegeTeams).down(0).down(0).setStyle({color: '#4696bb'});
  }
  openCollegeTeams = conference;
  $(openCollegeTeams).down(0).down(0).setStyle({color: '#000000'});

  $(conference + '_sub').toggle();
  
  $(conference + '_sub').setStyle({
	left: $(menuItem).getWidth() + 'px'
  });

    
}

//close menu if user clicks outside menu
//document.onclick = CloseAllMenus('sports');



/*******************************************************************************
 * Functions for the left side menu
 ******************************************************************************/

function expand_collapse_menu(id) {
    
  $("plus_minus_" + id).toggleClassName('expanded');
  $("plus_minus_" + id).toggleClassName('collapsed');
  
  Effect.toggle($(id), 'slide', {duration: .5});
  
}

function make_selected(id) {
  
  var selected = $('column-left').getElementsByClassName('selected');
  
  for (var element in selected) {
    element.removeClassName('selected');
  }
  
  $(id).addClassName('selected');
  
}
