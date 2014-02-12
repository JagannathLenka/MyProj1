class ApplicationController < ActionController::Base
  
   before_filter :login_require, :except=>[:new, :create]
   protect_from_forgery
   
   private
   def login_require
     response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
     response.headers["Pragma"] = "no-cache"
     response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
   
    if cookies[:userid].nil? 
               cookies[:last_url] = request.url
               redirect_to "/login"
    else
      @userid = cookies[:userid]
      @client_id=cookies[:client_id]
    
     #Refresh the cookies 
      cookies[:userid] = { 
                           value: cookies[:userid],               
                            expires: 1.hour.from_now
                                }
      cookies[:client_id] = {
                    value: cookies[:client_id],                    
                    expires: 1.hour.from_now                    
                  } 
    
    end
    
  end
end
