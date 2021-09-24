<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<style type="text/css">
.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.textbox-text{color:#666666;height: 25px; line-height: 25px}
.style1{color: red;height: 40px;}
.numberbox .textbox-text {text-align: left;}
.tabDiv{padding:10px;}
.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
.td1{width: 100px;}
.td2{height: 30px;width: 150px;}
.trtop{height: 10px;}
.trbody{height: 30px;}
</style>
	<script type="text/javascript">
    $('#F_fcType').combobox({  
        onChange:function(newValue,oldValue){  
    	var sel2=$('#F_fcType').combobox('getValue');
    	if(sel2!="1"){
    		$('#cg1').hide();
    		$('#cg2').hide();
    		//$('#F_fPurchNo').next(".textbox").show();
		}else{
    		$('#cg1').show();
    		$('#cg2').show();
    		//$('#F_fPurchNo').next(".textbox").hide();
		} 
        }
    }); 
   /*  function getFilePath(){  
        var input = document.getElementById("CF_file");
    	if(input){//input是<input type="file">Dom对象  
            if(window.navigator.userAgent.indexOf("MSIE")>=1){  //如果是IE    
                input.select();      
              return document.selection.createRange().text;      
            }      
            else if(window.navigator.userAgent.indexOf("Firefox")>=1){  //如果是火狐  {      
                if(input.files){      
                    return input.files.item(0).getAsDataURL();      
                }      
                return input.value;      
            }      
            return input.value;   
        }  
    }   */
		//baocun
		function CFAddEditForm(){
    	var s="";
		$(".fileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files").val(s);  
			$('#CFAddEditForm').form('submit', {
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
   						$('#CFAddEditForm').form('clear');
   						$("#CF_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						closeWindow();
   						$('#CFAddEditForm').form('clear');
   					}
   				} 
   			});		
		}
		function CFFormSS(){
			$("#CF_fFlowStauts").val('1');
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s);  
			$('#CFAddEditForm').form('submit', {
								
   				onSubmit: function(){ 
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				
   				//url:base+'/demo/save',
   				data:{'fFlowStauts':'1'},
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#CFAddEditForm').form('clear');
   						$("#CF_dg").datagrid('reload');
   						$('#indexdb').datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						closeWindow();
   						$('#CFAddEditForm').form('clear');
   					}
   				} 
   			});		
		}
		
		function fPurchNo_DC(){
			//var node=$('#CF_dg').datagrid('getSelected');
			var win=creatFirstWin('新增-合同拟定',950,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function officeOpen(path,outPutFile){
			//var path=$("#officePath").val();
		//	var outPutFile=$("#outPutFile").val();
			path = encodeURI(encodeURI(path));
			//window.open('${base}/Rece/office?path='+path);
					//window.open('http://192.168.191.1:8080/ftp/ff/HT/HTND/1.html');
			$.ajax({
				type:'post',
				url:'${base}/Office/office?path='+path,
				success:function(data){
					var ftphost=$("#ftphost").val();
					var webport=$("#webport").val();
					data=data.replace(/\"/g,"");
					window.open(data);
				}
			})
		}
		
	</script>
    <div class="easyui-layout" fit="true" >
	    	<form id="CFAddEditForm" action="${base}/Formulation/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	    		<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fUserName" id="F_fUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="F_fUserCode" value="${bean.fUserCode}"/>
	    		<input type="hidden" name="fProCode" id="F_fProCode" value="${bean.fProCode}"/>
	    		<input type="hidden" name="fNCode" id="F_fNCode" value="${bean.fNCode}"/>
	    		<input type="hidden" name="fPayStauts" id="F_fPayStauts" value="${bean.fPayStauts}"/>
	    		<%-- <c:if test="${fn:length(bean.id)>0}">
	    			<input type="hidden" name="islocked" value="${bean.islocked}"/>
	    			<input type="hidden" name="status" value="${bean.status}"/>
	    		</c:if> --%>
	    		<div data-options="region:'west',split:true"style="width:600px;border-color: dce5e9" id="westDiv">
				<table >
				<tr>
					<td style="vertical-align: top;">
						<div class="easyui-accordion" style="width:555px;margin-left: 20px;">
								<div title="合同信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
								<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同编号</td>
										<td  colspan="4">
											<input id="F_fcCode" class="easyui-textbox" type="text" readonly="readonly" name="fcCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fcCode}" style="width: 450"/> 
										</td>								
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同名称</td>
										<td  colspan="4">
											<input class="easyui-textbox" type="text" id="F_fcTitle"  name="fcTitle"required="required" data-options="validType:'length[1,20]'" value="${bean.fcTitle}" style="width: 450"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同分类</td>
										<td class="td2">
											<select class="easyui-combobox" id="F_fcType" name="fcType"  style="width: 150px;" data-options="editable:false,panelHeight:'auto'">
												<option value="2" <c:if test="${bean.fcCode=='2' }" >selected="selected"</c:if>>收入合同</option>
												<option value="1" <c:if test="${bean.fcCode=='1' }" >selected="selected"</c:if>>支出合同</option>
												<option value="3"<c:if test="${bean.fcCode=='3' }" >selected="selected"</c:if>>非经济合同</option>
											</select>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;合同份数</td>
										<td class="td2">
											<input id="F_fcNum"  class="easyui-numberbox"  type="text" required="true" name="fcNum" data-options="validType:'length[1,20]'"  value="${bean.fcNum}" style="width: 150"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同金额</td>
										<td class="td2">
											<input class="easyui-numberbox" type="text"  id="F_fcAmount" name="fcAmount" data-options="icons: [{iconCls:'icon-wanyuan'}]" value="${bean.fcAmount}" style="width: 150"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;质保期</td>
										<td class="td2">
											<input class="easyui-textbox" type="text"  id="F_fWarrantyPeriod" name="fWarrantyPeriod"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fWarrantyPeriod}"/>
										</td>
										<%-- <td class="td1">申请时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" id="F_fReqtIME" name="fReqtIME"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fReqtIME}"/>
										</td> --%>
									</tr>
									
									
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同开始时间</td>
										<td class="td2">
											<input id="F_fContStartTime" class="easyui-datebox"  class="dfinput"  name="fContStartTime" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fContStartTime}"/>					
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">&nbsp;&nbsp;合同结束时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput"  id="F_fContEndTime" name="fContEndTime"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fContEndTime}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同签署人</td>
										<td class="td2">
											<input id="F_fSignUser"  class="easyui-textbox"  type="text" name="fSignUser" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fSignUser}"/>					
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">&nbsp;&nbsp;合同签署时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput"  id="F_fSignTime" name="fSignTime"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fSignTime}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;保证金金额</td>
										<td class="td2">
											<input id="F_fMarginAmount"  class="easyui-numberbox"  type="text" name="fMarginAmount" data-options="validType:'length[1,20]',prompt:'(元)',precision:2" style="width: 150" value="${bean.fMarginAmount}"/>
										</td >
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;是否委托授权</td>
										<td class="td2">
											<input type="radio" name="fIsAuthor" value="1" checked="checked" <c:if test="${bean.fIsAuthor=='1'}">checked="checked"</c:if> />是
											<input type="radio" name="fIsAuthor" value="0" <c:if test="${bean.fIsAuthor=='0'}">checked="checked"</c:if> />否
											<%-- <select class="easyui-combobox" id="F_fIsAuthor" name="fIsAuthor" value="${bean.fIsAuthor}" style="width: 150px;" data-options="editable:false,panelHeight:'auto'">
												<option value="${bean.fIsAuthor}"></option>
												<option value="0">否</option>
												<option value="1">是</option>
											</select> --%>
										</td>
									</tr>
									<tr id="cg1" hidden="hidden" class="trbody">
										<td class="td1">&nbsp;&nbsp;采购订单号</td>
										<td  colspan="4">
											<a onclick="fPurchNo_DC()"><input id="F_fPurchNo"  class="easyui-textbox" name="fPurchNo" data-options="prompt:'单击打开选取采购订单号',validType:'length[1,50]'" value="${bean.fPurchNo}" style="width: 450"/></a>
										</td>
									</tr>
									<tr id="cg2" hidden="hidden" class="trbody">
										<td class="td1">&nbsp;&nbsp;预算指标名称</td>
										<td >
											<input id="F_fBudgetIndexName" class="easyui-textbox"  name="fBudgetIndexName" data-options="prompt:'单击打开选取指标',validType:'length[1,50]'" style="width: 150" value="${bean.fBudgetIndexName}"/>
										</td >
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;预算指标金额</td>
										<td >
											<input id="F_fAvailableAmount" class="easyui-textbox"  name="fAvailableAmount" style="width: 150"  value="${bean.fAvailableAmount}"/>
											<input id="F_fBudgetIndexCode" hidden="hidden"  name="fBudgetIndexCode" style="width: 150"  value="${bean.fBudgetIndexCode}"/>
										</td >
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;申请人</td>
										<td class="td2">
											<input id="F_fOperator"  class="easyui-textbox" readonly="readonly" name="fOperator" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fOperator}"/>					
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;申请时间</td>
										<td class="td2">
											<input id="F_fReqtIME"  class="easyui-datebox" readonly="readonly" name="fReqtIME" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fReqtIME}"/>					
										</td>
									</tr>
									<%--<tr class="trbody">
										<td class="td1">质保期</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" id="F_fWarrantyPeriod" name="fWarrantyPeriod"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fWarrantyPeriod}"/>
										</td>
										 <td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>项目编号</td>
										<td class="td2">
											<a onclick="fProCode_DC()"><input class="easyui-textbox" type="text" id="F_fProCode" name="fProCode"  data-options="prompt:'单击打开选取项目编号',validType:'length[1,20]'" style="width: 150" value="${bean.fProCode}"/></a>
										</td> 
									</tr>--%>
									
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="f" onchange="upFile()" hidden="hidden">
											<input type="text" id="files" name="files" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
												<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
											</a>
											<c:forEach items="${attac}" var="att">
												<div style="margin-top: 10px;">
													<a href='#' style="color: #666666;font-weight: bold;">${att.fAttacName}</a>
													&nbsp;&nbsp;&nbsp;&nbsp;
													<img src="${base}/resource-modality/${themenurl}/sccg.png">
													&nbsp;&nbsp;&nbsp;&nbsp;
													<a id="${att.fAttacName}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													<a style="color:red" class="fileUrl" href="#"  onclick="officeOpen('${att.fFileSrc }','${outPutFile }')" >预览</a>
													<input hidden="hidden" type="text" value="${att.fFileSrc }">
												</div>
											</c:forEach>
													<input id="webport" hidden="hidden" type="text" value="${webport }">
													<input id="ftphost" hidden="hidden" type="text" value="${ftphost }">
										</td>
									</tr>
									
									<tr style="height: 70px;">
										<td class="td1" valign="top">&nbsp;&nbsp;合同说明</td>
										<td  colspan="4">
											<input class="easyui-textbox"  data-options="multiline:true" id="CF_fRemark" name="fRemark" style="width:450px;height:70px" value="${bean.fRemark}">  
											<input type="text" id="CF_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/>
										</td>
									</tr>
								</table>
							</div>
					</tr>
					<%-- <tr style="height: 50px;text-align: center;">
						<td>
							<a href="javascript:void(0)"  onclick="CFAddEditForm();"><img src="${base}/resource-modality/${themenurl}/skin_/baocun.png"></a> &nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)"  onclick="CFFormSS();"><img src="${base}/resource-modality/${themenurl}/skin_/songshen.png"></a> &nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)"  onclick="closeWindow();"><img src="${base}/resource-modality/${themenurl}/skin_/guanbi.png"></a>&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr> --%>
				</table>
			</div>
			<div data-options="region:'center',split:true"
				style="width: 50xp;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7"></div>


			<div data-options="region:'east',split:true" style="width:190px;border-color: #dce5e9">
				<table class="ourtable2" style="width: 150px;margin-left: 20px;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="height: 28px;"><span style="color: ff6800">相关制度</span></td>
					</tr>
					<tr>
					<td valign="top">
						<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
					</td>
					</tr>
					<tr>
						<td style="height: 31px;">
							<input class="easyui-textbox" style="width:150px;"
							data-options="prompt: '搜索' ,icons: [{iconCls:'icon-sousuo',handler: function(e){}}]">
						</td>
					</tr>
					<c:forEach items="${cheterInfo}" var="li">
						<tr style="height: 30px;">
							<td>
								<a style="color: #666666" id="file${li.systemId}" href="#" onclick="findSystemFile(${li.systemId})">${li.fileName}</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
					<div style="width:598px;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 0px">
						<a href="javascript:void(0)" onclick="CFAddEditForm();">
							<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="CFFormSS()">
							<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="closeWindow()">
							<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</div>
					<div style="width: 8px;height:50px;border: 1px solid #f0f5f7;border-left:0px;border-right:0px; border-top:0px ;background-color: #f0f5f7;float: left;"></div>
					<div style="width: 188px;height:50px;border:1px solid #dce5e9;float: left;border-top: 0px"></div>
			</div>
		</form>
					
	</div>
	<script type="text/javascript">
	var c=0;
	//附件上传
	function upFile() {
		var url = $("#f").val();
		var urlli = url.split(',');
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
		        url:base+"/Formulation/formulationFile?fileurl="+fileurl,
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
	
	
	//附件删除AJAX
	function deleteAttac(a){
		var filename = a.id;
		filename = encodeURI(encodeURI(filename));  
		$.ajax({
			type:"POST",
	        url:base+"/Formulation/formulationFileDelete?filename="+filename,
	        success:function(data){
	        	if($.trim(data)=="true"){
					//删除div
		        	$(a).parent().remove();
	        		alert("附件删除成功！");
	        	} else {
	        		alert("附件删除失败！");
	        	}
	        }
	    });
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
										"</div>")
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
			var row = $('#CF_dg').datagrid('getSelected');
			var selections = $('#CF_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#CF_dg").datagrid('reload');
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
</html>

