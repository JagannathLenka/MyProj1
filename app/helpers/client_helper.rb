module ClientHelper
  include JqgridsHelper

  def client_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
      id  = params["id"]
      url = "/client" 
      height = 300 
      width = 1100   
    
    
    addcheckfunc = 'function(postdata, formid) {return[true, " "]}'
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#client_list').jqGrid('restoreRow',lastsel);
                           jQuery('#client_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#client_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});}, 
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"   
                       

    grid = [{
      :url => url,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> height,
      :width => width,
      :colNames => ['Id', 'FirstName','LastName','Organization Name','EmailId','No Of License Required','Phone1','Phone2', 'State','Country','Zipcode', 'Status' ],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55,:hidden => true },
        { :name => 'name_of_person', :index => 'name_of_person',  :width => 80, :align => 'center', :editable => true},
        { :name => 'lastname_of_person', :index => 'lastname_of_person',  :width => 80, :align => 'center', :editable => true},
        { :name => 'name_of_organization', :index => 'name_of_organization',  :width => 80, :align => 'center', :editable => true},
        { :name => 'email_id', :index => 'email_id',  :width => 80, :align => 'center', :editable => true},
        { :name => 'no_of_license_required', :index => 'no_of_license_required',  :width => 80, :align => 'center', :editable => true},
        { :name => 'phone_no1', :index => 'phone_no1',  :width => 80, :align => 'center', :editable => true},
        { :name => 'phone_no2', :index => 'phone_no2',  :width => 80, :align => 'center', :editable => true},
        { :name => 'state', :index => 'state',  :width => 80, :align => 'center', :editable => true,edittype:"select", editoptions: {value: "Yes:Yes;No:No" }},
        { :name => 'country', :index => 'country',  :width => 80, :align => 'center', :editable => true},
        { :name => 'zipcode', :index => 'zipcode',  :width => 80, :align => 'center', :editable => true},
        { :name => 'status', :index => 'status',  :width => 80, :align => 'center', :editable => true}
      ],
      :editurl => '/client',
      :pager => '#client_pager',
      :rowNum => 10,
      :rowList => [10, 20, 30],
      :sortname => 'id',
      :sortorder => 'asc',
      :viewrecords => true,
      :caption => 'Client Details',
      :reloadAfterEdit => true,
      :multiselect => true,
      :ondblClickRow  => selectrowfunc.to_json_var }]


    pager = [:navGrid, "#client_pager", {edit:false, add:true, del: true}, {:closeAfterEdit => true, :closeAfterAdd => true,
                                                       :closeOnEscape => true}, 
                                                       {:closeAfterAdd=>true, :errorTextFormat  =>aftersubfunc.to_json_var, :beforeSubmit => addcheckfunc.to_json_var}, {}, {}, {}]   
    #slotting_button = [:navButtonAdd, "#slotting_pager", {:caption => 'Slot the items', :onClickButton => slottfunc.to_json_var }]               
    

    jqgrid_api 'client_list', grid, pager, options

  end
end
