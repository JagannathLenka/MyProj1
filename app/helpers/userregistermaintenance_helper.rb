module UserregistermaintenanceHelper
   include JqgridsHelper

  def userregister_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#userregister_list').jqGrid('restoreRow',lastsel);
                           jQuery('#userregister_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#userregister_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"       
       
    grid = [{
      :url => '/userregistermaintenance/',
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      :width => 1200,
      
      :colNames => ['Id','First Name','Last Name', 'EmailId','Client Id','Phone(mobile)', 'Phone(work)','Organization Name', 'Address1','Address2','Zipcode','State','Country','No.of Users','Attribute1','Attribute2','Attribute3','Attribute4','Attribute5','Attribute6','Attribute7','Attribute8'],
      :colModel  => [
        { :name => 'id',   :index => 'id',  :width => 55, hidden:true},
        { :name => 'name_of_person',   :index => 'name_of_person',:width => 100,:align => 'center',:editable => true},
        { :name => 'lastname_of_person', :index => 'lastname_of_person',:width => 100, :align => 'center', :editable => true},
        { :name => 'email_id',   :index => 'email_id',    :width => 100, :align => 'center', :editable => true},
        { :name => 'client_id',   :index => 'client_id',    :width => 80, :align => 'center', :editable => true},
        { :name => 'phone_no1',  :index => 'phone_no1',  :width => 80, :align => 'left', :editable => true},
        { :name => 'phone_no2' ,   :index => 'phone_no2',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'name_of_organization' , :index => 'name_of_organization',  :width => 100, :align => 'left', :editable => true },
        { :name => 'address1' ,   :index => 'address1',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'address2' ,   :index => 'address2',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'zipcode' ,   :index => 'zipcode',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'state' ,   :index => 'state',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'country' ,   :index => 'country',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'no_of_license_required' ,   :index => 'no_of_license_required',     :width => 80,  :align => 'center', :editable => true},
        { :name => 'attribute1',  :index => 'attribute1',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute2',  :index => 'attribute2',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute3',  :index => 'attribute3',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute4',  :index => 'attribute4',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute5',  :index => 'attribute5',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute6',  :index => 'attribute6',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute7',  :index => 'attribute7',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        { :name => 'attribute8',  :index => 'attribute8',   :width => 100,   :align => 'center', :editable => true,hidden:true},
        
     ],
      :editurl => '/userregistermaintenance',
      :pager => '#userregister_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Userregister Maintenance',
      :reloadAfterEdit => true,
      :onSelectRow => selectrowfunc.to_json_var }]
    
     pager = [:navGrid, "#userregister_pager", {edit:true, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:closeAfterAdd=>true}, {}, {}, {}]   
    
    
    
    jqgrid_api 'userregister_list', grid, pager , options

  end
end
