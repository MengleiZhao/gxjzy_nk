<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="disputetInfo" action="${base}/Dispute/Save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data" >
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div class="window-div">
<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;margin-bottom: 10px;">
<div class="window-left-top-div">
<input type="hidden" name="fcId" id="dispute_fcId" value="${bean.fcId}"/>
	    <input type="hidden" name="fFlowStauts" id="dispute_fFlowStauts" value="${bean.fFlowStauts}"/>
	    <input type="hidden" name="fContStauts" id="dispute_fContStauts" value="${bean.fContStauts}"/>
	    <input type="hidden" name="fUserName" id="dispute_fUserName" value="${bean.fUserName}"/>
	    <input type="hidden" name="fUserCode" id="dispute_fUserCode" value="${bean.fUserCode}"/>
	    <input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
	    <div class="tab-wrapper" id="contract-dispute-edit">
	    	<ul class="tab-menu">
			<li class="active" onclick="onclickreimburset()">纠纷表</li>
			<li onclick="fcTypeOnClik()">合同信息</li>
			<c:if test="${!empty Upt.fContUptType}"><li onclick="onclickUpt()">变更合同信息</li></c:if>
	</ul>  
	<div class="tab-content">
	<div title="纠纷信息" style="width: 737px" data-options="iconCls:'icon-xxlb'">
	<jsp:include page="../base/contract-dispute-base-detail.jsp" />
	</div>
	<div title="合同信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
	<%@ include file="../formulation/formulation_detail_base.jsp" %>
	</div>
	<c:if test="${!empty Upt.fContUptType}">
	<div title="变更合同信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
	<%@ include file="../base/contract-change-base-detail.jsp" %>
	</div>
	</c:if>
	</div>
	</div>
</div>
	<div class="window-left-bottom-div">
	<a href="javascript:void(0)" onclick="closeWindow()">
	<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>&nbsp;
	</div>
</div>
</div>
</div>
</form>
<script type="text/javascript">
flashtab('contract-dispute-edit');	
//上传附件
function change_upFile(obj){
	//创建上传表单
	var files = obj.files;
	var formData = new FormData();
    for(var i=0; i< files.length; i++){
  	  formData.append("attFiles",files[i]);   
  	} 
    //ajax上传
	$.ajax({  
    	url: base + '/Formulation/uploadAtt?serviceType=htjf' ,  
        type: 'post',  
        data: formData,  
        cache: false,
        processData: false,
        contentType: false,
        async: false,
        dataType:'json',
	    success:function(data){
	    	 if(data.success==true){
			        var datainfo = data.info;
	    		 	var infoArray = datainfo.split(',');	
	    		 	for(var i=0; i< infoArray.length; i++){
	    		 		var info = infoArray[i];
	    		 		var inf = info.split('@');
	    		 		var id = inf[0];//附件id
	    		 		var name = inf[1];//附件名称
				        $('#tdfhtjf').append(
			    			"<div style='margin-top: 10px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$(".fileUrl").each(function(){
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#fhtjffiles").val(s);
		       	 	
	    	} else {
	    		alert(data.info);
	    		$('#tdfhtjf').append(
    				"<div style='margin-top: 10px;'>"+
    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
    			);
	    	}
	     },
	     error:function(){
	    	 alert('上传失败！');
	     }
    });
}	
	$('#F_fcType').combobox({  
        onChange:function(newValue,oldValue){  
    	var sel2=$('#F_fcType').combobox('getValue');
    	if(sel2=="HTFL-01"){
    		$('#cg1').show();
    		$('#cg2').show();
    		//$('#cg2').hide();
    		//$('#F_fPurchNo').next(".textbox").show();
		}else{
    		$('#cg1').hide();
    		$('#cg2').hide();
    		//$('#cg2').show();
    		//$('#F_fPurchNo').next(".textbox").hide();
		} 
        }
    });  
	function disputeSaveForm(){
		
		var s="";
		$(".fileUrl5").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files5").val(s); 
		
		var plan = getPlan();
    	$('#disputetInfo').form('submit', {
				onSubmit:function(param){ 
					param.planJson=plan;
					 flag=$(this).form('enableValidation').form('validate');
					 if(flag){
	   						$.messager.progress();
	   					}
						return flag;
				}, 
				url:'${base}/Dispute/save',
				type:'post',
				/* data:{'fFileSrc':$('#dispute_fFileSrc').val()}, */
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#dispute_dg').form('clear');
						$('#dispute_dg').datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
					}
				} 
			});		
		}
		function fPurchNo_DC(){
			//var node=$('#dispute_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#dispute_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		var c =0;
		function upt_upFile() {
			/* console.log(document.getElementById("upt_fFileSrc1"));
			var src = getFilePath();
			alert(getFilePath()); */
			c ++;
			var src = $('#upt_fFileSrc1').val();
			/* var srcs =src+','+$('#upt_fi1').val();
			$('#upt_fi1').val(srcs); */
			$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a><a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>删除</a></div>");
		} 
		function deleteF1(val){
			var child=document.getElementById(val.id);
			child.parentNode.removeChild(child);
		}
		
		
		$("#F_fContStartTime").datebox({
		    onSelect : function(beginDate){
		        $('#F_fContEndTime').datebox().datebox('calendar').calendar({
		            validator: function(date){
		                return beginDate <= date;
		            }
		        });
		    }
		});
	</script>
</body>