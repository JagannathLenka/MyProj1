module BayHelper
  def selected_bay(bayvalue)
    image_tag("pointer.jpg") if bayvalue[:customerid] == params["selectedbay"]
    
  end

  def bay_type bayvalue
    
    case 
      
   when bayvalue[:type] == 'bay'
     return image_tag("low_priority_bay.jpg", :size => "100x35")
  
   when bayvalue[:type] == 'bay_Empty' && bayvalue[:priority_bay] != "High"
     return image_tag("low_priority_empty_bay.jpg", :size => "100x35")
    
   when bayvalue[:type] == 'bay_Empty' && bayvalue[:priority_bay] = "High"
     return image_tag("high_priority_empty_bay.gif", :size => "100x35")
    
   end 
  end



  def aisle_render aisle, aislevalue
    
    case aislevalue["aisle_properties"]["aisle_pick"]
        
      when "L"
        return left_open aisle, aislevalue
        
      when "R"
        return right_open aisle, aislevalue
  
      when "LR"
        return close_aisle aisle, aislevalue
        
      else
       return empty_aisle aisle, aislevalue   
   end       
    
  end

  #Aisle Header 
  def aisle_header aisle, aislevalue

        output='</tr><tr>
                    <td> 
                       <div  class="aisle ui-corner-all" id="' + aisle.to_s + '"> Aisle: '+ aislevalue["aisle_properties"]["customer_id"].to_s + '</div> 
                   </td>'
       return output               
  end


  #Aisle placeholder 
  def aisle_placeholder

        output=     '</tr><tr>                      
                     <td> 
                       <div  style="width:80px"></div>
                   </td>'
       return output               
  end

  
  #Empty Aisle 
  def empty_aisle aisle, aislevalue
    
      if aislevalue["row"].empty?                  
         output = aisle_header aisle, aislevalue
         output += '<td>
                    <div  class="aisle_Empty"></div>
                  </td>'                   
        return output
      end 
  end


 def aisle_divider

       output = '</tr>
                  <tr>
                    <td>
                      <div  style="width:80px"></div>
                    </td>
                    <td>              
                     <div  class="aisle_divider"> </div>            
                  </td>'
       
       return output
   
 end

 def drive_path aisle, aislevalue

       output ='<tr>                 
                  <td>
                    
                    <div  class="aisle ui-corner-all" id="' + aisle.to_s + '"> Aisle: '+ aislevalue["aisle_properties"]["customer_id"].to_s + '</div>  
                  </td>                  
                  <td>
                     <table> 
                       <tr>
                          <td>          
                           <div  class="aisle_drivepath"></div>            
                         </td>
                       </tr>
                       <tr>  
                          <td>
                            <div> <hr color="yellow" style="margin:0px; height:1px"></div>   
                          </td>
                       </tr>  
                       <tr>
                          <td>              
                            <div  class="aisle_drivepath"></div>           
                          </td>
                       </tr>
                     </table>     
                  </td>
                </tr>' 
  
       
       return output
   
 end



 def bay_details bay, bayvalue
   
      logger.debug bayvalue 
       output = ''
       output  += '<td class="bay_col">' +
                     '<div id="' + bay.to_s + '"' + 
                         ' class="' + bayvalue[:type].to_s + '"' + 
                         ' title=" Product Type:' +  bayvalue[:item].to_s + '"' +  
                         ' style="background-color:'  + (bayvalue[:priority_bay]=='Highx' ? "#FFFF99" : "white").to_s + '" >' + 
                                selected_bay(bayvalue).to_s  +    
                                bay_type(bayvalue).to_s +            
                         '<label id="'+ bay.to_s + '_label" ' +
                                 'style="align:center">' + bayvalue[:customerid].to_s + '</label>' +           
                     '</div>
                  </td>'    
       return output  
 end 



  #Left side open aisle 
  def left_open aisle, aislevalue
  
    output = ''  
    
       output+= drive_path aisle, aislevalue

       output += aisle_placeholder
       
       aislevalue["row"]["L"].to_a.each do |bay,bayvalue| 
           output += bay_details bay, bayvalue              

    end   

   return output
  end

 #Right side open aisle 
  def right_open aisle, aislevalue
    
       output = ''

           #Aisle Divider      
           output += aisle_placeholder
           output += aisle_divider       
            
           output += aisle_placeholder
           #Aisle details
           aislevalue["row"]["R"].to_a.each do |bay,bayvalue|        
             output += bay_details bay, bayvalue       
           end          

           output+= drive_path aisle, aislevalue
       return output
  end


 #Right side open aisle 
  def close_aisle aisle, aislevalue
    
       output = ''

       #Aisle Divider
      
           output += aisle_divider       
           output += aisle_placeholder 
 
           aislevalue["row"]["L"].to_a.each do |bay,bayvalue|         
               output += bay_details bay, bayvalue              
           end          

           output+= drive_path aisle, aislevalue
           output += aisle_placeholder
   
           #Aisle details
           aislevalue["row"]["R"].to_a.each do |bay,bayvalue|        
             output += bay_details bay, bayvalue       
           end          
         return output
       end        
      

end