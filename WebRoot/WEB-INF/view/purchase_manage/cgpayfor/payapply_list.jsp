<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="receive_payfor_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">采购批次编号&nbsp;
					<input id="payfor_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称
					<input id="payfor_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申报时间&nbsp;
					<input id="payfor_time_a" name="" style="width: 150px;height:25px;" class="easyui-datebox" validType="dateBegin[payfor_time_b]"></input>
					&nbsp;-&nbsp;
					<input id="payfor_time_b" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					&nbsp;&nbsp;<a href="#" onclick="queryPayfor();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearPayforTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
				<!-- <tr id="helpTr" style="display: none;">
					<td align="center" style="width: 90px">申报时间：</td> 
					<td style="width: 140px">
						<input id="" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					<td align="center" style="width: 10px">~</td> 
					<td style="width: 140px">
						<input id="" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					
					<td align="center" style="width: 90px">申请金额：</td> 
					<td style="width: 140px">
						<input id="" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
				</tr> -->
		</table>
	</div>

	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="cg_payfor_receive_tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgreceiveLedger/cgledgerPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fpCode',align:'left'" style="width: 15%">采购批次编号</th>
					<th data-options="field:'fpName',align:'left',resizable:false,sortable:true" style="width: 12%">采购名称</th>
					<th
						data-options="field:'fpAmount',align:'left',resizable:false,sortable:true"
						style="width: 12%">采购金额[元]</th>
					<th
						data-options="field:'fDeptName',align:'left',resizable:false,sortable:true"
						style="width: 8%">申报部门</th>
					<th
						data-options="field:'fReqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat"
						style="width: 8%">申报时间</th>
					<th
						data-options="field:'fUserName',align:'left',resizable:false,sortable:true"
						style="width: 8%">申请人</th>
					<!-- <th
						data-options="field:'fpMethod',align:'left',resizable:false,sortable:true"
						style="width: 8%">采购方式</th> -->
					<th
						data-options="field:'fCheckStauts',align:'left',resizable:false,sortable:true,formatter:formatPrice"
						style="width: 8%">审批状态</th>
					<th
						data-options="field:'fIsReceive',align:'left',resizable:false,sortable:true,formatter:formatRecive"
						style="width: 8%">验收状态</th>
					<th
						data-options="field:'fpayStauts',align:'left',resizable:false,sortable:true,formatter:formatPay"
						style="width: 8%">付款审批状态</th>
					<th
						data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ"
						style="width: 8%">操作</th>
				</tr>
			</thead>
		</table>
	</div>



</div>
	<script type="text/javascript">
	$("#payfor_time_a").datebox({
	    onSelect : function(beginDate){
	        $('#payfor_time_b').datebox().datebox('calendar').calendar({
	            validator: function(date){
	                return beginDate <= date;
	            }
	        });
	    }
	});
	//分页样式调整
	$(function(){
		var pager = $('#cg_payfor_receive_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});			
	});
	
	//显示搜索
	function spread() {
		$('#helpTr').css("display", "");
		$('#retract').css("display", "");
		$('#spread').css("display", "none");
	}
	//隐藏搜索
	function retract() {
		$('#helpTr').css("display", "none");
		$('#retract').css("display", "none");
		$('#spread').css("display", "");
	}

		//点击查询
		function queryPayfor() {
			//alert($('#apply_time').val());
			$('#cg_payfor_receive_tab').datagrid('load', {
				fpCode:$('#payfor_fpCode').val(),
				fpName:$('#payfor_fpName').val(),
				timea:$('#payfor_time_a').val(),
				timeb:$('#payfor_time_b').val()
			});
		}
		//清除查询条件
		function clearPayforTable() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#payfor_fpCode").textbox('setValue','');
			$("#payfor_fpName").textbox('setValue','');
			$("#payfor_time_a").textbox('setValue','');
			$("#payfor_time_b").textbox('setValue','');
			$('#cg_payfor_receive_tab').datagrid('load',{//清空以后，重新查一次
			});
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
			return y + '-' + (m < 10 ? '0' + m : m) + '-'
					+ (d < 10 ? '0' + d : d);
		}	
		
	
	//设置采购审批状态
	var c;
	function formatPrice(val, row) {
		c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}
	}
	//设置付款申请状态
	var x;
	function formatPay(val, row) {
		x = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未申请" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}
	}
	//设置验收状态
	var z;
	function formatRecive(val, row) {
		z = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未验收" + '</a>';
		} else if (val == 1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已验收" + '</a>';
		}
	}
	
	//操作栏创建
	function CZ(val, row) {
		if (x == 9 || x == 1 || x == 2) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick="pay_apply_detail(' + row.fpId + ')" class="easyui-linkbutton">'+
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td></tr></table>';
		} else if(x == 0 ||x == -1) {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="pay_apply_detail(' + row.fpId + ')" class="easyui-linkbutton">'+
			   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   		'</a>'+ '</td><td style="width: 25px">'+
					'<a href="#" onclick="pay_apply_opera(' + row.fpId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/applyck1.png">'+
					'</a></td></tr></table>';
		}
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/applyck1.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/applyck2.png';
	}
	
	
	//跳转送审页面
	function pay_apply_opera(id) {
		var win = creatWin(' ', 970, 580, 'icon-search', "/cgpayfor/checkreceive?id="+ id);
		win.window('open');
	}		
	//跳转查看页面
	function pay_apply_detail(id) {
		var win = creatWin(' ', 970, 580, 'icon-search', "/cgpayfor/checkdetail?id="+ id);
		win.window('open');
	}		
		
	
		
	</script>
</body>
</html>

