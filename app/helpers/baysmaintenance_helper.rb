module BaysmaintenanceHelper
    
  include JqgridsHelper

  def bays_jqgrid
    
    options = {:on_document_ready => true, :html_tags => false}
    url = "/baysmaintenance?id=" + params["id"]
    editcheckfunc = 'function(postdata, formid) 
              {
               
                if (parseInt(postdata.no_of_level_bay) < parseInt(postdata.no_of_level_bay_hidden)) 
                   {
                     return[false, "Can not delete levels from this screen, Please use Level Maintenance"];
                   } 

              return[true, " "]}'
    addcheckfunc = 'function(postdata, formid) {postdata.pt_aisle_id=' + params["id"] + '; return[true, " "]}'
    copyrowfunc  = 'function() {
                                var ids = $("#bays_list").jqGrid("getGridParam","selarrrow");
                                
                                 $.post("/baysmaintenance",
                                       {
                                         "oper" :"cpy",
                                         "id"   :ids[0]
                                       },
                                       function(data,status)
                                       {
                                        alert(data);
                                       });
                                 $("#bays_list").trigger("reloadGrid");       
                   }'

     aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
     selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#bays_list').jqGrid('restoreRow',lastsel);
                           jQuery('#bays_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#bays_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                             });
                     lastsel=id;
                     } 
                   }" 
    grid = [{
      :url => url ,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      
     
      :colNames => ['Id','Sequence', 'Bay','Description','Client Id','sm_aisle_id','Aisle','aisle_id','sm_zone_id','Zone', 'sm_warehouse_id','Warehouse','Level/Bay', 'no_of_level_bay_hidden','Bay Sticker','Product Category','Row Of Aisle','PriorityBay','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',      :index => 'id',    :width => 55, :hidden => true},
        { :name => 'sm_bay_id',  :index => 'sm_bay_id',  :width => 120, :align => 'center', :editable => true, :hidden => true},
        { :name => 'cl_bay_id', :index => 'cl_bay_id',  :width => 80, :align => 'center', :editable => true, editrules:{required:true},formatter:'showlink', formatoptions:{baseLinkUrl:'/levelmaintenance'}},
        { :name => 'description', :index => 'description', :width => 120,  :align => 'left', :editable => true },
        { :name => 'client_id',:index => 'client_id',     :width => 55,  :align => 'center', :editable => false, :hidden => true},
        { :name => 'sm_aisle_id', :index => 'sm_aisle_id', :width => 150,  :align => 'center', :editable => false,:hidden => true },
        { :name => 'cl_aisle_id', :index => 'cl_aisle_id', :width => 120 ,  :align => 'center', :editable => false},
        { :name => 'aisle_id',    :index => 'aisle_id',     :width => 150,  :align => 'center', :editable => false,:hidden => true },
        { :name => 'sm_zone_id',  :index => 'sm_zone_id',     :width => 150,  :align => 'center', :editable => false,:hidden => true },
        { :name => 'cl_zone_id',  :index => 'cl_zone_id',     :width => 120,  :align => 'center', :editable => false},
        { :name => 'sm_warehouse_id',:index => 'sm_warehouse_id',   :width => 120,   :align => 'center', :editable => false,:hidden => true },
        { :name => 'cl_warehouse_id', :index => 'cl_warehouse_id',   :width => 120,   :align => 'center', :editable => false},
        { :name => 'no_of_level_bay', :index => 'no_of_level_bay',   :width => 120,   :align => 'center', :editable => true,editrules:{required:true,number:true}},
        { :name => 'no_of_level_bay_hidden', :index => 'no_of_level_bay_hidden',   :width => 120,   :align => 'center', :hidden => true,:editable => true},
        { :name => 'attribute1',   :index => 'attribute1',   :width => 120,   :align => 'center', :editable => true,:hidden => true },
        { :name => 'attribute2',   :index => 'attribute2',   :width => 120,   :align => 'center', :editable => true},
        { :name => 'attribute3',   :index => 'attribute3',   :width => 120,   :align => 'center', :editable => true ,editrules:{required:true}},
        { :name => 'attribute4',   :index => 'attribute4',   :width => 120,   :align => 'center', :editable => true,edittype:"select", editoptions: {value: "Yes:Yes;No:No" }},
        { :name => 'attribute5',   :index => 'attribute5',   :width => 120,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute6',   :index => 'attribute6',   :width => 120,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute7',   :index => 'attribute7',   :width => 120,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute8',   :index => 'attribute8',   :width => 120 ,  :align => 'center', :editable => true, :hidden => true}
        
      ],
      :editurl => '/baysmaintenance',
      :pager => '#bays_pager',
      :rowNum => 30,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Bay Maintenance',
      :closeAfterEdit => true,
      :reloadAfterEdit => true,
      :multiselect => true,
      :onSelectRow => selectrowfunc.to_json_var }]

      pager = [:navGrid, "#bays_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                         :closeOnEscape => true, :beforeSubmit => editcheckfunc.to_json_var}, 
                                                         {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var, :beforeSubmit => addcheckfunc.to_json_var}, {}, {}, {}]   
      
      pager_button = [:navButtonAdd, "#bays_pager", {:caption => 'Copy to other bay', :onClickButton => copyrowfunc.to_json_var }]
  
      jqgrid_api 'bays_list', grid, pager,pager_button, options

  end

  
end