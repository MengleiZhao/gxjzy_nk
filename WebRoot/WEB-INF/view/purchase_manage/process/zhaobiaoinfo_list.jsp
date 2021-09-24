<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div >
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="top-table-search">招标编号&nbsp;
							<input id="zbinfo_fbiddingCode" name="fbiddingCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
							&nbsp;&nbsp;招标名称
							<input id="zbinfo_fbiddingName" name="fbiddingName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
							&nbsp;&nbsp;<a href="#" onclick="queryZB();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
							<a href="#" onclick="clearZBTable();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>
					</tr>
				</table> 
		</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 250px;">	
			<table id="zbinfo_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/cgprocess/pickZBPage',
			method:'post',fit:true,pagination:false,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
					<th data-options="field:'fbId',hidden:true"></th>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fbiddingCode',align:'left'" style="width: 21%">招标编号</th>
					<th data-options="field:'fbiddingName',align:'left',resizable:false,sortable:true" style="width: 15%">招标名称</th>
					<th data-options="field:'ftendUnitName',align:'left',resizable:false,sortable:true" style="width: 15%">招标单位</th>
					<th data-options="field:'fstartTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 13%">开标时间</th>
					<th data-options="field:'ftendUser',align:'left',resizable:false,sortable:true" style="width: 9%">联系人</th>
					<th data-options="field:'ftendUserTel',align:'left',resizable:false,sortable:true" style="width: 12%">电话</th>
					<!-- <th data-options="field:'fagentName',align:'left',resizable:false,sortable:true" style="width: 10%">代理机构</th> -->
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:selectZB" style="width: 10%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
			<div style="text-align: left;">
				<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：请双击完成选择</span>
			</div>
			<div class="win-left-bottom-div"  style="text-align: center;">
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
</div>

	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#zbinfo_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
		$("#zbinfo_tab").datagrid({
			 onDblClickRow:function(index, row){
				 var row = $('#zbinfo_tab').datagrid('getSelected');
					var selections = $('#zbinfo_tab').datagrid('getSelections');
					if (row != null && selections.length == 1) {
						$("#F_fbId").val(row.fbId);//招标主键id
						$("#F_fpId").val(row.fpId);//采购主键id
						$("#F_fbiddingCode").textbox('setValue', row.fbiddingCode);//招标编号
						$("#F_fbiddingName").textbox('setValue', row.fbiddingName);//招标名称
						$("#F_fagentName").textbox('setValue', row.fagentName);//招标代理机构
						var fstartTime=row.fstartTime;
						var date = new Date(parseInt(fstartTime, 10));
						//月份为0-11，所以+1，月份小于10时补个0
						var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1): date.getMonth() + 1;
						var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
						var kb_time = date.getFullYear() + "-" + month + "-" + currentDate;
						$("#F_fstartTime").datebox('setValue', kb_time);//开标日期
						closeFirstWindow();
					} else {
						$.messager.alert('系统提示', '请选择一条数据！', 'info');
					} 
			 }
		});
	});
	
		//点击查询
		function queryZB() {
			//alert($('#apply_time').val());
			$('#zbinfo_tab').datagrid('load', {
				fbiddingCode:$('#zbinfo_fbiddingCode').val(),
				fbiddingName:$('#zbinfo_fbiddingName').val()
			});
		}
		//清除查询条件
		function clearZBTable() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#zbinfo_fbiddingCode").textbox('setValue','');
			$("#zbinfo_fbiddingName").textbox('setValue','');
			$('#zbinfo_tab').datagrid('load',{//清空以后，重新查一次
			});
		}
		
		
		//操作栏创建
		function selectZB(val,row) {		
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick="tendering_detail(' + row.fbId + ')" class="easyui-linkbutton">'+
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td></tr></table>';
			
		}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}		
	
	//查看
	function tendering_detail(id) {
		var win = creatWin(' ', 970, 580, 'icon-search',"/cgprocess/detail?id=" + id);
		win.window('open');

	} 
	</script>
</body>

