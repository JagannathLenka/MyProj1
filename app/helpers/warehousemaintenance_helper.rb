module WarehousemaintenanceHelper
  include JqgridsHelper

  def warehouse_jqgrid

    options = {:on_document_ready => true, :html_tags => false}

    grid = [{
      :url => '/warehousemaintenance/',
      :datatype => 'json',
      :mtype => 'GET',
      :colNames => ['Id','Warehouse', 'Warehouse id(Cust)','Client Id','Description', 'No of Zones','Noof zones_hidden', 'atrribute1','atrribute2','atrribute3','atrribute4','atrribute5','atrribute6','atrribute7','atrribute8'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55, hidden:true},
        { :name => 'sm_warehouse_id',   :index => 'sm_warehouse_id',:width => 100,:editable => false, formatter:'showlink', formatoptions:{baseLinkUrl:'/zonemaintenance'}},
        { :name => 'cl_warehouse_id',   :index => 'cl_warehouse_id',    :width => 150, :align => 'center', :editable => true},
        { :name => 'client_id',   :index => 'client_id',    :width => 100, :align => 'center', :editable => true},
        { :name => 'description',  :index => 'description',  :width => 150, :align => 'center', :editable => true},
        { :name => 'no_of_zones' ,   :index => 'no_of_zones',     :width => 150,  :align => 'left', :editable => true },
        { :name => 'no_of_zones_hidden' ,   :index => 'no_of_zones_hidden',     :width => 60,  :align => 'left',hidden:true, :editable => true },
        { :name => 'atrribute1',  :index => 'atrribute1',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'atrribute2',  :index => 'atrribute2',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'atrribute3',  :index => 'atrribute3',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'atrribute4',  :index => 'atrribute4',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'atrribute5',  :index => 'atrribute5',   :width => 150,   :align => 'center', :editable => true,hidden:true},
        { :name => 'atrribute6',  :index => 'atrribute6',   :width => 150,   :align => 'center', :editable => true,hidden:true},
        { :name => 'atrribute7',  :index => 'atrribute7',   :width => 150,   :align => 'center', :editable => true,hidden:true},
        { :name => 'atrribute8',  :index => 'atrribute8',   :width => 150,   :align => 'center', :editable => true,hidden:true},
        
     ],
      :editurl => '/warehousemaintenance',
      :pager => '#warehouse_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'Warehouse Maintenance',
      :onSelectRow => "function() {}".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    pager = [:navGrid, "#warehouse_pager", {edit:false,add:false,del:false}]
    pager2 = [:inlineNav, "#warehouse_pager"]
    pager_button = [:navButtonAdd, "#warehouse_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'warehouse_list', grid, pager,  options

  end

end
