<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top">
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;"  cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search-pro">指标名称&nbsp;
					<input id="outside_indexName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;调整金额&nbsp;
					<input id="c_changeAmountBegin"  name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" validType="numberBegin[c_cAmountEnd]" class="easyui-numberbox"></input>
					&nbsp;-&nbsp;
					<input id="c_changeAmountEnd" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" class="easyui-numberbox"></input>
					
					&nbsp;&nbsp;审批状态&nbsp;
					 <select class="easyui-combobox" id="outside_flowStauts" name=""  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="0" >暂存</option>
						<option value="-1" >已退回</option>
						<option value="9" >已审批</option>
						<option value="2" >待审批</option>
					 </select>
					&nbsp;&nbsp;<a href="#" onclick="outsidequery();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="outsideclearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addoutsideAdjust()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
			</table>   
		</div>



	<div class="list-table">
		<table id="outsideTab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/outsideAdjust/adjustPage',
		method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'aId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'opUser',align:'left',resizable:false,sortable:true" style="width: 10%">操作人</th>
					<th data-options="field:'indexName',align:'left',resizable:false,sortable:true" style="width: 25%">调整指标名称</th>
					<th data-options="field:'changeAmount',align:'left',resizable:false,sortable:true" style="width: 10%">调整金额[万元]</th>
					<th data-options="field:'opTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">调整时间</th>
					<th data-options="field:'flowStauts',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 15%">审批状态</th>
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" style="width: 20%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	


</div>
<script type="text/javascript">
	
	//新增页面
	function addoutsideAdjust() {
		var win = creatWin('申请新增',970, 580, 'icon-search', '/outsideAdjust/add');
		win.window('open');
	}
	
	//修改
	function editoutsideAdjust(id,type) {
		/*type为修改或查看1位修改，0位查看  */
		var win = creatWin(' ', 970, 580, 'icon-search', "/outsideAdjust/edit?id="+ id+"&editType="+type);
		win.window('open');
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
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
		}
	}

	//操作栏创建
	function CZ(val, row) {
		if (c == 9 || c == 1 || c == 2) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick="editoutsideAdjust(' + row.aId + ',0)" class="easyui-linkbutton">'+
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td></tr></table>';
		} else if(c == 0 || c == -1) {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="editoutsideAdjust(' + row.aId + ',0)" class="easyui-linkbutton">'+
			   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   		'</a>'+ '</td><td style="width: 25px">'+
					'<a href="#" onclick="editoutsideAdjust(' + row.aId + ',1)" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="deleteOutside(' + row.aId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
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
	
	//点击查询
	function outsidequery() {
		//alert($('#apply_time').val());
		$('#outsideTab').datagrid('load', {
			indexName:$('#outside_indexName').val(),
			changeAmountBegin:$('#c_changeAmountBegin').val(),
			changeAmountEnd:$('#c_changeAmountEnd').val(),
			flowStauts:$('#outside_flowStauts').val()
		});
	}
	//清除查询条件
	function outsideclearTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#outside_indexName").textbox('setValue','');
		$("#c_changeAmountBegin").textbox('setValue','');
		$("#c_changeAmountEnd").textbox('setValue','');
		$("#outside_flowStauts").combobox('setValue','');
		$('#outsideTab').datagrid('load',{//清空以后，重新查一次
		});
	}
	//删除
	function deleteOutside(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/outsideAdjust/delete?id=' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#outsideTab').datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}

</script>
</body>


