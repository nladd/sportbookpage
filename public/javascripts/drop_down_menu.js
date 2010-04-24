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

function ShowNestedMenu(id)
{
  if (openMenu){
    $(openMenu).hide();
  }
  openMenu = id;
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

//close menu if user clicks outside menu
document.onclick = CloseAllMenus('sports');

