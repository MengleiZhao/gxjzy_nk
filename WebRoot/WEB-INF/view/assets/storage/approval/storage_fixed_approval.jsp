<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript" src="/resource/custom/custom.js"></script>
<body>
<div class="win-div" style="">
<form id="StroageFixedAddEditForm" action="${base}/Storage/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fId_S" id="fId_S" value="${bean.fId_S}"/>
				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			    <!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
					<div class="easyui-accordion" style="width:662px;margin-left: 15px;">
							<div title="资产登记表" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" border="0" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>资产增加单单号</td>
										<td  colspan="4">
											<input id="S_fAssStorageCode" readonly="readonly" required="required" class="easyui-textbox"  name="fAssStorageCode" data-options="prompt:'',validType:'length[1,40]'" value="${bean.fAssStorageCode}" style="width: 555px"/> 
										</td>								
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>申请部门</td>
										<td class="td2">
											<input class="easyui-textbox" readonly="readonly" required="required" class="dfinput" id="S_fDeptName" name="fDeptName"  data-options="validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fDeptName}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>申请人</td>
										<td class="td2">
											<input class="easyui-textbox" class="dfinput" readonly="readonly" required="required" id="S_fOperator" name="fOperator"  data-options="validType:'length[1,50]'" style="width: 200px" value="${bean.fOperator}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">&nbsp;&nbsp;</span>合计金额</td>
										<td class="td2">
											<input class="easyui-numberbox" class="dfinput" id="S_fSumAmount" name="fSumAmount"  data-options="icons: [{iconCls:'icon-yuan'}],validType:'length[1,20]',precision:2" style="width: 200px" value="${bean.fSumAmount}"/>
										</td>
										<td class="td4">&nbsp;</td>
									</tr>
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="fgdzcdj" onchange="upladFile(this,'fixeddj','zcagl01')" hidden="hidden">
											<input type="text" id="files" name="storageFiles" hidden="hidden">
										</td>
										<td colspan="4" id=tdf>
											<%-- <c:if test="${openType=='add'||openType=='edit'}">
											<a onclick="$('#fgdzcdj').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											</c:if> --%>
											<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
										 		</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
									 		</div>
											<c:forEach items="${StorageAttaList}" var="att">
												<c:if test="${att.serviceType=='fixeddj' }">
													<div style="margin-top: 10px;">
													<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<%-- <c:if test="${openType=='add'||openType=='edit'}">
													<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
													&nbsp;&nbsp;&nbsp;&nbsp;
														<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</c:if> --%>
													</div>
												</c:if>
											</c:forEach>
										</td>
									</tr>	
									
									<tr style="height: 70px;">
										<td class="td1" valign="top">&nbsp;&nbsp;备注</td>
										<td  colspan="4">
											<%-- <input class="easyui-textbox"  readonly="readonly" data-options="multiline:true,validType:'length[1,200]'" id="S_fRemark_S" name="fRemark_S" style="width: 555px;height:70px" value="${bean.fRemark_S}"> --%>  
											<!-- <input type="text" id="S_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/> -->
											<textarea name="fRemark_S"  id="S_fRemark_S"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
											autocomplete="off"  style="width: 555px;height:70px;resize:none">${bean.fRemark_S }</textarea>
										</td>
									</tr>
									<c:if test="${openType=='add'||openType=='edit'}">
										<tr>
											<td align="right" colspan="5" style="padding-right: 0px;">
											可输入剩余数：<span id="textareaNum1" class="200">
												<c:if test="${empty bean.fRemark_S}">200</c:if>
												<c:if test="${!empty bean.fRemark_S}">${200-bean.fRemark_S.length()}</c:if>
											</span>
											</td>
										</tr>
									</c:if>
								</table>
							</div>
							<div title="资产详情表" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<%@ include file="storage_fixed_approval_plan.jsp" %>
							</div>
							<c:if test="${checkinfo==1}">
							<div title="审批记录" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../../check_history.jsp" />												
							</div>
							</c:if>
						</div>			
			
			
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
						<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<c:if test="${detailType=='detail'}">
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				<c:if test="${detailType=='ledger'}">
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</c:if>
				&nbsp;&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=资产管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
  $('#F_fcType').combobox({  
      onChange:function(newValue,oldValue){  
  	var sel2=$('#F_fcType').combobox('getValue');
  	if(sel2!="1"){
  		$('#cg1').hide();
  		//$('#cg2').hide();
  		//$('#F_fPurchNo').next(".textbox").show();
}else{
  		$('#cg1').show();
  		//$('#cg2').show();
  		//$('#F_fPurchNo').next(".textbox").hide();
} 
      }
  }); 
//如果选择‘采购’主管方法会弹出页面，让你选择采购计划
  $('#S_fAcquisitionType').combobox({
  	onChange:function(newValue,oldValue){
  		if(newValue=='QDFS-02'){
  			var win = creatSearchDataWin('采购计划', 970, 590, 'icon-search','/Storage/cgd?type=ZCLX-02&fAcquisitionType='+newValue);
  			win.window('open');
  			//如果不是采购的方式不需要挂接采购单，这由操作人自己添加物品
  			$("#S_fAcquisitionType").combobox('setValue','QDFS-02');
   		$('#addFixedButton').hide();
  		}else if(newValue=='QDFS-03'){
  			//如果是赠予的情况下显示其他字段
   		$('#addFixedButton').hide();
  		}else {
   		$('#addFixedButton').show();
  		}
  	}
  });
//上传附件
function storagefixed_upFile(obj){
	//创建上传表单
	var files = obj.files;
	var formData = new FormData();
    for(var i=0; i< files.length; i++){
  	  formData.append("attFiles",files[i]);   
  	} 
    //ajax上传
	$.ajax({  
    	url: base + '/Storage/uploadAtt?serviceType=fixeddj' ,  
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
				        $('#tdfgdzcdj').append(
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
	    			$("#storageFiles").val(s);
		       	 	
	    	} else {
	    		alert(data.info);
	    		$('#tdfgdzcdj').append(
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
function check(stauts){
	var fId=$('#fId_S').val();
	var r=$('#C_fremark').val();
	$('#StroageFixedAddEditForm').form('submit', {
			onSubmit: function(param){ 
				param.planJson=getPlan();
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			url:'${base}/Storage/approvalStorage/'+stauts,
			data:{'fFlowStatus':stauts,'id':fId},
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#StroageFixedAddEditForm').form('clear');
					$("#storage_fixed_approval_dg").datagrid('reload'); 
					$("#indexdb").datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});	
}
</script>
</body>