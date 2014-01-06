module WarehousemaintenanceHelper
  include JqgridsHelper

  def warehouse_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    editcheckfunc = 'function(postdata, formid) 
      {
          if (parseInt(postdata.no_of_zones) < parseInt(postdata.no_of_zones_hidden)) 
                   {
                      return[false, "Can not delete Zones from this screen, Please use Zone Maintenance"];
                    } 
              return[true, " "]}' 
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#warehouse_list').jqGrid('restoreRow',lastsel);
                           jQuery('#warehouse_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#warehouse_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"       
       
    grid = [{
      :url => '/warehousemaintenance/',
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      :width => 'auto',
      
      :colNames => ['Id','Sequence', 'Warehouse','Client Id','Description', 'No of Zones','Noof zones_hidden', 'City','State','Country','Location','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',   :index => 'id',  :width => 55, hidden:true},
        { :name => 'sm_warehouse_id',   :index => 'sm_warehouse_id',:width => 100,:align => 'center',:editable => false, hidden:true},
        { :name => 'cl_warehouse_id',   :index => 'cl_warehouse_id',    :width => 150, :align => 'center', :editable => true, editrules:{required:true},formatter:'showlink', formatoptions:{baseLinkUrl:'/zonemaintenance'}},
        { :name => 'client_id',   :index => 'client_id',    :width => 100, :align => 'center', :editable => false},
        { :name => 'description',  :index => 'description',  :width => 150, :align => 'left', :editable => true},
        { :name => 'no_of_zones' ,   :index => 'no_of_zones',     :width => 80,  :align => 'center', :editable => true, editrules:{required:true,number:true}},
        { :name => 'no_of_zones_hidden' ,   :index => 'no_of_zones_hidden',     :width => 60,  :align => 'left',hidden:true, :editable => true},
        { :name => 'attribute1',  :index => 'attribute1',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'attribute2',  :index => 'attribute2',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'attribute3',  :index => 'attribute3',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'attribute4',  :index => 'attribute4',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'attribute5',  :index => 'attribute5',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute6',  :index => 'attribute6',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute7',  :index => 'attribute7',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute8',  :index => 'attribute8',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        
     ],
      :editurl => '/warehousemaintenance',
      :pager => '#warehouse_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'asc',
      :shrinkToFit => true,
      :autowidth => true,
      :viewrecords => true,
      :caption => 'Warehouse Maintenance',
      :reloadAfterEdit => true,
      :onSelectRow => selectrowfunc.to_json_var }]
    pager = [:navGrid, "#warehouse_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, 
                                                       :closeOnEscape => true,  :beforeSubmit => editcheckfunc.to_json_var}, 
                                                       {:closeAfterAdd=>true, :errorTextFormat  => aftersubfunc.to_json_var}, {}, {}, {}]                                                              

    pager_button = [:navButtonAdd, "#warehouse_pager", 
                   {:caption => "Show Locations", :onClickButton => "function() {
                                          var grid = $('#warehouse_list');
                                          selectedRowId= grid.jqGrid ('getGridParam','selrow');                                          
                                          if (selectedRowId == null){
                                          $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ 'Select warehouse for location' +'</div>', 
                                          $.jgrid.edit.bClose,{buttonalign:'right'});  
                                             return;
                                          }                
                                          window.location.href = '/locationmaintenance?warehouse_id=' + selectedRowId                                                
                                          }".to_json_var }]
                                          
    
    
    jqgrid_api 'warehouse_list', grid, pager , pager_button, options

  end

end