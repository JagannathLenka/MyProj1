module ItemerrorHelper

include JqgridsHelper

  def itemerror_jqgrid

    options = {:on_document_ready => true, :html_tags => false}
    
    if ! params[:uploadfile_id].nil?
        url = '/itemerror?uploadfile_id=' + params[:uploadfile_id]   
    else
       url = '/itemerror/' 
    end
   
    aftersubfunc = 'function(response, postdata) {message = response.responseText; success = false; return [success, message ]}'
    selectrowfunc = "function(id) { 
                      if(id && id!==lastsel){
                           jQuery('#itemerror_list').jqGrid('restoreRow',lastsel);
                           jQuery('#itemerror_list').jqGrid('editRow',id,{keys: true, 
                           aftersavefunc: function(){lastsel=0;jQuery('#itemerror_list').trigger('reloadGrid');},
                           errorfunc: function(id, response){lastsel=0;
                                       $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ response.responseText +'</div>', 
                                       $.jgrid.edit.bClose,{buttonalign:'right'});},
                           afterrestorefunc : function(){lastsel=0;}            
                      });
                     lastsel=id;
                     } 
                   }" 
                   
     reprocessfunc  = "function() {
                                var ids = $('#itemerror_list').jqGrid('getGridParam','selarrrow');
                                
                                 $.post('/itemerror',
                                       {
                                         'oper' :'proc',
                                         'id'  :ids
                                       },
                                       function(data,status)
                                       {

                                       })
                                        .done(function(xhr, textStatus)   { 
                                          $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">' + xhr  +'</div>', 
                                          $.jgrid.edit.bClose,{buttonalign:'right'});  
                                          lastsel=0;
                                          })
                                          
                                       .fail(function(xhr, textStatus, errorThrown)   { 
                                          $.jgrid.info_dialog($.jgrid.errors.errcap,'<div class=""ui-state-error"">'+ 'Processing Failed' +  xhr  +'</div>', 
                                          $.jgrid.edit.bClose,{buttonalign:'right'});  
                                          lastsel=0;
                                         })
 
                                 $('#itemerror_list').trigger('reloadGrid');       
                   }"
       
    grid = [{
      :url => url,
      :datatype => 'json',
      :mtype => 'GET',
      :height=> 350,
      :width => 'auto',
    
      :colNames => ['Id','FileName', 'TransactionId','SequenceNo','ErrorCode', 'ErrorDescription','ClientId' ,'ItemNo','Velocity','Daily Sales','Weekly Sales','Monthly sales','Daily Forecast','Case Quantity','Case splitAloowed','Putaway Type'],
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
        { :name => 'attribute10',  :index => 'attribute10',   :width => 100,   :align => 'center', :editable => true,hidden:false},
     ],
      :editurl => '/itemerror',
      :pager => '#itemerror_pager',
      :rowNum => 50,
      :rowList => [100, 200, 300],
      :sortname => 'file_name',
      :sortorder => 'desc',
      :viewrecords => true,
      :shrinkToFit => true,
      :autowidth => true,
      :caption => 'ItemError',
      :reloadAfterEdit => true,
      :multiselect => true,
      :ondblClickRow  => selectrowfunc.to_json_var }]
      pager = [:navGrid, "#itemerror_pager",  {edit:false, add:false, del: true}, 
                                                 {:closeAfterEdit => true, :closeOnEscape => true},                                                        
                                                 {:closeAfterAdd=>true, :errorTextFormat  => aftersubfunc.to_json_var}, 
                                                 {reloadAfterSubmit:true}, {closeAfterSearch:true}, {}]                                                              

   
                                          
     pager_button = [:navButtonAdd, "#itemerror_pager", {:caption => 'Reprocess', :onClickButton => reprocessfunc.to_json_var }]

    
    jqgrid_api 'itemerror_list', grid, pager , pager_button , options

  end


end
