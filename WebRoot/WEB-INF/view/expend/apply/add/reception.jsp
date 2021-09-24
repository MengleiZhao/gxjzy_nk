<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访单位</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="receptionObject"
			value="${receptionBean.receptionObject}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访日期</td>
		<td class="td2">
			<input class="easyui-datebox" style="width: 200px; height: 30px;" id="reDateStart" name="reDateStart"
			data-options="" value="${receptionBean.reDateStart}" required="required" editable="false"/>
		</td>
		<%-- <td class="td1"><span class="style1">*</span> 接待对象人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 238px; height: 30px;" name="rePeopNum" id="rePeopNum"
			value="${receptionBean.rePeopNum}" data-options="required:true,validType:'length[1,5]'"/>
		</td> --%>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访活动名称</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="receptionContent"
			value="${receptionBean.receptionContent}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 120px"><span class="style1">*</span> 来访单位带队领导姓名</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="diningPlacePlan1"
			value="${receptionBean.diningPlacePlan1}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 120px"><span class="style1">*</span> 来访单位带队领导职务</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" name="diningPlacePlan2"
			value="${receptionBean.diningPlacePlan2}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1"  style="width: 70px"><span class="style1">*</span>领导级别</td>
		<td class="td2" >
		<select id="receptionLevels1" class="easyui-combobox"
			name="receptionLevel1" style="width: 230px; height: 30px;" data-options="required:true,onChange:onselectjb" editable="false">
				<option value="1" <c:if test="${receptionBean.receptionLevel1=='1'}"> selected="selected" </c:if>>省部级</option>
				<option value="2" <c:if test="${receptionBean.receptionLevel1=='2'}"> selected="selected" </c:if>>司局级</option>
				<option value="3" <c:if test="${receptionBean.receptionLevel1=='3'}"> selected="selected" </c:if>>处级以下（含处级）</option>
			</select>

		</td>
	</tr>
	<tr class="trbody">
	 <td class="td1" style="width: 70px"><span class="style1">*</span> 随行人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 230px; height: 30px;" id="attendPeopNum" name="attendPeopNum"
			value="${receptionBean.attendPeopNum}" data-options="required:true,validType:'length[1,5]'"/>
		</td> 
		<td class="td1" style="width: 70px"><span class="style1">*</span> 陪餐人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 230px; height: 30px;" id="diningPlacePlan3" name="diningPlacePlan3"
			value="${receptionBean.diningPlacePlan3}" data-options="required:true,validType:'length[1,5]',onChange:selectpcrs"/>
		</td>
	</tr>
	<tr class="trbody">
	 <td class="td1" style="width: 70px"><span class="style1">*</span> 用餐总人数</td>
		<td class="td2">
			<input class="easyui-numberbox" id="rePeopNums" style="width: 230px; height: 30px;" name="rePeopNum" 
			value="${receptionBean.rePeopNum}" data-options="onChange:selectrs,required:true,validType:'length[1,5]'"/>
		</td> 
		<td class="td1" style="width: 70px"><span class="style1">*</span> 用餐地点类型</td>
		<td class="td2">
			<select id="receptionLevel" class="easyui-combobox"
			name="receptionLevel" style="width: 230px; height: 30px;" data-options="required:true,onChange:onselect" editable="false">
				<option value="1" <c:if test="${receptionBean.receptionLevel=='1'}"> selected="selected" </c:if>>学校内部</option>
				<option value="2" <c:if test="${receptionBean.receptionLevel=='2'}"> selected="selected" </c:if>>学校外部</option>
				<%-- <option value="3" <c:if test="${receptionBean.receptionLevel=='3'}"> selected="selected" </c:if>>执行任务</option>
				<option value="4" <c:if test="${receptionBean.receptionLevel=='4'}"> selected="selected" </c:if>>学习交流</option>
				<option value="5" <c:if test="${receptionBean.receptionLevel=='5'}"> selected="selected" </c:if>>检查指导</option>
				<option value="6" <c:if test="${receptionBean.receptionLevel=='6'}"> selected="selected" </c:if>>请示汇报工作</option>
				<option value="7" <c:if test="${receptionBean.receptionLevel=='7'}"> selected="selected" </c:if>>其他</option> --%>
			</select>
		</td>
	</tr>
	 <tr class="trbody">
		<td class="td1"  style="width: 70px"><span class="style1">*</span>用餐地点</td>
		<td class="td2" >
		<input class="easyui-textbox" style="width: 230px; height: 30px;" id= "diningPlace" name="diningPlace"
			value="${receptionBean.diningPlace}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 费用预算</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 230px; height: 30px;" name="amount" id="amount" 
			value="${bean.amount}" data-options="required:true,validType:'length[1,25]'"/> <!-- ,onChange:selectbx -->
		</td>
	</tr>
	<%-- <tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span>开始时间</td>
		<td class="td2">
			<input style="width: 230px; height: 30px;" id="reDateStart"
			name="reDateStart" class="easyui-datebox"
			data-options="required:true"
			value="${receptionBean.reDateStart}" editable="false"/>
		</td>
		<td class="td1" style="width: 70px">结束时间</td>
		<td class="td2">
			<input style="width: 238px; height: 30px;" id="reDateEnd"
			name="reDateEnd" class="easyui-datebox"
			data-options="onSelect:onSelect8,required:true" value="${receptionBean.reDateEnd}" editable="false"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 接待天数</td>
		<td class="td2">
			<input style="width: 230px; height: 30px;" id="reDayNum"
			name="reDayNum" class="easyui-numberbox"
			value="${receptionBean.reDayNum}" readonly="readonly" data-options="required:true,validType:'length[1,2]'"/>
		</td>		
	</tr> --%>

