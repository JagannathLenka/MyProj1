module PosmaintenanceHelper
  include JqgridsHelper

  def pos_jqgrid
    
    options = {:on_document_ready => true, :html_tags => false}
    url = "/posmaintenance?id=" + params["id"]
    grid = [{
      :url => url ,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      
      :colNames => ['Id','Sequence', 'Position','sm_level_id','Level','sm_bay_id', 'Bay',
        'Client Id','Description','sm_aisle_id','Aisle','level_id','sm_zone_id','Zone', 
        'sm_warehouse_id','Warehouse','sm_barcode', 'Barcode',
        'Attribute1','Attribute2','Attribute3','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',      :index => 'id',    :width => 55, :hidden => true},
        { :name => 'sm_pos_id',  :index => 'sm_pos_id',  :width => 120, :align => 'center', :editable => false,formatter:'showlink', formatoptions:{baseLinkUrl:'/posmaintenance'}},
        {:name => 'cl_pos_id', :index => 'cl_pos_id',  :width => 120, :align => 'left', :editable => true, editrules:{required:true}},
        { :name => 'sm_level_id',  :index => 'sm_bay_id',  :width => 120, :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_level_id',  :index => 'cl_level_id',  :width => 120, :align => 'center', :editable => false },
        { :name => 'sm_bay_id',  :index => 'sm_bay_id',  :width => 120, :align => 'center', :editable => false },
        {:name => 'cl_bay_id', :index => 'cl_bay_id',  :width => 120, :align => 'left', :editable => false, :hidden => true},
        { :name => 'client_id',:index => 'client_id',     :width => 55,  :align => 'center', :editable => false },
        { :name => 'description', :index => 'description', :width => 120,  :align => 'left', :editable => true },
        { :name => 'sm_aisle_id', :index => 'sm_aisle_id', :width => 150,  :align => 'left', :editable => false,:hidden => true },
        { :name => 'cl_aisle_id', :index => 'cl_aisle_id', :width => 80,  :align => 'left', :editable => false},
        { :name => 'level_id',    :index => 'aisle_id',     :width => 150,  :align => 'left', :editable => false,:hidden => true },
        { :name => 'sm_zone_id',  :index => 'sm_zone_id',     :width => 150,  :align => 'left', :editable => false,:hidden => true },
        { :name => 'cl_zone_id',  :index => 'cl_zone_id',     :width => 80,  :align => 'left', :editable => false},
        { :name => 'sm_warehouse_id',:index => 'sm_warehouse_id',   :width => 80,   :align => 'center', :editable => false,:hidden => true },
        { :name => 'cl_warehouse_id', :index => 'cl_warehouse_id',   :width => 80,   :align => 'center', :editable => false},
        { :name => 'sm_barcode', :index => 'sm_barcode',   :width => 80,   :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_barcode',   :index => 'cl_barcode',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute1',   :index => 'attribute1',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute2',   :index => 'attribute2',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute3',   :index => 'attribute3',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute4',   :index => 'attribute4',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute5',   :index => 'attribute5',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute6',   :index => 'attribute6',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute7',   :index => 'attribute7',   :width => 80,   :align => 'center', :editable => true,:hidden => true},
        { :name => 'attribute8',   :index => 'attribute8',   :width => 80,   :align => 'center', :editable => true, :hidden => true}
        
      ],
      :editurl => '/posmaintenance',
      :pager => '#pos_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'sm_pos_id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Position Maintenance',
      :closeAfterEdit => true,
      :reloadAfterEdit => true,
      :onSelectRow => "function() {}".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
        pager = [:navGrid, "#pos_pager", {:del => true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:beforeSubmit =>
                                                        "function(postdata, formid) 
                                                                  {
                                                                   postdata.warehouse_id='1';
                                                                   postdata.sm_warehouse_id='1';   
                                                                   return [true, ' ']}".to_json_var 
                                                                   }, {}, {}, {}]                                                                                             

    #pager2 = [:inlineNav, "#bays_pager"]

    
    pager_button = [:navButtonAdd, "#pos_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'pos_list', grid, pager, options

  end

  
end
