module AislemaintenanceHelper
    
    include JqgridsHelper

  def aisle_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    url = "/aislemaintenance?id=" +  params["id"]
    
    grid = [{
      :url => url,
      :datatype => 'json',
      :mtype => 'GET',
      :colNames => ['id', 'Aisle id(cust)', 'Zone id','No of Bays','Properties1','Properties2','Properties3'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55, formatter:'showlink', formatoptions:{baseLinkUrl:'/baysmaintenance'}},
        { :name => 'customer_aisle_id', :index => 'customer_aisle_id',  :width => 190, :align => 'center', :editable => true},
        { :name => 'zone_id',    :index => 'zone_id',     :width => 150,  :align => 'center', :editable => true },
        { :name => 'noof_bays',    :index => 'noof_bays',     :width => 150,  :align => 'left', :editable => true },
        { :name => 'properties1',  :index => 'properties1',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'properties2',     :index => 'properties2',      :width => 80,   :align => 'center', :editable => true},
        { :name => 'properties3',   :index => 'properties3',    :width => 80,   :align => 'center', :editable => true }
        
      ],
      :editurl => '/aislemaintenance',
      :pager => '#aisle_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'aisle_id',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'My first grid',
      :onSelectRow => "function() {}".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    pager = [:navGrid, "#aisle_pager", {edit:false,add:false,del:false}]
    pager2 = [:inlineNav, "#aisle_pager"]

    
    pager_button = [:navButtonAdd, "#aisle_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'aisle_list', grid, pager, pager2, pager_button, options

  end

  
end
