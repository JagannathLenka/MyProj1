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
                           aftersavefunc: function(){lastsel=0;
                                      $('#item_list').trigger('reloadGrid',[{row:40}]);                                                    },
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
      :colNames => ['Id', 'Item No','Description', 'Short Description', 'Velocity','Daily avg Sale','Weekly avg Sale','Monthly avg Sale',
                    'Item Category 1','Item Category 2', 'Item Category 3','Unit Length','Unit Breadth','Unit Height','Unit Volume','Unit Weight','Case Length','Case Breadth',
                    'Case Height','Case Volume','Case Weight','UOM','Daily Forecast','Case Quantity','Case Split','PutAway Type'],
      :colModel  => [
        { :name => 'itemmaster[id]',   :index => 'id',    :width => 55,:hidden => true },
        { :name => 'itemmaster[item_number]', :index => 'item_number',  :width => 80, :align => 'center', :editable => true, editrules:{required:true}},
        { :name => 'itemmaster[long_description]', :index => 'long_description',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[short_description]', :index => 'short_description',  :width => 80, :align => 'center', :editable => true, hidden:true},
        { :name => 'itemmaster[velocity]', :index => 'velocity',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[daily_avg_sales]', :index => 'daily_avg_sales',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[weekly_avg_sales]', :index => 'weekly_avg_sales',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[monthly_avg_sales]', :index => 'monthly_avg_sales',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[item_category1]', :index => 'item_category1',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[item_category2]', :index => 'item_category2',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[item_category3]', :index => 'item_category3',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[unit_length]', :index => 'unit_length',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[unit_breadth]', :index => 'unit_breadth',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[unit_height]', :index => 'unit_height',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[unit_volume]', :index => 'unit_volume',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[unit_weight]', :index => 'unit_weight',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[case_length]', :index => 'case_length',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[case_breadth]', :index => 'case_breadth',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[case_height]', :index => 'case_height',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[case_volume]', :index => 'case_volume',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[case_weight]', :index => 'case_weight',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[stocking_UOM]', :index => 'stocking_UOM',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[daily_forecast]', :index => 'daily_forecast',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[case_quantity]', :index => 'case_quantity',  :width => 80, :align => 'center', :editable => true},
        { :name => 'itemmaster[case_split_allowed]', :index => 'case_split_allowed',  :width => 80, :align => 'center', :editable => true,edittype:"select", editoptions: {value: "Yes:Yes;No:No" }},
        { :name => 'itemmaster[attribute1]', :index => 'attribute1',  :width => 80, :align => 'center', :editable => true}
       
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
      :ondblClickRow  => selectrowfunc.to_json_var }]


    pager = [:navGrid, "#item_pager", {edit:false, add:true, del: true, view: true}, 
                                      {:closeAfterEdit => true, :closeAfterAdd => true, :closeOnEscape => true}, 
                                      {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var, :beforeSubmit => addcheckfunc.to_json_var}, 
                                      {}, 
                                      {height:150,jqModal:true,closeOnEscape:true}, {}]   
    
    
     pager_button = [:navButtonAdd, "#item_pager", 
                    {:caption => 'Show Errors', :onClickButton => 'function() {
                                          win = window.open("/itemerror", "_blank");
                                          win.focus();
                                          }'.to_json_var },
                    ]
 
   pager_button2 = [:navButtonAdd, "#item_pager", 
                    {caption: "Columns",                    
                    title: "Reorder Columns",
                    onClickButton: "function (){
                                                jQuery('#item_list').jqGrid('columnChooser');}".to_json_var}
                    ]




    jqgrid_api 'item_list', grid, pager , pager_button, pager_button2, options
    

  end

end
