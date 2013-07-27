module WarehousemaintenanceHelper
  include JqgridsHelper

  def warehouse_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
     editcheckfunc = 'function(postdata, formid) {if (postdata.no_of_zones < postdata.no_of_zones_hidden) {return[false, "Can not delete Zones from this screen, Please use Zone Maintenance"];} return[true, " "]}' 
    grid = [{
      :url => '/warehousemaintenance/',
      :datatype => 'json',
      :mtype => 'GET',
      
      :colNames => ['Id','Sequence', 'Warehouse','Client Id','Description', 'No of Zones','Noof zones_hidden', 'City','State','Country','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',   :index => 'id',  :width => 55, hidden:true},
        { :name => 'sm_warehouse_id',   :index => 'sm_warehouse_id',:width => 100,:align => 'center',:editable => false, formatter:'showlink', formatoptions:{baseLinkUrl:'/zonemaintenance'}},
        { :name => 'cl_warehouse_id',   :index => 'cl_warehouse_id',    :width => 150, :align => 'center', :editable => true, editrules:{required:true}},
        { :name => 'client_id',   :index => 'client_id',    :width => 100, :align => 'center', :editable => false, hidden:false},
        { :name => 'description',  :index => 'description',  :width => 150, :align => 'center', :editable => true},
        { :name => 'no_of_zones' ,   :index => 'no_of_zones',     :width => 150,  :align => 'left', :editable => true, editrules:{required:true,number:true} },
        { :name => 'no_of_zones_hidden' ,   :index => 'no_of_zones_hidden',     :width => 60,  :align => 'left',hidden:true, :editable => true },
        { :name => 'attribute1',  :index => 'attribute1',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'attribute2',  :index => 'attribute2',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'attribute3',  :index => 'attribute3',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'attribute4',  :index => 'attribute4',   :width => 150,   :align => 'center', :editable => true},
        { :name => 'attribute5',  :index => 'attribute5',   :width => 150,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute6',  :index => 'attribute6',   :width => 150,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute7',  :index => 'attribute7',   :width => 150,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute8',  :index => 'attribute8',   :width => 150,   :align => 'center', :editable => true,hidden:true},
        
     ],
      :editurl => '/warehousemaintenance',
      :pager => '#warehouse_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Warehouse Maintenance',
      :reloadAfterEdit => true,
      :onSelectRow => "function() {}".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    #pager = [:navGrid, "#warehouse_pager", {edit:true,add:true,del:true}]
    pager = [:navGrid, "#warehouse_pager", {:del => true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true, :beforeSubmit => editcheckfunc.to_json_var }, 
                                                       {:beforeSubmit =>
                                                        "function(postdata, formid) 
                                                                  {
                                                                   postdata.pt_warehouse='1';
                                                                   postdata.pt_sm_warehouse_id='1';   
                                                                   return [true, ' ']}".to_json_var 
                                                                   }, {}, {}, {}]                                                                   
    pager2 = [:inlineNav, "#warehouse_pager"]
    pager_button = [:navButtonAdd, "#warehouse_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'warehouse_list', grid, pager,  options

  end

end
