<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
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
	
	/*---滚动条默认显示样式--*/
	::-webkit-scrollbar-thumb {
		background-color: #f0f5f7;
		height: 50px;
		outline-offset: -2px;
		outline: 2px solid #fff;
		-webkit-border-radius: 4px;
		border: 2px solid #fff;
	}
	
	/*---鼠标点击滚动条显示样式--*/
	::-webkit-scrollbar-thumb:hover {
		background-color: #f0f5f7;
		height: 50px;
		-webkit-border-radius: 4px;
	}
	
	/*---滚动条大小--*/
	::-webkit-scrollbar {
		width: 8px;
		height: 8px;
	}
	
	/*---滚动框背景样式--*/
	::-webkit-scrollbar-track-piece {
		background-color: #fff;
		-webkit-border-radius: 0;
	}
	
	</style>

	<div class="easyui-layout" fit="true">
		<form id="directly_reimburse_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
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
											<td class="td1"><span class="style1">*</span>报销人</td>

											<td class="td2"><input style="width: 150px;" id=""
												name="userName" class="easyui-textbox"
												value="${bean.userName}" readonly="readonly"></input>
											<td class="td4">
												<!-- 隐藏域 --> 
												<!-- 主键ID --><input type="hidden" name="drId" value="${bean.drId}" />
												<!-- 收款人主键ID --><input type="hidden" name="pId" value="${payeeBean.pId}"/>
												<!-- 报销单编号 --><input type="hidden" name="drCode" value="${bean.drCode}" />
												<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="drFlowStauts" />
												<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="drStauts" />
												<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
												<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
												<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
												<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="indexId"/>
												<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
											</td>

											<td class="td1"><span class="style1">*</span>报销部门</td>
											<td class="td2"><input style="width: 150px;"
												value="${bean.deptName}" readonly="readonly" id=""
												name="deptName" class="easyui-textbox"></input>
											</td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>报销类别</td>
											<td class="td2">
											<input style="width: 150px;"
												value="直接报销" readonly="readonly" id="drType"
												name="type" class="easyui-textbox"/>
											</td>

											<td style="width: 0px"></td>

											<td class="td1"><span class="style1">*</span>报销时间</td>

											<td class="td2"><input style="width: 150px;"
												id="directlyReimburseReqTime" name="reqTime" class="easyui-datebox"
												readonly="readonly" value="${bean.reqTime}"></input></td>
										</tr>

										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>支出项目</td>
											<td class="td2"><input type="text" style="width: 150px;"
												name="indexName" class="easyui-textbox"
												value="${bean.indexName}" id="indexName"
												data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo',handler: function(){openIndex()}}]"/>
											</td>

											<td style="width: 0px"></td>

											<td class="td1"><span class="style1">*</span>可用预算金额</td>
											<td class="td2"><input style="width: 150px;"
												name="" class="easyui-numberbox" id="indexAmount"
												data-options="precision:2,icons: [{iconCls:'icon-wanyuan'}]"
												value="${bean.indexAmount}" readonly="readonly" precision="2"></input></td>
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
														<img src="${base}/resource-modality/${themenurl}/sccg.png">
														&nbsp;&nbsp;&nbsp;&nbsp;
														<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</div>
												</c:forEach>
												</td>
										</tr>
										

										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;申请事由</p></td>
											<td colspan="4">
											<input class="easyui-textbox"data-options="multiline:true" name="reason" style="width:450px;height:70px;" value="${bean.reason}">
											
										</td>
									</tr>
								</table>
							</div>

							<div title="明细信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="directly_reimburse_mingxi.jsp" />
							</div>
							
							<div title="发票信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="directly_reimburse_invoice.jsp" />
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
											value="${payeeBean.amount}" readonly="readonly"/>
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
			if ($("#directlyReimburseReqTime").textbox().textbox('getValue') == "") {
				$("#directlyReimburseReqTime").textbox().textbox('setValue', 'date');
			}

		});


		//保存
		function saveReimburse(flowStauts) {
			// 在后台反序列话成明细Json的对象集合
			accept();
			var rows = $('#drmxdg').datagrid('getRows');
			var mingxi = "";
			for (var i = 0; i < rows.length; i++) {
				mingxi = mingxi + JSON.stringify(rows[i]) + ",";
			}
			$('#drMingxiJson').val(mingxi);
			
			// 在后台反序列话成发票Json的对象集合
			accept2();
			var rows2 = $('#drfpdg').datagrid('getRows');
			var fapiao = "";
			for (var i = 0; i < rows2.length; i++) {
				fapiao = fapiao + JSON.stringify(rows2[i]) + ",";
			}
			$('#drfpJson').val(fapiao);
			
			
			//附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s);

			//设置审批状态
			$('#drFlowStauts').val(flowStauts);
			//设置申请状态
			$('#drStauts').val(flowStauts);
			
			//报销类型为0直接报销
			$('#drType').textbox('setValue','0');
			

			//提交
			$('#directly_reimburse_save_form').form('submit', {
				onSubmit : function() {
					flag = $(this).form('enableValidation').form('validate');
					if (flag) {
						$.messager.progress();
					}
					return flag;
				},
				url : base + '/directlyReimburse/save',
				success : function(data) {
					if (flag) {
						$.messager.progress('close');
					}
					data = eval("(" + data + ")");
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#directly_reimburse_save_form').form('clear');
						$('#directlyReimbTab').datagrid('reload');
						$('#indexdb').datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
						$('#directly_reimburse_save_form').form('clear');
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
		        url:base+"/directlyReimburse/fileDelete?filename="+filename,
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
		
		//打开指标选择页面
		function openIndex() {
			var win = creatFirstWin('指标选择', 840, 450, 'icon-search', '/directlyReimburse/index');
			win.window('open');
		}
		
</script>
</body>
<script type="text/javascript">
//显示详情tab
</script>
</html>