<%-- 	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span>就餐安排</td>
		<td class="td2" colspan="3" >
		<input type="checkbox" onclick="someCheck1()" value="宴请" name="box" id="box1" <c:if test="${receptionBean.diningPlacePlan1=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>宴请
		<input type="hidden" id="diningPlacePlan1" name="diningPlacePlan1" value="${receptionBean.diningPlacePlan1}" />
		<input type="checkbox" onclick="someCheck2()" value="工作餐" name="box" id="box2" <c:if test="${receptionBean.diningPlacePlan2=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>工作餐
		<input type="hidden" id="diningPlacePlan2" name="diningPlacePlan2"  value="${receptionBean.diningPlacePlan2}"/>
		</td>

	</tr> --%>
<%-- 	<tbody id="tr0">
		<tr class="trbody">
			<td class="td1" style="width: 70px"><span class="style1">*</span>工作餐就餐地点</td>
					<td class="td2">
				<input style="width: 230px; height: 30px;" id="diningPlace"
				name="diningPlace" class="easyui-textbox"
				value="${receptionBean.diningPlace}" data-options="required:false,validType:'length[1,100]'"/>
			</td>
		</tr>
	</tbody>
	<tbody  id="tr1" >
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span>宴请时间</td>
		<td class="td2" >
			<input style="width: 230px; height: 30px;" id="fFeteTime"
			name="fFeteTime" class="easyui-datebox"
			data-options="onChange:fFeteTimeAmong"
			value="${receptionBean.fFeteTime}" editable="false"/>
		</td>
	</tr>
	<tr class="trbody"  >
		<td class="td1" style="width: 70px"><span class="style1">*</span>宴请地点</td>
		<td colspan="3">
			<input class="easyui-textbox" id="unitFeteSite" 
			name="unitFeteSite" style="width:606px; height: 30px;"
			value="${receptionBean.unitFeteSite}" data-options="required:false,validType:'length[1,250]'"/>
			</td>
	</tr>

	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span>宴请人数</td>
		<td class="td2">
			<input style="width: 238px; height: 30px;" id="unitFeteNum"
			name="unitFeteNum" class="easyui-numberbox"
			value="${receptionBean.unitFeteNum}" data-options="required:false,validType:'length[1,100]'"/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 陪餐人数</td>
		<td class="td2">
			<input style="width: 238px; height: 30px;" id="attendPeopNum" name="attendPeopNum" class="easyui-numberbox" 
			value="${receptionBean.attendPeopNum}" data-options="required:false,validType:'length[1,5]'"/>
		</td>
	</tr>
	</tbody> --%>
	<tr class="trbody">
		<td class="td1"  style="width: 70px"><span class="style1">*</span> 经办人</td>
		<td class="td2" >
		<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${bean.userNames}" style="width: 230px;height: 30px;margin-left: 10px " >
		</td>
		<td class="td1"  style="width: 70px"><span class="style1">*</span> 部门名称</td>
		<td class="td2" >
		<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 238px;height: 30px;margin-left: 10px " >
		</td>
	</tr>
	
	<tr id="b1">
		<td colspan="3" >
			<p style="font-weight: bold;color: red;">用餐地点类型为学校内部：省部级领导同志及其随员每人不高于160元</p> 
		</td>
	</tr>
	 <tr id="b2" >
	 	<td colspan="3" >
			<p style="font-weight: bold;color: red;">用餐地点类型为学校内部：司局级干部及其随员每人不高于120元</p> 
		</td>
	</tr>
	<tr id="b3" >
		<td colspan="3" >
			<p style="font-weight: bold;color: red;">用餐地点类型为学校内部：处级以下（含处级）干部每人不高于90元</p> 
		</td>
	</tr>
	<tr id="b4" >
		<td colspan="3" >
			<p style="font-weight: bold;color: red;">用餐地点为学校外部：省部级领导同志及其随员每人不高于200元</p> 
		</td>
	</tr>
	<tr id="b5" >
		<td colspan="3" >
			<p style="font-weight: bold;color: red;">用餐地点为学校外部：司局级干部及其随员每人不高于150元</p> 
		</td>
	</tr>
	<tr id="b6" >
		<td colspan="3" >
			<p style="font-weight: bold;color: red;">用餐地点为学校外部：处级以下（含处级）干部每人不高于130元</p> 
		</td>
	</tr> 
	<%-- <tr style="height: 70px;">
		<td class="td1" style="width: 70px;"><span class="style1">*</span>接待事由</td>
		<td colspan="3">
			<textarea name="receptionContent"  id="receptionContent" class="textbox-text"   autocomplete="off" 
			  style="width:600px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${receptionBean.receptionContent}</textarea>
		</td>
	</tr> --%>
	<%-- <tr>
		<td class="td1" style="width:75px;"><span class="style1">*</span>
			接待公函及其他附件 <input type="file" multiple="multiple" id="jdgh"
			onchange="upladFileMoreParams(this,'jdgh','zcgl01','jdghprogressNumber','jdghpercent','jdghtdf','jdghfiles','jdghprogid','jdghfileUrl')" hidden="hidden"> <input
			type="text" id="jdghfiles" name="jdghfiles" hidden="hidden"></td>
		<td colspan="3" id="jdghtdf">&nbsp;&nbsp; <a onclick="$('#jdgh').click()"
			style="font-weight: bold;  " href="#"> <img
				style="vertical-align:bottom;margin-bottom: 5px;"
				src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
				onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
			<div id="jdghprogid"
				style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
				<div id="jdghprogressNumber"
					style="background:#3AF960;width:0px;height:10px"></div>
				文件上传中...&nbsp;&nbsp;<font id="jdghpercent">0%</font>
			</div> <c:forEach items="${attaList}" var="att">
			<c:if test="${att.serviceType=='jdgh' }">
				<div style="margin-top: 5px;">
					<a href='${base}/attachment/download/${att.id}'
						style="color: #666666;font-weight: bold;">${att.originalName}</a>
					&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
						src="${base}/resource-modality/${themenurl}/sccg.png">
					&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="jdghfileUrl" href="#"
						style="color:red" onclick="deleteAttac(this)">删除</a>
				</div>
			</c:if>
			</c:forEach>
		</td>
	</tr> --%>
