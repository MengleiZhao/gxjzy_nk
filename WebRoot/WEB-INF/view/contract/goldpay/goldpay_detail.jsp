<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="goldpay" action="${base}/Dispute/Save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="goldpayfcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fFlowStauts" id="goldpayfFlowStauts" value="${bean.fFlowStauts}"/>
	    		<input type="hidden" name="fContStauts" id="goldpayfContStauts" value="${bean.fContStauts}"/>
	    		<input type="hidden" name="fUserName" id="goldpayfUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="goldpayfUserCode" value="${bean.fUserCode}"/>
	    		<div class="tab-wrapper" id="contract-goldpay-update">
						<ul class="tab-menu">
							<li>合同信息</li>
							<li>签约方信息</li>
							<c:if test="${bean.fcType=='HTFL-01'}"><li onclick="$('#filing-edit-plan-dg').datagrid('reload')">付款计划</li></c:if>
							<c:if test="${!empty Upt.fContUptType}"><li onclick="$('#change-upt-datagrid').datagrid('reload')">变更表</li></c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}"><li>纠纷表</li></c:if>
							<%-- <c:if test="${!empty archiving.fToPosition}"><li>归档位置</li></c:if> --%>
							<c:if test="${!empty goldPay.fPayAmount||openType=='Gedit'}"><li >退还表</li></c:if>
							<li onclick="$('#check-history-dg').datagrid('reload')">审批记录</li>
						</ul>
						
						<div class="tab-content">
							<div title="合同信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-base2.jsp" %>
							</div>
							<div title="签约方信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../base/contract-formulation-sign-base-detail.jsp" %>
							</div>
							<c:if test="${bean.fcType=='HTFL-01'}">
								<div title="付款计划" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-filing-edit-plan-detail.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty Upt.fContUptType}">
								<div title="变更表" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-change-base-detail.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}">
								<div title="纠纷信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-dispute-base-detail.jsp" %>
								</div>
							</c:if>
							<%-- <c:if test="${!empty archiving.fToPosition}">
								<div title="归档位置" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-archiving-base.jsp" %>
								</div>
							</c:if> --%>
							<c:if test="${!empty goldPay.fPayAmount||openType=='Gedit'}">
								<div title="退还信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../base/contract-goldpay-base-detail.jsp" %>
								</div>
							</c:if>
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../check_history.jsp" />												
							</div>
						</div>
				
					</div>
	    		
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<%-- <c:if test="${openType=='Gadd'||openType=='Gedit'}">
					<a href="javascript:void(0)" onclick="GoldPaySaveForm();">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if> --%>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			 <jsp:include page="../../check_system.jsp" /> 
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">
flashtab('contract-goldpay-update');
	/* $(function() {
		new TextMagnifier({
			inputElem : '.inputElem4',
			align : 'right',
			splitType : [ 3, 3, 3, 3, 3, 3, 3 ],
		});
	});	 */
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
	    	url: base + '/Formulation/uploadAtt?serviceType=htbzj' ,  
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
					        $('#tdfhtbzj').append(
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
		    			$("#fhtbzjFiles").val(s);
			       	 	
		    	} else {
		    		alert(data.info);
		    		$('#tdfhtbzj').append(
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
	function GoldPaySaveForm(){
		//保证金类型选择校验
		var g=$('#goldpay_fWarType').combobox('getValue');
		if(g==null||g==''){
			$.messager.alert('系统提示', '请选择保证金类型！', 'info');
		}else{
			
	    	$('#goldpay').form('submit', {
					onSubmit:function(){ 
						
						flag=$(this).form('enableValidation').form('validate');
						if(flag){
	   						$.messager.progress();
	   					}
						return flag;
					}, 
					url:'${base}/GoldPay/save',
					type:'post',
					/* data:{'fFileSrc':$('#goldpayfFileSrc').val()}, */
					success:function(data){
						if(flag){
							$.messager.progress('close');
						}
						data=eval("("+data+")");
						if(data.success){
							$.messager.alert('系统提示', data.info, 'info');
							closeWindow();
							$('#goldpay_dg').form('clear');
							$('#goldpay_dg').datagrid('reload'); 
						}else{
							$.messager.alert('系统提示', data.info, 'error');
							closeWindow();
							$('#goldpay_dg').form('clear');
						}
					} 
				});
			}
		}
		function fPurchNo_DC(){
			//var node=$('#goldpaydg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#goldpaydg').datagrid('getSelected');
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
		//时间格式化
		function ChangeDateFormat1(val) {
			//alert(val)
		    var t, y, m, d, h, i, s;
		    if(val==null){
		  	  return "";
		    }
		    t = new Date(val);
		    y = t.getFullYear();
		    m = t.getMonth() + 1;
		    d = t.getDate();
		    h = t.getHours();
		    i = t.getMinutes();
		    s = t.getSeconds();
		    // 可根据需要在这里定义时间格式  
		    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) + ':' + (s < 10 ? '0' + s : s);
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