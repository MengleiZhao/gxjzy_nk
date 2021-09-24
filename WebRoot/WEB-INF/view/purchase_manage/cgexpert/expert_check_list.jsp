<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="CK_EXP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">专家编号&nbsp;
					<input id="expert_check_fexpertCode" name="fexpertCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;专家名称
					<input id="expert_check_fexpertName" name="fexpertName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;擅长领域
					<input id="expert_check_ffield" name="ffield" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;性别&nbsp;
					 <select class="easyui-combobox" id="expert_check_fexpertSex" name="fexpertSex"  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="0" >男</option>
						<option value="1" >女</option>
					 </select>
					&nbsp;&nbsp;<a href="#" onclick="CKqueryExpert();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearCKExpertTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>	
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="check_expert_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/expertcheck/expertCheckPageData',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'feId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fexpertCode',align:'center'" width="12%">专家编号</th>
						<th data-options="field:'fexpertName',align:'left'" width="6%">专家名称</th>
						<th data-options="field:'fidNumber',align:'center'" width="12%">身份证号</th>
						<th data-options="field:'fmTel',align:'center'" width="9%">联系手机</th>
						<th data-options="field:'feducation',align:'center'" width="6%">专家学历</th>
						<th data-options="field:'fjobTime',align:'center'" width="6%">工作年限</th>
						<th data-options="field:'ffield',align:'left'" width="11%">擅长领域</th>
						<th data-options="field:'fbirthday',align:'center',resizable:false,sortable:true,formatter:formatAge" style="width: 6%">年龄</th>
						<th data-options="field:'fexpertSex',align:'center',resizable:false,sortable:true,formatter:formatSex" style="width: 6%">性别</th>
						<th data-options="field:'fcheckType',align:'center',formatter:format_checkType" width="8%">审批类型</th>
						<th data-options="field:'fcheckStauts',align:'center',resizable:false,sortable:true,formatter:formatCkexpstauts" style="width: 8%">审批状态</th>
						<th data-options="field:'operation',align:'center',formatter:format_CKexpert" width="7%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	
	</div>
	

	<script type="text/javascript">
	//审批类型
	function format_checkType(val,row){
		//入库
		if(val=="in"){
			return "入库审批";
		}else if(val=="out"){
		//出库
			return "出库审批";
		}else if(val=="black"){
		//黑名单
			t="black";
			return "黑名单审批";
		}else{
			return "无";
		}
	}
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#check_expert_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	//点击查询
	function CKqueryExpert() {
		//alert($('#apply_time').val());
		$('#check_expert_tab').datagrid('load', {
			fexpertCode:$('#expert_check_fexpertCode').val(),
			fexpertName:$('#expert_check_fexpertName').val(),
			ffield:$('#expert_check_ffield').val(),
			fexpertSex:$('#expert_check_fexpertSex').val()
		});
	}
	//清除查询条件
	function clearCKExpertTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#expert_check_fexpertCode").textbox('setValue','');
		$("#expert_check_fexpertName").textbox('setValue','');
		$("#expert_check_ffield").textbox('setValue','');
		$('#expert_check_fexpertSex').combobox('setValue',"");
		$('#check_expert_tab').datagrid('load',{//清空以后，重新查一次
		});
	}
		//设置审批状态
		function formatCkexpstauts(val, row) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}

		//操作栏创建
		function format_CKexpert(val, row) {
			var checkType=row.fcheckType;
			if(row.fcheckType=="in" && row.fcheckStauts==9 && row.fisOutStatus!=9){
				checkType="out";
			}
			return 	'<table style="margin:0 auto;"><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="checkExpertApply(' + row.feId + ',\''+checkType+'\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
					'</a></td></tr></table>';
		}
		
		//跳转审批页面
		function checkExpertApply(id,checkType) {
			var win = creatWin(' ', 970, 580, 'icon-search', "/expertcheck/check?id="+ id+"&checkType="+checkType);
			win.window('open');
		}
		//性别
		function formatSex(val, row) {
			if (val == 0) {
				return '<a style="color:#666666;">' + "男" + '</a>';
			} else if (val ==1) {
				return '<a style="color:#666666;">' + "女" + '</a>';
			} 
		}
		//年龄
		
		function formatAge(val, row) {
			 //出生时间 毫秒
		    var birthDayTime = new Date(val).getTime();
		    //当前时间 毫秒
		    var nowTime = new Date().getTime();
		    //一年毫秒数(365 * 86400000 = 31536000000)
		    return Math.ceil((nowTime-birthDayTime)/31536000000);
		}
	


	</script>
</body>
</html>

