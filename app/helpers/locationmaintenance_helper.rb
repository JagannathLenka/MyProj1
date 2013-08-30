module LocationmaintenanceHelper
  include JqgridsHelper

  def loc_jqgrid
    
    options = {:on_document_ready => true, :html_tags => false}
    url = '/locationmaintenance?warehouse_id=' + params[:warehouse_id]   
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
      
      :colNames => ['Id','Sequence','Location','sm_pos_id', 'Position', 'sm_level_id','Level','sm_bay_id', 'Bay',
                    'sm_aisle_id','Aisle','sm_zone_id','Zone', 'sm_warehouse_id','Warehouse','sm_barcode', 'Barcode','Client Id',
                    'Current Item','Current Quantity','Lifetime TotalPicks','Lock Code', 'Maximum Quantity','Minimum Quantity','Status',
                    'Attribute1','Attribute2','Attribute3','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',      :index => 'id',    :width => 55, :hidden => true},
        {:name => 'sm_loc_id', :index => 'sm_loc_id',  :width => 120, :align => 'center', :editable => true, :hidden => true},
        {:name => 'cl_loc_id', :index => 'cl_loc_id',  :width => 120, :align => 'center', :editable => true,  :hidden => true},
        { :name => 'sm_pos_id',  :index => 'sm_pos_id',  :width => 120, :align => 'center', :hidden => true, :hidden => true},
        {:name => 'cl_pos_id', :index => 'cl_pos_id',  :width => 120, :align => 'center', :editable => false, :hidden => true},
        { :name => 'sm_level_id',  :index => 'sm_bay_id',  :width => 120, :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_level_id',  :index => 'cl_level_id',  :width => 120, :align => 'center', :editable => false , :hidden => true},
        { :name => 'sm_bay_id',  :index => 'sm_bay_id',  :width => 120, :align => 'center', :editable => false, :hidden => true },
        {:name => 'cl_bay_id', :index => 'cl_bay_id',  :width => 120, :align => 'center', :editable => false, :hidden => true},  
        { :name => 'sm_aisle_id', :index => 'sm_aisle_id', :width => 150,  :align => 'left', :editable => true,:hidden => true },
        { :name => 'cl_aisle_id', :index => 'cl_aisle_id', :width => 100,  :align => 'center', :editable => true, :hidden => true},
        { :name => 'sm_zone_id',  :index => 'sm_zone_id',     :width => 150,  :align => 'left', :editable => false,:hidden => true },
        { :name => 'cl_zone_id',  :index => 'cl_zone_id',     :width => 100,  :align => 'center', :editable => true, :hidden => true},
        { :name => 'sm_warehouse_id',:index => 'sm_warehouse_id',   :width => 80,   :align => 'center', :editable => false,:hidden => true },
        { :name => 'cl_warehouse_id', :index => 'cl_warehouse_id',   :width => 100,   :align => 'center', :editable => true, :hidden => false, editrules:{required:true}},
        { :name => 'sm_barcode', :index => 'sm_barcode',   :width => 80,   :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_barcode',   :index => 'cl_barcode',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'client_id',:index => 'client_id',     :width => 55,  :align => 'center', :editable => false, :hidden => true },
        {:name => 'current_item', :index => 'current_item',  :width => 120, :align => 'center', :editable => true, editrules:{required:true}},
        {:name => 'current_quantity', :index => 'current_quantity',  :width => 120, :align => 'center', :editable => true, editrules:{required:true}},
        {:name => 'life_time_total_picks', :index => 'life_time_total_picks',  :width => 120, :align => 'center', :editable => true},
        {:name => 'lock_code', :index => 'lock_code',  :width => 120, :align => 'center', :editable => true},
        {:name => 'maximum_quantity', :index => 'maximum_quantity',  :width => 120, :align => 'center', :editable => true, editrules:{required:true}},
        {:name => 'minimum_quantity', :index => 'minimum_quantity',  :width => 120, :align => 'center', :editable => true, editrules:{required:true}},
        {:name => 'status', :index => 'status',  :width => 120, :align => 'center', :editable => true, editrules:{required:true}},
        { :name => 'attribute1',   :index => 'attribute1',   :width => 100,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute2',   :index => 'attribute2',   :width => 100,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute3',   :index => 'attribute3',   :width => 100,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute4',   :index => 'attribute4',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute5',   :index => 'attribute5',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute6',   :index => 'attribute6',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute7',   :index => 'attribute7',   :width => 80,   :align => 'center', :editable => true,:hidden => true},
        { :name => 'attribute8',   :index => 'attribute8',   :width => 80,   :align => 'center', :editable => true, :hidden => true}
        
      ],
      :editurl => '/locationmaintenance',
      :pager => '#loc_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'sm_loc_id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Location Maintenance',
      :closeAfterEdit => true,
      :reloadAfterEdit => true,
      :onSelectRow => selectrowfunc.to_json_var }]

      pager = [:navGrid, "#loc_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                         :closeOnEscape => true, :beforeSubmit => editcheckfunc.to_json_var}, 
                                                         {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var}, {}, {closeAfterSearch:true}, {}]   
      
      #pager_button = [:navButtonAdd, "#loc_pager", {:caption => 'Copy to other bay', :onClickButton => copyrowfunc.to_json_var }]
  
      jqgrid_api 'loc_list', grid, pager, options

  end

end
