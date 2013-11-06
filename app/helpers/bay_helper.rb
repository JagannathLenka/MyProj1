module BayHelper
  def selected_bay(bayvalue)
    image_tag("pointer.jpg") if bayvalue[:customerid] == params["selectedbay"]
    
  end
end
