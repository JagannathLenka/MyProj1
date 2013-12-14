module UsermaintenanceHelper
include JqgridsHelper

  def user_jqgrid
    
    options = {:on_document_ready => true, :html_tags => false}
    url = "/usermaintenance" 
    
    grid = [{
      :url => url ,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 'auto',
      :width => 'auto',
      
    
      :colNames => ['Id','Client Id','UserId','Name','Password','Email Id','Phone(work)','Phone(mobile)','Status','Last Login','Attribute1','Attribute2','Attribute3','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',      :index => 'id',    :width => 55, :hidden => true},
        { :name => 'client_id',  :index => 'client_id',  :width => 80, :align => 'center', :editable => true,editrules:{required:true}},
        { :name => 'user_id',    :index => 'user_id',     :width => 80,  :align => 'center', :editable => true,editrules:{required:true} },
        { :name => 'user_name',  :index => 'user_name',  :width => 120,  :align => 'center', :editable => true ,editrules:{required:true}},
        { :name => 'password', :index => 'password', :width => 80,  :align => 'center', :editable => true,:hidden =>true,:edittype => "password", editrules:{required:true,edithidden:true} },
        { :name => 'email_id',:index => 'email_id',     :width => 100,  :align => 'center', :editable => true,editrules:{required:true,email:true}},
        {:name => 'contact_phone', :index => 'contact_phone',  :width => 80, :align => 'center', :editable => true,editrules:{required:true,number:true}},
        {:name => 'contact_phone2', :index => 'contact_phone2',  :width => 80, :align => 'center', :editable => true,editrules:{required:true,number:true}},
        { :name => 'status', :index => 'status', :width => 60 ,  :align => 'center', :editable => true,editrules:{required:true}},
        { :name => 'last_login', :index => 'last_login', :width => 120,  :align => 'left', :editable => false ,editrules:{required:true}},
        { :name => 'attribute1',   :index => 'attribute1',   :width => 60,   :align => 'center', :editable => true},
        { :name => 'attribute2',   :index => 'attribute2',   :width => 60,   :align => 'center', :editable => true,},
        { :name => 'attribute3',   :index => 'attribute3',   :width => 60,   :align => 'center', :editable => true},
        { :name => 'attribute4',   :index => 'attribute4',   :width => 60,   :align => 'center', :editable => true},
        { :name => 'attribute5',   :index => 'attribute5',   :width => 60,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute6',   :index => 'attribute6',   :width => 60,   :align => 'center', :editable => true, :hidden => true},
        { :name => 'attribute7',   :index => 'attribute7',   :width => 60,   :align => 'center', :editable => true,:hidden => true},
        { :name => 'attribute8',   :index => 'attribute8',   :width => 60 ,   :align => 'center', :editable => true, :hidden => true}
        
      ],
      :editurl => '/usermaintenance',
      :pager => '#user_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'client_id',
      :sortorder => 'asc',
      :shrinkToFit => true,
      :autowidth => true,
      :viewrecords => true,
      :caption => 'User Maintenance',
      :closeAfterEdit => true,
      :reloadAfterEdit => true,
      :onSelectRow => "function(id) { 
                       if(id && id!==lastsel){
      jQuery('#user_list').jqGrid('restoreRow',lastsel);
      jQuery('#user_list').jqGrid('editRow',id,{keys: true, aftersavefunc: function(){lastsel=0;}});
      lastsel=id;
    } 
      }".to_json_var
    }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)
    #pager = [:navGrid, "#aisle_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]
        pager = [:navGrid, "#user_pager", {edit:true, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:closeAfterAdd=>true}, {}, {}, {}]   
    #pager2 = [:inlineNav, "#bays_pager"]


    
    pager_button = [:navButtonAdd, "#user_pager", {:caption => 'Add', :onClickButton => 'function() {alert("Custom button!")}'.to_json_var }]

    jqgrid_api 'user_list', grid, pager, options

  end

end
