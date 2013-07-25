module AislemaintenanceHelper
    
    include JqgridsHelper

  def aisle_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    url = "/aislemaintenance?id=" +  params["id"]
        grid = [{
      :url => url,
      :datatype => 'json',
      :mtype => 'GET',
      :colNames => ['Id','Sequence', 'Aisle','Client Id','sm_zone_id', 'Zone','zone_id','sm_warehouse_id','Warehouse','Description','Bays/Aisle','no_of_bays_aisle_hidden','Levels/Aisle','no_of_levels_aisles_hidden','Attribute1','Attribute2','Types of Aisle','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55,:hidden => true },
        { :name => 'sm_aisle_id', :index => 'sm_aisle_id',  :width => 80, :align => 'center',formatter:'showlink', formatoptions:{baseLinkUrl:'/baysmaintenance'}, :editable => false},
        { :name => 'cl_aisle_id', :index => 'cl_aisle_id',  :width => 90, :align => 'center', :editable => true, editrules:{required:true}},
        { :name => 'client_id', :index => 'client_id',  :width => 60, :align => 'center', :editable => false, :hidden => false},
        { :name => 'sm_zone_id', :index => 'sm_zone_id',  :width => 80, :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_zone_id', :index => 'cl_zone_id',  :width => 60, :align => 'center', :editable => false},
        { :name => 'zone_id',    :index => 'zone_id',     :width => 80,  :align => 'center', :editable => false, :hidden =>true},
        { :name => 'sm_warehouse_id', :index => 'sm_warehouse_id',  :width => 80, :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_warehouse_id', :index => 'cl_warehouse_id',  :width => 80, :align => 'center', :editable => false, :hidden => false},
        { :name => 'description',   :index => 'description',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'no_of_bays_aisle',:index => 'no_of_bays_aisle',     :width => 80,  :align => 'left', :editable => true , editrules:{required:true,number:true}},
        { :name => 'no_of_bays_aisle_hidden',:index => 'no_of_bays_aisle_hidden',     :width => 80,  :align => 'left', :editable => true, :hidden => true },
        { :name => 'no_of_levels_aisles',:index => 'no_of_levels_aisles',     :width => 80,  :align => 'left', :editable => true , editrules:{required:true,number:true}},
        { :name => 'no_of_levels_aisles_hidden',:index => 'no_of_levels_aisles_hidden',     :width => 80,  :align => 'left', :editable => true, :hidden => true },
        { :name => 'attribute1',   :index => 'attribute1',   :width => 90,   :align => 'center', :editable => true},
        { :name => 'attribute2',   :index => 'attribute2',   :width => 60,   :align => 'center', :editable => true},
        { :name => 'attribute3',   :index => 'attribute3',   :width => 60,   :align => 'center', :editable => true ,edittype:"select", editoptions: {value: "L:Single Side Aisle- Left;R:Single Side Aisle- Right;LR:Double Side Aisle" }},
        { :name => 'attribute4',   :index => 'attribute4',   :width => 60,   :align => 'center', :editable => true},
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
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'Aisle Maintenance',
      :reloadAfterEdit => true,
      :onSelectRow => "function() { }".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    #pager = [:navGrid, "#aisle_pager", {edit:true,add:true,del:true}]
    pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:beforeSubmit =>
                                                        "function(postdata, formid) 
                                                                  {
                                                                   postdata.pt_warehouse='1';
                                                                   postdata.pt_sm_warehouse_id='1';   
                                                                   return [true, ' ']}".to_json_var 
                                                                   }, {}, {}, {}]                                                                   

    #pager2 = [:inlineNav, "#aisle_pager"]

    
    pager_button = [:navButtonAdd, "#aisle_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]
    

    jqgrid_api 'aisle_list', grid, pager,  options

  end

  
end
