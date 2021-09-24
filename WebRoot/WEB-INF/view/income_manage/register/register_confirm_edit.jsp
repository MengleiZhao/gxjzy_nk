<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<style>
	 .dialog-button {
		text-align: center;
    }

</style>
<!-- <div style="margin:20px 0;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('open')">Open</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('close')">Close</a>
</div> -->


	
<form id="re_confirm_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 451px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div" id="easyAcc">
				<!-- 主键id --><input type="hidden" name="fincomeId" id="F_fincomeId" value="${bean.fincomeId}"/>
				<!-- 主键id --><input type="hidden" name="fpId" id="fpId" value="${icBean.fpId}"/>
				<!-- 主键id --><input type="hidden" name="flowStatus" id="flowStatus" />
				<!-- 主键id --><input type="hidden" name="status" id="status" />
				<div class="easyui-accordion"  style="margin-left: 20px;margin-right: 20px;">
					<div title="基本信息" data-options="collapsible:false" style="overflow:auto;">
						<table class="win-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;登记编号</td>
								<td class="td2">
									<input id="F_fincomeNum" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fincomeNum" data-options="validType:'length[1,30]'" style="width: 212px" value="${bean.fincomeNum}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;登记日期</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_fregisterTime" name="fregisterTime" readonly="readonly" required="required" data-options="validType:'length[1,30]',editable:false" style="width: 212px" value="${bean.fregisterTime}"/>
								</td>			
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;登记部门</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fregisterDepart" name="fregisterDepart" readonly="readonly" required="required" data-options="validType:'length[1,30]',editable:false" style="width: 212px" value="${bean.fregisterDepart}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;登记人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fregisterPerson" name="fregisterPerson" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 212px" value="${bean.fregisterPerson}"/>
								</td>
							</tr>
										
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;立项项目名称</td>
								<td class="td2">
									<input id="fproName" class="easyui-textbox" type="text" readonly="readonly" name="fproName" data-options="editable:false" required="required" style="width: 212px" value="${bean.fproName}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;金额</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fregisterAmount" name="fregisterAmount" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 212px" value="${bean.fregisterAmount}"/>
								</td>
							</tr>
										
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费标准</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fPlanPrice" name="fPlanPrice" readonly="readonly" required="required" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fPlanPrice}"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费依据</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fProPlan" name="fProPlan" required="required" readonly="readonly"  data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fProPlan}"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1">论证资料</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fRemark" name="fRemark" required="required" readonly="readonly"  data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fRemark}"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
								</td>
								<td colspan="4" id="tdf">
								<c:if test="${!empty businessAttaList}">
									<c:forEach items="${businessAttaList }" var="att">
										<c:if test="${att.serviceType=='business' }">
											<div style="margin-top: 10px;">
												<a href='${base}/attachment/download/${att.id }' style="color: #666666;font-weight: bold;">${att.originalName }</a>
												&nbsp;&nbsp;&nbsp;&nbsp;
											</div>
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${empty businessAttaList}">
									<span style="color:#999999">暂未上传附件</span>
								</c:if>
								</td>
							</tr>
						</table>
					</div>
					</div>
				<div  class="easyui-accordion"  style="margin-left: 20px;margin-right: 20px;height:auto">
					<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">
						<table class="win-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f_confirm" onchange="uploadFile(this, 'confirm', 'confirm01')" hidden="hidden">
									<input type="text" id="confirmFiles" name="confirmFiles" hidden="hidden">
								</td>
								<td colspan="4" id="tdfConfirm">
									<a onclick="$('#f_confirm').click()" style="font-weight: bold;" href="#">
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<c:forEach items="${confirmAttaList }" var="att">
										<c:if test="${att.serviceType=='confirm' }">
										<div style="margin-top: 10px;">
											<a href='${base}/attachment/download/${att.id }' style="color: #666666;font-weight: bold;">${att.originalName }</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<a id="${att.id }" class="fileUrl confirm" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
										</c:if>
									</c:forEach>
									<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
										<div id="progressNumber" style="background:#3AF960;width:0px;height:10px"></div>
										文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- 应收款项明细-->
				<div  class="easyui-accordion"  style="margin-left: 20px;margin-right: 20px;height:auto">
					<div title="应收款项明细" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="mingxi_list_confirm.jsp" /> 
						</div>
					</div>
				</div>
				</div>
			
			<div class="window-left-bottom-div" style="margin-top: 15px;">
				<a href="javascript:void(0)" onclick="saveConfirm(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveConfirm(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		
		<div class="window-right-div" style="width:254px;height: auto">
			<jsp:include page="../../check_system.jsp" />
		</div>
		
	</div>
