<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search-pro">模版编码&nbsp;
					<input id="temp_code" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;模版名称
					<input id="temp_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="querySelfTemp();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearSelfTemp();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px;">
					<a href="#" onclick="addSelfTemp()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</td>
			</tr>	
		</table>
	</div>

	<div class="list-table">
		<table id="self_rule_Tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/selfevaluationrule/selfevalPage',
			method:'post',fit:true,pagination:true,singleSelect: true,selectOnCheck: true,
			checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'ftId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'ftempCode',align:'left',resizable:false,sortable:true" style="width: 15%">模版编码</th>
					<th data-options="field:'ftempName',align:'left'" style="width: 17%">模版名称</th>
					<th data-options="field:'ftempDesc',align:'left',resizable:false,sortable:true" style="width: 15%">模版说明</th>
					<th data-options="field:'fyear',align:'left',resizable:false,sortable:true" style="width: 12%">应用年度</th>
					<th data-options="field:'fisOn',align:'left',resizable:false,sortable:true,formatter:formatQiyong" style="width: 12%">是否启用</th>
					<th data-options="field:'fisCo',align:'left',resizable:false,sortable:true,formatter:formatPeizhi" style="width: 12%">是否已配置规则</th>
					<th data-options="field:'fCheckStauts',align:'left',resizable:false,sortable:true,formatter:CZ" style="width: 12%">审批状态</th>
				</tr>
			</thead>
		</table>
	</div>
</div>

	


	<script type="text/javascript">
		//分页样式调整
		$(function() {
			var pager = $('#self_rule_Tab').datagrid().datagrid('getPager'); // get the pager of datagrid
			pager
					.pagination({
						layout : [ 'sep', 'first', 'prev', 'links', 'next',
								'last'/* ,'refresh' */]
					});
		});
		
		//点击查询
		function querySelfTemp() {
			//alert($('#apply_time').val());
			$('#self_rule_Tab').datagrid('load', {
				ftempCode : $('#temp_code').textbox('getValue'),
				ftempName : $('#temp_name').textbox('getValue')
			});
		}
		//清除查询条件
		function clearSelfTemp() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#temp_code").textbox('setValue','');
			$("#temp_name").textbox('setValue','');
			$('#self_rule_Tab').datagrid('load',{//清空以后，重新查一次
			});
		}
		
		var c;
		//启用状态的格式化
		function formatQiyong(val, row) {
			c = val;
			if (c == 0) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">'+ " 未启用" + '</a>';
			} else if (c == 1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">'+ " 已启用" + '</a>';
			}
		}
		//配置状态的格式化
		function formatPeizhi(val, row) {
			if (val == 0) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">'+ " 未配置" + '</a>';
			} else if (val == 1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">'+ " 已配置" + '</a>';
			}
		}
		
		
		//操作栏创建
		function CZ(val,row) {		
			if (c == 1 ) {//已启用的模版只能查看和停用
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
						'<a href="#" onclick="temp_detail(' + row.ftId + ')" class="easyui-linkbutton">'+
		   				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   				'</a>'+ '</td><td style="width: 25px">'+
						'<a href="#" onclick="temp_off(' + row.ftId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="showY(this)" onmouseout="showX(this)" src="'+base+'/resource-modality/${themenurl}/list/turndown1.png">'+
						'</a>' + '</td><td style="width: 25px">'+
						'</a></td></tr></table>';
			} else if(c==0){ //未启用的查看 修改 删除 启用
				 return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
						'<a href="#" onclick="temp_detail(' + row.ftId + ')" class="easyui-linkbutton">'+
		   				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   				'</a>'+ '</td><td style="width: 25px">'+
						'<a href="#" onclick="temp_update(' + row.ftId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
						'</a>' + '</td><td style="width: 25px">'+
						'<a href="#" onclick="temp_delete(' + row.ftId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
						'</a>' + '</td><td style="width: 25px">'+
						'<a href="#" onclick="temp_on(' + row.ftId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/turnon1.png">'+
						'</a>' + '</td><td style="width: 25px">'+
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
		function showG(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/turnon1.png';
		}
		function showH(obj){
			obj.src=base+'/resource-modality/${themenurl}/turnon2.png';
		}
		function showX(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/turndown1.png';
		}
		function showY(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/turndown2.png';
		}
		 //新增页面
		function addSelfTemp() {
			var win = creatSecondWin('新增', 840, 600, 'icon-search', '/selfevaluationrule/add');
			win.window('open');
		} 	
		 
		 //查看
		 function temp_detail(id) {
			var win = creatFirstWin(' ', 840, 600, 'icon-search',"/selfevaluationrule/detail?id=" + id);
			win.window('open');
		} 
		//修改
		function temp_update(id) {
			var win = creatSecondWin(' ', 840, 600, 'icon-search',"/selfevaluationrule/edit?id=" + id);
			win.window('open');  
			
	   }
		//启用自评模版生成自评项目
		function temp_on(id) {
				 if (confirm("确认启用该模版吗？")) {
					$.ajax({
						type : 'POST',
						url : '${base}/selfevaluationrule/turnon?id='+id,
						dataType : 'json',
						success : function(data) {
							if (data.success) {
								$.messager.alert('系统提示', data.info, 'info');
								$('#self_rule_Tab').datagrid("reload");
							} else {
								$.messager.alert('系统提示', data.info, 'error');
							}
						}
					});
			}
	   }
		//停用模版信息
		function temp_off(id) {
				  if (confirm("确认停用该模版吗？")) {
					$.ajax({
						type : 'POST',
						url : '${base}/selfevaluationrule/turnoff?id='+id,
						dataType : 'json',
						success : function(data) {
							if (data.success) {
								$.messager.alert('系统提示', data.info, 'info');
								$('#self_rule_Tab').datagrid("reload");
							} else {
								$.messager.alert('系统提示', data.info, 'error');
							}
						}
					});
			} 
	   }
		
		 
		
		 //删除
		function temp_delete(id) {
				if (confirm("确认删除吗？")) {
					$.ajax({
						type : 'POST',
						url : '${base}/selfevaluationrule/delete?id='+id,
						dataType : 'json',
						success : function(data) {
							if (data.success) {
								$.messager.alert('系统提示', data.info, 'info');
								$('#self_rule_Tab').datagrid("reload");
							} else {
								$.messager.alert('系统提示', data.info, 'error');
							}
						}
					});
				}
			 
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

