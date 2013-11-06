module SlottingrecomaintenanceHelper
  include JqgridsHelper

  def slotting_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
      id  = params["id"]
      url = "/slottingrecomaintenance" 
      height = 300 
      width = 1100   
    
    
    addcheckfunc = 'function(postdata, formid) {return[true, " "]}'
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#slotting_list').jqGrid('restoreRow',lastsel);
                           jQuery('#slotting_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#slotting_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});}, 
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"   
                      
     slottfunc  = 'function() {
                                var ids = $("#slotting_list").jqGrid("getGridParam","selarrrow");
                                
                                 $.post("/slottingrecomaintenance",
                                       {
                                         "oper" :"slott",
                                         "id"   :ids
                                       },
                                       function(data,status)
                                       {
                               
                                       });
                                 $("#slotting_list").trigger("reloadGrid"); 
                                 lastsel=0;      
                   }'
                                       

    grid = [{
      :url => url,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> height,
      :width => width,
      
      :colNames => ['Id', 'Item No','Quantity to be slotted','Preffered Warehouse', 'Preffered  Zone' ,
        'Preffered Aisle','Preffered Bay','Preffered Level','Preffered Position','Preffered Slottingrules',
        'Partial Slotting', 'Reco Location', 'Slotting status'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55,:hidden => true },
        { :name => 'item_number', :index => 'item_number',  :width => 80, :align => 'center', :editable => true, :hidden => false},
        { :name => 'quantity_to_be_slotted',:index => 'quantity_to_be_slotted',     :width => 80,  :align => 'center', :editable => true },
        { :name => 'preffered_warehouse', :index => 'preffered_warehouse',  :width => 80, :align => 'center', :editable => true},
        { :name => 'preffered_zone', :index => 'preffered_zone',  :width => 80, :align => 'center', :editable => true, :hidden => false},        
        { :name => 'preffered_aisle', :index => 'preffered_aisle',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'preffered_bay', :index => 'preffered_bay',     :width => 80,  :align => 'center', :editable => true },
        { :name => 'preffered_level', :index => 'preffered_level',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'preffered_position',:index => 'preffered_position',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'preffered_slotting_rules',:index => 'preffered_slotting_rules',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'partial_slotting',    :index => 'partial_slotting',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'location_recommended', :index => 'location_recommended',  :width => 80, :align => 'center', :editable => true, formatter:'showlink', formatoptions:{baseLinkUrl:'/bay?id=161', addParam: '&selectedbay=B3'}},
        { :name => 'slotting_status',:index => 'slotting_status',     :width => 80,  :align => 'center', :editable => true, edittype:"select", editoptions: {value: "Open:Open;Close:Close" }}
      ],
      :editurl => '/slottingrecomaintenance',
      :pager => '#slotting_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Slottingrecommendation Maintenance',
      :reloadAfterEdit => true,
      :multiselect => true,
      :onSelectRow => selectrowfunc.to_json_var }]


    pager = [:navGrid, "#slotting_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var, :beforeSubmit => addcheckfunc.to_json_var}, {}, {}, {}]   
    slotting_button = [:navButtonAdd, "#slotting_pager", {:caption => 'Slot the items', :onClickButton => slottfunc.to_json_var }]               
    

    jqgrid_api 'slotting_list', grid, pager, slotting_button, options

  end
end
