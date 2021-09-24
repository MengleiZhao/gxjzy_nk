<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="TPDAddEditForm"  action="${base}/wflow/TProcessDefinSave" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 600px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div " style="height: 300px">
				<input type="hidden" name="FPId" id="TPD_FPId" value="${bean.FPId}"/>
	    		<input type="hidden" name="FStauts" id="TPD_FStauts" value="${bean.FStauts}"/>
	    		<input type="hidden" name="FUpdateTime" id="TPD_FUpdateTime" value="${bean.FUpdateTime}"/>
	    		<input type="hidden" name="FCreateUser" id="TPD_FCreateUser" value="${bean.FCreateUser}"/>
				<div class="easyui-accordion" style="width:670px;margin-left: 20px;">
							<div title="流程配置信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>流程显示名称</td>
										<td class="td2">
											<input class="easyui-textbox" id="TPD_FPName" name="FPName"  data-options="validType:'length[1,50]'" style="width: 150;height:25px" value="${bean.FPName }"/>
										</td>
										<td style="width: 50px">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>流程定义代码</td>
										<td class="td2">
											<input class="easyui-textbox"  id="TPD_FPCode" name="FPCode" readonly="readonly"  data-options="validType:'length[1,20]'" style="width: 150;height:25px" value="${bean.FPCode}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>归属部门</td>
										<td class="td2">
											<c:if test="${openType=='add'||openType=='edit'}"><a onclick="depart()"></c:if><input class="easyui-textbox" id="TPD_departName" name="departName"  data-options="prompt:'点击选择',validType:'length[1,20]'" style="width: 150;height:25px" value="${bean.departName }"/></a>
											<input hidden="hidden" type="text" name="departCode" value="${bean.departCode}" id="TPD_departCode">
										</td>
										<td style="width: 50px">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>业务范围</td>
										<td class="td2">
											<input  id="TPD_FBusiArea" name="FBusiArea"  value="${bean.FBusiArea }" data-options="url:'${base}/wflow/lookupsJson?parentCode=YWFW&selected=${bean.FBusiArea}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'" class="easyui-combobox" style="width: 150;height:25px" />
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><p style="margin-top: 8px">&nbsp;&nbsp;开始执行时间</p></td>
										<td class="td2">
											<input class="easyui-datebox" id="TPD_FStartTime" name="FStartTime"  data-options="validType:'length[1,20]'" style="width: 150;height:25px" value="${bean.FStartTime }"/>
										</td>
										<td style="width: 50px">&nbsp;</td>
										<td class="td1"><p style="margin-top: 8px">&nbsp;&nbsp;执行周期(频率)</p></td>
										<td class="td2">
											<input class="easyui-textbox"  id="TPD_FCycle" name="FCycle"  data-options="validType:'length[1,20]'" style="width: 150;height:25px" value="${bean.FCycle}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><p style="margin-top: 8px">&nbsp;&nbsp;所属业务目录</p></td>
										<td class="td2">
											<input id="TPD_FPath" name="FPath" data-options="url:'${base}/wflow/lookupsJson?parentCode=YWML&selected=${bean.FPath}',method:'POST',valueField:'text',textField:'text',editable:false,validType:'selectValid'" class="easyui-combobox" style="width: 150;height:25px" value="${bean.FPath}"/>
										</td>
									</tr>
									<tr  style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;流程描述</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" data-options="multiline:true,validType:'length[0,200]'" id="TPD_FPDesc" name="FPDesc" style="width: 505px;height:70px" value="${bean.FPDesc}">  
										</td>
									</tr>
								</table>	
							</div>
						</div>
		
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="TPDAddEditForm()">
						<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
