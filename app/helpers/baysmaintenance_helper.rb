module BaysmaintenanceHelper
    
    include JqgridsHelper

  def bays_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    url = "/baysmaintenance/ #{params[:id]}"
 

    grid = [{
      :url => url ,
      :datatype => 'json',
      :mtype => 'GET',
      :colNames => ['id', 'bay_id','customer_bay_id', 'properties1','properties2','properties3', 'aisle_id'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55, formatter:'showlink', formatoptions:{baseLinkUrl:'/baysmaintenance'}},
        { :name => 'bay_id',   :index => 'bay_id',    :width => 55, :align => 'right', :editable => true},
        { :name => 'customer_bay_id', :index => 'customer_bay_id',  :width => 190, :align => 'right', :editable => true},
        { :name => 'properties1',  :index => 'properties1',   :width => 80,   :align => 'right', :editable => true},
        { :name => 'properties2',     :index => 'properties2',      :width => 80,   :align => 'right', :editable => true},
        { :name => 'properties3',   :index => 'properties3',    :width => 80,   :align => 'right', :editable => true },
        { :name => 'aisle_id',    :index => 'aisle_id',     :width => 150,  :align => 'right', :editable => true }
      ],
      :editurl => '/baysmaintenance',
      :pager => '#bays_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'bay_id',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'Bay Maintenance',
      :onSelectRow => "function() { alert('Row selected!');}".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    pager = [:navGrid, "#bays_pager", {edit:false,add:false,del:false}]
    pager2 = [:inlineNav, "#bays_pager"]

    
    pager_button = [:navButtonAdd, "#bays_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'bays_list', grid, pager, pager2, pager_button, options

  end

  
end