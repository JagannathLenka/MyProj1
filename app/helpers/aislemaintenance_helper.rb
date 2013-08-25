module AislemaintenanceHelper
    
  include JqgridsHelper

  def aisle_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    
    
    if params[:lightweight] == "yes"
      lightweight = "yes"   
      aisles = Aisle.find_by_id(params["aisleid"].to_i)
      id =  aisles.zone_id.to_s
      height = 80
      width = 900
      url = "/aislemaintenance?id=" +  id + "&aisleid=" + params["aisleid"]
    else
      lightweight = "no"
      id  = params["id"]
      url = "/aislemaintenance?id=" +  id
      height = 300 
      width = 1100   
   end 
    editcheckfunc = 'function(postdata, formid) 
              {
                if (parseInt(postdata.no_of_bays_aisle) < parseInt(postdata.no_of_bays_aisle_hidden))
                   {
                     return[false, "Can not delete bay from this screen, Please use Bays Maintenance"];
                   } 

                if (parseInt(postdata.no_of_levels_aisle) <parseInt(postdata.no_of_levels_aisle_hidden))
                   {
                     return[false, "Can not delete Levels from this screen, Please use Level Maintenance"];
                   } 
              return[true, " "]}'
    addcheckfunc = 'function(postdata, formid) {postdata.pt_zone_id=' + id + '; return[true, " "]}'
     
    showLayout   = 'function() {          
                                          win = window.open("/bay?id=' + id + '", "_blank");
                                          win.focus();
                               }'
                               
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    
    selectrowfunc = "function(id) { 
                      
                      if(id && id!==lastsel){
                           
                           jQuery('#aisle_list').jqGrid('restoreRow',lastsel);
                           
                           jQuery('#aisle_list').jqGrid('editRow',id,{keys: true, 
                           
                           aftersavefunc: function(){lastsel=0;jQuery('#aisle_list').trigger('reloadGrid');},
                           
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
      :height=> height,
      :width => width,
      
      :colNames => ['Id','Sequence', 'Aisle','Description','Client Id','sm_zone_id', 'Zone','zone_id','sm_warehouse_id',
        'Warehouse','Bays/Aisle','no_of_bays_aisle_hidden','Levels/Aisle','no_of_levels_aisle_hidden',
        'Types of Aisle','Attribute1','Attribute2','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55,:hidden => true },
        { :name => 'sm_aisle_id', :index => 'sm_aisle_id',  :width => 80, :align => 'center', :editable => true, :hidden =>true},
        { :name => 'cl_aisle_id', :index => 'cl_aisle_id',  :width => 80, :align => 'center', :editable => true, editrules:{required:true},formatter:'showlink', formatoptions:{baseLinkUrl:'/baysmaintenance' , addParam: '&lightweight='+ lightweight}},
        { :name => 'description',   :index => 'description',   :width => 120,   :align => 'left', :editable => true},
        { :name => 'client_id', :index => 'client_id',  :width => 60, :align => 'center', :editable => true, :hidden => true},
        { :name => 'sm_zone_id', :index => 'sm_zone_id',  :width => 80, :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_zone_id', :index => 'cl_zone_id',  :width => 80, :align => 'center', :editable => false},
        { :name => 'zone_id',    :index => 'zone_id',     :width => 80,  :align => 'center', :editable => false, :hidden =>true},
        { :name => 'sm_warehouse_id', :index => 'sm_warehouse_id',  :width => 80, :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_warehouse_id', :index => 'cl_warehouse_id',  :width => 80, :align => 'center', :editable => false, :hidden => false},        
        { :name => 'no_of_bays_aisle',:index => 'no_of_bays_aisle',     :width => 80,  :align => 'center', :editable => true , editrules:{required:true,number:true}},
        { :name => 'no_of_bays_aisle_hidden',:index => 'no_of_bays_aisle_hidden',     :width => 80,  :align => 'center', :editable => true, :hidden => true },
        { :name => 'no_of_levels_aisle',:index => 'no_of_levels_aisle',     :width => 80,  :align => 'center', :editable => true , editrules:{required:true,number:true}},
        { :name => 'no_of_levels_aisle_hidden',:index => 'no_of_levels_aisle_hidden',     :width => 80,  :align => 'left', :editable => true, :hidden => true },
        { :name => 'attribute3',   :index => 'attribute3',   :width => 80,   :align => 'center', :editable => true ,edittype:"select", editoptions: {value: "LR:LR-Double Side Pick Aisle;R:R-Right Side Pick Aisle- Right;L:L-Left Side Aisle- Left" }},
        { :name => 'attribute1',   :index => 'attribute1',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute2',   :index => 'attribute2',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute4',   :index => 'attribute4',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute5',   :index => 'attribute5',   :width => 60,   :align => 'center', :editable => true, :hidden => true },
        { :name => 'attribute6',   :index => 'attribute6',   :width => 60,   :align => 'center', :editable => true, :hidden => true },
        { :name => 'attribute7',   :index => 'attribute7',   :width => 60,   :align => 'center', :editable => true, :hidden => true },
        { :name => 'attribute8',   :index => 'attribute8',   :width => 60,   :align => 'center', :editable => true, :hidden => true }
        
      ],
      :editurl => '/aislemaintenance',
      :pager => '#aisle_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'sm_aisle_id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Aisle Maintenance',
      :reloadAfterEdit => true,
      :onSelectRow => selectrowfunc.to_json_var }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    #pager = [:navGrid, "#aisle_pager", {edit:true,add:true,del:true}]
    pager = [:navGrid, "#aisle_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true, :beforeSubmit => editcheckfunc.to_json_var}, 
                                                       {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var, :beforeSubmit => addcheckfunc.to_json_var}, {}, {}, {}]   
    #pager2 = [:inlineNav, "#aisle_pager"]

    
    pager_button = [:navButtonAdd, "#aisle_pager", 
                   {:caption => 'Show Layout', :onClickButton => showLayout.to_json_var }]


    jqgrid_api 'aisle_list', grid, pager, pager_button,  options

  end

  
end
