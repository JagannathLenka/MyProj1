module BayHelper

  @output_aisle = 'Jagannath'
  @output_bay   = 'Jagannath'
  

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



  def aisle_render
    
  BayHelper.output_aisle = ''
  BayHelper.output_bay   = ''  

     @aislehash.each do |aisle, aislevalue| 
        case aislevalue["aisle_properties"]["aisle_pick"]
            
          when "L"
             left_open aisle, aislevalue
            
          when "R"
             right_open aisle, aislevalue
      
          when "LR"
             both_side_aisle aisle, aislevalue
            
          else
            empty_aisle aisle, aislevalue   
       end       
   end   
   return  
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
                       <div  style="width:80px; height:43px; float:left"> </div> 
                   </td>'
       return output               
  end

  

 def aisle_divider

       output = '</tr>
                    <td>              
                     <div  class="aisle_divider"> </div>            
                  </td>
                 </tr>
                <tr> '
       
       return output
   
 end

 #aisle header
 def drive_header aisle, aislevalue

       output ='<tr>                 
                  <td>
                    <div  class="aisle ui-corner-all" id="' + aisle.to_s + '"> Aisle: '+ aislevalue["aisle_properties"]["customer_id"].to_s + '</div> 
                  </td>'                  
       return output
 end
 
 #aisle drive path
 def drive_path  
        output ='<tr>  
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


 #bay details
 def bay_details bay, bayvalue
   
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

       
       BayHelper.output_aisle +=  aisle_header aisle, aislevalue  
       BayHelper.output_bay   +=   drive_path 

       BayHelper.output_aisle +=  aisle_placeholder
       
       aislevalue["row"]["L"].to_a.each do |bay,bayvalue| 
           BayHelper.output_bay   += (bay_details bay, bayvalue)             

     end   

   return 
  end

 #Right side open aisle 
  def right_open aisle, aislevalue
    
       output = ''

           #Aisle Divider      
           BayHelper.output_bay += aisle_divider       
            
           BayHelper.output_aisle += aisle_placeholder
           #Aisle details
           aislevalue["row"]["R"].to_a.each do |bay,bayvalue|        
             BayHelper.output_bay += (bay_details bay, bayvalue)       
           end          

           BayHelper.output_aisle+= aisle_header aisle, aislevalue  
           BayHelper.output_bay+=   drive_path 
       return 
  end


 #Both side aisle 
  def both_side_aisle aisle, aislevalue
    
       output = ''

       #Aisle Divider
      
           BayHelper.output_bay += aisle_divider       
           BayHelper.output_aisle += aisle_placeholder 
 
           aislevalue["row"]["L"].to_a.each do |bay,bayvalue|         
               BayHelper.output_bay += (bay_details bay, bayvalue)              
           end          

           BayHelper.output_aisle+= (aisle_header aisle, aislevalue)  
           BayHelper.output_bay+=   drive_path 
           BayHelper.output_aisle += aisle_placeholder
   
           #Aisle details
           aislevalue["row"]["R"].to_a.each do |bay,bayvalue|        
             BayHelper.output_bay += (bay_details bay, bayvalue)       
           end          
         return 
       end        

  #Empty Aisle 
  def empty_aisle aisle, aislevalue
    
      if aislevalue["row"].empty?                  
         BayHelper.output_aisle += aisle_header aisle, aislevalue
         BayHelper.output_bay += '</tr>
                         <tr>
                          <td>
                            <div  class="aisle_Empty"></div>
                          </td>'                   
        return
      end 
  end

  def self.output_aisle= aisle
    @output_aisle = aisle
  end    

  def self.output_aisle
    @output_aisle
  end
  
  def self.output_bay
    @output_bay
  end    
  

  def self.output_bay=bay
    @output_bay=bay
  end    
      

end