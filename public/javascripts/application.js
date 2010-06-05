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

function toggle_sport_checkbox(sport) {

  Effect.toggle(sport, 'slide', {duration: .5});

  if(sport_toggle == 0) {
    sport_toggle = 1;
  }
  else {
    //if the parent sport checkbox is unchecked, uncheck all the sub-team checkboxes too
    team_checkboxes = $(sport).getElementsByClassName(sport);
    for (var i = 0; i < team_checkboxes.length; i++) {
      team_checkboxes[i].checked = false;
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
* Show more rows
******************************************************************************/
function showMore(drop_id, abbr, size, j) {

  Effect.SlideDown(drop_id + '_hide_' + abbr + '_' + j, 'slide' ); 
  $(drop_id + '_more_' + abbr + '_' + j).hide(); 
  $(drop_id + '_more_' + abbr + '_' + ( (j+12) > size ? size : (j+12) )).show(); 

}

/******************************************************************************
* Show less rows
******************************************************************************/
function showLess(drop_id, abbr, j) {

  Effect.SlideUp(drop_id + '_hide_' + abbr + '_' + (j-12), 'slide' ); 
  $(drop_id + '_more_' + abbr + '_' + j).hide(); 
  $(drop_id + '_more_' + abbr + '_' + (j-12)).show();

}

/******************************************************************************
* Show less rows
******************************************************************************/
function finalShowLess(drop_id, abbr, size) {
  Effect.SlideUp(drop_id + '_hide_' + abbr + '_' + (size - (size % 12)), 'slide' ); 
  $(drop_id + '_more_' + abbr + '_' + size).hide(); 
  $(drop_id + '_more_' + abbr + '_' + (size - (size % 12))).show();
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

/******************************************************************************
 * Scroll a drop area div
 ******************************************************************************/
function scrollDropArea(event) {
  //clearTimeout(scrollTimer);
  var parameters = $A(arguments);

  var step = 0; //parameters[2];

  var elem = $(parameters[1]);
  var scrollDiv = $('drop_1_frame'); //Event.element(event);
  
  var offset = $(scrollDiv).cumulativeOffset();  //get the location of the div within the page
  //var posX = Event.pointerX(event);   //get the X position of the mouse within the page
  var posY = Event.pointerY(event);   //get the Y position of the mouse within the page
  
    
  var scrollDivHeight = $(scrollDiv).getHeight();
  var height = offset[1] + $(scrollDiv).getHeight() - posY;
  
  //if (step == -1) {
  //  step = step * 6 * ((height)/scrollDivHeight);
  //} else {
  //  step = step * 6 * ((scrollDivHeight-height)/scrollDivHeight);
  //}

  if ((posY - offset[1]) < scrollDivHeight/4 ) {
    step = -3;
  } else if ((posY - offset[1]) > (scrollDivHeight * .75)) {
    step = 3;
  }
  
  
  //alert("posY = " + posY + " offset = " + offset[1] + "posY - offset = " + (posY - offset[1]) + " step = " + step);
  
  scroll($(elem).identify(), step);
  
}

function scroll(id, step) {
  clearTimeout(scrollTimer);
  $(id).scrollTop += step;
  scrollTimer = setTimeout("scroll('" + id + "', " + step + ")", 20); // scrolls every 20 milliseconds
}

function stopScroll() {
  clearTimeout(scrollTimer);
}



