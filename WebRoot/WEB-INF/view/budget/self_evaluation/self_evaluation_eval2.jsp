<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<style>
input{width: 196px}
</style>


<form id="project_eval_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div style="border:1px #d9e3e7 solid;width: 976px;height: 507px" >

	<div style="width: 976px;height: 440px;overflow:auto;">
		<div class="easyui-accordion" style="width:936px;margin-left: 20px;">
			<div title="项目支出信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
				<table cellpadding="0" cellspacing="0" class="ourtable" >
					<tr>
						<td class="td1">项目名称</td>
						
						<td colspan="4">
							<input style="width: 555px;" id="" name="" class="easyui-textbox"
									value="${bean.FProName}" readonly="readonly"/>
						</td>
					</tr>
					
					<tr>
						<td class="td1">主管部门及代码</td>
						<td class="td2">
							<input style="width: 200px;" id="" name="" class="easyui-textbox"
									value="${bean.managerDepartCode}" readonly="readonly"/>
						</td>
						<td class="td3">
							<input type="hidden" name="FProId" id="F_FProId" value="${bean.FProId}"/><!--隐藏域   项目的id -->
							<input type="hidden" name="fgId" id="F_fgId" value="${actfinbean.fgId}"/><!--隐藏域   项目的id -->
						</td>
						<td class="td1">承担处室</td>
						<td class="td2">
							<input style="width: 200px;" id="" name="" class="easyui-textbox"
									value="${sbbm}" readonly="readonly"/>
						</td>
					</tr>
					
					<tr>
						<td colspan="5">项目资金-年度资金总额(万元)</td>
						
					</tr>
					
					<tr>
						<td class="td1">预算数</td>
						<td class="td2">
							<input class="easyui-numberbox" id="F_yearTotal"   data-options="validType:'length[1,20]',precision:2,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" value="${expendbean.yearTotal}" readonly="readonly"/>
						</td>
						<td class="td3"></td>
						<td class="td1"><span class="style1">*</span>全年执行数</td>
						<td class="td2">
							<input class="easyui-numberbox" type="text" id="F_ftoalYear"  value="${actfinbean.ftoalYear}"  name="ftoalYear"  required="required"    data-options="validType:'length[1,20]',onChange:setftotalRate,precision:2,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"/>
						</td>
					</tr>
					
					<tr>
						<td class="td1"><span class="style1">*</span>分制</td>
						<td class="td2">
							<select class="easyui-combobox" id="F_ftotalGoal"  name="ftotalGoal"   value="${actfinbean.ftotalGoal}"   required="required" style="width: 200px;"  data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
								<option value="100">百分制</option>
								<option value="10">十分制</option>
							</select>	
							<!-- <input class="easyui-numberbox" type="text" id="F_ftotalGoal"  name="ftotalGoal"  required="required" data-options="validType:'length[1,20]',precision:2"  value=""/> -->
						</td>
						<td class="td3"></td>
						<td class="td1"><span class="style1">*</span>执行率</td>
						<td class="td2">
							<!-- <div id="F_ftotalRate1" class="easyui-progressbar" data-options="value:0"  style="width:200px;height: 14px;"></div> -->
							<input class="easyui-numberbox" type="text" id="F_ftotalRate" readonly="readonly" name="ftotalRate"   value="${actfinbean.ftotalRate}"   required="required" data-options="validType:'length[1,20]',precision:2"  />
						</td>
					</tr>
					
					<tr>
						<td class="td1"><span class="style1">*</span>得分</td>
						
						<td colspan="4">
							<input class="easyui-numberbox" type="text" id="F_ftotalScore"  name="ftotalScore"   value="${actfinbean.ftotalScore}"    required="required" data-options="validType:'length[1,20]',precision:2,onChange:checkftotalScore"  />
						</td>
					</tr>
					
					<tr>
						<td colspan="5">项目资金-财政拨款(万元)</td>
						
					</tr>
					
					<tr>
						<td class="td1">预算数</td>
						<td class="td2">
							<input class="easyui-numberbox" id="F_yearAmount1" data-options="validType:'length[1,20]',icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"  value="${expendbean.yearAmount1}" readonly="readonly"/>
						</td>
						<td class="td3"></td>
						<td class="td1"><span class="style1">*</span>全年执行数</td>
						<td class="td2">
							<input class="easyui-numberbox" type="text" id="F_fecoYear"  name="fecoYear"   value="${actfinbean.fecoYear}"  required="required" data-options="validType:'length[1,20]',precision:2,onChange:setfecoRate,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"/>
						</td>
					</tr>
					
					<tr>
						<td class="td1"><span class="style1">*</span>分制</td>
						<td class="td2">
							<select class="easyui-combobox" id="F_fecoGoal"  name="fecoGoal"    value="${actfinbean.fecoGoal}"   required="required" style="width: 200px;" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']" >
								<option value="100">百分制</option>
								<option value="10">十分制</option>
							</select>	
							<!-- <input class="easyui-numberbox" type="text" id="F_fecoGoal"  name="fecoGoal"  required="required" data-options="validType:'length[1,20]',precision:2"  value=""/> -->
						</td>
						<td class="td3"></td>
						<td class="td1"><span class="style1">*</span>执行率</td>
						<td class="td2">
							<!-- <div id="F_fecoRate1" class="easyui-progressbar" data-options="value:0"  style="width:200px;height: 14px;"></div> -->
							<input class="easyui-numberbox" type="text" id="F_fecoRate"  name="fecoRate"   value="${actfinbean.fecoRate}"  readonly="readonly"  required="required" data-options="validType:'length[1,20]',precision:2"/>
						</td>
					</tr>
					
					<tr>
						<td class="td1"><span class="style1">*</span>得分</td>
						
						<td colspan="4">
							<input class="easyui-numberbox" type="text" id="F_fecoScore"  name="fecoScore"  value="${actfinbean.fecoScore}"   required="required" data-options="validType:'length[1,20]',precision:2,onChange:checkfecoScore"  />
						</td>
					</tr>
					
					
					<tr>
						<td colspan="5">项目资金-其他资金(万元)</td>
					</tr>
					
					<tr>
						<td class="td1">预算数</td>
						<td class="td2">
							<input class="easyui-numberbox" id="F_yearAmount2" data-options="validType:'length[1,20]',icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"  value="${expendbean.yearAmount2}" readonly="readonly"/>
						</td>
						<td class="td3"></td>
						<td class="td1">全年执行数</td>
						<td class="td2">
							<input class="easyui-numberbox" type="text" id="F_fotherYear"  name="fotherYear"  value="${actfinbean.fotherYear}"   data-options="validType:'length[1,20]',precision:2,onChange:setfotherRate,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"/>
						</td>
					</tr>
					
					<tr>
						<td class="td1"><span class="style1">*</span>分制</td>
						<td class="td2">
							<select class="easyui-combobox" id="F_fotherGoal"  name="fotherGoal"  required="required"  value="${actfinbean.fotherGoal}"   style="width: 200px;" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']" >
								<option value="100">百分制</option>
								<option value="10">十分制</option>
							</select>	
							<!-- <input class="easyui-numberbox" type="text" id="F_fotherGoal"  name="fotherGoal"   data-options="validType:'length[1,20]',precision:2"  value=""/> -->
						</td>
						<td class="td3"></td>
						<td class="td1"><span class="style1">*</span>执行率</td>
						<td class="td2">
							<!-- <div id="F_fotherRate1" class="easyui-progressbar" data-options="value:0"  style="width:200px;height: 14px;"></div> -->
							<input class="easyui-numberbox" type="text" id="F_fotherRate"  name="fotherRate"  value="${actfinbean.fotherRate}"   readonly="readonly"  data-options="validType:'length[1,20]',precision:2" />
						</td>
					</tr>
					
					<tr>
						<td class="td1"><span class="style1">*</span>得分</td>
						
						<td colspan="4">
							<input class="easyui-numberbox" type="text" id="F_fotherScore"  name="fotherScore"  value="${actfinbean.fotherScore}"    data-options="validType:'length[1,20]',precision:2,onChange:checkfotherScore"  />
						</td>
					</tr>
					
					<tr>
						<td colspan="5">年度总体目标完成情况</td>
					</tr>
					
					<tr>
						<td class="td1">预期目标</td>
						
						<td colspan="4">
							<input class="easyui-textbox" data-options="multiline:true"  readonly="readonly" value="${goalbean.longGoal}" style="width:555px;height:70px;" />
						</td>
					</tr>
					<tr style="height: 70px;">
						<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>目标实际完成情况</p></td>
						<td colspan="4">
							<%-- <input class="easyui-textbox" data-options="multiline:true" id="F_fremark"  name="fremark"  value="${actfinbean.fremark}"   required="required" data-options="validType:'length[0,200]'"  style="width:555px;height:70px;" /> --%>
							<textarea name="fremark"  id="F_fremark"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')" autocomplete="off"  style="width:555px;height:70px">${bean.fremark }</textarea>
						</td>
					</tr>
					<c:if test="${operation=='detail' }">
						<tr>
							<td align="right" colspan="10" style="padding-right: 10px;">
							可输入剩余数：<span id="textareaNum1" class="200">200
							</span>
							</td>
						</tr>
					</c:if>
					
				</table>
			</div>
			
			<div title="绩效指标信息" style="" data-options="iconCls:'icon-xxlb'">
				<table>
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
</form>

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
	function setfecoRate(){
		setRate('F_yearAmount1','F_fecoYear','F_fecoRate');
	}
	function setftotalRate(){
		setRate('F_yearTotal','F_ftoalYear','F_ftotalRate');
	}
	function setfotherRate(){
		setRate('F_yearAmount2','F_fotherYear','F_fotherRate');
	}
	//设置执行率
	function setRate(total,year,rate){
		var f_total=$('#'+total).val();
		var f_year=$('#'+year).val();
		var f_rate=f_year/f_total;
		if(f_rate>1){
			alert("全年执行数不能大于预算数");
			$('#'+year).numberbox('setValue','');
		}else{
			$('#'+rate).numberbox('setValue',f_rate);
		//	start2(rate+'1',f_rate);
		}
	}
	function start2(rate,f_rate) {
		 var v = parseFloat(f_rate)*100;
		 var value1 = $('#'+rate).progressbar().progressbar('getValue');  
	       if (value1 < v){  
	          value1 += Math.floor(Math.random() * 2);  
	          $('#'+rate).progressbar('setValue', value1);  
	               if(value1<=30){  
	                   $(".progressbar-value .progressbar-text").css("background-color","#DF4134");  
	               }else if (value1<=70){  
	                   $(".progressbar-value .progressbar-text").css("background-color","#EABA0A");  
	               }else if (value1>70){  
	                   $(".progressbar-value .progressbar-text").css("background-color","#53CA22");  
	               }
	             
	           setTimeout(arguments.callee, 30);  
	       } 
	}
	
	
	function checkftotalScore(){
		checkScore('F_ftotalGoal','F_ftotalScore');
	}
	function checkfecoScore(){
		checkScore('F_fecoGoal','F_fecoScore');
	}
	function checkfotherScore(){
		checkScore('F_fotherGoal','F_fotherScore');
	}
	//校验分数
	function checkScore(goal,score){
		var f_goal=$('#'+goal).val();
		var f_scorer=$('#'+score).val();
		var value=f_scorer-f_goal;
		if(f_scorer<0){
			alert("得分不能小于零");
			$('#'+score).numberbox('setValue','');
		}
		if(value>0){
			alert("得分不能大于分制");
			$('#'+score).numberbox('setValue','');
		}
	}
	</script>
