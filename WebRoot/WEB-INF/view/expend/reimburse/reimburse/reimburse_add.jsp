<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>


	<div class="easyui-layout" fit="true">
		<form id="reimburse_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
			<div data-options="region:'west',split:true" style="width:600px;border-color: #dce5e9" id="westDiv">
				<table>
					<tr>
						<td style="height: 50px;">
						
						</td>
					</tr>

					<tr>
						<td>
							<div class="easyui-accordion" data-options="" id="easyAcc" style="width:555px;margin-left: 20px">
								<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>事前申请单号</td>
											<td colspan="4">
												<input type="text" style="width: 150px;"
												name="gCode" class="easyui-textbox"
												value="${bean.gCode}" id=""
												data-options="prompt: '事前申请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){openApply(${bean.type})}}]"/>
											</td>
										</tr>
									
									
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>报销人</td>

											<td class="td2">
												<input style="width: 150px;" id="" name="userName" class="easyui-textbox"
												value="${bean.userName}" readonly="readonly"></input>
											<td class="td4">
												<!-- 隐藏域 --> 
												<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
												<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}" id="rId"/>
												<!-- 收款人主键ID --><input type="hidden" name="pId" value="${payeeBean.pId}"/>
												<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
												<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
												<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
												<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
												<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
												<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" />
												<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
												<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id=""/>
											</td>

											<td class="td1"><span class="style1">*</span>报销部门</td>
											<td class="td2">
												<input style="width: 150px;" id="" name="deptName" class="easyui-textbox"
												value="${bean.deptName}" readonly="readonly"></input></td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>报销事项</td>
											<td class="td2">
											<select id="reimburseType" class="easyui-combobox" name="type" style="width: 150px;">
													<option value="1">通用事项报销</option>
													<option value="2">会议报销</option>
													<option value="3">培训报销</option>
													<option value="4">差旅报销</option>
													<option value="5">接待报销</option>
											</select></td>

											<td style="width: 0px"></td>

											<td class="td1"><span class="style1">*</span>报销时间</td>

											<td class="td2"><input style="width: 150px;"
												id="reimburseReqTime" name="reimburseReqTime" class="easyui-datebox"
												readonly="readonly" value="${bean.reimburseReqTime}"></input></td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>支出项目</td>
											<td class="td2"><input type="text" style="width: 150px;"
												name="indexName" class="easyui-textbox"
												value="${bean.indexName}" id="" readonly="readonly"/>
											</td>

											<td style="width: 0px"></td>

											<td class="td1"><span class="style1">*</span>可用预算金额</td>
											<td class="td2"><input style="width: 150px;"
												name="indexAmount" class="easyui-numberbox" id=""
												data-options="precision:2,icons: [{iconCls:'icon-wanyuan'}]"
												value="" readonly="readonly"></input>
											</td>
										</tr>

										<tr class="trbody">
											<td class="td1">
												&nbsp;&nbsp;附件
												<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl03')" hidden="hidden">
												<input type="text" id="files" name="files" hidden="hidden">
											</td>
											<td colspan="4" id="tdf">
												<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
													<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
												</a>
												<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
													<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
												 	</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
												</div>
												<c:forEach items="${attac}" var="att">
													<div style="margin-top: 10px;">
														<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
														&nbsp;&nbsp;&nbsp;&nbsp;
														<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
														&nbsp;&nbsp;&nbsp;&nbsp;
														<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</div>
												</c:forEach>
												</td>
										</tr>
										

										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;报销事由</p></td>
											<td colspan="4">
											<input class="easyui-textbox"data-options="multiline:true" name="reimburseReason" style="width:450px;height:70px;" value="${bean.reimburseReason}">
											
										</td>
									</tr>
								</table>
							</div>


							<div title="会议信息" data-options="iconCls:'icon-xxlb'"
								style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../apply/check/meetingCheck.jsp" />
							</div>

							<div title="培训信息" data-options="iconCls:'icon-xxlb'"
								style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../apply/check/trainingCheck.jsp" />
							</div>

							<div title="差旅信息" data-options="iconCls:'icon-xxlb'"
								style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../apply/check/travelCheck.jsp" />
							</div>

							<div title="接待信息" data-options="iconCls:'icon-xxlb'"
								style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../apply/check/receptionCheck.jsp" />
							</div>

							<div title="报销明细" data-options="iconCls:'icon-xxlb'"
								style="overflow:auto;margin-top: 10px;">
								<jsp:include page="reimburse_mingxi.jsp" />
							</div>
							
							<div title="发票信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="reimburse_invoice.jsp" />
							</div>
							
							<div title="收款人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<table cellpadding="0" cellspacing="0" class="ourtable">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>收款人</td>

										<td class="td2">
											<input style="width: 150px;" id="" name="payee" class="easyui-textbox"
											value="${payeeBean.payee}"/>
										</td>
										<td class="td4">
										</td>

										<td class="td1"><span class="style1">*</span>身份证号</td>
										<td class="td2">
											<input style="width: 150px;" id="" name="idCard" class="easyui-textbox"
											value="${payeeBean.idCard}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>账户</td>

										<td class="td2">
											<input style="width: 150px;" id="" name="account" class="easyui-numberbox"
											value="${payeeBean.account}"/>
										</td>
										<td class="td4">
										</td>

										<td class="td1"><span class="style1">*</span>开户银行</td>
										<td class="td2">
											<input style="width: 150px;" id="" name="bank" class="easyui-textbox"
											value="${payeeBean.bank}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>应付金额</td>

										<td colspan="4">
											<input style="width: 150px;" id="num2" name="amount" class="easyui-numberbox"
											value="${payeeBean.amount}" readonly="readonly" precision="2"/>
										</td>
									</tr>
									
								</table>
							</div>
									
							</div>
						</td>
					</tr>

				</table>
			</div>

			<div data-options="region:'center',split:true"
				style="width: 8xp;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7"></div>



			<div data-options="region:'east',split:true" style="width:190px;border-color: #dce5e9">
				<jsp:include page="../../checkAndCheter.jsp" />
			</div>
			
			<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
					<div style="width:598px;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 0px">
						<a href="javascript:void(0)" onclick="saveReimburse(0)">
							<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="saveReimburse(1)">
							<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>&nbsp;&nbsp;
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
		//显示详细信息手风琴页面
		$(document).ready(function() {
			//设值时间
			if ($("#rId").val() == "") {
				$("#reimburseReqTime").textbox().textbox('setValue', 'date');
			}

			var h = $("#reimburseTypeHi").textbox().textbox('getValue');
			if (h != "") {
				$('#reimburseType').textbox().textbox('setValue', h);
				$('#reimburseType').textbox().attr('readonly', true);
			}

			if (h == 1) {
				$("#easyAcc").accordion().accordion('remove', '会议信息');
				$("#easyAcc").accordion().accordion('remove', '培训信息');
				$("#easyAcc").accordion().accordion('remove', '差旅信息');
				$("#easyAcc").accordion().accordion('remove', '接待信息');
				
				$("#meetingSteps").remove();
				$("#trainingSteps").remove();
				$("#travelSteps").remove();
				$("#receptionSteps").remove();
			}
			if (h == 2) {
				$("#easyAcc").accordion().accordion('remove', '培训信息');
				$("#easyAcc").accordion().accordion('remove', '差旅信息');
				$("#easyAcc").accordion().accordion('remove', '接待信息');
				
				$("#generalSteps").remove();
				$("#trainingSteps").remove();
				$("#travelSteps").remove();
				$("#receptionSteps").remove();
			}
			if (h == 3) {
				$("#easyAcc").accordion().accordion('remove', '会议信息');
				$("#easyAcc").accordion().accordion('remove', '差旅信息');
				$("#easyAcc").accordion().accordion('remove', '接待信息');
				
				$("#generalSteps").remove();
				$("#meetingSteps").remove();
				$("#travelSteps").remove();
				$("#receptionSteps").remove();
			}
			if (h == 4) {
				$("#easyAcc").accordion().accordion('remove', '会议信息');
				$("#easyAcc").accordion().accordion('remove', '培训信息');
				$("#easyAcc").accordion().accordion('remove', '接待信息');
				
				$("#generalSteps").remove();
				$("#trainingSteps").remove();
				$("#meetingSteps").remove();
				$("#receptionSteps").remove();
			}
			if (h == 5) {
				$("#easyAcc").accordion().accordion('remove', '会议信息');
				$("#easyAcc").accordion().accordion('remove', '培训信息');
				$("#easyAcc").accordion().accordion('remove', '差旅信息');
				
				$("#generalSteps").remove();
				$("#trainingSteps").remove();
				$("#travelSteps").remove();
				$("#meetingSteps").remove();
			}
		});


		//保存
		function saveReimburse(flowStauts) {
			// 在后台反序列话成明细Json的对象集合
			accept();
			var rows = $('#rmxdg').datagrid('getRows');
			var mingxi = "";
			for (var i = 0; i < rows.length; i++) {
				mingxi = mingxi + JSON.stringify(rows[i]) + ",";
			}
			$('#rMingxiJson').val(mingxi);
			
			// 在后台反序列话成发票Json的对象集合
			accept2();
			var rows2 = $('#rfpdg').datagrid('getRows');
			var fapiao = "";
			for (var i = 0; i < rows2.length; i++) {
				fapiao = fapiao + JSON.stringify(rows2[i]) + ",";
			}
			$('#rfpJson').val(fapiao);
			
			
			//附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s);


			//设置审批状态
			$('#reimburseFlowStauts').val(flowStauts);
			//设置报销状态
			$('#reimburseStauts').val(flowStauts);

			//提交
			$('#reimburse_save_form').form('submit', {
				onSubmit : function() {
					flag = $(this).form('enableValidation').form('validate');
					if (flag) {
						$.messager.progress();
					}
					return flag;
				},
				url : base + '/reimburse/save',
				success : function(data) {
					if (flag) {
						$.messager.progress('close');
					}
					data = eval("(" + data + ")");
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#reimburse_save_form').form('clear');
						$('#reimburseTab').datagrid('reload');
						$('#indexdb').datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
						$('#reimburse_save_form').form('clear');
					}
				}
			});
		}

		
		//附件删除AJAX
		function deleteAttac(a){
			var filename = a.id;
			filename = encodeURI(encodeURI(filename));  
			$.ajax({
				type:"POST",
		        url:base+"/reimburse/fileDelete?filename="+filename,
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
		
		
		//寻找相关制度
		function findSystemFile(id) {
			$.ajax({ 
				url: base+"/cheter/systemFind?id="+id, 
				success: function(data){
					data=data.replace('\"','');
					data=data.replace('\"','');
					window.open(data);
		    }});
		}
		
		//打开事前申请选择页面
		function openApply(applyType) {
			var win = creatFirstWin('指标选择', 840, 450, 'icon-search', '/reimburse/applyList?applyType='+applyType);
			win.window('open');
		}
		
		//选择申请单
		function choiceApply(gId,applyType){
			$.ajax({
			      type:'post',
			      url:base+'/reimburse/findApply?gId='+gId,
			      dataType: 'json',
			      success:function(data){
			    		$('#reimburse_save_form').form('load', data);
			    	  	$('#rmxdg').datagrid({url:base+'/apply/mingxi'});
			    	  	$('#rmxdg').datagrid('reload',{
							id:data.gId
						});
			      }
			});
			if(applyType==2||applyType==3){
				$.ajax({
				      type:'post',
				      url:base+'/reimburse/findOther?gId='+gId+'&type='+applyType,
				      dataType: 'json',
				      success:function(data){
				    		$('#reimburse_save_form').form('load', data);
				      }
				});
			}
			if(applyType==4){
				$.ajax({
				      type:'post',
				      url:base+'/reimburse/findOther?gId='+gId+'&type='+applyType,
				      dataType: 'json',
				      success:function(data){
				    		$('#reimburse_save_form').form('load', data);
				      }
				});
			}
			if(applyType==5){
				$.ajax({
				      type:'post',
				      url:base+'/reimburse/findOther?gId='+gId+'&type='+applyType,
				      dataType: 'json',
				      success:function(data){
				    		$('#reimburse_save_form').form('load', data);
				    		
				    		$('#rpt').datagrid({url:base+'/apply/recep'});
				    		$('#rpt').datagrid('reload',{
								id:data.jId
							});
				      }
				});
			}
			closeFirstWindow();
		}
		
		
</script>
</body>
<script type="text/javascript">
//显示详情tab
</script>
</html>

