module LocationmaintenanceHelper
  include JqgridsHelper

  def loc_jqgrid
    
    options = {:on_document_ready => true, :html_tags => false}
    
    if ! params[:warehouse_id].nil?
        url = '/locationmaintenance?warehouse_id=' + params[:warehouse_id]   
    else
       url = '/locationmaintenance?zone_id=' + params[:zone_id] 
    end
       
    editcheckfunc = 'function(postdata, formid) 
              {
               
                if (parseInt(postdata.current_quantity) < parseInt(postdata.minimum_quantity)) 
                   {
                     return[false, "Can not have less quantity than Minimum quantity"];
                   } 
                 if (parseInt(postdata.current_quantity) > parseInt(postdata.maximum_quantity)) 
                 {
                   return[false, "Can not have more quantity than Maximum quantity"];
                 } 

              return[true, " "]}'    
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#loc_list').jqGrid('restoreRow',lastsel);
                           jQuery('#loc_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#loc_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                             });
                     lastsel=id;
                     } 
                   }" 
             
      
      grid = [{
      :url => url,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      :width=> 'auto',
      :scrollbar=> true,
      
      :colNames => ['Id','Sequence','Location','sm_pos_id', 'Position', 'sm_level_id','Level','sm_bay_id', 'Bay',
                    'sm_aisle_id','Aisle','sm_zone_id','Zone', 'sm_warehouse_id','Warehouse','sm_barcode', 'Barcode','Client Id',
                    'Current Item','Current Quantity','Lifetime TotalPicks','Lock Code','Minimum Quantity', 'Maximum Quantity','Status',
                    'Priority Location','Length','Breadth','Height','Volume','Allowed Weight','Short Description','Long Description',
                    'Location Type','Sequence No.','Attribute3','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'location[id]',      :index => 'id',    :width => 55, :hidden => true},
        {:name => 'location[sm_loc_id]', :index => 'sm_loc_id',  :width => 120, :align => 'center', :editable => true, :hidden => true},
        {:name => 'location[cl_loc_id]', :index => 'cl_loc_id',  :width => 120, :align => 'center', :editable => true,  :hidden => true},
        { :name => 'location[sm_pos_id]',  :index => 'sm_pos_id',  :width => 120, :align => 'center', :hidden => true, :hidden => true},
        {:name => 'location[cl_pos_id]', :index => 'cl_pos_id',  :width => 120, :align => 'center', :editable => false, :hidden => true},
        { :name => 'location[sm_level_id]',  :index => 'sm_bay_id',  :width => 120, :align => 'center', :editable => false, :hidden => true},
        { :name => 'location[cl_level_id]',  :index => 'cl_level_id',  :width => 120, :align => 'center', :editable => false , :hidden => true},
        { :name => 'location[sm_bay_id]',  :index => 'sm_bay_id',  :width => 120, :align => 'center', :editable => false, :hidden => true },
        {:name => 'location[cl_bay_id]', :index => 'cl_bay_id',  :width => 120, :align => 'center', :editable => false, :hidden => true},  
        { :name => 'location[sm_aisle_id]', :index => 'sm_aisle_id', :width => 150,  :align => 'left', :editable => true,:hidden => true },
        { :name => 'location[cl_aisle_id]', :index => 'cl_aisle_id', :width => 100,  :align => 'center', :editable => true, :hidden => true},
        { :name => 'location[sm_zone_id]',  :index => 'sm_zone_id',     :width => 150,  :align => 'left', :editable => false,:hidden => true },
        { :name => 'location[cl_zone_id]',  :index => 'cl_zone_id',     :width => 100,  :align => 'center', :editable => true, :hidden => true},
        { :name => 'location[sm_warehouse_id]',:index => 'sm_warehouse_id',   :width => 80,   :align => 'center', :editable => false,:hidden => true },
        { :name => 'location[cl_warehouse_id]', :index => 'cl_warehouse_id',   :width => 100,   :align => 'center', :editable => true, :hidden => false, editrules:{required:true}},
        { :name => 'location[sm_barcode]', :index => 'sm_barcode',   :width => 80,   :align => 'center', :editable => false, :hidden => true},
        { :name => 'location[cl_barcode]',   :index => 'cl_barcode',   :width => 160,   :align => 'center', :editable => true},
        { :name => 'location[client_id]',:index => 'client_id',     :width => 55,  :align => 'center', :editable => false, :hidden => true },
        {:name => 'location[current_item]', :index => 'current_item',  :width => 120, :align => 'center', :editable => true, editrules:{required:false}},
        {:name => 'location[current_quantity]', :index => 'current_quantity',  :width => 120, :align => 'center', :editable => true, editrules:{required:false}},
        {:name => 'location[life_time_total_picks]', :index => 'life_time_total_picks',  :width => 120, :align => 'center', :editable => true,:hidden => true},
        {:name => 'location[lock_code]', :index => 'lock_code',  :width => 80, :align => 'center', :editable => true},
        {:name => 'location[minimum_quantity]', :index => 'minimum_quantity',  :width => 120, :align => 'center', :editable => true, editrules:{required:false}},
        {:name => 'location[maximum_quantity]', :index => 'maximum_quantity',  :width => 120, :align => 'center', :editable => true, editrules:{required:false}},
        {:name => 'location[status]', :index => 'status',  :width => 120, :align => 'center', :editable => true, editrules:{required:true}},
        {:name => 'location[location_priority]', :index => 'location_priority',  :width => 120, :align => 'center', :editable => false,:hidden => false},
        {:name => 'location[location_length]', :index => 'location_length',  :width => 120, :align => 'center', :editable => true},
        {:name => 'location[location_breadth]', :index => 'location_breadth',  :width => 120, :align => 'center', :editable => true},
        {:name => 'location[location_height]', :index => 'location_height',  :width => 120, :align => 'center', :editable => true},
        {:name => 'location[location_volume]', :index => 'location_volume',  :width => 120, :align => 'center', :editable => true},
        {:name => 'location[allowed_weight]', :index => 'allowed_weight',  :width => 120, :align => 'center', :editable => true},
        {:name => 'location[item_short_description]', :index => 'item_short_description',  :width => 120, :align => 'center', :editable => true},
        {:name => 'location[item_long_description]', :index => 'item_long_description',  :width => 120, :align => 'center', :editable => true},
        { :name => 'location[attribute1]',   :index => 'attribute1',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'location[attribute2]',   :index => 'attribute2',   :width => 100,   :align => 'center', :editable => false, :hidden =>true},
        { :name => 'location[attribute3]',   :index => 'attribute3',   :width => 100,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'location[attribute4]',   :index => 'attribute4',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'location[attribute5]',   :index => 'attribute5',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'location[attribute6]',   :index => 'attribute6',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'location[attribute7]',   :index => 'attribute7',   :width => 80,   :align => 'center', :editable => true,:hidden => true},
        { :name => 'location[attribute8]',   :index => 'attribute8',   :width => 80,   :align => 'center', :editable => true, :hidden => true}
        
      ],
      :editurl => '/locationmaintenance',
      :pager => '#loc_pager',
      :rowNum => 50,
      :rowList => [50, 100, 200],
      :sortname => 'cl_barcode',
      :sortorder => 'asc',
      :viewrecords => true,
      :shrinkToFit => true,
      :autowidth => true,
      :multiselect => true,
      :caption => 'Location Maintenance',
      :closeAfterEdit => true,
      :reloadAfterEdit => true,
      :onSelectRow => selectrowfunc.to_json_var }]

      pager = [:navGrid, "#loc_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                         :closeOnEscape => true, :beforeSubmit => editcheckfunc.to_json_var}, 
                                                         {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var}, {}, {closeAfterSearch:true}, {}]   
      
      pager_button = [:navButtonAdd, "#loc_pager", 
                   {:caption => 'Show Errors', :onClickButton => 'function() {
                                          win = window.open("/locationerror", "_blank");
                                          win.focus();
                                          }'.to_json_var }]
  
      jqgrid_api 'loc_list', grid, pager,  pager_button, options

  end

end
