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


</style>  
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
	
	
	//附件删除AJAX
	function deleteAttac(a){
		var filename = a.id;
		var fAssType= $("#S_fAssType").val();
		filename = encodeURI(encodeURI(filename));  
		$.ajax({
			type:"POST",
	        url:base+"/Storage/storageFileDelete?filename="+filename,
	        data:{"fAssType":fAssType},
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
		function expenditure2AddEditForm(){
			/* //附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			}); */
			$('#expenditure2AddEditForm').form('submit', {
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
   						$('#expenditure2AddEditForm').form('clear');
   						$("#expenditure_dg2").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function TPDFormSS(){
			$("#expenditure_FStauts").val("1");
			$('#expenditure2AddEditForm').form('submit', {
								
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
   						$('#expenditure2AddEditForm').form('clear');
   						$("#expenditure_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						$('#expenditure2AddEditForm').form('clear');
   					}
   				} 
   			});		
		}
		
		function depart(){
			var win=creatFirstWin('原配置单号',840,450,'icon-search','/wflow/departCodeList');
			win.window('open');
		}
		function fTransUser(){
			var win=creatFirstWin('姓名部门',840,450,'icon-search','/Alloca/nameAndDept');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#expenditure_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		
		
	</script>
    <div class="easyui-layout" fit="true" style="color: #333333">
   		<div data-options="region:'west',split:true"style="width:600px;border-color: dce5e9" id="westDiv">
	    	<form id="expenditure2AddEditForm" action="${base}/ExpenditureBaseic/save?leixing=2" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	    			<input type="hidden" name="tEbId2" id="expenditure_tEbId2" value="${bean.tEbId2}"/>
	    			<input type="hidden" name="a" id="expenditure_a" value="${bean.eb1.tEbId}"/>
				<table >
				<tr>
					<td >
						<div class="easyui-accordion" style="width:555px;margin-left: 20px;">
							<div title="明细科目" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>明细科目(名称)</td>
										<td class="td2">
											<input class="easyui-textbox" id="expenditure_tEbName2" name="tEbName2"  data-options="validType:'length[1,20]'" style="width: 150;height:25px" value="${bean.tEbName2}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>费用类型代码</td>
										<td class="td2">
											<input class="easyui-textbox" id="expenditure_tEbCode2" name="tEbCode2"  value="${bean.tEbCode2 }"  data-options="validType:'length[1,20]'" style="width: 150;height:25px"/>
										</td>
									</tr>
									<tr style="height: 70px;">
										<td class="td1" valign="top"><p style="margin-top: 8px">费用说明</p></td>
										<td  colspan="4">
											<input class="easyui-textbox" data-options="multiline:true" id="expenditure_tEbDirections" name="tEbDirections" style="width:505px;height:70px" value="${bean.tEbDirections}">  
										</td>
									</tr>
								</table>	
							</div>
						</div>
					</td>
				</tr>
				</table>
				</div>
			<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
					<div style="text-align: center;">
						<c:if test="${openType=='add'||openType=='edit'}">
							<a href="javascript:void(0)" onclick="expenditure2AddEditForm();">
								<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>&nbsp;&nbsp;&nbsp;
						</c:if>
						<a href="javascript:void(0)" onclick="closeWindow()">
							<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</div>
			</div>
			</form>
	</div>
	<script type="text/javascript">
	$(function(){
		var value=$('#expenditure_FPath').val;
		if(value=='全局'){
			$('#expenditure_FPath').combobox.combobox('setValue','LCYWFW-01');
		}
		if(value=='局部'){
			$('#expenditure_FPath').combobox.combobox('setValue','LCYWFW-02');
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
			var selections = $('#expenditure_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#expenditure_dg").datagrid('reload');
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

