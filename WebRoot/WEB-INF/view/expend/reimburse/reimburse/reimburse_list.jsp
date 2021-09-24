<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>



<body >
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;报销单编号&nbsp;
					<input id="reimburse_list_top_rCode_${reimburseType}" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;报销时间&nbsp;
					<input id="reimburse_list_top_reqTime1_${reimburseType}" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[reimburse_list_top_reqTime2_${reimburseType}]"/>
					&nbsp;-&nbsp;
					<input id="reimburse_list_top_reqTime2_${reimburseType}" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[reimburse_list_top_reqTime1_${reimburseType}]"/>
					
					&nbsp;&nbsp;审批状态&nbsp;
					
					<select id="reimburse_list_top_flowStauts_${reimburseType}" class="easyui-combobox" style="width: 150px;height:25px;">
						<option value="">--请选择--</option>
						<option value="0">暂存</option>
						<option value="1">待审批</option>
						<option value="-1">已退回</option>
						<option value="9">已审批</option>
					</select>
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryReimburse(${reimburseType});">
						<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearReimburse(${reimburseType});">
						<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addReimburse(${reimburseType})">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>



	<div class="list-table">
		<table id="reimburseTab${reimburseType}" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/reimburse/reimbursePage?reimburseType=${reimburseType}',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'rId',hidden:true"></th>
					<th data-options="field:'applyAmount',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'type',align:'center',formatter:typeSet" style="width: 5%">报销类型</th>
					<th data-options="field:'rCode',align:'center',resizable:false,sortable:true" style="width: 15%">报销单编号</th>
					<th data-options="field:'gName',align:'center',resizable:false,sortable:true" style="width: 15%">报销摘要</th>
					<th data-options="field:'amount',align:'center',resizable:false,sortable:true,formatter: Baoxiaochaoe" style="width: 15%">报销金额</th>
					<th data-options="field:'reimburseReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">报销时间</th>
					<th data-options="field:'deptName',align:'center',resizable:false,sortable:true" style="width: 10%">报销部门</th>
					<th data-options="field:'userName',align:'center',resizable:false,sortable:true" style="width: 5%">报销申请人</th>
					<th data-options="field:'flowStauts',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>



<script type="text/javascript">
//设置申请事项
function typeSet(val, row) {
	if (val == 0) {
		return '<span>' + "直接报销" + '</span>';
	} else if (val == 1) {
		return '<span>' + "通用事项报销" + '</span>';
	} else if (val == 2) {
		return '<span>' + "会议报销" + '</span>';
	} else if (val == 3) {
		return '<span>' + "培训报销" + '</span>';
	} else if (val == 4) {
		return '<span>' + "差旅报销" + '</span>';
	} else if (val == 5) {
		return '<span>' + "公务接待报销" + '</span>';
	} else if (val == 9) {
		return '<span>' + "合同报销" + '</span>';
	} else if (val == 6) {
		return '<span>' + "公车运维报销" + '</span>';
	} else if (val == 7) {
		return '<span>' + "公务出国报销" + '</span>';
	}
}


//设置审批状态
var c;
function flowStautsSet(val, row) {
	c = val;
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	} else if (val == 9) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
	} else if (val == -4) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
	}  else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
	}
}
function Baoxiaochaoe(val, row){
	
	var a = row.applyAmount;
	if(a>0){
		return '<span style="color:red">'+fomatMoney(val,2)+"【报销超额】"+'</span>';
	}else{
		return fomatMoney(val,2);
	}
}
//操作栏创建
function CZ(val, row) {
	if (c == 1 || c == 2) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editReimburse(' + row.rId + ',0,'+row.type+')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td><td style="width: 25px">'+
			   '<a href="#" onclick="reCall(\'reimburseTab${reimburseType}\',' + row.rId + ',\'/reimburse/reimburseReCall\')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			   '</a></td></tr></table>';
	} else if(c == 0 || c == -1 || c == -4) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="editReimburse(' + row.rId + ',0,'+row.type+')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="editReimburse(' + row.rId + ',1,'+row.type+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				/* '</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="deleteReimburse(' + row.rId + ',' + row.type + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+ */
				'</a></td></tr></table>';
	}else{
		//c==9审批通过无法撤回
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   '<a href="#" onclick="editReimburse(' + row.rId + ',0,'+row.type+')" class="easyui-linkbutton">'+
			   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   '</a></td></tr></table>';
	}
}

