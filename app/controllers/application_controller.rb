class ApplicationController < ActionController::Base
  
   before_filter :login_require, :except=>[:new, :create]
   protect_from_forgery
   
   private
   def login_require
     response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
   response.headers["Pragma"] = "no-cache"
   response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
   
    if cookies[:userid].nil? 
               redirect_to "/login"
    else
      @userid = cookies[:userid]
    end
    
  end
end
