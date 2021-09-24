<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="${base}/resource-modality/js/echarts.min.js"></script>

<div class="win-div">
<form id="project_eval_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div data-options="region:'west',split:true">
			<div>
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:940px;margin-left: 20px;">
					<div title="项目支出信息" id="xmzcxxdiv" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table class="ystable" width="876" height="456" border="1">
							  <tr>
							    <td class="pro_plan_th" width="132" style="text-align: center">项目名称</td>
							    <td colspan="6" style="text-align: center">
							    	${bean.FProName}
							    	<input type="hidden" name="FProId" id="F_FProId" value="${bean.FProId}"/><!--隐藏域   项目的id -->
							    </td>
							  </tr>
							  <tr>
							    <td class="pro_plan_th" style="text-align: center">主管部门及代码</td>
							    <td colspan="2" style="text-align: center">${bean.managerDepartCode}</td>
							    <td  class="pro_plan_th" width="109" style="text-align: center">承担处室</td>
							    <td colspan="3" style="text-align: center">${sbbm}</td>
							  </tr>
							  <tr>
							    <td  class="pro_plan_th" rowspan="4" style="text-align: center">项目资金（万元）</td>
							    <td  class="pro_plan_th" width="137" style="text-align: center"></td>
							    <td class="pro_plan_th" width="154" style="text-align: center">预算数</td>
							    <td class="pro_plan_th" style="text-align: center">全年执行数</td>
							    <td class="pro_plan_th" width="113" style="text-align: center">分值</td>
							    <td class="pro_plan_th" width="98" style="text-align: center">执行率</td>
							    <td class="pro_plan_th" width="87" style="text-align: center">得分</td>
							  </tr>
							  <tr>
							    <td class="pro_plan_th" style="text-align: center">年度资金总额</td>
							    <td style="text-align: center">${expendbean.yearTotal}</td>
							    <td style="text-align: center">													
							    	<input class="easyui-textbox" type="text" id="F_ftoalYear"  name="ftoalYear"  required="required" data-options="validType:'length[1,20]'"  value=""/>
								</td>
							    <td style="text-align: center">
							    	<input class="easyui-textbox" type="text" id="F_ftotalGoal"  name="ftotalGoal"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_ftotalRate"  name="ftotalRate"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_ftotalScore"  name="ftotalScore"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							  </tr>
							  <tr>
							    <td class="pro_plan_th" style="text-align: center">财政拨款</td>
							    <td style="text-align: center">${expendbean.yearAmount1}</td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_fecoYear"  name="fecoYear"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_fecoGoal"  name="fecoGoal"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_fecoRate"  name="fecoRate"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_fecoScore"  name="fecoScore"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							  </tr>
							  <tr>
							    <td class="pro_plan_th" height="53" style="text-align: center">其他资金</td>
							    <td style="text-align: center">${expendbean.yearAmount2}</td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_fotherYear"  name="fotherYear"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_fotherGoal"  name="fotherGoal"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_fotherRate"  name="fotherRate"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							    <td style="text-align: center">
									<input class="easyui-textbox" type="text" id="F_fotherScore"  name="fotherScore"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							  </tr>
							  <tr>
							    <td class="pro_plan_th" rowspan="2" style="text-align: center">年度总体目标完成情况</td>
							    <td class="pro_plan_th" height="45" colspan="2" style="text-align: center">预期目标</td>
							    <td class="pro_plan_th" colspan="4" style="text-align: center">目标实际完成情况</td>
							  </tr>
							  <tr>
							    <td height="88" colspan="2" style="text-align: center">${goalbean.longGoal}</td>
							    <td colspan="4" style="text-align: center">
									<input style="width: 100%; height: 100%" class="easyui-textbox" type="text" id="F_fremark"  name="fremark"  required="required" data-options="validType:'length[1,20]'"  value=""/>
							    </td>
							  </tr>
							</table>
					</div>
					
					<div title="绩效指标信息" id="jxzbxxdiv" style="" data-options="iconCls:'icon-xxlb'">
						<table>
							<!-- <tr>
								<td class="td1"><span class="style1">*</span>自评负责人</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fevalUser"  name="fevalUser"  required="required" data-options="validType:'length[1,20]'" style="width: 150px" value=""/>
								</td>
								<td style="width: 0px"></td>
								<td class="td1"><span class="style1">*</span>自评方式</td>
								<td class="td2">
									<select id="F_fevalMethod" class="easyui-combobox" name="fevalMethod"  style="width: 150px;height:25px;" >
														<option value="" >-请选择-</option>
														<option value="1" >第三方评价</option>
														<option value="2" >自主评价</option>
														<option value="3" >其他</option>
													</select>
								</td>
							</tr> -->
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'ysgl09')" hidden="hidden">
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
											<a href='#' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
								</c:forEach>
								</td>
						</tr>
						</table>					
						<div>
							 <%@ include file="project_year_eval.jsp" %>
						</div>
		        	</div> 
				</div>	
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveEval()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	</div>
</form>
</div>

	<script type="text/javascript">
	//保存
	function saveEval() {
		// 在后台反序列话成采购明细Json的对象集合
		accept();
		
		var rows = $('#dg').datagrid('getRows');
		var data1 = [];
		var mingxi = "";
		for (var i = 0; i < rows.length; i++) {
			 data1.push({ "pid": rows[i].pid, "factFinish": rows[i].factFinish, 
     			"factGoal": rows[i].factGoal, "factScore": rows[i].factScore, 
     			"factRemark": rows[i].factRemark}); 
			 }
		mingxi = JSON.stringify(data1);
		$('#mingxiJson').val(mingxi);
		
		//alert(mingxi);
		//alert($('#F_FProId').val());
		
		//附件的路径地址
		var s="";
		$(".fileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files").val(s);


 		//提交
 		$('#project_eval_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					openAccordion();
				}
				return flag;
			},
			url : base + '/selfevaluation/evalsave',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					//$("#cgsq_apply_form").form("clear");
					 $("#eval_pro_tab").datagrid("reload");
				} else {
					$.messager.alert('系统提示', data.info, 'error');
					closeWindow();
					$('#project_eval_form').form('clear');
				}
			}
		});  
	
	}
	
	function accept() {
		if (endEditing()) {
			$('#dg').datagrid('acceptChanges');
		}
	}
	</script>
