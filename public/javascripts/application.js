var sport_toggle = 0;

/******************************************************************************
Varaibles needed for a rotating slideshow. Each drop area gets its own timer so that multiple slideshows
in different drop areas can be running at the same time. Each drop area also needs to know how many slides
it should be rotating through and that is stored in the Num_slides variable
******************************************************************************/
var drop_1_num_slides = 0;
var drop_2_num_slides = 0;
var drop_3_num_slides = 0;
var drop_4_num_slides = 0;
var drop_1_timer = 0;
var drop_2_timer = 0;
var drop_3_timer = 0;
var drop_4_timer = 0;

/* Timer to close help messages when no longer needed */
var help_timer = 0;

/* Timer to stop scrolling a drop area */
var scrollTimer = 0;

/*
 * Uncheck all checkboxes in a form
 */
function uncheck_all(form) {
 
  checkboxes = $(form).getInputs('checkbox');

  for (var i = 0; i < checkboxes.length; i++) {
    checkboxes[i].checked = false;
  }  
  
}

/*
 * Check all league checkboxes
 */
function checkAllLeague(league) {
  
  Effect.SlideDown(league, {duration: .5});
  
  $(league + '_checkbox').checked = true;
  
  lists = $(league).getElementsBySelector('ul');
  for(var i = 0; i < lists.length; i++) {
    lists[i].show();
  }
  
  checkboxes = $(league).getElementsBySelector('input');
  for (var i = 0; i < checkboxes.length; i++) {
    checkboxes[i].checked = true;
  }
    
  $('check_all_' + league).hide();
  $('uncheck_all_' + league).show();
  
}


/*
 * Uncheck all league checkboxes
 */
function uncheckAllLeague(league) {
  
  checkboxes = $(league).getElementsBySelector('input');
  for (var i = 0; i < checkboxes.length; i++) {
    checkboxes[i].checked = false;
  }
  
  lists = $(league).getElementsBySelector('ul');
  for(var i = 0; i < lists.length; i++) {
    lists[i].hide();
  }
  
  Effect.SlideUp(league, {duration: .5});
  $(league + '_checkbox').checked = false;
    
  $('check_all_' + league).show();
  $('uncheck_all_' + league).hide();
  
}


/*
 * Check all checkboxes in a form
 */
function toggle_all_checkboxes(form) {
 
  checkboxes = $(form).getElementsBySelector('input');

  if($('check_all_' + form).checked) {
    for (var i = 0; i < checkboxes.length; i++) {
      checkboxes[i].checked = true;
    }
    $('check_all_' + form + '_label').hide();
    $('uncheck_all_' + form + '_label').show();
  } 
  else {
    for (var i = 0; i < checkboxes.length; i++) {
      checkboxes[i].checked = false;
    }
    $('check_all_' + form + '_label').show();
    $('uncheck_all_' + form + '_label').hide();
  }
    
}

function toggleHeaderCheckbox(id) {

  Effect.toggle(id, 'slide', {duration: .5});

  if(sport_toggle == 0) {
    sport_toggle = 1;
  }
  else {
    //if the parent sport checkbox is unchecked, uncheck all the sub checkboxes too
    sub_checkboxes = $(id).select('input');
    for (var i = 0; i < sub_checkboxes.length; i++) {
      sub_checkboxes[i].checked = false;
    }
  
    //get all list below this element and hide them
    sub_lists = $(id).select('ul');
    for (var i = 0; i < sub_lists.length; i++) {
      sub_lists[i].hide();
    }
    sport_toggle = 0;
  }
  
}

/*
 * Validate that text entered in a input field is a numeric value
 *
 */
function isNumeric(element, value, elementName) {

  if (isNaN(value)) {
    alert("Invalid input for field: " + elementName);
    $(element).value = "0";
  }
}

/*
 * Check the display box for a user's profile item when they enter a value
 *
 */
function checkProfileBox(item) {
  
  if ($(item).value == "") {
    $(item).checked = false;
  } 
  else {
    $(item).checked = true;
  }

} 


/******************************************************************************
* Return the appropriate timer for a given drop area
******************************************************************************/
function getTimer(drop_id) {

  timer = 0;

  if (drop_id == 'drop_1') {
    timer = drop_1_timer;
  }
  else if (drop_id == 'drop_2') {
    timer = drop_2_timer;
  }
  else if (drop_id == 'drop_3') {
    timer = drop_3_timer;
  }
  else if (drop_id == 'drop_4') {
    timer = drop_4_timer;
  }

  return timer;
}

/******************************************************************************
* Set the appropriate timer for a given drop area
******************************************************************************/
function setTimer(drop_id, method, timeout) {

  if (drop_id == 'drop_1') {
    drop_1_timer = setTimeout(method, timeout);
  }
  else if (drop_id == 'drop_2') {
    drop_2_timer = setTimeout(method, timeout);
  }
  else if (drop_id == 'drop_3') {
    drop_3_timer = setTimeout(method, timeout);
  }
  else if (drop_id == 'drop_4') {
    drop_4_timer = setTimeout(method, timeout);
  }

}

