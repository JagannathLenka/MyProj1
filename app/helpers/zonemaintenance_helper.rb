module ZonemaintenanceHelper
  include JqgridsHelper

  def zone_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    url = "/zonemaintenance?id=" +  params["id"]
 
    grid = [{
      :url => url ,
      :datatype => 'json',
      :mtype => 'GET',
      :colNames => ['Id','Zone Id','Zone Id(Cust)','Description', 'Aisles/Zone', 'noofaisles_zone_hidden', 'Bays/Aisle','Level/Aisle','Warehouse', 'Properties1', 'Properties2', 'Properties3'], 
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 50, :align => 'center',hidden:true},
        { :name => 'zone_id',   :index => 'zone_id',    :width => 85, :align => 'center',:editable => true,formatter:'showlink', formatoptions:{baseLinkUrl:'/aislemaintenance'}, :editable => false},
        { :name => 'zone_customerid',   :index => 'zone_customerid',    :width => 125, :align => 'center', :editable => true},
        { :name => 'description',   :index => 'description',    :width => 150, :align => 'center', :editable => true},
        { :name => 'noofaisles_zone',    :index => 'noofaisles_zone',     :width => 100,  :align => 'center', :editable => true },
        { :name => 'noofaisles_zone_hidden',    :index => 'noofaisles_zone_hidden',     :width => 100,  :align => 'center', hidden:true, :editable => true },
        { :name => 'noofbays_aisle',    :index => 'noofbays_aisle',     :width => 100,  :align => 'center', :editable => true },
        { :name => 'nooflevel_aisle',    :index => 'nooflevel_aisle',     :width => 100,  :align => 'center', :editable => true, formatter:'showlink', formatoptions:{baseLinkUrl:'/levelmaintenance'} },
        { :name => 'warehouse_id', :index => 'warehouse_id',  :width => 150, :align => 'center', :editable => true},
        { :name => 'properties1',  :index => 'properties1',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'properties2',     :index => 'properties2',      :width => 150,   :align => 'left', :editable => true},
        { :name => 'properties3',   :index => 'properties3',    :width => 150,   :align => 'left', :editable => true },
        
        
      ],
      :editurl => '/zonemaintenance',
      :pager => '#zone_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'zone_id',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'Zone Maintenance',
      :onSelectRow => "function() { }".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    pager = [:navGrid, "#zone_pager", {edit:false,add:false,del:false}]
    pager2 = [:inlineNav, "#zone_pager"]

    
    pager_button = [:navButtonAdd, "#zone_pager", 
                    {:caption => 'Show Layout', :onClickButton => 'function() {
                                          var grid = $("#zone_list");
                                          selectedRowId= grid.jqGrid ("getGridParam","selrow");
                                          win = window.open("/bay?id=" + selectedRowId, "_blank");
                                          win.focus();
                                          }'.to_json_var }]

    jqgrid_api 'zone_list', grid, pager, pager2, pager_button, options

  end

  
end
