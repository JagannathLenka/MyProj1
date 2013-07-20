module LevelmaintenanceHelper
   include JqgridsHelper

  def level_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    url = "/levelmaintenance?id=" + params["id"]
    grid = [{
      :url => url ,
      :datatype => 'json',
      :mtype => 'GET',
      ['id','sm_level_id','cl_level_id','client_id','description', 'sm_bay_id','cl_bay_id','bay_id','no_of_level_bay', 'sm_aisle_id','cl_aisle_id','sm_zone_id','cl_zone_id','zone_id','sm_warehouse_id','cl_warehouse_id','attribute1', 'attribute2', 'attribute3', 'attribute4','attribute5','attribute6', 'attribute7','attribute8']
      :colNames => ['Id','Sequence', 'Level d(cust)','Level id(cust)','Properties1','Properties2','Properties3'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55, formatter:'showlink', formatoptions:{baseLinkUrl:'/levelmaintenance'}},
        { :name => 'level_id',    :index => 'level_id',     :width => 55,  :align => 'center', :editable => false },
        { :name => 'zone_id',    :index => 'zone_id',     :width => 55,  :align => 'center', :editable => true },
        { :name => 'level_customerid', :index => 'level_customerid',  :width => 120, :align => 'left', :editable => true},
        { :name => 'properties1',  :index => 'properties1',   :width => 120,   :align => 'left', :editable => true},
        { :name => 'properties2',   :index => 'properties2',    :width => 120,   :align => 'center', :editable => true},
        { :name => 'properties3',   :index => 'properties3',    :width => 120,   :align => 'center', :editable => true },
        
      ],
      :editurl => '/levelmaintenance',
      :pager => '#level_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'level_id',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'Level Maintenance',
      :onSelectRow => "function() {}".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    pager = [:navGrid, "#level_pager", {edit:false,add:false,del:false}]
    pager2 = [:inlineNav, "#level_pager"]

    
    pager_button = [:navButtonAdd, "#level_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'level_list', grid, pager, pager2, pager_button, options

  end

  
end
