/******************************************************************************
 * Author: Nathan Ladd
 * Date: 07/28/10
 *
 * Description:
 * This file contains functions that are used by the target areas.
 *
 ******************************************************************************/ 



/******************************************************************************
 * Expand or collapse a target. When expanding/collapsing a target, all the visible
 * content needs to be expanded/collapsed as well.
 *
*******************************************************************************/
function expandCollapseTarget(target) {
  //counter for our for loops
  var c = 0;
  var cells;
  
  //target is expanded, shrink it
  if ($(target).hasClassName('expanded')) {
    new Effect.Morph(target, {
      style: 'width:301px; height:340px;',
      duration: 1.0
    });
    cells = $(target).select('span.expn');
    $(target + 'ToggleText').innerHTML = 'Expand';
  } else if ($(target).hasClassName('collapsed')) {
    new Effect.Morph(target, {
      style: 'width:615px; height:550px;',
      duration: 1.0
    });
    cells = $(target).select('span.clps');
    $(target + 'ToggleText').innerHTML = 'Collapse';
  }
    
    
var size = 0;

  //shrink each cell
  for (c = 0; c < cells.length; c++) {
    //if a cell is hidden it'll have a width of 0, so in that case skip it
    //we'll expand the hidden cells when the become visible with the expandShirnkHiddenCells() method
    if ($(cells[c]).getWidth() == 0) {
      continue;  
    }
    if ($(target).hasClassName('expanded')) {
      size = (($(cells[c]).getWidth() - 7) / 2);
    } else if ($(target).hasClassName('collapsed')) {
      size = (($(cells[c]).getWidth() * 2) + 7);
    }
      
    new Effect.Morph(cells[c], {
      style: 'width:' + size + 'px;',
      duration: 1.0
    });
      
    $(cells[c]).toggleClassName('clps');
    $(cells[c]).toggleClassName('expn');
  }

  //after the Morph effects have complete, toggle the target's class name to the rest of the appropriate
  //styles are applied
  setTimeout(function(){$(target).toggleClassName('expanded'); $(target).toggleClassName('collapsed');}, 1000);

}

/******************************************************************************
 * Expand and collapse cells that are originally hidden, but has since become visible.
 *
*******************************************************************************/
function expandCollapseHiddenCells(dropId, moreLessId) {
  
  var newWidth = 0;  //the newWidth of the expanded/collapsed content
  var c = 0;  //counter
  
  //target is shrunk, so shrink all expanded hidden cells
  if ($(dropId).hasClassName('collapsed')) {
    
    var cells = $(moreLessId).select('span.expn');
    
    //shrink each cell
    for (c = 0; c < cells.length; c++) {
      
      if ($(cells[c]).getWidth() != 0) {
        newWidth = (($(cells[c]).getWidth() - 7) / 2);
      }
      
      new Effect.Morph(cells[c], {
        style: 'width:' + newWidth + 'px;',
        duration: 1.0
      });
      
      $(cells[c]).toggleClassName('clps');
      $(cells[c]).toggleClassName('expn');
    }

  }
    
  //target is expanded so expand all shrunk cells
  if ($(dropId).hasClassName('expanded')) {

    var cells = $(moreLessId).select('span.clps');
  
    for (c = 0; c < cells.length; c++) {
      
      if ($(cells[c]).getWidth() != 0) {
        newWidth = (($(cells[c]).getWidth() * 2) + 7);
      }
      
      new Effect.Morph(cells[c], {
        style: 'width:' + newWidth + 'px;',
        duration: 1.0
      });
      
      $(cells[c]).toggleClassName('clps');
      $(cells[c]).toggleClassName('expn');
    }
    
  }
  
}


