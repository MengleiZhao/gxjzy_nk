<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 ">
		<!-- 隐藏域 -->
		<!-- 申报类型  yxxd:一下下达 ，exxd:二下下达 -->
		<input type="hidden" id="cgconfplan_list_sblx" value="${sblx }" />
		<!-- 上报阶段  1：一上   2：二上 -->
		<input type="hidden" id="cgconfplan_list_freportStage" value="${freportStage }" />
	</div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="confplan_resolve_top1">
				<td class="top-table-search">采购计划编号&nbsp;
					<input id="confplan_resolve_flistNum1" name="flistNum" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="confplan_resolve_freqDept1" name="freqDept" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购类型&nbsp;
					<select class="easyui-combobox" id="confplan_resolve_fprocurType1" name="fprocurType"  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="A10" >货物</option>
						<option value="A20" >工程</option>
						<option value="A30" >服务</option>
						<option value="A40" >办公用品及耗材</option>
					</select>
					&nbsp;
					<a href="#" onclick="queryConfplan(0);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;
					<a href="#" onclick="clearConfplan(0);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>		
			</tr>
			
			<tr id="confplan_resolve_top2" style="display: none">
				<td class="top-table-search">采购计划编号&nbsp;
					<input id="confplan_resolve_flistNum2" name="flistNum" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="confplan_resolve_freqDept2" name="freqDept" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购类型&nbsp;
					<select class="easyui-combobox" id="confplan_resolve_fprocurType2" name="fprocurType"  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="A10" >货物</option>
						<option value="A20" >工程</option>
						<option value="A30" >服务</option>
						<option value="A40" >办公用品及耗材</option>
					</select>
					&nbsp;
					<a href="#" onclick="queryConfplan(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;
					<a href="#" onclick="clearConfplan(1);">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>		
			</tr>
		</table>
	</div>
	
	<div class="list-table-tab2">
		<div class="tab-wrapper" id="resolve-tab">
			<ul class="tab-menu">
				<li class="active" onclick="notResolve();">未二下</li>
			    <li onclick="resolve();">已二下</li>
			</ul>
			
			<div class="tab-content">
				<div style="height: 410px;">	
					<table id="confplan_resolve_tab1" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/cgconfplan/confplanResolvePageData?status=0&freportStage=${freportStage }',
						method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
						selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
						<thead>
							<tr>
								<th data-options="field:'fplId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" width="5%">序号</th>
								<th data-options="field:'flistNum',align:'center'" width="15%">采购计划编号</th>
								<th data-options="field:'freqDept',align:'center'" width="15%">申请部门</th>
								<th data-options="field:'freqTime',align:'center',formatter:ChangeDateFormat" width="15%">申请日期</th>
								<th data-options="field:'fprocurType',align:'center',formatter:formatProcurType" width="15%">采购类型</th>
								<th data-options="field:'freqLinkMen',align:'center'" width="10%">申请人</th>
								<th data-options="field:'flinkTel',align:'center'" width="15%">联系电话</th>
								<th data-options="field:'operation',align:'center',formatter:format_resolve" width="11%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
				
				<div style="height: 410px;">	
					<table id="confplan_resolve_tab2" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/cgconfplan/confplanResolvePageData?status=1&freportStage=${freportStage }',
						method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
						selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
						<thead>
							<tr>
								<th data-options="field:'fplId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" width="5%">序号</th>
								<th data-options="field:'flistNum',align:'center'" width="15%">采购计划编号</th>
								<th data-options="field:'freqDept',align:'center'" width="15%">申请部门</th>
								<th data-options="field:'freqTime',align:'center',formatter:ChangeDateFormat" width="15%">申请日期</th>
								<th data-options="field:'fprocurType',align:'center',formatter:formatProcurType" width="15%">采购类型</th>
								<th data-options="field:'freqLinkMen',align:'center'" width="10%">申请人</th>
								<th data-options="field:'flinkTel',align:'center'" width="15%">联系电话</th>
								<th data-options="field:'operation',align:'center',formatter:format_resolve" width="10%">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>	
</div>
<script type="text/javascript">
	//加载tab页
	flashtab('resolve-tab');
	
	//type为一下状态	0-未二下	1-已二下
	var type = 0;
	function notResolve() {	//未二下
		type = 0;
		$('#confplan_resolve_tab1').datagrid('reload');
		$('#confplan_resolve_top1').show();
		$('#confplan_resolve_top2').hide();
	}
	
	function resolve() {	//已二下
		type = 1;
		$('#confplan_resolve_tab2').datagrid('reload');
		$('#confplan_resolve_top2').show();
		$('#confplan_resolve_top1').hide();
	}
	
	//点击查询
	function queryConfplan(type) {
		if(type == 0){
			$('#confplan_resolve_tab1').datagrid('load',{
				flistNum : $('#confplan_resolve_flistNum1').textbox('getValue'),
				freqDept : $('#confplan_resolve_freqDept1').textbox('getValue'),
				fprocurType : $('#confplan_resolve_fprocurType1').textbox('getValue'),
			});
		}else if(type == 1){
			$('#confplan_resolve_tab2').datagrid('load',{
				flistNum : $('#confplan_resolve_flistNum2').textbox('getValue'),
				freqDept : $('#confplan_resolve_freqDept2').textbox('getValue'),
				fprocurType : $('#confplan_resolve_fprocurType2').textbox('getValue'),
			});
		}
	}
	
	//清除查询条件
	function clearConfplan(type) {
		if(type == 0){
			$('#confplan_resolve_flistNum1').textbox('setValue','');
			$('#confplan_resolve_freqDept1').textbox('setValue','');
			$('#confplan_resolve_fprocurType1').combobox('setValue','');
			$('#confplan_resolve_tab1').datagrid('load',{});//清空以后，重新查一次
		}else if(type == 1){
			$('#confplan_resolve_flistNum2').textbox('setValue','');
			$('#confplan_resolve_freqDept2').textbox('setValue','');
			$('#confplan_resolve_fprocurType2').combobox('setValue','');
			$('#confplan_resolve_tab2').datagrid('load',{});//清空以后，重新查一次
		}
	}
	
	//采购类型
	function formatProcurType(val,row){
		if (val == 'A10') {
			return '货物';
		}else if (val == 'A20') {
			return '工程';
		}else if (val == 'A30') {
			return '服务';
		}else if (val == 'A40') {
			return '办公用品及耗材';
		} 
	}
	
	//操作栏创建
	function format_resolve(val, row) {
		var c = row.secondIssuedStatus;
		if (c == 0) {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="confplan_resolve(' + row.fplId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/xiada1.png">'+
					'</a></td></tr></table>';
		}else if(c == 1) {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="confplan_detail(' + row.fplId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
					'</a></td></tr></table>';
		}			
	}
	
	//下达
	function confplan_resolve(id) {
		var win = parent.creatWin('下达', 970, 580, 'icon-search', '/cgconfplan/secondResolve?id='+id);
		win.window('open'); 
  	}
	
	//查看
	function confplan_detail(id) {
		var win = parent.creatWin('查看', 970, 580, 'icon-search', '/cgconfplan/secondResolveDetail?id='+id);
		win.window('open'); 
	} 
</script>
</body>