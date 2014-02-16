module SlottingruleMastermaintenanceHelper
  
  include JqgridsHelper

  def slottingrule_master_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
     
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#slottingrule_master_list').jqGrid('restoreRow',lastsel);
                           jQuery('#slottingrule_master_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#slottingrule_master_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"       
       
    grid = [{
      :url => '/slottingrule_mastermaintenance/',
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      :width => 'auto',
      
      :colNames => ['RuleId','Priority', 'Description','Status','Users','Attribute1','Attribute2','Attribute3','Attribute4','Attribute5','Attribute6'],
      :colModel  => [
        { :name => 'SlottingruleMaster[id]',   :index => 'id',  :width => 55, :align => 'center',:editable => false, editrules:{required:true},formatter:'showlink', formatoptions:{baseLinkUrl:'/slottingrule_detailsmaintenance'}},
        { :name => 'SlottingruleMaster[priority]',   :index => 'priority',:width => 100,:align => 'center',:editable => true},
        { :name => 'SlottingruleMaster[description]',   :index => 'description', :width => 150, :align => 'center', :editable => true},
        { :name => 'SlottingruleMaster[status]',   :index => 'status',    :width => 100, :align => 'center', :editable => true},
        { :name => 'SlottingruleMaster[users]',  :index => 'users',  :width => 150, :align => 'center', :editable => true},
        { :name => 'SlottingruleMaster[attribute1]',  :index => 'attribute1',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'SlottingruleMaster[attribute2]',  :index => 'attribute2',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'SlottingruleMaster[attribute3]',  :index => 'attribute3',   :width => 100,   :align => 'center', :editable => true, hidden:true},
        { :name => 'SlottingruleMaster[attribute4]',  :index => 'attribute4',   :width => 100,   :align => 'center', :editable => true, hidden:true},
        { :name => 'SlottingruleMaster[attribute5]',  :index => 'attribute5',   :width => 100,   :align => 'center', :editable => true, hidden:true},
        { :name => 'SlottingruleMaster[attribute6]',  :index => 'attribute6',   :width => 100,   :align => 'center', :editable => true,hidden:true},
       
     ],
      :editurl => '/slottingrule_mastermaintenance',
      :pager => '#slottingrule_master_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'asc',
      :multiselect => true,
      :autowidth => true,
      :viewrecords => true,
      :caption => 'Slottingrule Master Maintenance',
      :reloadAfterEdit => true,
      :onSelectRow => selectrowfunc.to_json_var }]
      
    pager = [:navGrid, "#slottingrule_master_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, 
                                                       :closeOnEscape => true}, 
                                                       {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var}, {}, {}, {}]                                                              

   
    
    jqgrid_api 'slottingrule_master_list', grid, pager , options

  end
end
