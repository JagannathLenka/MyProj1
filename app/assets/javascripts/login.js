         $(document).ready(function() {
			  $('.carousel').carousel({
 			  interval: 2000
			 })
		 });
     
     	 function register(){
					$('#register').load("/userregister"); 
				    $('#register').dialog({
		    	  	height: 1000,
		      		width: 800,
		      		modal: true
				 })
	       }
	       
          function getCookie(c_name)
					{
					var c_value = document.cookie;
					var c_start = c_value.indexOf(" " + c_name + "=");
					if (c_start == -1)
					  {
					  c_start = c_value.indexOf(c_name + "=");
					  }
					if (c_start == -1)
					  {
					  c_value = null;
					  }
					else
					  {
					  c_start = c_value.indexOf("=", c_start) + 1;
					  var c_end = c_value.indexOf(";", c_start);
					  if (c_end == -1)
					  {
					c_end = c_value.length;
					}
					c_value = unescape(c_value.substring(c_start,c_end));
					}
					return c_value;
					}

	        function login() {
                                
                                 $.post("/login",
                                       {
                                         "txtuid"  :$('#txtuid').val(),
                                         "txtpswd" :$('#txtpswd').val()
                                       },
                                       function(data,status)
                                       {
                               				if (data.substring(0,5) == "Error")
                               						$("#Error").html(data.substring(6));	
                               				else
                               					redirect_url = getCookie("last_url")
                               					if (redirect_url == null) {
                               						redirect_url = "/login/landingpage"
                               					}
                               					window.location.href=redirect_url;
                               							
                                       });                                   
                   }
                   
                   
          jQuery(function(){
			  jQuery(window).keyup( function(e){ 
    			if (e.keyCode == 13) {
         			login()
         		 }
  				});
		  });
       
