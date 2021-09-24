<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>

<style type="text/css">
.tabletop{margin: 0 10px 10px 10px;background-color: #fff;font-family: "微软雅黑"}
.queryth{text-align: right;}
</style>

</head>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="easyui-layout" fit="true">
	<div data-options="region:'center'" border="0" style="background-color: #f0f5f7;text-align: center;">						
		
		<div style="margin: 0 10px 0 10px;height: 350px;">	
			<table id="show_pro_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'',
			method:'post',fit:true,pagination:false,singleSelect: false,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fproId',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'center'" width="17%">项目编号</th>
						<th data-options="field:'fproName',align:'center'" width="20%">项目名称</th>
						<th data-options="field:'typeName',align:'center',formatter: protyeformatter" width="23%">项目类型</th>
						<th data-options="field:'fproAttribute',align:'center',formatter: attformatter" width="16%">项目属性</th>
						<th data-options="field:'fproBudgetAmount',align:'left'" width="10%">预算(元)</th>
						<th data-options="field:'operation',align:'center',formatter:format_oper" width="9%">操作</th>
						
						<!-- <th data-options="field:'fproHead',align:'center'" width="10%">负责人</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ProListDateFormat" width="10%">申报时间</th> -->
				</tr>
				</thead>
			</table>
		</div>
	
	</div>
	
	<div data-options="region:'south'" border: 0px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-edit" onclick="saveProIds()">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeFirstWindow()">关闭</a> 
	</div>
</div>


	<script type="text/javascript">
		//分页样式调整
		$(document).ready(
				function() {
					var pager = $('#guibi_pro_tab').datagrid().datagrid('getPager'); // get the pager of datagrid
					pager.pagination({
						layout : [ 'sep', 'first', 'prev', 'links', 'next',
								'last'/* ,'refresh' */]
					});	
					
				});


		//时间格式化
		function ProListDateFormat(val) {
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



		function attformatter(val, row) {
			if (val == 1) {
				return '部门预算项目';
			} else if (val == 2) {
				return '省直专项';
			}else  if(val == 3){
				return '省对下转移支付项目';
			}
			return '';
		}
		function protyeformatter(val, row) {
			if (val == "PRO-TYPE-1") {
				return '纪检监察工作经费';
			} 
			else if (val == "PRO-TYPE-2") {
				return '机关建设与日常保障费用';
			}
			else  if(val == "PRO-TYPE-3"){
				return '宣传文化工作专项经费';
			}
			else  if(val == "PRO-TYPE-4"){
				return '互联网信息管理专项经费';
			}
			else  if(val == "PRO-TYPE-5"){
				return '文明办工作专项经费';
			}
			else  if(val == "PRO-TYPE-6"){
				return '文化发展专项经费';
			}
			else  if(val == "PRO-TYPE-99"){
				return '其他';
			}
			return '';
		}
	
		//操作栏创建
		function format_oper(val, row) {
				return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="see_detail(' + row.fproId + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="see_delete(' + row.fproId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'</a></td></tr></table>';
		}
		function showA(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
		}
		function showB(obj){
			obj.src=base+'/resource-modality/${themenurl}/select2.png';
		}
		function showE(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
		}
		function showF(obj){
			obj.src=base+'/resource-modality/${themenurl}/delete2.png';
		}
		
		 //删除
		function see_delete(fproId) {
			 //alert(fproId);
			 var datas = $('#show_pro_tab').datagrid('getData');
		    	for(var i=0;i<datas.rows.length;i++){
		    	    if(datas.rows[i].fproId==fproId){//数据中的id和渲染时的id相等
		    	    	//通过传入的id值查询到对应的记录，在获取实际的Index,这样去删除,（直接传入渲染好的索引值会出现错误）
				  		var rowIndex = $('#show_pro_tab').datagrid('getRowIndex',datas.rows[i]);
				  		 $('#show_pro_tab').datagrid('deleteRow', rowIndex);
				  		 return;
		    		} 
		  		 } 
		}
		 
		//	确认选择  获取所有的id  进行保存操作   最终自评项目的id
		 function saveProIds(){
			var datas = $('#show_pro_tab').datagrid('getData');
			var finalproids = '';
	    	for(var i=0;i<datas.rows.length;i++){
	    		finalproids +=datas.rows[i].fproId + ',';

	    	}
	    	//alert(finalproids);
			$('#finalproids').val(finalproids);
			closeFirstWindow();
		}
		//查看
		function see_detail(proId){
			var win=creatWin('查看-项目信息',840,450,'icon-search','/project/detail/'+proId);
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