/******************************************************************************
 * Expand and collapse cells that are originally hidden, but has since become visible.
 *
*******************************************************************************/
function expandCollapseCells(dropId) {
  
  var newWidth = 0;  //the newWidth of the expanded/collapsed content
  var c = 0;  //counter
  
  //target is shrunk, so shrink all expanded hidden cells
  if ($(dropId).hasClassName('collapsed')) {
    
    var cells = $(dropId).select('span.expn');
    
    //shrink each cell
    for (c = 0; c < cells.length; c++) {
      
      if ($(cells[c]).getWidth() != 0) {
        newWidth = (($(cells[c]).getWidth() - 7) / 2);
      }
      
      new Effect.Morph(cells[c], {
        style: 'width:' + newWidth + 'px;',
        duration: 1.0
      });
      
      $(cells[c]).addClassName('clps');
      $(cells[c]).removeClassName('expn');
    }

    $(dropId + 'ToggleText').innerHTML = 'Expand';
  }
    
  //target is expanded so expand all shrunk cells
  if ($(dropId).hasClassName('expanded')) {

    var cells = $(dropId).select('span.clps');
  
    for (c = 0; c < cells.length; c++) {
      
      if ($(cells[c]).getWidth() != 0) {
        newWidth = (($(cells[c]).getWidth() * 2) + 7);
      }
      
      new Effect.Morph(cells[c], {
        style: 'width:' + newWidth + 'px;',
        duration: 1.0
      });
      
      $(cells[c]).removeClassName('clps');
      $(cells[c]).addClassName('expn');
    }
    
    $(dropId + 'ToggleText').innerHTML = 'Collapse';
  }
  
}


/******************************************************************************
 * Scroll a target on mouse hover over the scroll images
 ******************************************************************************/
function scrollDropArea(event) {
  //clearTimeout(scrollTimer);
  var parameters = $A(arguments);

  var step = 0; //parameters[2];

  var elem = $(parameters[1]);
  //var scrollDiv = $('drop_1_frame'); //Event.element(event);
  
  //var offset = $(scrollDiv).cumulativeOffset();  //get the location of the div within the page
  //var posX = Event.pointerX(event);   //get the X position of the mouse within the page
  //var posY = Event.pointerY(event);   //get the Y position of the mouse within the page
  
    
  //var scrollDivHeight = $(scrollDiv).getHeight();
  //var height = offset[1] + $(scrollDiv).getHeight() - posY;
  
  ////if (step == -1) {
  ////  step = step * 6 * ((height)/scrollDivHeight);
  ////} else {
  ////  step = step * 6 * ((scrollDivHeight-height)/scrollDivHeight);
  ////}

  //if ((posY - offset[1]) < scrollDivHeight/4 ) {
  //  step = -3;
  //} else if ((posY - offset[1]) > (scrollDivHeight * .75)) {
  //  step = 3;
  //}
  
  //alert($(elem).identify());
  
  step = parameters[2];
  
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


function jumpToTop(id) {
    $(id).scrollTop = 0;
}

function jumpToBottom(id) {
    $(id).scrollTop = 100000;
}

/******************************************************************************
* Show more rows
******************************************************************************/
function showMore(drop_id, abbr, size, j) {

  Effect.SlideDown(drop_id + '_hide_' + abbr + '_' + j, 'slide' ); 
  $(drop_id + '_more_' + abbr + '_' + j).hide(); 
  $(drop_id + '_more_' + abbr + '_' + ( (j+12) > size ? size : (j+12) )).show(); 

  setTimeout(function(){expandCollapseHiddenCells(drop_id, $(drop_id + '_hide_' + abbr + '_' + j))}, 1000);

}

/******************************************************************************
* Show less rows
******************************************************************************/
function showLess(drop_id, abbr, j) {

  setTimeout(function(){expandCollapseHiddenCells(drop_id, $(drop_id + '_hide_' + abbr + '_' + (j-12)))}, 1000);

  Effect.SlideUp(drop_id + '_hide_' + abbr + '_' + (j-12), 'slide' ); 
  $(drop_id + '_more_' + abbr + '_' + j).hide(); 
  $(drop_id + '_more_' + abbr + '_' + (j-12)).show();
  
}

/******************************************************************************
* Show less rows
******************************************************************************/
function finalShowLess(drop_id, abbr, size) {
  setTimeout(function(){expandCollapseHiddenCells(drop_id, $(drop_id + '_hide_' + abbr + '_' + (size - (size % 12))))}, 1000);
  
  Effect.SlideUp(drop_id + '_hide_' + abbr + '_' + (size - (size % 12)), 'slide' ); 
  $(drop_id + '_more_' + abbr + '_' + size).hide(); 
  $(drop_id + '_more_' + abbr + '_' + (size - (size % 12))).show();
  
}