//新增页面
function addReimburse(reimburseType) {
	var title = null;
	if(reimburseType=="1") {
		title="通用事项报销";
	} else if(reimburseType=="2") {
		title="会议报销";
	} else if(reimburseType=="3") {
		title="培训报销";
	} else if(reimburseType=="4") {
		title="差旅报销";
	} else if(reimburseType=="5") {
		title="公务接待报销";
	} else if(reimburseType=="6") {
		title="公车运维报销";
	} else if(reimburseType=="7") {
		title="公务出国报销";
	}
	if(reimburseType=="1"){
		var win = creatWin(title, 780, 580, 'icon-search', '/reimburse/add?reimburseType='+reimburseType);
	}else {
		var win = creatWin(title, 1075, 580, 'icon-search', '/reimburse/add?reimburseType='+reimburseType);
	}
	win.window('open');
}

//删除
function deleteReimburse(id,type) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/reimburse/delete?id=' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#reimburseTab'+type).datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}

//查看/修改 页面跳转
function editReimburse(id,type,reimburseType) {
	/*type为修改或查看,1为修改，0为查看  */
	if(type==1){
		if(reimburseType=="1") {
			title="通用事项报销-修改";
		} else if(reimburseType=="2") {
			title="会议报销-修改";
		} else if(reimburseType=="3") {
			title="培训报销-修改";
		} else if(reimburseType=="4") {
			title="差旅报销-修改";
		} else if(reimburseType=="5") {
			title="公务接待报销-修改";
		} else if(reimburseType=="6") {
			title="公车运维报销-修改";
		} else if(reimburseType=="7") {
			title="公务出国报销-修改";
		}
	}else if(type==0){
		if(reimburseType=="1") {
			title="通用事项报销明细";
		} else if(reimburseType=="2") {
			title="会议报销明细";
		} else if(reimburseType=="3") {
			title="培训报销明细";
		} else if(reimburseType=="4") {
			title="差旅报销明细";
		} else if(reimburseType=="5") {
			title="公务接待报销明细";
		} else if(reimburseType=="6") {
			title="公车运维报销明细";
		} else if(reimburseType=="7") {
			title="公务出国报销明细";
		}
	}
	if((reimburseType=="1" && type==0) || (reimburseType=="1" && type==1)){
		
		if(type==0){
		var win = creatWin(title, 780, 580, 'icon-search', "/reimburse/edit?id="+ id +"&editType="+ type);
		win.window('open');
		}else{
		var win = creatWin(title, 780, 580, 'icon-search', "/reimburse/edit?id="+ id +"&editType="+ type);
		win.window('open');
		}
	}else {
		if(type==0){
		var win = creatWin(title, 1080, 580, 'icon-search', "/reimburse/edit?id="+ id +"&editType="+ type);
		win.window('open');
		}else{
		var win = creatWin(title, 1080, 580, 'icon-search', "/reimburse/edit?id="+ id +"&editType="+ type);
		win.window('open');
		}
	}
	
}

//查询
function queryReimburse(reimburse) {
	var tableid="reimburseTab"+reimburse;
	
	var rCode="reimburse_list_top_rCode_"+reimburse;
	var reqTime1="reimburse_list_top_reqTime1_"+reimburse;
	var reqTime2="reimburse_list_top_reqTime2_"+reimburse;
	var flowStauts="reimburse_list_top_flowStauts_"+reimburse;
	
	$("#"+tableid).datagrid('load',{
		rCode:$("#"+rCode).textbox('getValue').trim(),
		reimburseReqTime1:$("#"+reqTime1).datebox('getValue').trim(),
		reimburseReqTime2:$("#"+reqTime2).datebox('getValue').trim(),
		flowStauts:$("#"+flowStauts).textbox('getValue').trim(),
	});
}
//清除查询条件
function clearReimburse(reimburse) {
	var rCode="reimburse_list_top_rCode_"+reimburse;
	var reqTime1="reimburse_list_top_reqTime1_"+reimburse;
	var reqTime2="reimburse_list_top_reqTime2_"+reimburse;
	var flowStauts="reimburse_list_top_flowStauts_"+reimburse;
	
	$("#"+rCode).textbox('setValue','');
	$("#"+reqTime1).datebox('setValue','');
	$("#"+reqTime2).datebox('setValue','');
	$("#"+flowStauts).textbox('setValue','');
	
	var tableid="reimburseTab"+reimburse;
	$("#"+tableid).datagrid('load',{});
}
$("#reimburse_list_top_reqTime1_"+${reimburseType}).datebox({
    onSelect : function(beginDate){
        $('#reimburse_list_top_reqTime2_'+${reimburseType}).datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

</script>
</body>
</html>

