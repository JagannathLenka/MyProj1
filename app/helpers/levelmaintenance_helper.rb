module LevelmaintenanceHelper
   include JqgridsHelper

  def level_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    url = "/levelmaintenance?id=" + params["id"]
    grid = [{
      :url => url ,
      :datatype => 'json',
      :mtype => 'GET',
      :colNames => ['Id','Sequence','Level id(cust)','Clent Id','Description','sm_bay_id','Bay','bay_id','Position/Level','no_of_pos_level_hidden','sm_aisle_id','Aisle','sm_zone_id','Zone','sm_warehouse_id','Warehouse','Attribute1','Attribute2','Attribute3','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55, :hidden => true},
        { :name => 'sm_level_id',    :index => 'sm_level_id',     :width => 55,  :align => 'center', :editable => false, formatter:'showlink', formatoptions:{baseLinkUrl:'/levelmaintenance'} },
        { :name => 'cl_level_id',    :index => 'cl_level_id',     :width => 55,  :align => 'center', :editable => true,editrules:{required:true} },
        { :name => 'client_id', :index => 'client_id',  :width => 60, :align => 'left', :editable => false},
        { :name => 'description',  :index => 'description',   :width => 120,   :align => 'left', :editable => true},
        { :name => 'sm_bay_id',   :index => 'sm_bay_id',    :width => 120,   :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_bay_id',   :index => 'cl_bay_id',    :width => 60,   :align => 'center', :editable => false },
        { :name => 'bay_id',   :index => 'bay_id',    :width => 120,   :align => 'center', :editable => false, :hidden => true},
        { :name => 'no_of_pos_level',   :index => 'no_of_pos_level',    :width => 60,   :align => 'center', :editable => true,editrules:{required:true,number:true}},
        { :name => 'no_of_pos_level_hidden',   :index => 'no_of_pos_level',    :width => 60,   :align => 'center', :hidden => true},
        { :name => 'sm_aisle_id',   :index => 'sm_aisle_id',    :width => 60,   :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_aisle_id',   :index => 'cl_aisle_id',    :width => 60,   :align => 'center', :editable => false, :hidden => false},
        { :name => 'sm_zone_id',   :index => 'sm_zone_id',    :width => 60,   :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_zone_id',   :index => 'cl_zone_id',    :width => 60,   :align => 'center', :editable => false, :hidden => false},
        { :name => 'sm_warehouse_id',   :index => 'sm_warehouse_id',    :width => 60,   :align => 'center', :editable => false, :hidden => true},
        { :name => 'cl_warehouse_id',   :index => 'cl_warehouse_id',    :width => 60,   :align => 'center', :editable => false, :hidden => false},
        { :name => 'attribute1',   :index => 'attribute1',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute2',   :index => 'attribute2',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute3',   :index => 'attribute3',   :width => 80,   :align => 'center', :editable => true },
        { :name => 'attribute4',   :index => 'attribute4',   :width => 80,   :align => 'center', :editable => true },
        { :name => 'attribute5',   :index => 'attribute5',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute6',   :index => 'attribute6',   :width => 80,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute7',   :index => 'attribute7',   :width => 80,   :align => 'center', :editable => true,:hidden => true},
        { :name => 'attribute8',   :index => 'attribute8',   :width => 80,   :align => 'center', :editable => true, :hidden => true}
       
      ],
      :editurl => '/levelmaintenance',
      :pager => '#level_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'sm_level_id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Level Maintenance',
      :onSelectRow => "function() {}".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
    #pager = [:navGrid, "#level_pager", {edit:true,add:true,del:true}]
    pager = [:navGrid, "#level_pager", {:del => true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:beforeSubmit =>
                                                        "function(postdata, formid) 
                                                                  {
                                                                   postdata.pt_warehouse='1';
                                                                   postdata.pt_sm_warehouse_id='1';   
                                                                   return [true, ' ']}".to_json_var 
                                                                   }, {}, {}, {}]                                                                   

    #pager2 = [:inlineNav, "#level_pager"]

    
    pager_button = [:navButtonAdd, "#level_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'level_list', grid, pager,  options

  end

  
end