<input  type="hidden" id="totalPerson" />
<script type="text/javascript">
function foreignYes(){
	var level =$('#receptionLevel1').combobox('getValue');
	var indexId = $('#F_fBudgetIndexCode').val();
	if(level=='2'){
		$('#check_system_div').load('${base}/apply/refreshGwjdProcess?fpPype=1&indexId='+indexId+'');
	}
	$('#rec-food-dg').datagrid('hideColumn', 'time');
	$('#rec-food-dg').datagrid('showColumn', 'date');
	if(${bean.gId==''||bean.gId==null}){
		var data = new Array();
		$('#rec-food-dg').datagrid('loadData',data);
		$("#costFood").numberbox('setValue','');
		$("#costFoodStd").val('');
	}else{
		var costFood =$("#costFoodVal").val();
		var costFoodStd=$("#costFoodStdVal").val();
		$('#rec-food-dg').datagrid('reload');
		$("#costFood").numberbox('setValue',costFood);
		$("#costFoodStd").val(costFoodStd);
	}
}
function foreignNo(){
	var level =$('#receptionLevel1').combobox('getValue');
	var indexId = $('#F_fBudgetIndexCode').val();
	if(level=='2'){
		$('#check_system_div').load('${base}/apply/refreshGwjdProcess?fpPype=2&indexId='+indexId+'');
	}
	$('#rec-food-dg').datagrid('showColumn', 'time');
	$('#rec-food-dg').datagrid('hideColumn', 'date');
	if(${bean.gId==''||bean.gId==null}){
		var data = new Array();
		$('#rec-food-dg').datagrid('loadData',data);
		$("#costFood").numberbox('setValue','');
		$("#costFoodStd").val('');
	}else{
		var costFood =$("#costFoodVal").val();
		var costFoodStd=$("#costFoodStdVal").val();
		$('#rec-food-dg').datagrid('reload');
		$("#costFood").numberbox('setValue',costFood);
		$("#costFoodStd").val(costFoodStd);
	}
}	
function reloadProcess() {
	var indexId = $('#F_fBudgetIndexCode').val();
	var level =$('#receptionLevel1').combobox('getValue');
	var isForeign =$('input[name="isForeign"]:checked').val();
	if(level!=''&&isForeign!=''&&isForeign!=null){
		if(level=='1'){
			$('#check_system_div').load('${base}/apply/refreshGwjdProcess?fpPype=0&indexId='+indexId+'');
		}
		if(level=='2'){
			if(isForeign=='1'){
				$('#check_system_div').load('${base}/apply/refreshGwjdProcess?fpPype=1&indexId='+indexId+'');
			}else{
				$('#check_system_div').load('${base}/apply/refreshGwjdProcess?fpPype=2&indexId='+indexId+'');
			}
		}
	}
}

	$(document).ready(function() {
		var diningPlace = $("#receptionLevel").val();
		var receptionLevel1 = $("#receptionLevels1").val();
		var yxdz = $("#diningPlace").val();
		if(diningPlace == '1'){
			if(yxdz == ''){
				$("#diningPlace").val("学校食堂");
			}
			if(receptionLevel1 == '1'){
				$('#b1').show();
				$('#b4').hide();
				$('#b2').hide();
				$('#b3').hide();
				$('#b5').hide();
				$('#b6').hide();
			}else if(receptionLevel1 == '2'){
				$('#b2').show();
				$('#b1').hide();
				$('#b5').hide();
				$('#b3').hide();
				$('#b4').hide();
				$('#b6').hide();
			}else{
				$('#b3').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b6').hide();
				$('#b4').hide();
				$('#b5').hide();
			}
		}else{
			if(receptionLevel1 == '1'){
				$('#b4').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b3').hide();
				$('#b5').hide();
				$('#b6').hide();
			}else if(receptionLevel1 == '2'){
				$('#b5').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b3').hide();
				$('#b4').hide();
				$('#b6').hide();
			}else{
				$('#b6').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b5').hide();
				$('#b4').hide();
				$('#b3').hide();
			}
		}
		$('#F_fBudgetIndexName').textbox({
			onChange : function(newValue, oldValue) {
				reloadProcess();
			}
		});
	});
