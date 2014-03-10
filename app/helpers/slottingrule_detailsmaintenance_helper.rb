module SlottingruleDetailsmaintenanceHelper
  
  include JqgridsHelper

  def slottingrule_details_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    id = params[:id]
     
    aftersubfunc   = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    addcheckfunc   = 'function(postdata, formid) {postdata.pt_master_id=' + params["id"] + '; return[true, " "]}' 
    dataevent_func = "function(e) {
                                   var thisval = $(e.target).val();                                  
                                   selectedRowId = $('#slottingrule_details_list').jqGrid ('getGridParam', 'selrow')
                                   $('#SlottingruleDetails\\\\[attribute2\\\\]').html(targetselect_func(thisval));  
                                   $('#' + selectedRowId + '_SlottingruleDetails\\\\[attribute2\\\\]').html(targetselect_func(thisval))  
                                  }"                        
                             
                    
    selectrowfunc  = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#slottingrule_details_list').jqGrid('restoreRow',lastsel);
                           jQuery('#slottingrule_details_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#slottingrule_details_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"       
       
    grid = [{
      :url => '/slottingrule_detailsmaintenance/?id=' + id,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      :width => 'auto',
      
      :colNames => ['Id','Ruleid','RuleType', 'Description','Attribute1','Attribute2','Attribute3','Attribute4','Attribute5','Attribute6'],
      :colModel  => [
        { :name => 'SlottingruleDetails[id]',   :index => 'id',  :width => 55, hidden:true},
        { :name => 'SlottingruleDetails[rule_id]',   :index => 'rule_id',:width => 100,:align => 'center',:editable => false},
        { :name => 'SlottingruleDetails[rule_type]',   :index => 'rule_type', :width => 150, :align => 'center', :editable => true, edittype:"select", editoptions: {value: "SELECTION:SELECTION;SORTING:SORTING"}},
        { :name => 'SlottingruleDetails[rule_description]',   :index => 'rule_description',    :width => 100, :align => 'center', :editable => true, edittype:"select", 
                                                               editoptions: {value: "select:select; item_category1:Item category1; item_category2:Item category2; item_category3:Item category3;velocity:Velocity", 
                                                                              dataEvents:   [                                                      
                                                                                            {type: 'change', fn: dataevent_func.to_json_var}, 
                                                                                            {type: 'click', fn: dataevent_func.to_json_var} 
                                                                                           ] 
                                                                             }                                                               
                                                                },
        { :name => 'SlottingruleDetails[attribute1]',  :index => 'attribute1',   :width => 100,   :align => 'center', :editable => true, edittype:"select", editoptions: {value: "in:=;Like:like" }},
        { :name => 'SlottingruleDetails[attribute2]',  :index => 'attribute2',   :width => 100,   :align => 'center', :editable => true, edittype:"select", editoptions: {value: "select:select", multiple: true}},
        { :name => 'SlottingruleDetails[attribute3]',  :index => 'attribute3',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'SlottingruleDetails[attribute4]',  :index => 'attribute4',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'SlottingruleDetails[attribute5]',  :index => 'attribute5',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'SlottingruleDetails[attribute6]',  :index => 'attribute6',   :width => 100,   :align => 'center', :editable => true,hidden:true},
       
     ],
      :editurl => '/slottingrule_detailsmaintenance',
      :pager => '#slottingrule_details_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'asc',
      :multiselect => true,
      :autowidth => true,
      :viewrecords => true,
      :caption => 'Slottingrule Details Maintenance',
      :reloadAfterEdit => true,
      :ondblClickRow  => selectrowfunc.to_json_var }]
      
    pager = [:navGrid, "#slottingrule_details_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, 
                                                       :closeOnEscape => true}, 
                                                       {:closeAfterAdd=>true , :beforeSubmit => addcheckfunc.to_json_var}, {}, {}, {}]                                                              

   
    
    jqgrid_api 'slottingrule_details_list', grid, pager , options

  end
end
