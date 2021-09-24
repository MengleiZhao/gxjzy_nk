<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>



<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;还款人&nbsp;
					<input id="payment_list_hkr" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;还款时间&nbsp;
					<input id="loan_list_top_estChargeTime1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[loan_list_top_estChargeTime2]"/>
					&nbsp;-&nbsp;
					<input id="loan_list_top_estChargeTime2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[loan_list_top_estChargeTime1]"/>
					
					
					&nbsp;&nbsp;
					<a href="#" onclick="queryPaym();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearPaym();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<c:if test='${menuType==1 }'>
						<a href="#" onclick="addPayment();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</c:if>
				</td>
			
			</tr>
		</table>  
	</div>
	
	<div class="list-table">
		<table id="dg_payment_list" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/payment/pageList?menuType=${menuType }',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'id',hidden:true"></th>
					<th data-options="field:'orderNum',align:'center'" style="width: 10%">序号</th>
					<th data-options="field:'code',align:'center',resizable:false,sortable:true" style="width: 20%">申请单编号</th>
					<th data-options="field:'payAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 20%">还款金额[元]</th>
					<th data-options="field:'payPerson',align:'center',resizable:false,sortable:true" style="width: 10%">还款人</th>
					<th data-options="field:'payTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 20%">还款时间</th>
					<th data-options="field:'flowStatus',align:'center',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
function ChangeDateFormat(val) {
	var t, y, m, d, h, i, s;
    if(val==null){
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
}
//设置审批状态
var c;
function flowStautsSet(val, row) {
	c = val;
	if (val =="0") {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
	} else if (val =="-1") {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
	} else if (val =="9") {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已确认" + '</a>';
	} else if (val ==-4) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
	}  else {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待确认" + '</a>';
	}
}

//操作栏创建
function CZ(val, row) {
	//申请列表
	if(${menuType}=='1'){
		if(c =="0" || c =="-1" || c =="-4") {
			//修改、删除、查看
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="detailPaym(' + row.id + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a>'+ '</td><td style="width: 25px">'+
			'<a href="#" onclick="editPaym(' + row.id + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
			'</a>' + '</td><td style="width: 25px">'+
			'<a href="#" onclick="deletePayment(' + row.id + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
			'</a></td></tr></table>';
		} else if(c =="9"){
			//查看
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="detailPaym(' + row.id + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a>'+ '</td><td style="width: 25px">'+
			'<a href="#" onclick="exportHtml(' + row.lId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
		   '</a></td></tr></table>';
		}else{
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="detailPaym(' + row.id + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a>'+ '</td><td style="width: 25px">'+
			'</a></td><td style="width: 25px">'+
			'<a href="#" onclick="reCall(\'dg_payment_list\',' + row.id + ',\'/payment/paymentReCall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			'</a>'+ '</td><td style="width: 25px">'+
			'</a></td></tr></table>';
		}
	}
	//审批列表
	if (${menuType}=='2') {
		//查看、审批
		/* return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="detailPaym(' + row.id + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a>'+ '</td><td style="width: 25px">'+
			
			'<a href="#" onclick="checkPayment(' + row.id + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
			'</a>' + '</td><td style="width: 25px">'+
		'</a></td></tr></table>'; */
		if(c =="9"){
			//查看
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="detailPaym(' + row.id + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a>'+ '</td><td style="width: 25px">'+
			'<a href="#" onclick="exportHtml(' + row.lId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
		   '</a></td></tr></table>';
		}else{
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="checkPayment(' + row.id + ',1)" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
			'</a></td></tr></table>';
		}
	}
}

	 
//新增页面
function addPayment() {
	var win = creatWin('还款登记申请', 1080, 580, 'icon-search', '/payment/add');
	win.window('open');
}
function exportHtml(id) {
	window.open(base+"/exportApplyAndReim/paymentExprot?id="+ id);
}
	
//删除
function deletePayment(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/payment/delete/'+id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#dg_payment_list').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}

function editPaym(id) {
	var win = creatFirstWin('还款登记-修改 ', 1080, 580, 'icon-search', "/payment/edit/"+ id);
	win.window('open');
}
function detailPaym(id) {
	var win = creatFirstWin('还款登记明细 ', 1080, 580, 'icon-search', "/payment/detail/"+ id);
	win.window('open');
}

//查询
function queryPaym() {
	
	
	$("#dg_payment_list").datagrid('load',{
		payPerson:$("#payment_list_hkr").textbox('getValue').trim(),
		payTimes:$("#loan_list_top_estChargeTime1").datebox('getValue').trim(),
		payTimee:$("#loan_list_top_estChargeTime2").datebox('getValue').trim()
	});

}
//清除查询条件
function clearPaym() {
	
	alert($("#loan_list_top_estChargeTime1").datebox('getValue'))
	
	$("#payment_list_hkr").textbox('setValue',''),
	$("#loan_list_top_estChargeTime1").datebox('setValue',''),
	$("#loan_list_top_estChargeTime2").datebox('setValue',''),
	
	$("#dg_payment_list").datagrid('load',{});
}

//审批页面跳转
function checkPayment(id){
	var win = creatFirstWin('审批', 1080, 580, 'icon-search', "/payment/check/"+ id);
	win.window('open');
}


$("#loan_list_top_estChargeTime1").datebox({
    onSelect : function(beginDate){
        $('#loan_list_top_estChargeTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
</script>
</body>