//global variable
  pos_html_map = {}           
  $( init );
 
 
//

//To swap the position of two items
function init() { 
 
 posHTML.setDragnDrop()
 
 //Tooltip
  $("a").tooltip('show')
  $('a').tooltip({html: true})  
  $("a").tooltip('hide')  
}


var posHTML = {


  
setDragnDrop: function setDragnDrop() { 
 
    $('.pos').draggable(
       {
        revert: true, 
        helper: helpermethod,
        
        start: function(event, ui) {
           var offset = $(this).offset(); 
           
           pos_html_map.pos= $(this).attr('id');
           pos_html_map.title= $(this).attr('title');
           pos_html_map.content= $(this).attr('class') ;           
       }
    });

  function helpermethod( event ) {
    
         newdiv = '<div id ="pos_draggedhelper" class="pos_draggedhelper">' +  $(this).attr('title') + '</div>'
         return newdiv;
  }
  
  
    $('.pos_Empty').droppable( {
        drop: handleDropEvent
        
      } ); 
    
   
  function handleDropEvent( event, ui ) {

        oldTitle = $(this).attr('title');
        oldid = $(this).attr('id');

        $(this).removeClass('ui-draggable ui-droppable')
        oldClass = $(this).attr('class');
  


        //this code is written because ui-droppable is always appeneded after the JQuery        
        $('#pos_draggedhelper').html(oldTitle);
        $('#pos_draggedhelper').attr(oldClass);


        $(this).attr('title', pos_html_map.title);
        $(this).attr('class', pos_html_map.content);
        $(this).removeClass('ui-draggable ui-droppable')

        pos = pos_html_map.pos;

        $("#"+pos).attr('title', oldTitle);
        $("#"+pos).attr('class',  oldClass);

        $.post("/position",
                {
                  "position[event]": "update_posclass",
                  "position[dragpos_id]": pos,
                  "position[droppos_id]": $(this).attr('id')   
                },
                function(data,status)
                {
                  //window.location.reload();
                  if (data=='false')
                    {alert('Can not move Item due to preference mismatch');}
                
                //$('#position').load('/position/'+ <%= @bay_id %>);
                        
                    });
              
      } 
    } //ends the init function

}

  function goBack()
    {
    window.history.back()
    }