/******************************************************************************
* Get the appropriate num_slides count for a given drop area
******************************************************************************/
function getNumSlides(drop_id) {

  num_slides = 0;

  if (drop_id == 'drop_1') {
    num_slides = drop_1_num_slides;
  }
  else if (drop_id == 'drop_2') {
    num_slides = drop_2_num_slides;
  }
  else if (drop_id == 'drop_3') {
    num_slides = drop_3_num_slides;
  }
  else if (drop_id == 'drop_4') {
    num_slides = drop_4_num_slides;
  }

  return num_slides;

}

/******************************************************************************
* Set the appropriate num_slides count for a given drop area
******************************************************************************/
function setNumSlides(drop_id, num_slides) {

  if (drop_id == 'drop_1') {
    drop_1_num_slides = num_slides;
  }
  else if (drop_id == 'drop_2') {
    drop_2_num_slides = num_slides;
  }
  else if (drop_id == 'drop_3') {
    drop_3_num_slides = num_slides;
  }
  else if (drop_id == 'drop_4') {
    drop_4_num_slides = num_slides;
  }

}

/******************************************************************************
* Start a slideshow that will rotate through the headlines
*
******************************************************************************/
function start_slideshow(num_slides, drop_id) {

  setNumSlides(drop_id, num_slides);

  stop_slideshow(0, drop_id);

  if (getNumSlides(drop_id) > 0) {
    next_slide(0, drop_id);
  }
  else {
    $(drop_id + '_headlines_0').show();
  }

}

/******************************************************************************
* Move to the next slide in the slideshow
*
******************************************************************************/
function next_slide(slide, drop_id) {

  if (slide == 0) {
    $(drop_id + '_headlines_' + (getNumSlides(drop_id) - 1)).hide();
    $(drop_id + '_tab_' + (getNumSlides(drop_id) - 1)).setStyle({background: 'none', color: 'black'});
  }
  else {
    $(drop_id + '_headlines_' + (slide - 1)).hide();
    $(drop_id + '_tab_' + (slide - 1)).setStyle({background: 'none', color: 'black'});
  }

  $(drop_id + '_headlines_' + slide).show();
  $(drop_id + '_tab_' + slide).setStyle({background: '#49A3FF', color: 'white'});
 
  if ( (slide + 1) == getNumSlides(drop_id) ) {
    method = "next_slide(0, '" + drop_id + "')";
    setTimer(drop_id, method, 8000);
  } 
  else {
    method = "next_slide(" + (slide + 1) + ", '" + drop_id + "')";
    setTimer(drop_id, method, 8000);
  }

}

/******************************************************************************
* Stop the slideshow and clear slideshow the timer
******************************************************************************/
function stop_slideshow(slide, drop_id) {
  
    if (drop_id == 'drop_1') {
      window.clearTimeout(drop_1_timer);
    }
    else if (drop_id == 'drop_2') {
      window.clearTimeout(drop_2_timer);
    }
    else if (drop_id == 'drop_3') {
      window.clearTimeout(drop_3_timer);
    }
    else if (drop_id == 'drop_4') {
      window.clearTimeout(drop_4_timer);
    }

  for(var i = 0; i < getNumSlides(drop_id); i++) {
    if (i == slide) {
      $(drop_id + '_headlines_' + i).show();
      $(drop_id + '_tab_' + i).setStyle({background: '#49A3FF', color: 'white'});
    }
    else {
      $(drop_id + '_headlines_' + i).hide();
      $(drop_id + '_tab_' + i).setStyle({background: 'none', color: 'black'});
    }
  
  }

}


/******************************************************************************
 * Show the popup help menu
 ******************************************************************************/
function ShowHelp(event) {
  
  window.clearTimeout(help_timer);
  
  var posX = Event.pointerX(event) + 10;
  var posY = Event.pointerY(event) + 10;
  
  var parameters = $A(arguments);
  
  $('popup_help').setStyle({top: posY + 'px', left: posX + 'px'});
  $('popup_help').update(parameters[1]);
  $('popup_help').show();
  
  help_timer = setTimeout(function(){$('popup_help').hide();}, 1000);
  
}


/****************************************************************************
 *
 * Toggles tabs when a tab is selected. Accepts two parameters: a hash of the selected tab id,
 * to selected content id, and a hash of the tab ids  and tab content ids of the tabs in this
 * tab list. Show the selected tab and toggle its background so it is highlighted, and then
 * hide all the other tabs and toggle their backgrounds so they are not selected.
 * 
 * *****************************************************************************/
function toggleTabs(selectedHash, tabsHash) {
  
  selected = selectedHash.keys()[0];
  
  $(selectedHash.get(selected)).show();
  //select the item
  $(selected).setStyle({padding:'10px',
                        fontSize:'1em',
                        color:'#FFFFFF',
                        fontWeight:'bold',
                        background: 'url(/images/css/column-left-select-row-bg.jpg) repeat-y top right'})
    
  tabsHash.each(function(pair) {
    $(pair.value).hide();
    // unselect the item
    $(pair.key).setStyle({padding:'10px',
                          fontSize:'1em',
                          color:'#4696bb',
                          background: 'none',
                          fontWeight:'bold'})
  });
  
}


/******************************************************************************
 * Functions defined by Brett for the design
 * ****************************************************************************/

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