//var cxjk = $('input[name="withLoans"]:checked').val();	
	var yanqing = "";
	var zhengcan = "";
	var zaocan = "";
	var stdArr =new Array();
	var stdArrWb = new Array();
	//支出标准获取
	function zcbz() {

		$.ajax({
			url : base + "/hotelStandard/calcCost?outType=recep",
			type : 'post',
			async : true,
			dataType : 'json',
			contentType : 'application/json;charset=UTF-8',
			success : function(json) {
				for (var i = 0; i < json.length; i++) {
					var costDetail = json[i].costDetail;
					if(costDetail == "宴请"||costDetail == "早餐"||costDetail == "正餐"){
						var costStd = {};
						costStd.id =costDetail;
						costStd.text =costDetail;
						costStd.std = parseInt(json[i].standard);
						stdArr.push(costStd);
					}else{
						var costStdWb ={};
						costStdWb.id =costDetail;
						costStdWb.text =costDetail;
						costStdWb.std = parseInt(json[i].standard);
						stdArrWb.push(costStdWb);
						
					}
					
					
				}
			}
		});
	}




	$(function() {
		zcbz();
		$("#receptionLevel1").combobox(
				{
					onChange : function(newValue, oldValue) {
						var isForeign = $('input[name="isForeign"]:checked').val();	
						var indexId = $('#F_fBudgetIndexCode').val();
						if(newValue=='1'){
							$('#check_system_div').load('${base}/apply/refreshGwjdProcess?fpPype=0&indexId='+indexId+'');
						}
						if(newValue=='2'){
							if(isForeign=='1'){
								$('#check_system_div').load('${base}/apply/refreshGwjdProcess?fpPype=1&indexId='+indexId+'');
							}else{
								$('#check_system_div').load('${base}/apply/refreshGwjdProcess?fpPype=2&indexId='+indexId+'');
							}
						}
					}
				});
		$("#rePeopNum").numberbox(
				{
					onChange : function(newValue, oldValue) {
						var data = new Array();
						$('#rec-food-dg').datagrid('loadData',data);
						editIndex1 = undefined;
					}
				});
	});


	function requiredValidatebox() {
		var fFeteTime = $("#fFeteTime").datebox('getValue');
		var unitFeteSite = $("#unitFeteSite").textbox('getValue');
		var unitFeteNum = $("#unitFeteNum").numberbox('getValue');
		var attendPeopNum = $("#attendPeopNum").numberbox('getValue');
		if (fFeteTime == '' || unitFeteSite == '' || unitFeteNum == ''
				|| attendPeopNum == '') {
			return false;
		}
		return true;
	}

	function fFeteTimeAmong(newVal, oldVal) {
		var reDateStart = $("#reDateStart").datebox('getValue');
		var reDateEnd = $("#reDateEnd").datebox('getValue');
		var maxTime = Date.parse(new Date(reDateEnd));
		var minTime = Date.parse(new Date(reDateStart));
		var startday = Date.parse(new Date(newVal));
		if (!isNaN(startday)) {
			if ((startday >= minTime && startday <= maxTime)) {
			} else {
				alert("所选时间不在接待时间范围内请重新选择！");
				$("#fFeteTime").datebox('setValue', "");
			}

		}
	}
	
	function onselect(newVal){
		var rePeopNums = $("#rePeopNums").val();
		var receptionLevel1 = $("#receptionLevels1").textbox('getValue');
		if(newVal == '1'){
			if(receptionLevel1 == '1'){
				$('#b1').show();
				$('#b4').hide();
				$('#b2').hide();
				$('#b3').hide();
				$('#b5').hide();
				$('#b6').hide();
			}else if(receptionLevel1 == '2'){
				$('#b2').show();
				$('#b1').hide();
				$('#b5').hide();
				$('#b3').hide();
				$('#b4').hide();
				$('#b6').hide();
			}else{
				$('#b3').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b6').hide();
				$('#b5').hide();
				$('#b4').hide();
			}
		}else{
			if(receptionLevel1 == '1'){
				$('#b4').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b3').hide();
				$('#b5').hide();
				$('#b6').hide();
			}else if(receptionLevel1 == '2'){
				$('#b5').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b3').hide();
				$('#b4').hide();
				$('#b6').hide();
			}else{
				$('#b6').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b3').hide();
				$('#b5').hide();
				$('#b4').hide();
			}
		}
		if(newVal == '1'){
			$("#diningPlace").textbox('setValue', "学校食堂");
			if(receptionLevel1 == '1'){
				$("#costFoodStd").textbox('setValue', rePeopNums*160);
				}else if(receptionLevel1 == '2'){
					$("#costFoodStd").textbox('setValue', rePeopNums*120);
				}else{
					$("#costFoodStd").textbox('setValue', rePeopNums*90);
				}
		}
		if(newVal == '2'){
		//$("#diningPlace").val();
		$("#diningPlace").textbox('setValue', "");
		if(receptionLevel1 == '1'){
			$("#costFoodStd").textbox('setValue', rePeopNums*200);
			}else if(receptionLevel1 == '2'){
				$("#costFoodStd").textbox('setValue', rePeopNums*150);
			}else{
				$("#costFoodStd").textbox('setValue', rePeopNums*130);
			}
		}
	}
	
	function selectrs(newVal){
		var diningPlacePlan3 = $("#diningPlacePlan3").val();
		var attendPeopNum = $("#attendPeopNum").val();
		var attend = parseInt(diningPlacePlan3)+parseInt(attendPeopNum);
		if(newVal > attend){
			alert("用餐总人数不能大于随行人数+陪餐人数！");
			$("#rePeopNums").numberbox('setValue','');
		}
		var diningPlace = $("#receptionLevel").val();
		var receptionLevel1 = $("#receptionLevels1").textbox('getValue');
		if(diningPlace == '1'){
			if(receptionLevel1 == '1'){
			$("#costFoodStd").textbox('setValue', newVal*160);
			}else if(receptionLevel1 == '2'){
				$("#costFoodStd").textbox('setValue', newVal*120);
			}else{
				$("#costFoodStd").textbox('setValue', newVal*90);
			}
		}else{
			if(receptionLevel1 == '1'){
				$("#costFoodStd").textbox('setValue', newVal*200);
				}else if(receptionLevel1 == '2'){
					$("#costFoodStd").textbox('setValue', newVal*150);
				}else{
					$("#costFoodStd").textbox('setValue', newVal*130);
				}
		}
	}
	
	function onselectjb(newVal){
		var rePeopNums = $("#rePeopNums").val();
		var receptionLevel = $("#receptionLevel").textbox('getValue');
		if(newVal == '1'){
			if(receptionLevel == '2'){
				$('#b4').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b6').hide();
				$('#b5').hide();
				$('#b3').hide();
			}else{
				$('#b1').show();
				$('#b3').hide();
				$('#b2').hide();
				$('#b6').hide();
				$('#b5').hide();
				$('#b4').hide();
			}
		}else if(newVal == '2'){
			if(receptionLevel == '2'){
				$('#b5').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b6').hide();
				$('#b4').hide();
				$('#b3').hide();
			}else{
				$('#b2').show();
				$('#b3').hide();
				$('#b6').hide();
				$('#b1').hide();
				$('#b5').hide();
				$('#b4').hide();
			}
		}else{
			if(receptionLevel == '2'){
				$('#b6').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b4').hide();
				$('#b5').hide();
				$('#b3').hide();
			}else{
				$('#b3').show();
				$('#b1').hide();
				$('#b2').hide();
				$('#b6').hide();
				$('#b5').hide();
				$('#b4').hide();
			}
		}
		if(newVal == '1'){
			if(receptionLevel == '1'){
				$("#costFoodStd").textbox('setValue', rePeopNums*160);
			}else{
				$("#costFoodStd").textbox('setValue', rePeopNums*200);
			}
		}else if(newVal == '2'){
			if(receptionLevel == '1'){
				$("#costFoodStd").textbox('setValue', rePeopNums*120);
			}else{
				$("#costFoodStd").textbox('setValue', rePeopNums*150);
			}
		}else{
			if(receptionLevel == '1'){
				$("#costFoodStd").textbox('setValue', rePeopNums*90);
			}else{
				$("#costFoodStd").textbox('setValue', rePeopNums*130);
			}
		}
	}
	function selectpcrs(newVal) {
		var rePeopNums = $("#attendPeopNum").val();
		if(rePeopNums<10){
			if(newVal>3){
				alert("随行人数在10人以内，陪餐人数不得超过3人！");
				$("#diningPlacePlan3").numberbox('setValue','');
			}
		}else{
			if(newVal>rePeopNums/3){
				alert("不得超过随行人数的三分之一！");
				$("#diningPlacePlan3").numberbox('setValue','');
			}
		}
	}
	function selectfyys(newVal) {
		var receptionLevel1 = $("#receptionLevels1").textbox('getValue');
		var rePeopNums = $("#rePeopNums").val();
		var receptionLevel = $("#receptionLevel").textbox('getValue');
		if(receptionLevel == '2'){
			if(receptionLevel1 == '1'){
				if(newVal > rePeopNums*200){
					alert("已超出用餐标准！");
					$("#costFoodStd").numberbox('setValue',rePeopNums*200);
				}
			}else if(receptionLevel1 == '2'){
				if(newVal > rePeopNums*150){
					alert("已超出用餐标准！");
					$("#costFoodStd").numberbox('setValue',rePeopNums*150);
				}
			}else{
				if(newVal > rePeopNums*130){
					alert("已超出用餐标准！");
					$("#costFoodStd").numberbox('setValue',rePeopNums*130);
				}
			}
		}else{
			if(receptionLevel1 == '1'){
				if(newVal > rePeopNums*160){
					alert("已超出用餐标准！");
					$("#costFoodStd").numberbox('setValue',rePeopNums*160);
				}
			}else if(receptionLevel1 == '2'){
				if(newVal > rePeopNums*120){
					alert("已超出用餐标准！");
					$("#costFoodStd").numberbox('setValue',rePeopNums*120);
				}
			}else{
				if(newVal > rePeopNums*90){
					alert("已超出用餐标准！");
					$("#costFoodStd").numberbox('setValue',rePeopNums*90);
				}
			}
		}
	}
</script>
