module WarehousemaintenanceHelper
  include JqgridsHelper

  def warehouse_jqgrid

    options = {:on_document_ready => true, :html_tags => false}

    grid = [{
      :url => '/warehousemaintenance/',
      :datatype => 'json',
      :mtype => 'GET',
      :colNames => ['id', 'warehouse_customerid','description', 'properties1','properties2','properties3','noof_zones'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55, formatter:'showlink', formatoptions:{baseLinkUrl:'/zonemaintenance'}},
        { :name => 'warehouse_customerid',   :index => 'warehouse_customerid',    :width => 55, :align => 'right', :editable => true},
        { :name => 'description',  :index => 'description',  :width => 190, :align => 'right', :editable => true},
        { :name => 'properties1',  :index => 'properties1',   :width => 80,   :align => 'right', :editable => true},
        { :name => 'properties2',   :index => 'properties2',      :width => 80,   :align => 'right', :editable => true},
        { :name => 'properties3',   :index => 'properties3',    :width => 80,   :align => 'right', :editable => true },
        { :name => 'noof_zones' ,   :index => 'noof_zones',     :width => 150,  :align => 'right', :editable => true }
      ],
      :editurl => '/warehousemaintenance',
      :pager => '#warehouse_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'warehouse_customerid',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'WarehouseMaintenance',
      :onSelectRow => "function() {}".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    pager = [:navGrid, "#warehouse_pager", {edit:false,add:false,del:false}]
    pager2 = [:inlineNav, "#warehouse_pager"]
    pager_button = [:navButtonAdd, "#warehouse_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'warehouse_list', grid, pager, pager2, options

  end

end
