module SlottingWavemaintenanceHelper
  
  include JqgridsHelper

  def slotting_wave_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
     
    aftersubfunc   = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
   # addcheckfunc   = 'function(postdata, formid) {postdata.pt_rule_id=' + params["rule_id"] + '; return[true, " "]}' 
                              
                    
    selectrowfunc  = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#slotting_wave_list').jqGrid('restoreRow',lastsel);
                           jQuery('#slotting_wave_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#slotting_wave_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"       
      
    grid = [{
      :url => '/slotting_wavemaintenance?rule_id=' + params[:rule_id].to_s + '&wave_status=' + params[:wave_status].to_s ,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      :width => 'auto',
      
       :colNames => ['Id', 'Wave No','Preffered Warehouse', 'Preffered  Zone' ,
                     'Preffered Aisle','Preffered Bay','Preffered Level','Preffered Position','Preffered Slottingrules', 'Wave status'],
       :colModel  => [
        { :name => 'SlottingWave[id]',   :index => 'id',    :width => 55,:hidden => true },
        { :name => 'SlottingWave[wave_number]', :index => 'wave_number',  :width => 80, :align => 'center', :editable => true, :hidden => false},
        { :name => 'SlottingWave[preffered_warehouse]', :index => 'preffered_warehouse',  :width => 80, :align => 'center', :editable => true},
        { :name => 'SlottingWave[preffered_zone]', :index => 'preffered_zone',  :width => 80, :align => 'center', :editable => true, :hidden => false},        
        { :name => 'SlottingWave[preffered_aisle]', :index => 'preffered_aisle',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'SlottingWave[preffered_bay]', :index => 'preffered_bay',     :width => 80,  :align => 'center', :editable => true },
        { :name => 'SlottingWave[preffered_level]', :index => 'preffered_level',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'SlottingWave[preffered_position]',:index => 'preffered_position',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'SlottingWave[preffered_slotting_rules]',:index => 'preffered_slotting_rules',     :width => 80,  :align => 'center', :editable => true,editrules:{required:true}},
        { :name => 'SlottingWave[wave_status]',:index => 'wave_status', :width => 80,  :align => 'center', :editable => true, edittype:"select", editoptions: {value: "Open:Open;Close:Close;Selected:Selected;Submited:Submited" }}
      ],
      :editurl => '/slotting_wavemaintenance',
      :pager => '#slotting_wave_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'desc',
      :multiselect => true,
      :autowidth => true,
      :viewrecords => true,
      :caption => 'Slottingrule Wave Maintenance',
      :reloadAfterEdit => true,
      :onSelectRow => selectrowfunc.to_json_var }]
      
    pager = [:navGrid, "#slotting_wave_pager", {edit:false, add: params[:view] == 'yes' ? false : true,
                                                            del: params[:view] == 'yes' ? false : true}, {:closeAfterEdit => true, 
                                                       :closeOnEscape => true}, 
                                                       {:closeAfterAdd=>true}, {}, {}, {}]                                                              

                                                       #{:closeAfterAdd=>true, :beforeSubmit => addcheckfunc.to_json_var}, {}, {}, {}]                                                              

   
    jqgrid_api 'slotting_wave_list', grid, pager , options

  end
end
