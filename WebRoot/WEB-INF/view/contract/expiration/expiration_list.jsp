<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search">合同编号&nbsp;
						<input id="expiration_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="expiration_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;付款性质&nbsp;
						<input class="easyui-combobox" id="expiration_fReceProperty" name="fReceProperty" style="width: 150px;height:25px;" data-options="url:'${base}/Expiration/lookupsJson?parentCode=FKXZ',method:'POST',valueField:'code',textField:'text',editable:false">
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="expiration_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="expiration_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					
					
					
					</td> 
					<%-- <td class="top-table-td1">合同编号：</td> 
					<td class="top-table-td2">
						<input id="expiration_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">合同名称：</td> 
					<td class="top-table-td2">
						<input id="expiration_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">付款性质：</td> 
					<td class="top-table-td2">
						<input class="easyui-combobox" id="expiration_fReceProperty" name="fReceProperty" style="width: 150px;height:25px;" 
						data-options="url:'${base}/Expiration/lookupsJson?parentCode=FKXZ',method:'POST',valueField:'code',textField:'text',editable:false">
						<!-- <input id="expiration_fReceProperty" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input> -->
					</td>
					<!-- <td class="top-table-td1">签署人：</td> 
					<td class="top-table-td2">
						<input id="expiration_fSignUser" name="" style="width: 150px;height:25px;" data-options="prompt:''" class="easyui-textbox"></input>
					</td> -->
					<td style="width: 30px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="expiration_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
					<td style="width: 12px"><span style="font-weight: bold;"></span>
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="expiration_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<table id="expiration_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Expiration/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'fPlanId',hidden:true">付款计划的id</th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="15%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="15%">合同名称</th>
						<th data-options="field:'fcAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%" >合同金额(元)</th>
						<th data-options="field:'fRecePlanAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">本次付款金额(元)</th>
						<th data-options="field:'datenumber',align:'center',formatter:tiansu,resizable:false,sortable:true" width="10%">距离计划付款天数</th>
						<th data-options="field:'fReceProperty',align:'center',resizable:false,sortable:true,formatter:ReceProperty" width="7%">付款性质</th>
						<th data-options="field:'fNotAllAmountL',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="8%">未付金额(元)</th>
						<th data-options="field:'fDeptName',align:'center'" width="11%">所属部门</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
var day;
//清除查询条件
function expiration_clearTable() {
	$('#expiration_fcCode').textbox('setValue',null);
	$('#expiration_fcTitle').textbox('setValue',null);
	$('#expiration_fReceProperty').textbox('setValue',null);
	$('#expiration_fSignUser').textbox('setValue',null);
	expiration_query();
}
//鼠标移入图片替换
function mouseOver(img){
	var src = $(img).attr("src");
	src = src.replace(/1/, "2");
	$(img).attr("src",src);
}
	
