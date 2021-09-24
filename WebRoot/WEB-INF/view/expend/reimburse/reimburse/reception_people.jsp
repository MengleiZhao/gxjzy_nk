<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-table">
	<div id="recp" style="height:30px;padding-top : 8px">
		<a href="javascript:void(0)" onclick="editPeople()" id="editId" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a href="javascript:void(0)" onclick="savePeople()" id="addId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="removeitP()" id="removeId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendP()" id="appendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	<table id="dg_reception_people_reimb" class="easyui-datagrid" style="width:694px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty receptionBean.jId}">
	url: '${base}/apply/recep?id=${receptionBeanEdit.jId}',
	</c:if>
	<c:if test="${empty receptionBean.jId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowP,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'travelRId',hidden:true"></th>
				<th data-options="field:'receptionPeopName',width:100,align:'center',editor:'textbox'">姓名</th>
				<th data-options="field:'unit',width:180,align:'center',editor:'textbox'">单位</th>
				<c:if test="${receptionBeanEdit.isForeign==0}">
				<th data-options="field:'position',width:200,align:'center',editor:{
							editable:true,
							type:'combotree',
							filter: function(q, row){
									var opts = $(this).combotree('options');
									return row[opts.textField].indexOf(q) == 0;
								},
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/apply/lookupsJson?parentCode=ZWJBJD',
								onSelect:setCode
							}}">职务/级别</th>
				</c:if>	
				<c:if test="${receptionBeanEdit.isForeign==1}">
				<th data-options="field:'position',width:200,align:'center',editor:{
							editable:true,
							type:'combotree',
							filter: function(q, row){
									var opts = $(this).combotree('options');
									return row[opts.textField].indexOf(q) == 0;
								},
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/apply/lookupsJson?parentCode=ZWJBWB',
								onSelect:setCode
							}}">职务/级别</th>
				</c:if>			
				<th data-options="field:'contactInformation',width:150,align:'center',editor:'textbox'">联系方式</th>
				<th data-options="field:'jDremake',width:100,align:'center',editor:'textbox'">备注</th>			
				<th data-options="field:'positionCode',hidden:true,editor:'textbox'"></th>				
			</tr>
		</thead>
	</table>
	
