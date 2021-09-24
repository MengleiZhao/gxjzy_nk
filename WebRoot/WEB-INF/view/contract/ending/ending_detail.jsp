<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript" src="/resource/custom/custom.js"></script>
<body>

<div class="win-div">
<form id="endingAddEditFrom" action="${base}/ending/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
	    		<c:if test="${bean.fcId!=null}">
	    			<input type="hidden" name="fUserName" id="F_fUserName" value="${bean.fUserName}"/>
	    			<input type="hidden" name="fUserCode" id="F_fUserCode" value="${bean.fUserCode}"/>
	    			<input type="hidden" name="fProCode" id="F_fProCode" value="${bean.fProCode}"/>
	    			<input type="hidden" name="fNCode" id="F_fNCode" value="${bean.fNCode}"/>
	    			<input type="hidden" name="fPayStauts" id="F_fPayStauts" value="${bean.fPayStauts}"/>
	    			<input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
	    		</c:if>
				<div class="tab-wrapper" id="contract-formulation-add">
					<ul class="tab-menu">
							<li class="active">终止表</li>
							<li>合同信息</li>
							<li>签约方信息</li>
							<li onclick="$('#filing-edit-plan-dg').datagrid('reload')">付款计划</li>
							<c:if test="${!empty Upt.fContUptType}"><li onclick="$('#change-upt-datagrid').datagrid('reload')">变更表</li></c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}"><li>纠纷信息</li></c:if>
							<c:if test="${!empty archiving.fToPosition}"><li>归档位置</li></c:if>
							<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
					</ul>
					
					<div class="tab-content">
							<div title="合同终止" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
								<%@ include file="../base/contract-ending-base-detail.jsp" %>
							</div>
							<div title="合同信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-base2.jsp" %>
							</div>
							<div title="签约方信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-sign-base-detail.jsp" %>
							</div>
							<div title="付款计划" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
								<%@ include file="../base/contract-filing-edit-plan-detail.jsp" %>
							</div>
							<c:if test="${!empty Upt.fContUptType}">
								<div title="变更表" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-change-base-detail.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}">
								<div title="纠纷信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-dispute-base.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty archiving.fToPosition}">
								<div title="归档位置" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-archiving-base.jsp" %>
								</div>
							</c:if>
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../check_history.jsp" />												
							</div>
					</div>
			
				</div>
			</div>
		
			
			<div class="win-left-bottom-div">
				<%-- <c:if test="${openType=='Endadd'||openType=='Endedit'}">
					<a href="javascript:void(0)" onclick="endingAddEditFrom();">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="endingFromSS()">
						<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if> --%>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">

flashtab('contract-formulation-add');

/* var pp = $('#contract-formulation-add').accordion('getSelected'); // 获取选中的面板（panel）
if (pp){
    pp.panel('refresh','new_content.php'); // 调用 'refresh' 方法加载新内容
} */

	//上传附件
	function ending_upFile(obj){
		//创建上传表单
		var files = obj.files;
		var formData = new FormData();
	    for(var i=0; i< files.length; i++){
	  	  formData.append("attFiles",files[i]);   
	  	} 
	    //ajax上传
		$.ajax({  
	    	url: base + '/Formulation/uploadAtt?serviceType=htzz' ,  
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
					        $('#tdfhtzz').append(
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
		    			$("#endingFiles").val(s);
			       	 	
		    	} else {
		    		alert(data.info);
		    		$('#tdfhtzz').append(
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
/* 	//删除附件
	function deleteAttac(obj){
		if(confirm("确认删除吗？")){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/attachment/delete/'+obj.id,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$(obj).parent().remove();
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			}); 
		}
	}	 */

	var c=0;
	/*	//附件上传
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
	} */
	
	var c1 =0;
	function upFile1() {
		c1 ++;
		var src = $('#a_fFileSrc1').val();
		$('#fi1').val(src);
		$('#f_a_f1').append("<div id='c1"+c1+"'><a href='#' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c1"+c1+")'>删除</a></div>");
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
			var row = $('#ending_dg').datagrid('getSelected');
			var selections = $('#ending_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#ending_dg").datagrid('reload');
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
				function endingAddEditFrom(){
					$("#end_stauts").val('0');
		    		$('#endingAddEditFrom').form('submit', {
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
		   						$('#endingAddEditFrom').form('clear');
		   						$("#ending_dg").datagrid('reload'); 
		   					}else{
		   						$.messager.alert('系统提示', data.info, 'error');
		   					}
		   				} 
		   			});		
				}
				function endingFromSS(){
					$("#end_stauts").val('1');
					$('#endingAddEditFrom').form('submit', {
										
		   				onSubmit: function(){ 
		   					flag=$(this).form('enableValidation').form('validate');
		   					if(flag){
		   						$.messager.progress();
		   					}
		   					return flag;
		   				}, 
		   				
		   				//url:base+'/demo/save',
		   				//data:{'fFlowStauts':'1'},
		   				success:function(data){
		   					if(flag){
		   						$.messager.progress('close');
		   					}
		   					data=eval("("+data+")");
		   					if(data.success){
		   						$.messager.alert('系统提示', data.info, 'info');
		   						closeWindow();
		   						$('#endingAddEditFrom').form('clear');
		   						$("#ending_dg").datagrid('reload');
		   						$('#indexdb').datagrid('reload'); 
		   					}else{
		   						$.messager.alert('系统提示', data.info, 'error');
		   					}
		   				} 
		   			});		
				}
				
				function BudgetIndexCode(){
					var win=creatFirstWin(' ',860,580,'icon-search','/Formulation/BudgetIndexCode');
					win.window('open');
				}
				function fPurchNo_DC(){
					var win=creatFirstWin(' ',840,450,'icon-search','/PurchaseApply/PurchNoList');
					win.window('open');
				}
				function fProCode_DC(){
					var win=creatFirstWin(' ',800,550,'icon-search','/Formulation/fProCode');
					win.window('open');
				}
				function quota_DC(){
					//var node=$('#ending_dg').datagrid('getSelected');
					var win=creatFirstWin('选择-预算指标编号',860, 580,'icon-add','/Formulation/BudgetIndexCode');
					win.window('open');
				}
	</script>
</body>