function mouseOut(img) {
	var src = $(img).attr("src");
	src = src.replace(/2/, "1");
	$(img).attr("src",src);
}
	function ReceProperty(val, row) {
		if (val == "FKXZ-01") {
			return '<span >' + "首款" + '</span>';
		} else if (val == "FKXZ-02") {
			return '<span >' + "阶段款" + '</span>';
		}else if (val == "FKXZ-03") {
			return '<span >' + "验收款" + '</span>';
		}else if (val == "FKXZ-04") {
			return '<span >' + "质保款" + '</span>';
		}
	}
	function ContStauts(val, row) {
		if (val == 1) {
			return '<span >' + "未备案" + '</span>';
		} else if (val == 9) {
			return '<span >' + "已备案" + '</span>';
		}else if (val == 3) {
			return '<span >' + "已结项" + '</span>';
		}else if (val == 5) {
			return '<span >' + "已归档" + '</span>';
		}else if (val == 7) {
			return '<span >' + "有纠纷" + '</span>';
		}
	}
	function hong(){
		
	}
	//增加进度条显示功能
    function showProcessBar(value, row, index) {  
            console.log(isNaN(parseInt(value)));
            console.log(row);
            console.log(index);
        var htmlstr = null;
        //如果NaN，则说明未分配计划
        /* if(isNaN(parseInt(value))){
            console.log("NaN");
            htmlstr = '<div class="progressbar-text" style="width:90px;">' 
                + "未分配计划" + '</div><div class="progressbar-value" style="width:0px">&nbsp </div>';
        }else if(parseInt(value) > 100 || value.indexOf(",") > 0){//大于100，统一按照100%统计，//超过1000
            console.log("大于100 value = "+value+" parseIntValue = "+ parseInt(value));
            htmlstr = '<div class="progressbar-text" style="width:90px;">' 
                + value + '</div><div class="progressbar-value" style="width:90px">&nbsp </div>';
        }else{//完成比例正常显示 */
            console.log("小于100 value = "+value+" parseIntValue = "+ parseInt(value));
            htmlstr = '<div class="progressbar-text" style="width:90px;">' 
                + value + '</div><div class="progressbar-value" style="width:'+
                parseInt(value)+'px">&nbsp </div>';
       // }
        return htmlstr;
    }
	function CZ(val, row) {
			return  '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'
					+'<a href="#" onclick="detail(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="expirationshowB(this)" onmouseout="expirationshowA(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'
					+'</a>'+ '</td><td style="width: 25px">'
					+ '<a href="#" onclick="plan(' + row.fcId
					+ ')" class="easyui-linkbutton"><img onmouseover="expirationshowD(this)" onmouseout="expirationshowC(this)" src="'+base+'/resource-modality/${themenurl}/list/pay1.png">'
					+'</a></td></tr></table>';
	}
	function expirationshowB(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
	}
	function expirationshowA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function expirationshowD(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/pay2.png';
	}
	function expirationshowC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/pay1.png';
	}
	/* $(function() {
		//定义双击事件
		$('#expiration_dg').datagrid({
			onDblClickRow : function(rowIndex, rowData) {
				detailDemo();
			}
		});
	}); */
	function expiration_query() {
		/* var fRP=$('#expiration_fReceProperty').val();
		if(fRP=="FKXZ-01"){
			fRP="1";
		}else if(fRP=="FKXZ-02"){
			fRP="2";
		}else if(fRP=="FKXZ-03"){
			fRP="3";
		}else if(fRP=="FKXZ-04"){
			fRP="4";
		} */
		$('#expiration_dg').datagrid('load', {
			fcCode : $('#expiration_fcCode').val(),
			fcTitle : $('#expiration_fcTitle').val(),
			fReceProperty : $('#expiration_fReceProperty').val(),
			fSignUser : $('#expiration_fSignUser').val()
		});
	}
	function addCF() {
		var node = $('#expiration_dg').datagrid('getSelected');
		var win = creatWin(' ', 840, 450, 'icon-search', '/Formulation/add');
		if (null != node) {
			win = creatWin(' ', 840, 450, 'icon-search',
					'/Formulation/add?departId=' + node.id);
		}
		win.window('open');
	}
	
	function detail(id) {
			var win = creatWin('合同付款明细', 705, 580, 'icon-search',"/Expiration/detail/" + id);
			win.window('open');
	}
	function plan(id) {
		var row = $('#expiration_dg').datagrid('getSelected');
		var selections = $('#expiration_dg').datagrid('getSelections');
		var win = creatWin('合同付款申请', 970, 580, 'icon-search',
				"/Enforcing/plan/" + id);
		win.window('open'); 
	}
	/* function editCF() {
		var row = $('#expiration_dg').datagrid('getSelected');
		var selections = $('#expiration_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 840, 450, 'icon-search',
					"/Formulation/edit/" + row.fcId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function CF_update(id) {
		//var row = $('#expiration_dg').datagrid('getSelected');
		var selections = $('#expiration_dg').datagrid('getSelections');
		var win = creatWin(' ', 780, 450, 'icon-search',
				"/Formulation/edit/" + id);
		win.window('open');
	}
	function CF_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Formulation/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#expiration_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	function expListlawHelp() {
		//var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
		//win.window('open');
		if (confirm("按当前查询条件导出？")) {
			var queryForm = document.getElementById("lawHelp_list_form");
			queryForm.setAttribute("action", "${base}/demo/expList");
			queryForm.submit();
		}
	}
	function tiansu(val){
		day=val;
		if(val<=30){
			return "<span style='color: red;font-weight: bold;'>" + val + "</span>";
		}else if(val<0){
			val;
			console.log(val)
			return "<span style='color: red;font-weight: bold;'>逾期(" + val + ")天</span>";
		}else {
			return "<span >" + val + "</span>";
		}
	}
	//时间格式化
	function ChangeDateFormat(val) {
		//alert(val)
		var t, y, m, d, h, i, s;
		if (val == null) {
			return "";
		}
		t = new Date(val)
		y = t.getFullYear();
		m = t.getMonth() + 1;
		d = t.getDate();
		h = t.getHours();
		i = t.getMinutes();
		s = t.getSeconds();
		// 可根据需要在这里定义时间格式  
		return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
	
	function formatOper(value, row, index) {
		return 'sfsdf';
		//return '<a href="#" onclick="test('+index+')">修改</a>';  
		//    return '<a href="javascript:void(0);" onclick="openviewzfrw(\''+row.person+'\',\''+row.data_status+'\')"><font color="blue">走访</font></a>'; 
	}
</script>
</body>
</html>