</div>
<script type="text/javascript">
var flag2=0;
setTimeout("hidecz()",500);
//接待人员表格添加删除，保存方法
	var editIndexP = undefined;
	function endEditingP() {
		if (editIndexP == undefined) {
			return true;
		}
		if ($('#dg_reception_people_reimb').datagrid('validateRow', editIndexP)) {
			var rph = $('#dg_reception_people_reimb').datagrid('getEditor', {
				index : editIndexP,
				field : 'receptionPeopName'
			});
			var tr = $('#dg_reception_people_reimb').datagrid('getEditors', editIndexP);
			var text2=tr[2].target.combotree('getText');
			if(text2!='--请选择--'){
				tr[2].target.combotree('setValue',text2);
			}
			$('#dg_reception_people_reimb').datagrid('endEdit', editIndexP);
			editIndexP = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowP(index) {
		if(flag2==1){
			return false;
		}else{
			if (editIndexP != index) {
				if (endEditingP()) {
					$('#dg_reception_people_reimb').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					editIndexP = index;
				} else {
					$('#dg_reception_people_reimb').datagrid('selectRow', editIndexP);
				}
			}
		}
	}
	function appendP() {
		if (endEditingP()) {
			$('#dg_reception_people_reimb').datagrid('appendRow', {});
			editIndexP = $('#dg_reception_people_reimb').datagrid('getRows').length - 1;
			$('#dg_reception_people_reimb').datagrid('selectRow', editIndexP).datagrid('beginEdit',editIndexP);
		}
	}
	function removeitP() {
		if (editIndexP == undefined) {
			return
		}
		$('#dg_reception_people_reimb').datagrid('cancelEdit', editIndexP).datagrid('deleteRow',
				editIndexP);
		editIndexP = undefined;
	}
	function acceptP() {
		if (endEditingP()) {
			$('#dg_reception_people_reimb').datagrid('acceptChanges');
		}
	}
	
	
/* 	//重新计算开支标准
	function countkzbz() {
		accept();
		//获得接待人数（有几行就是接待多少人）
		var rownum = $('#dg_reception_people_reimb').datagrid('getRows').length;
		//修改明细表中的开支标准
		var rows = $('#appli-detail-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++) {
			var tr = $('#appli-detail-dg').datagrid('getEditors', i);
			//获得每一行的开支标准
			var kzbz=rows[i].standard;
			//设置开支标准
			onClickRow(i);
			tr[1].target.textbox('setValue', parseFloat(kzbz*rownum));
			accept();
		}
	} */
	
	function hidecz(){
		var rId = '${bean.rId}';
		if(rId!=''){
			flag2=1;
			$("#addId").hide();
			$("#removeId").hide();
			$("#appendId").hide();
			$("#editId").show();
			$("#rcep").show();
			recepNameArr();
		}
	}
	
	
	function editPeople(){
		flag2 = 0;
		$("#addId").show();
		$("#removeId").show();
		$("#appendId").show();
		$("#editId").hide();
		//$("#recp").hide();
		/* $("#addId1").show();
		$("#removeId1").show();
		$("#appendId1").show();
		$("#editId1").hide();
		accept2()
		flag1=1; */
	}
	function savePeople(){
		acceptP();
		
		
		var rows = $('#dg_reception_people_reimb').datagrid('getRows');
		if(rows==''){
			alert("请添加接待人员名单！");
			return false;
		}
		for(var i=0;i<rows.length;i++){
			if(rows[i].receptionPeopName==''){
				alert("请填写接待人员名单上的姓名！");
				return false;
			}
			if(rows[i].unit==''){
				alert("请填写接待人员名单上的单位！");
				return false;
			}
			if(rows[i].position==''){
				alert("请填写接待人员名单上的职务！");
				return false;
			}
		}
		flag2=1;
		$("#addId").hide();
		$("#removeId").hide();
		$("#appendId").hide();
		$("#editId").show();
		$("#rcep").show();
		editIndexP = undefined;
	/* 	accept1();
		for (var i = rows.length-1; i >= 0; i--) {
			if(rows[i].lecturerName==''&&rows[i].lecturerLevel==''&&rows[i].lecturerLevelCode==''&&rows[i].isOutside==''&&rows[i].bankCard==''&&rows[i].bank==''&&rows[i].phoneNum==''){
				$('#dg_train_lecturer').datagrid('deleteRow',i);
			}
		}
		flag1=0;
		$('#trainingType').combobox('readonly',true);
		$('#trDateStart').datebox('readonly',true);
		$('#trDateEnd').datebox('readonly',true);
		$('#trAttendNum').numberbox('readonly',true);
		$('#trStaffNum').numberbox('readonly',true); */
		recepNameArr();
		//loadDatas()
	}
	
	//接待人员姓名数组
	function recepNameArr(){
		var rows = $('#dg_reception_people_reimb').datagrid('getRows');
		var arr = new Array();
		for (var i = 0; i < rows.length; i++) {
				var receptionPeopName = rows[i].receptionPeopName;
				var position = rows[i].position;
				var positionCode = rows[i].positionCode;
				var idAndName = {};
				idAndName.id = receptionPeopName;
				idAndName.text = receptionPeopName;
				idAndName.position =position;
				idAndName.positionCode =positionCode;
				arr.push(idAndName);
		}
		return arr;
	}
	
	function setCode(rec){
		var row = $('#dg_reception_people_reimb').datagrid('getSelected');
		var rindex = $('#dg_reception_people_reimb').datagrid('getRowIndex', row); 
		var ed = $('#dg_reception_people_reimb').datagrid('getEditor',{
			index:rindex,
			field : 'positionCode'  
		});
			$(ed.target).textbox('setValue', rec.code);
	}
	
	function receptionPepoleJson(){
		acceptP();
		var rows = $('#dg_reception_people_reimb').datagrid('getRows');
		var recePeopJson = "";
		for (var i = 0; i < rows.length; i++) {
			recePeopJson = recePeopJson + JSON.stringify(rows[i]) + ",";
		}
		$('#recePeopJson').val(recePeopJson);
	}
</script>