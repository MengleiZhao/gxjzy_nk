<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="capital_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-td1">借款单编号&nbsp;
					<input id="re_lCode" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;所属部门&nbsp;
					<input id="re_deptName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;还款状态&nbsp;
					<select id="re_frepayStatus" name="" style="width: 150px; height:25px;" class="easyui-combobox">
						<option value="">--请选择--</option>
						<option value="0">待还款</option>
						<option value="-1">已退还</option>
						<option value="9">已还款</option>
						<option value="1">待审定</option>
					</select>
					&nbsp;&nbsp;
					<a href="#" onclick="queryCapital();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearCapitalTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				
				</td>
				<%-- <td class="top-table-td1">申请时间：</td>
				<td	class="top-table-td2">
					<input id="re_lCode" name="" style="width: 150px; height:25px;" class="easyui-datebox"></input>
				</td>

				<td class="top-table-td1">预计冲账时间：</td>
				<td class="top-table-td2">
					<input id="re_deptName" name="" style="width: 150px; height:25px;" class="easyui-datebox"></input>
				</td>

				
				<td style="width: 30px;"></td>
				<td style="width: 26px;">
					<a href="#" onclick="queryCapital();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>				
				<td style="width: 8px;"></td>	
				<td style="width: 26px;">
					<a href="#" onclick="clearCapitalTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>								
				<td align="right" style="padding-right: 10px">
				</td> --%>
			</tr>
			
		</table>
	</div>



	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="capitalTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/srcapital/srcapitalPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'lId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'lCode',align:'left',resizable:false,sortable:true" style="width: 15%">借款单编号</th>
					<th data-options="field:'lAmount',align:'left',resizable:false,sortable:true" style="width: 10%">借款金额[元]</th>
					<th data-options="field:'userName',align:'left',resizable:false,sortable:true" style="width: 12%">借款人</th>
					<th data-options="field:'deptName',align:'left',resizable:false,sortable:true" style="width: 12%">所属部门</th>
					<th data-options="field:'reqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 12%">申请时间</th>
					<th data-options="field:'estChargeTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 12%">预计冲账时间</th>
					<th data-options="field:'frepayStatus',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 7%">还款状态</th>
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" style="width: 15%">操作</th>
				</tr>
			</thead>
		</table>
	</div>



</div>
	<script type="text/javascript">
	
	//分页样式调整
	$(function(){
		var pager = $('#capitalTab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});			
	});
		
		//点击查询
		function queryCapital() {
			//alert($('#register_code').val());
			$('#capitalTab').datagrid('load', {
				lCode : $('#re_lCode').textbox('getValue'),
				deptName : $('#re_deptName').textbox('getValue'),
				frepayStatus : $('#re_frepayStatus').textbox('getValue'),
			});
		}

		//清除查询条件
		function clearCapitalTable() {
			$("#re_lCode").textbox('setValue','');
			$("#re_deptName").textbox('setValue','');
			$("#re_frepayStatus").combobox('setValue','');
			queryCapital();
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
	
		//设置审批状态
		var c;
		function flowStautsSet(val, row) {
			c = val;
			if (val == 0) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "待还款" + '</a>';
			} else if (val == -1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
			} else if (val == 9) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已还款" + '</a>';
			} else {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审定" + '</a>';
			}
		}
		
		//操作栏创建
		function CZ(val,row) {		
			 if(c == 0 || c == -1) {//待还款和已退回的可以查看和还款
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
						'<a href="#" onclick="repayDetail(' + row.lId + ',0)" class="easyui-linkbutton">'+
				   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   		'</a>'+ '</td><td style="width: 25px">'+
						'<a href="#" onclick="repayOpera(' + row.lId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/repayment1.png">'+
						'</a></td></tr></table>';
			}else{//待审定和已还款的只能查看
				return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
			   		   '<a href="#" onclick="repayDetail(' + row.lId + ',0)" class="easyui-linkbutton">'+
				   	   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
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
			obj.src=base+'/resource-modality/${themenurl}/list/repayment1.png';
		}
		function showD(obj){
			obj.src=base+'/resource-modality/${themenurl}/repayment2.png';
		}

		 //查看
		 function repayDetail(id) {
			var win = creatWin(' ', 765, 580, 'icon-search',"/srcapital/detail?id=" + id);
			win.window('open');
		} 
		//还款
		function repayOpera(id) {
			var win = creatWin(' ', 765, 580, 'icon-search',"/srcapital/repayment?id=" + id);
			win.window('open');
	   }
		
	
		
	
	

		

		
	</script>
</body>
</html>

