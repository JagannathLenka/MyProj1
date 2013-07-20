module ZonemaintenanceHelper
  include JqgridsHelper

  def zone_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    url = "/zonemaintenance?id=" +  params["id"]
 
    grid = [{
      :url => url ,
      :datatype => 'json',
      :mtype => 'GET',
                   
      :colNames => ['Id','Sequence','Zone','Client Id','sm_warehouse_id','Warehouse','warehouse_id','Description', 'Aisles/Zone', 'no_of_aisles_zone_hidden',  'Bays/Aisle','Levels/Aisle', 'Attribute1', 'Attribute2', 'Attribute3','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'], 
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 50, :align => 'center',hidden:true},
        { :name => 'sm_zone_id',   :index => 'sm_zone_id',    :width => 100, :align => 'center',:editable => false,formatter:'showlink', formatoptions:{baseLinkUrl:'/aislemaintenance'}, :editable => false},
        { :name => 'cl_zone_id',   :index => 'cl_zone_id',    :width => 100, :align => 'center', :editable => true},
        { :name => 'client_id',   :index => 'client_id',    :width => 100, :align => 'center', :editable => false, hidden:false},
        { :name => 'sm_warehouse_id',   :index => 'sm_warehouse_id',    :width => 100, :align => 'center', :editable => false, hidden:true},
        { :name => 'cl_warehouse_id',   :index => 'cl_warehouse_id',    :width => 100, :align => 'center', :editable => false, hidden:false},
        { :name => 'warehouse_id',   :index => 'warehouse_id',    :width => 100, :align => 'center', :editable => false, hidden:true},      
        { :name => 'description',   :index => 'description',    :width => 150, :align => 'center', :editable => true},
        { :name => 'no_of_aisles_zone',    :index => 'no_of_aisles_zone',     :width => 150,  :align => 'center', :editable => true },
        { :name => 'no_of_aisles_zone_hidden',    :index => 'no_of_aisles_zone_hidden',     :width => 100,  :align => 'center', hidden:true, :editable => true },
        { :name => 'no_of_bays_aisle',    :index => 'no_of_bays_aisle',     :width => 150,  :align => 'center', :editable => true },
        { :name => 'no_of_levels_aisle',    :index => 'no_of_levels_aisle',     :width => 100,  :align => 'center', :editable => true, formatter:'showlink', formatoptions:{baseLinkUrl:'/levelmaintenance'} },
        { :name => 'attribute1',  :index => 'attribute1',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'attribute2',     :index => 'attribute2',      :width => 150,   :align => 'left', :editable => true},
        { :name => 'attribute3',   :index => 'attribute3',    :width => 150,   :align => 'left', :editable => true },
        { :name => 'attribute4',   :index => 'attribute4',    :width => 150,   :align => 'left', :editable => true },
        { :name => 'attribute5',   :index => 'attribute5',    :width => 150,   :align => 'left', :editable => true,  :hidden => true },
        { :name => 'attribute6',   :index => 'attribute6',    :width => 150,   :align => 'left', :editable => true,  :hidden => true },
        { :name => 'attribute7',   :index => 'attribute7',    :width => 150,   :align => 'left', :editable => true,  :hidden => true },
        { :name => 'attribute8',   :index => 'attribute8',    :width => 150,   :align => 'left', :editable => true,  :hidden => true },

        
        
      ],
      :editurl => '/zonemaintenance',
      :pager => '#zone_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'sm_zone_id',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'Zone Maintenance',
      :reloadAfterEdit => true,
      :onSelectRow => "function() { }".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    pager = [:navGrid, "#zone_pager", {:del => true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:beforeSubmit =>
                                                        "function(postdata, formid) 
                                                                  {
                                                                   postdata.warehouse_id='1';
                                                                   postdata.sm_warehouse_id='1';   
                                                                   return [true, ' ']}".to_json_var 
                                                                   }, {}, {}, {}]                                                                                             
                                                                                   
    #pager = [:navGrid, "#zone_pager", {edit:true,add:true,del:true}]
    pager2 = [:inlineNav, "#zone_pager"]

    
    pager_button = [:navButtonAdd, "#zone_pager", 
                   {:caption => 'Show Layout', :onClickButton => 'function() {
                                          var grid = $("#zone_list");
                                          selectedRowId= grid.jqGrid ("getGridParam","selrow");
                                          win = window.open("/bay?id=" + selectedRowId, "_blank");
                                          win.focus();
                                          }'.to_json_var }]

    jqgrid_api 'zone_list', grid, pager, pager_button, options

  end

  
end
