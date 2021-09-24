<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table id="bider_dg" class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">招标工程编号&nbsp;
					<input id="bid_fbiddingCode" name="fbiddingCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
				&nbsp;&nbsp;招标工程名称
					<input id="bid_fbiddingName" name="fbiddingName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
				&nbsp;&nbsp;中标组织名称&nbsp;
					<input id="bid_forgName" name="forgName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="queryBid();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearbidabc_Table();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addBid()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>



	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="bidabc_Tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgbid/cgbidPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fbIdId',hidden:true"></th>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'fwId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fbiddingCode',align:'left'" style="width: 15%">招标工程编号</th>
					<th data-options="field:'fbiddingName',align:'left',resizable:false,sortable:true" style="width: 15%">招标工程名称</th>
					<th data-options="field:'forgName',align:'left',resizable:false,sortable:true" style="width: 20%">中标组织名称</th>
					<th data-options="field:'fagentName',align:'left',resizable:false,sortable:true" style="width: 20%">招标代理机构名称</th>
					<th data-options="field:'fbidTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">中标时间</th>
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>


</div>

	<script type="text/javascript">
	
	//分页样式调整
	$(function(){
		var pager = $('#bidabc_Tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});			
	});
	
		//点击查询
		function queryBid() {
			//alert($('#apply_time').val());
			$('#bidabc_Tab').datagrid('load', {
				fbiddingCode:$('#bid_fbiddingCode').val(),
				fbiddingName:$('#bid_fbiddingName').val(),
				forgName:$('#bid_forgName').val()
			});
		}
		//清除查询条件
		function clearbidabc_Table() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#bid_fbiddingCode").textbox('setValue','');
			$("#bid_fbiddingName").textbox('setValue','');
			$("#bid_zforgName").textbox('setValue','');
			$('#bidabc_Tab').datagrid('load',{//清空以后，重新查一次
			});
		}
		//新增页面
		function addBid() {
			var win = creatSecondWin('新增', 760, 580, 'icon-search', '/cgbid/add');
			win.window('open');
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
	
		//操作栏创建
		function CZ(val,row) {		
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
						'<a href="#" onclick="bid_detail(' + row.fbIdId + ')" class="easyui-linkbutton">'+
				   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   		'</a>'+ '</td><td style="width: 25px">'+
						'<a href="#" onclick="bid_update(' + row.fbIdId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
						'</a>' + '</td><td style="width: 25px">'+
						'<a href="#" onclick="bid_delete(' + row.fbIdId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
						'</a></td></tr></table>';
			
		}
		function showA(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
		}
		function showB(obj){
			obj.src=base+'/resource-modality/${themenurl}/select2.png';
		}
		function showC(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
		}
		function showD(obj){
			obj.src=base+'/resource-modality/${themenurl}/update2.png';
		}
		function showE(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
		}
		function showF(obj){
			obj.src=base+'/resource-modality/${themenurl}/delete2.png';
		}

		
		//查看
		function bid_detail(id) {
			var win = creatSecondWin('查看', 760, 580, 'icon-search',"/cgbid/detail?id=" + id);
			win.window('open');
	
		}
		//修改
		function bid_update(id) {
			var win = creatSecondWin('修改', 760, 580, 'icon-search',"/cgbid/edit?id=" + id);
			win.window('open');
	   }
		
		 
		
		//删除
		function bid_delete(id) {
			if (confirm("确认删除吗？")) {
				$.ajax({
					type : 'POST',
					url : '${base}/cgbid/delete?id='+id,
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							$.messager.alert('系统提示', data.info, 'info');
							$('#bidabc_Tab').datagrid("reload");
						} else {
							$.messager.alert('系统提示', data.info, 'error');
						}
					}
				});
			}
		} 
	
		
	
	
		
		
	</script>
</body>