<%-- 					<a href="javascript:void(0)" onclick="TPDFormSS()">
						<img src="${base}/resource-modality/${themenurl}/button/jihuo1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp; --%>
				</c:if>
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">
var c=0;
//附件上传
function upFile() {
	var url = $("#f").val();
	var urlli = url.split(',');
	var fAssType= "ZCLX-01";
	for(var i=0; i< urlli.length; i++){
		var fileurl=urlli[i];
		var filename = fileurl.split('\\');
		$('#tdf').append(
			"<div style='margin-top: 10px;'>"+
				"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<img id='imgt"+c+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
				"<img id='imgf"+c+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+fileurl+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
		);
		c++;
		fileurl = encodeURI(encodeURI(fileurl));
		$.ajax({
			async:false,
			type:"POST",
	        url:base+"/Storage/storageFile?fileurl="+fileurl,
	        data:{"fAssType":fAssType},
	        success:function(data){
		    	if($.trim(data)=="true"){
					$('#imgt'+i).css('display','');
		    	} else {
					$('#imgf'+i).css('display','');
		    	}
	        }
	    });
	}	
} 
function TPDAddEditForm(){
	/* //附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	}); */
	$("#TPD_FStauts").val("0");
	$('#TPDAddEditForm').form('submit', {
		onSubmit: function(){ 
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			/* url:base+'/demo/save',  */
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#TPDAddEditForm').form('clear');
					$("#wf_dg").datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});		
}
function TPDFormSS(){
	$("#TPD_FStauts").val("1");
	$('#TPDAddEditForm').form('submit', {
						
			onSubmit: function(){ 
				
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			
			//url:base+'/demo/save',
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#TPDAddEditForm').form('clear');
					$("#wf_dg").datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});		
}

function depart(){
	var win=creatFirstWin('原配置单号',840,450,'icon-search','/wflow/departCodeList');
	win.window('open');
}

/* function fTransUser(){
	var win=creatFirstWin('姓名部门',840,450,'icon-search','/Alloca/nameAndDept');
	win.window('open');
} */
/* function quota_DC(){
	//var node=$('#wf_dg').datagrid('getSelected');
	var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
	win.window('open');
} */

$(function(){
	var value=$('#TPD_FPath').val;
	if(value=='全局'){
		$('#TPD_FPath').combobox.combobox('setValue','LCYWFW-01');
	}
	if(value=='局部'){
		$('#TPD_FPath').combobox.combobox('setValue','LCYWFW-02');
	}
});
var c1 =0;
function upFile1() {
	c1 ++;
	var src = $('#a_fFileSrc1').val();
	$('#fi1').val(src);
	$('#S_a_f1').append("<div id='c1"+c1+"'><a href='#' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c1"+c1+")'>删除</a></div>");
} 
function deleteF1(val){
	var child=document.getElementById(val.id);
	child.parentNode.removeChild(child);
}
	var names = new Array();
	function streetChange(streetCode){
		$('#userStreetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
	}
	function departSelect(selectType){
		var win=creatSearchDataWin('选择-部门',590,400,'icon-add',"/depart/refUserDepart/"+selectType);
	    win.window('open');
	} 
	function departReturnSelect(ret){
		if (ret == "clear") {
	       $("#user_depart").html("");
		}

	    if (ret!="&&&&" && ret != undefined && ret != null && ret.indexOf("&&") != -1 && ret != "cancel") {
	    	var retArray = ret.split("&&");
	        var str= new Array(); 
	       	str=retArray[2].split(","); 
	       	for(var i=0;i<str.length-1 ;i++){
	       		if(null!=str[i]){
	       			var str1= new Array();
	       			str1=str[i].split(":");
	       			var div1 = $("#user_depart");
	       			if(!isUserTreeExist(str1[0]) && !isUserTreeExist(str1[1])){
						names.push(str1[0]);	
						div1.html("<div  style='float:left;margin-left:8px;margin-top:8px;' > "+
									"<input type='hidden' name='depart.id' id='departIds' value='"+str1[0]+"'/>"+
									"<span title='"+str1[1]+"'>"+((str1[1].length>8)?str1[1].substring(0,8)+"...":str1[1])+"</span>"+
									"<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelUserDepart(this)' title='删除' id='"+str1[0]+"'/>"+
									"</div>");
					}
	       		}
	       	}
	    }
	}
	function isUserTreeExist(name){
		for(var i=0; i<names.length; i++){
			if(names[i] == name){
				return true;
			}
		}
		return false;
	}
	function deleteCF(){
		var row = $('#CS_dg').datagrid('getSelected');
		var selections = $('#wf_dg').datagrid('getSelections');
			if(confirm("确认删除吗？")){
				$.ajax({ 
					type: 'POST', 
					url: '${base}/Formulation/delete/'+row.fcId,
					dataType: 'json',  
					success: function(data){ 
						if(data.success){
							$.messager.alert('系统提示',data.info,'info');
							$("#wf_dg").datagrid('reload');
						}else{
							$.messager.alert('系统提示',data.info,'error');
						}
					} 
				}); 
			}
	}
	function cancelUserDepart(obj){
		var id=obj.id;
		if(names.length>0)
		{
			for(i=0; i<names.length; i++){
				if(names[i] == id){
					names.splice(i,1);
				}
			}
		}
		$(obj).parent().remove();
	}
	function checkMobileNo(){
		var mobile=$("#user_edit_mobileNo").textbox("getValue");
		var id=$("#user_edit_id").val();
		var tag="0";
		if(mobile!=''){
			 $.ajax({
	  			   type : "post",
	  			   url : "${base}/user/mobileCheck",
	  			   data:{"mobileNo":mobile,"id":id},
	  			   dataType: 'json',  
				   async: false,
	  			   success : function(data){
	  				   if(data.success){ 	
	  			   	     $.messager.alert('系统提示', "手机号在系统中已存在，请更换手机号！", 'info');
	  			   	     tag="1";
	  			   	   }else{
	  			   		 tag="0"; 
	  			   	   }  
	  			   }
	  		   })
		}
		 if(tag=="0"){
	    	return true; 
	     }else if(tag=="1"){
	    	return false; 
	     }
	}

</script>

</body>