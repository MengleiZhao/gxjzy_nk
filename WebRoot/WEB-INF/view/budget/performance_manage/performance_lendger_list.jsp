<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
				<td class="top-table-search-pro">项目编号&nbsp;
					<input id="performance_lendger_proCode" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;项目名称
					<input id="performance_lendger_proName" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="queryProLendger();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearProLendgerTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
					<td style="text-align: right;  padding-right: 10px; width:600px;">
						<a href="#" onclick="exportJxtz();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daochu1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
							/>
						</a>
					</td>	
				</tr>
			</table> 
	</div>
		
		
		
	<div class="list-table">	
		<table id="performance_lendger_tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/pfmlendgergl/projectPage',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'proId',hidden:true"></th>
					<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
					<th data-options="field:'proCode',align:'center'" width="11%">项目编号</th>
					<th data-options="field:'proName',align:'center'" width="15%">项目名称</th>
					<th data-options="field:'proYear',align:'center'" width="5%">年度</th>
					<!-- <th data-options="field:'typeName',align:'left'" width="10%">项目类型</th>
					<th data-options="field:'fproAttribute',align:'left',formatter: typeformattter" width="8%">项目属性</th> -->
					<!-- <th data-options="field:'proHeader',align:'left'" width="8%">负责人</th>
					<th data-options="field:'proSbr',align:'left'" width="8%">申报人</th>
					<th data-options="field:'proSbbm',align:'left'" width="8%">申报部门</th>
					<th data-options="field:'proSbsj',align:'left',resizable:false,sortable:true,formatter: ProListDateFormat" width="10%">申报时间</th> -->
					
					<th data-options="field:'longGoal',align:'center'" width="7%">年度目标</th>
					<th data-options="field:'longTotal',align:'center'" width="7%">年度资金总额[万元]</th>
					<th data-options="field:'longAmount1',align:'center'" width="7%">年度财政拨款[万元]</th>
					<th data-options="field:'longAmount2',align:'center'" width="7%">年度其他资金[万元]</th>
					<th data-options="field:'midGoal',align:'center'" width="8%">中期目标</th>
					<th data-options="field:'midTotal',align:'center'" width="7%">中期资金总额[万元]</th>
					<th data-options="field:'midAmount1',align:'center'" width="7%">中期财政拨款[万元]</th>
					<th data-options="field:'midAmount2',align:'center'" width="7%">中期其他资金[万元]</th>
					<th data-options="field:'operation',align:'center',formatter:format_oper" width="5%">操作</th>
			</tr>
			</thead>
		</table>
	</div>
	
</div>

		<form id="form_export">
			<input type="hidden" id="exp_pro_category" name="typeName">
			<input type="hidden" id="exp_pro_property" name="FProAttribute">
		</form>
	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#performance_lendger_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	
	//导出
	function exportJxtz(){
		var typeName = $('#pro_category').combobox('getText');
		var FProAttribute = $('#pro_property').combobox('getValue');
		$('#exp_pro_category').val(typeName);
		$('#exp_pro_property').val(FProAttribute);
	    if(confirm('是否按查询条件导出？')){
			$('#form_export').attr('action','${base}/pfmlendgergl/exportExcel');
			$('#form_export').submit();
		}  
	}
		//点击查询
		function queryProLendger() {
			//alert($('#apply_time').val());
			$('#performance_lendger_tab').datagrid('load', {
				FProCode:$('#performance_lendger_proCode').val(),
				FProName:$('#performance_lendger_proName').val()
			});
		}
		//清除查询条件
		function clearProLendgerTable() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#performance_lendger_proCode").textbox('setValue','');
			$("#performance_lendger_proName").textbox('setValue','');
			$('#performance_lendger_tab').datagrid('load',{//清空以后，重新查一次
			});
		}

	//时间格式化
	function ProListDateFormat(val) {
		//alert(val)
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
	//时间格式化
	function typeformattter(val,row) {
		if (val == 1) {
			return '部门预算项目';
		} else if (val == 2) {
			return '省直专项';
		} else if(val == 3){
			return '省对下转移支付项目';
		}
		return '';
	}	
	
	function format_fflowStauts(val, row){
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
		} else if (val == 1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		} else if (val == 2) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		} else if (val == 3) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 已退回" + '</a>';
		}
	}
	
	
	function formatter_libName(val, row){
		if (val == 1) {
			return '申报库';
		} else if (val == 2) {
			return '备选库';
		} else if (val == 3) {
			return '执行库';
		} else if (val == 4) {
			return '结转库';
		}
		return '';
	}
	


	//操作栏创建
	function format_oper(val, row) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick=pfmdetail('+ row.proId +') class="easyui-linkbutton">'+ 
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td></tr></table>';
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}		
	//查看详情
	function pfmdetail(id){
		//alert(id);
		var win = creatWin(' ', 840, 450, 'icon-search',"/pfmlendgergl/pfmldetail?id=" + id);
		win.window('open'); 
	}
 	
	
		//鼠标移入图片替换
		function mouseOver(img) {
			var src = $(img).attr("src");
			src = src.replace(/1/, "2");
			$(img).attr("src", src);
		}

		function mouseOut(img) {
			var src = $(img).attr("src");
			src = src.replace(/2/, "1");
			$(img).attr("src", src);
		}
	</script>
</body>
</html>

