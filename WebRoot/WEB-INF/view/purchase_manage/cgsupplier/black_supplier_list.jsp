<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="black_SUP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">供应商编码&nbsp;
				<input id="black_fwCode" name="fwCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
				&nbsp;&nbsp;供应商名称
				<input id="black_fwName" name="fwName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
				&nbsp;&nbsp;移入时间&nbsp;
					<input id="black_time_a" name="" style="width: 150px;height:25px;" class="easyui-datebox"  validType="dateBegin[black_time_b]"></input>
					&nbsp;-&nbsp;
					<input id="black_time_b" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
				&nbsp;&nbsp;<a href="#" onclick="queryBlack();">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<a href="#" onclick="clearBlackTable();">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</td>			
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="black_supplier_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/suppliergl/blacksupPage',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="6%">序号</th>
						<th data-options="field:'fwCode',align:'center'" width="14%">供应商编码</th>
						<th data-options="field:'fwName',align:'left'" width="16%">供应商名称</th>
						<th data-options="field:'fwuserName',align:'center'" width="8%">联系人</th>
						<th data-options="field:'fblackTime',align:'center',formatter: ChangeDateFormat" width="10%">移入黑名单时间</th>
						<th data-options="field:'faccFreq',align:'right'" width="10%">累计移入黑名单次数</th>
						<th data-options="field:'fopName',align:'center'" width="8%">操作人</th>
						<th data-options="field:'fblackDesc',align:'left'" width="18%">移入黑名单原因</th>
						<!-- <th data-options="field:'fisBlack',align:'left',resizable:false,sortable:true,formatter:formatStauts" style="width: 12%">是否黑名单</th> -->
						<th data-options="field:'operation',align:'left',formatter:format_black" width="10%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	

</div>

	<script type="text/javascript">
	$("#black_time_a").datebox({
	    onSelect : function(beginDate){
	        $('#black_time_b').datebox().datebox('calendar').calendar({
	            validator: function(date){
	                return beginDate <= date;
	            }
	        });
	    }
	});
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#black_supplier_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	
	//点击查询
	function queryBlack() {
		//alert($('#apply_time').val());
		$('#black_supplier_tab').datagrid('load', {
			fwCode:$('#black_fwCode').val(),
			fwName:$('#black_fwName').val(),
			timea:$('#black_time_a').val(),
			timeb:$('#black_time_b').val()
		});
	}
	//清除查询条件
	function clearBlackTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#black_fwCode").textbox('setValue','');
		$("#black_fwName").textbox('setValue','');
		$("#black_time_a").textbox('setValue','');
		$("#black_time_b").textbox('setValue','');
		$('#black_supplier_tab').datagrid('load',{//清空以后，重新查一次
		});
	}

		//时间格式化
		function ChangeDateFormat(val) {
			//alert(val)
			var t, y, m, d, h, i, s;
			if (val == null) {
				return "";
			}
			t = new Date(val);
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
	function formatStauts(val, row) {
		c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 否" + '</a>';
		} else if (val == 1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 是" + '</a>';
		}
	}
	
	//操作栏创建
	function format_black(val,row) {		
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="supplier_detail(' + row.fwId + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px"><a href="#" onclick="OUT_BLACK(' + row.fwId + ')" class="easyui-linkbutton">'+
		       '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/outblack1.png">'+
		       '</a></td></tr></table>';		
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/outblack1.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/outblack2.png';
	}
	//移出黑名单
	function OUT_BLACK(id) {
		var win =parent.creatWin(' ', 540, 300, 'icon-search',"/blacksuppliergl/moveoutblack?id=" + id);
		win.window('open'); 
  	}
	/*  //移出黑名单
	function OUT_BLACK(id) {
		if (confirm("确认移出黑名单吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/blacksuppliergl/moveoutblack?id='+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#black_supplier_tab').datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	} */
	 //查看
	 function supplier_detail(id) {
		var win = parent.creatWin(' ', 970, 580, 'icon-search',"/suppliergl/detail?id=" + id+"&type=black");
		win.window('open'); 
	}  
	</script>
</body>

