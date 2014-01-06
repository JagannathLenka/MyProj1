module ItemmastermaintenanceHelper
  include JqgridsHelper

  def item_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
      id  = params["id"]
      url = "/itemmastermaintenance" 
      height = 350 
      width = 'auto'
    
    
    addcheckfunc = 'function(postdata, formid) {return[true, " "]}'
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#item_list').jqGrid('restoreRow',lastsel);
                           jQuery('#item_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#item_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});}, 
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"   
                      
     slottfunc  = 'function() {
                                var ids = $("#item_list").jqGrid("getGridParam","selarrrow");
                                
                                 $.post("/slottingrecomaintenance",
                                       {
                                         "oper" :"slott",
                                         "id"   :ids
                                       },
                                       function(data,status)
                                       {
                               
                                       });
                                 $("#itemmastermaintenance").trigger("reloadGrid");       
                   }'
                                       

    grid = [{
      :url => url,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> height,
      :width => width,
      :colNames => ['Id', 'Item No','Velocity','Daily avg Sale','Weekly avg Sale','Monthly avg Sale','Daily Forecast','Case Quantity','Case Split','PutAway Type'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55,:hidden => true },
        { :name => 'item_number', :index => 'item_number',  :width => 80, :align => 'center', :editable => true},
        { :name => 'velocity', :index => 'velocity',  :width => 80, :align => 'center', :editable => true},
        { :name => 'daily_avg_sales', :index => 'daily_avg_sales',  :width => 80, :align => 'center', :editable => true},
        { :name => 'weekly_avg_sales', :index => 'weekly_avg_sales',  :width => 80, :align => 'center', :editable => true},
        { :name => 'monthly_avg_sales', :index => 'monthly_avg_sales',  :width => 80, :align => 'center', :editable => true},
        { :name => 'daily_forecast', :index => 'daily_forecast',  :width => 80, :align => 'center', :editable => true},
        { :name => 'case_quantity', :index => 'case_quantity',  :width => 80, :align => 'center', :editable => true},
        { :name => 'case_split_allowed', :index => 'case_split_allowed',  :width => 80, :align => 'center', :editable => true,edittype:"select", editoptions: {value: "Yes:Yes;No:No" }},
        { :name => 'attribute1', :index => 'attribute1',  :width => 80, :align => 'center', :editable => true}
       
      ],
      :editurl => '/itemmastermaintenance',
      :pager => '#item_pager',
      :rowNum => 50,
      :rowList => [50, 100, 150],
      :sortname => 'id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Item Master Maintenance',
      :reloadAfterEdit => true,
      :autowidth => true,
      :multiselect => true,
      :onSelectRow => selectrowfunc.to_json_var }]


    pager = [:navGrid, "#item_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var, :beforeSubmit => addcheckfunc.to_json_var}, {}, {}, {}]   
    
    
     pager_button = [:navButtonAdd, "#item_pager", 
                   {:caption => 'Show Errors', :onClickButton => 'function() {
                                          win = window.open("/itemerror", "_blank");
                                          win.focus();
                                          }'.to_json_var }]

    jqgrid_api 'item_list', grid, pager , pager_button, options

  end

end
