module UploadfileHelper
  include JqgridsHelper

  def uploadfile_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
      id  = params["id"]
      url = "/uploadfile" 
      height = 350 
      width = 'auto'
    
      addcheckfunc = 'function(postdata, formid) {return[true, " "]}'
      aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'   
      selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#uploadfile_list').jqGrid('restoreRow',lastsel);
                           jQuery('#uploadfile_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#uploadfile_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});}, 
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }"  
               
      customerLinkFormatter = "function(cellvalue, options, rowdata) {
      
                                 if (rowdata[2] == 'Location.csv')
                                   {
                                   return '<a href=\"locationerror?uploadfile_id=' + rowdata[0] + '\"> ' + cellvalue + '</a>';
                                   }
                                 else
                                   {
                                     return '<a href=\"itemerror?uploadfile_id=' + rowdata[0] + '\"> ' + cellvalue + '</a>';
                                   }
                              }" 

      statusFormatter = "function(cellvalue, options, rowdata) {
      
                             switch (cellvalue) 
                                   {
                                   case 'Error' :  
                                   return '<div class=\"status level label label-danger\" >' + cellvalue + '</div>';
                                   
                                   case 'Processed' :  
                                   return '<div class=\"status level label label-success\">' + cellvalue + '</div>';
                                   
                                   case 'Processed with Error' :  
                                   return '<div class=\"status level label label-warning\">' + cellvalue + '</div>';
                                   
                                   case 'Uploaded':
                                   return '<div class=\"status level label label-default\">' + cellvalue + '</div>';
                                   
                                   case 'Processing':
                                    return '<div class=\"status level label label-info\">' + cellvalue + '</div>'; 
                                    
                                   default:
                                    return '<div class=\"status level label label-default\">' + cellvalue + '</div>'; 
                                   }
                              }" 


    grid = [{
      :url => url,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> height,
      :width => width,
      :colNames => ['Id', 'Client Id','Upload Filename', 'Uploaded at', 'Total Records',' Processed Records ','Error Records','Deleted Records','Status'],
      :colModel  => [
        { :name => 'id',   :index => 'id',    :width => 55,:hidden => true },
        { :name => 'client_id', :index => 'client_id',  :width => 80, :align => 'center', :editable => true, :hidden => true},
        { :name => 'upload_filename', :index => 'upload_filename',  :width => 80, :align => 'center', :editable => true},
        { :name => 'created_at', :index => 'ucreated_at',  :width => 80, :align => 'center', :editable => false},
        { :name => 'no_of_records', :index => 'no_of_record',  :width => 80, :align => 'center', :editable => true},
        { :name => 'no_of_processed_records', :index => 'no_of_processed_records',  :width => 80, :align => 'center', :editable => true},
        { :name => 'no_of_error_records', :index => 'no_of_error_records',  :width => 80, :align => 'center', :editable => true, formatter: customerLinkFormatter.to_json_var},
        { :name => 'attribute2', :index => 'attribute2',  :width => 80, :align => 'center', :editable => true},
        { :name => 'attribute1', :index => 'attribute1',  :width => 80, :align => 'center', :editable => true, formatter: statusFormatter.to_json_var}
        
      ],
      :editurl => '/uploadfile',
      :pager => '#uploadfile_pager',
      :rowNum => 50,
      :rowList => [50, 100, 150],
      :sortname => 'created_at',
      :sortorder => 'desc',
      :viewrecords => true,
      :caption => 'Uploadfile Maintenance',
      :reloadAfterEdit => true,
      :autowidth => true,
      :multiselect => true,
      #:onSelectRow => selectrowfunc.to_json_var
       }]


    pager = [:navGrid, "#uploadfile_pager", {edit:false, add:false, del: true}, 
                                            {:closeAfterEdit => true, :closeAfterAdd => true, :closeOnEscape => true}, 
                                            {:closeAfterAdd=>true,    :errorTextFormat  =>aftersubfunc.to_json_var, :beforeSubmit => addcheckfunc.to_json_var}, {}, {}, {}]   
                                            
    jqgrid_api 'uploadfile_list', grid, pager , options

  end

end


