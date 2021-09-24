<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">采购批次编号&nbsp;
					<input id="receive_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称&nbsp;
					<input id="receive_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="receive_fDeptName" name="fDeptName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;
					<a href="#" onclick="queryReceive();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearReceiveTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="list-table">
		<table id="receive_forAcceptance" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgreceive/cgreceivePage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'fItems',hidden:true"></th>
					<th data-options="field:'facpId',hidden:true"></th>
					<th data-options="field:'fIsContract',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fpCode',align:'center'" style="width: 14%">采购批次编号</th>
					<th data-options="field:'facpName',align:'center',resizable:false" style="width: 19%">采购名称</th>
					<th data-options="field:'facpAmount',align:'center',resizable:false,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">采购金额(元)</th>
					<th data-options="field:'cgUserName',align:'center',resizable:false" style="width: 10%">申请人</th>
					<th data-options="field:'cgDeptName',align:'center',resizable:false" style="width: 11%">申请部门</th>
					<th data-options="field:'cgTime',align:'center',resizable:false,formatter: ChangeDateFormat" style="width: 11%">申请日期</th>
					<th data-options="field:'fCheckStauts',align:'center',resizable:false,formatter:formatRecive" style="width: 11%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	//点击查询
	function queryReceive(num) {
		$("#receive_forAcceptance").datagrid('load', {
			fpCode:$('#receive_fpCode').val(),
			fpName:$('#receive_fpName').val(),
			fDeptName:$('#receive_fDeptName').val(),
		});
	}
	
	//清除查询条件
	function clearReceiveTable(num) {
		$("#receive_fpCode").textbox('setValue','');
		$("#receive_fpName").textbox('setValue','');
		$("#receive_fDeptName").textbox('setValue','');
		queryReceive();
	}

	//设置验收状态
	var c;
	function formatRecive(val, row) {
		c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		} else if (val ==-4) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else if(val == null){
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未验收" + '</a>';
		}else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}
	}
		
	
	//操作栏创建
	function CZ(val, row) {				//0-暂存		1-待验收	-1-已退回		9-已验收
		/* if(row.fIsContract=='0'){//首先需要判断  是否签订合同   然后判断需不需要审批流  控制撤回按钮显示
			if(c == ''||c == '0'){		//暂存	 只能验收、查看和查看合同
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="receive(' + row.fpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/yanshou1.png">'+
				'</a></td></tr></table>';
			}else if(c == 1){		//待验收	只能查看验收和查看合同
				//工程不显示撤回按钮
				if(row.fItems=='A20'){
					return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="ys_lendger_detail_s(' + row.fpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
					'</a></td></tr></table>';
				}else{
					return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="ys_lendger_detail_s(' + row.fpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
					'</a></td><td style="width: 25px">'+
					'<a href="#" onclick="reCall(\'receive_forAcceptance\',' + row.fpId + ',\'/cgreceive/reCall\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
					'</a></td></tr></table>';
				}
			}else{
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="ys_lendger_detail_s(' + row.fpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a></td></tr></table>';
			}
		}else{
			//首先需要判断  是否签订合同   然后判断需不需要审批流  控制撤回按钮显示
			if(c == ''||c == '0'){		//暂存	 只能验收、查看和查看合同
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="receive(' + row.fpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/yanshou1.png">'+
				'</a>'+'</td><td style="width: 25px">'+
				'<a href="#" onclick="htPro(' + row.fpId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ht1.png">'+
				'</a></td></tr></table>';
			}else if(c == 1){		//待验收	只能查看验收和查看合同
				//工程不显示撤回按钮
				if(row.fItems=='A20'){
					return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="ys_lendger_detail_s(' + row.fpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
					'</a>'+'</td><td style="width: 25px">'+
					'<a href="#" onclick="htPro(' + row.fpId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ht1.png">'+
					'</a></td></tr></table>';
				}else{
					return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="ys_lendger_detail_s(' + row.fpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
					'</a>'+'</td><td style="width: 25px">'+
					'<a href="#" onclick="htPro(' + row.fpId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ht1.png">'+
					'</a></td><td style="width: 25px">'+
					'<a href="#" onclick="reCall(\'receive_forAcceptance\',' + row.fpId + ',\'/cgreceive/reCall\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
					'</a></td></tr></table>';
				}
			}else{
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="ys_lendger_detail_s(' + row.fpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a>'+'</td><td style="width: 25px">'+
				'<a href="#" onclick="htPro(' + row.fpId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ht1.png">'+
				'</a></td></tr></table>';
			}
		} */
		if(c == '9'){
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="ys_lendger_detail_s(' + row.facpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a>'+'</td></tr></table>';
		}else if(c == '0' || c == '-4' || c == '-1'){
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="ys_lendger_detail_s(' + row.facpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a>'+'</td><td style="width: 25px">'+
			'<a href="#" onclick="receive(' + row.facpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
			'</a>'+'</td></tr></table>';
		}else if(c == null || c == ''){
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="receive(' + row.facpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/yanshou1.png">'+
			'</a></td></tr></table>';
		}else{
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="ys_lendger_detail_s(' + row.facpId + ',\'' + row.fItems + '\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a>'+'</td><td style="width: 25px">'+
			'<a href="#" onclick="reCall(\'receive_forAcceptance\',' + row.facpId + ',\'/cgreceive/reCall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			'</a></td></tr></table>';
		}
	}
	//查看合同
	function htPro(fpId) {
		var win = creatWin('合同信息',800,580,'icon-search',"/cgreceive/detailContract/"+fpId);
		win.window('open');
	}
	
	//跳转查看页面
	function ys_lendger_detail_s(id,fItems) {
		
		var win ;
		if(fItems=="A20"){
			win = creatWin('验收详情', 815, 580, 'icon-search', "/cgreceive/detail?id="+ id);
		}else{
			win = creatWin('验收详情', 1115, 580, 'icon-search', "/cgreceive/detail?id="+ id);
		}
		win.window('open');
	}	
	//进行供应商的评价
	function supplier_eval(id) {
		var win = creatWin('供应商评价', 1115, 550, 'icon-search', "/evalsupplier/trhisdiscussYi?id="+ id);
		win.window('open');
	}	
	
	//跳转验收 （新增/修改）
	function receive(id,fItems) {
		
		var win;
		if(fItems=="A20"){
			win = creatWin('采购验收', 815, 580, 'icon-search', "/cgreceive/receive?id="+ id);
		}else{
			win = creatWin('采购验收', 1115, 580, 'icon-search', "/cgreceive/receive?id="+ id);
		}
		win.window('open');
	}
	
</script>
</body>
</html>