</form>
<!-- <div id="dlg"  class="easyui-dialog" title="提示" style="width:400px;height:200px;padding:10px;text-align:center"
			data-options="
				closed:true,
				buttons: [{
					text:'是',
					iconCls:'icon-ok',
					handler:function(){
						$('#dlg').dialog('close')
						saveConfirm(9);
					}
				},{
					text:'否',
					handler:function(){
						$('#dlg').dialog('close')
					}
				}]
			">
		所有人员缴费情况已确认，是否完结本项目收款确认。
	</div> -->
<script type="text/javascript">
//送审
function saveConfirm(status) {
	$('#flowStatus').val(status);
	$('#status').val(status);
	accept1();
	var rows2 = $('#mingxi-dg').datagrid('getRows');
	var mingxiJson = "";
	for (var i = 0; i < rows2.length; i++) {
		mingxiJson = mingxiJson + JSON.stringify(rows2[i]) + ",";
	}
	$('#mingxiJson').val(mingxiJson);
	$('#re_confirm_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/incomeConfirm/saveConfirm',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#re_confirm_form').form('clear');
				$('#registerTab').datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
				closeSecondWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});  
}

function confirm1(){
	$.messager.confirm('My Title', 'Are you confirm this?', function(r){
		if (r){
			alert('confirmed: '+r);
		}
	});
}

function uploadFile(obj,serviceType,pathNum,mark) {
	  var files = obj.files;
	  var size=files[0].size;
	  if(size==0){
		  alert("不允许上传空文件");
		  return false;
	  }
	  var formData = new FormData();
	  //判断有没有选中附件信息
	  if(files==null || files=="null"|| files.length==0){
		  alert("请选择附件上传");
		  return false;
	  }
	  //把所有的附件都存入变量，准备传给后台
	  for(var i=0; i< files.length; i++){
	  	 formData.append("attFiles",files[i]);
	  } 
	  //初始化进度条为0
	  $("#percent").html(0 + '%');
	  $("#progressNumber").css("width",""+0+"px");
	  
	  $('.win-left-bottom-div').hide();
	  
	  // 接收上传文件的后台地址 
	  var url = base + "/attachment/uploadAtt?serviceType="+serviceType+"&pathNum="+pathNum;          
	  //1.创建XMLHttpRequest组建    
	  xmlHttpRequest = createXmlHttpRequest();  
	  //post请求
	  xmlHttpRequest.open("post", url, true);
	  //请求成功回调
	  xmlHttpRequest.onload = function (data) {
		  callbackA(mark);
		  var resObj = JSON.parse(data.currentTarget.response);
		  if(resObj.success && 'zdsy'==serviceType){
			  //如果是制度索引文件上传
			  var fileName = resObj.info.split("@")[1];
			  var fileId = resObj.info.split("@")[0];
			  fileName = fileName.replace('.pdf','');
			  $('#cheter_add_fileName').textbox('setValue',fileName);
			  $('#F_attachmentId').val(fileId);
			  $('#systemcenter_add_uploadbtn').hide();
		  }
	  };
	  //调用线程监听上传进度
	  xmlHttpRequest.upload.addEventListener("progress", progressFunction, false);
	  //把文件数据发送出去
	  xmlHttpRequest.send(formData);
	  //清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
	  event.target.value=null;
	}
	
	
function callbackA(mark) {
    //5。接收响应数据
    //判断对象的状态是交互完成
    if (xmlHttpRequest.readyState == 4) {
        //判断http的交互是否成功
        if (xmlHttpRequest.status == 200) {
            //获取服务器段输出的纯文本数据
            var responseText = xmlHttpRequest.responseText;
            //文本数据转换成json
            var jsonResponse = JSON.parse(responseText);
	    	 if(jsonResponse.success==true){
	    		    //获取controller 返回的对象信息
			        var datainfo = jsonResponse.info;
	    		    //如果上传了多个文件，返回的string就有多个，使用逗号分割，现在截取
	    		 	var infoArray = datainfo.split(',');	
	    		 	for(var i=0; i< infoArray.length; i++){
	    		 		var info = infoArray[i];
	    		 		var inf = info.split('@');
	    		 		var id = inf[0];//附件id
	    		 		var name = inf[1];//附件名称
				        $('#tdfConfirm').append(
			    			"<div style='margin-top: 5px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this,\""+mark+"\")'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$(".fileUrl").each(function(){
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#confirmFiles").val(s);
	    			$("#progid").hide();
	    	} else {
	    		alert(jsonResponse.info);
	    		$('#tdfConfirm').append(
    				"<div style='margin-top: 5px;'>"+
    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
    			);
	    		$("#progid").hide();
	    	}
        } else {
            alert("上传失败");
        }
        $('.win-left-bottom-div').show();
    }
}
</script>
</body>