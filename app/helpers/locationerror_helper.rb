module LocationerrorHelper
  include JqgridsHelper

  def locationerror_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
   
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#locationerror_list').jqGrid('restoreRow',lastsel);
                           jQuery('#locationerror_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#locationerror_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }" 
                   
     reprocessfunc  = "function() {
                                var ids = $('#locationerror_list').jqGrid('getGridParam','selarrrow');
                                
                                 $.post('/locationerror',
                                       {
                                         'oper' :'proc',
                                         'id'  :ids
                                       },
                                       function(data,status)
                                       {

                                       })
                                       .done(function()   { 
                                          $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ 'Processed Successfully' +'</div>', 
                                          $.jgrid.edit.bClose,{buttonalign:'right'});  
                                          lastsel=0;
                                          })
                                       .fail(function(xhr, textStatus, errorThrown)   { 
                                          $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ 'Processing Failed' + xhr.responseText +'</div>', 
                                          $.jgrid.edit.bClose,{buttonalign:'right'});  
                                          lastsel=0;
                                         })
 
                                 $('#locationerror_list').trigger('reloadGrid');       
                   }"
       
    grid = [{
      :url => '/locationerror/',
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      :width => 'auto',
    
      :colNames => ['Id','FileName', 'TransactionId','SequenceNo','ErrorCode', 'ErrorDescription', 'Warehouse','Barcode','CurrentItem','CurrentQuantity','Totalpics','LockCode','Maximum Quantity','Minimum Quantity','Status'],
      :colModel  => [
        { :name => 'id',   :index => 'id',  :width => 55, hidden:true},
        { :name => 'file_name',   :index => 'file_name',:width => 350,:align => 'center',:editable => false},
        { :name => 'transaction_id',   :index => 'transaction_id',    :width => 60, :align => 'center', :editable => false},
        { :name => 'sequence_no',   :index => 'sequence_no',    :width => 60, :align => 'center', :editable => false},
        { :name => 'error_code',  :index => 'error_code',  :width => 60, :align => 'left', :editable => false},
        { :name => 'error_description' ,   :index => 'error_description',     :width => 180,  :align => 'center', :editable => false},
        { :name => 'attribute1',  :index => 'attribute1',   :width => 80,   :align => 'center', :editable => true},
        { :name => 'attribute2',  :index => 'attribute2',   :width => 180,   :align => 'center', :editable => true},
        { :name => 'attribute3',  :index => 'attribute3',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'attribute4',  :index => 'attribute4',   :width => 100,   :align => 'center', :editable => true},
        { :name => 'attribute5',  :index => 'attribute5',   :width => 100,   :align => 'center', :editable => true,hidden:false},
        { :name => 'attribute6',  :index => 'attribute6',   :width => 100,   :align => 'center', :editable => true,hidden:false},
        { :name => 'attribute7',  :index => 'attribute7',   :width => 100,   :align => 'center', :editable => true,hidden:false},
        { :name => 'attribute8',  :index => 'attribute8',   :width => 100,   :align => 'center', :editable => true,hidden:false},
        { :name => 'attribute9',  :index => 'attribute9',   :width => 100,   :align => 'center', :editable => true,hidden:false},
        
     ],
      :editurl => '/locationerror',
      :pager => '#locationerror_pager',
      :rowNum => 50,
      :rowList => [100, 200, 300],
      :sortname => 'file_name',
      :sortorder => 'desc',
      :viewrecords => true,
      :shrinkToFit => true,
      :autowidth => true,
      :caption => 'LocationError',
      :reloadAfterEdit => true,
      :multiselect => true,
      :onSelectRow => selectrowfunc.to_json_var }]
      pager = [:navGrid, "#locationerror_pager", {edit:false, add:false, del: true}, {:closeAfterEdit => true, :closeOnEscape => true}, 
                                                       
                                                       {:closeAfterAdd=>true, :errorTextFormat  => aftersubfunc.to_json_var}, {}, {closeAfterSearch:true}, {}]                                                              

   
                                          
     pager_button = [:navButtonAdd, "#locationerror_pager", {:caption => 'Reprocess', :onClickButton => reprocessfunc.to_json_var }]

    
    jqgrid_api 'locationerror_list', grid, pager , pager_button , options

  end

end
