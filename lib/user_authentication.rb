module UserAuthentication
  def self.authentication user
    if user.nil? 
       redirect_to "/login"
       #return false
    else
        @userid = user
        #return true
    end
  end
end