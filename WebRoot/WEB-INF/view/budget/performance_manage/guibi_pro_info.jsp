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
		
		<div class="list-top">
			<table style="font-size: 12px;">
					<tr>
						<td class="top-table-td1">执行年份：</td>
						<td class="top-table-td2">
							<input id="pro_applitime" name=""style="width: 150px;height:25px;" class="easyui-textbox"></input>
							<%-- <input id="pro_type"  class="easyui-combobox" style="height:25px; font-size: 14px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=PRO-TYPE',method:'get',valueField:'code',textField:'text',editable:false"/> --%>
						</td>
						<td class="top-table-td1">项目名称：</td>
						<td class="top-table-td2">
							<input id="pro_name" name=""style="width: 150px;height:25px;" class="easyui-textbox"></input>
						</td>
						
						<td style="width: 30px;"></td>				
						<td style="width: 26px;">
							<a href="#" onclick="queryGbPro();">
								<img  style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>				
						<td style="width: 3px;"></td>			
						<td>
							<a href="#" onclick="clearGbTable();">
								<img  style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>						
					</tr>
				</table> 
		</div>
		
		
		<div style="margin: 0 10px 0 10px;height: 300px;">	
			<table id="guibi_pro_info_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/selfevaluationrule/getjiexiangjson',
			method:'post',fit:true,pagination:true,singleSelect: false,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:'true'"></th>
						<th data-options="field:'fproId',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'center'" width="22%">项目编号</th>
						<th data-options="field:'fproName',align:'center'" width="15%">项目名称</th>
						<th data-options="field:'typeName',align:'center'" width="12%">项目类型</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ProListDateFormat" width="10%">申报时间</th>
						<th data-options="field:'fproBudgetAmount',align:'left'" width="8%">项目预算（万元）</th>
						<th data-options="field:'fflowStauts',align:'center',formatter:format_fflowStauts" width="8%">审批状态</th> -->
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'fproId',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'left'" width="15%">项目编号</th>
						<th data-options="field:'fproName',align:'left'" width="20%">项目名称</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ProListDateFormat" width="10%">申报时间</th>
						<th data-options="field:'fproBudgetAmount',align:'center'" width="13%">项目预算（万元）</th>
						<th data-options="field:'fflowStauts',align:'center',formatter:format_fflowStauts" width="7%">审批状态</th>
						<th data-options="field:'operation',align:'left',formatter:format_oper" width="<c:if test="${sbkLx=='xmsb' }">10%</c:if><c:if test="${sbkLx!='xmsb' }">20%</c:if>">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	
	</div>
	
	
	<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
			<div style="width:100%;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 0px">
				<a href="javascript:void(0)" onclick="confirmKm()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
	</div>
</div>


	<script type="text/javascript">
		//分页样式调整
		$(document).ready(
				function() {
					var pager = $('#guibi_pro_info_tab').datagrid().datagrid('getPager'); // get the pager of datagrid
					pager.pagination({
						layout : [ 'sep', 'first', 'prev', 'links', 'next',
								'last'/* ,'refresh' */]
					});	
					
				});
		//展示已选择过的数据
		$('#guibi_pro_info_tab').datagrid({
				onLoadSuccess:function(data){
					//获取页面的所有数据
					var rows = $("#guibi_pro_info_tab").datagrid("getRows"); 
					//获取规避清单的id
					var value=document.getElementsByName("annotation");
					//勾选已选择过的项目行
					for(var i=0;i<rows.length;i++){
						for(var j=0;j<value.length;j++){
								if(rows[i].fproId==value[j].value){
									$(this).datagrid('selectRow',i);
								}
							} 
						}
				},
			});
		
				   
		//点击查询
		function queryGbPro() {
			var fProAppliTime=$('#pro_applitime').textbox('getValue');
			if(checkFProAppliTime(fProAppliTime)==false){
				alert("执行年份格式不正确");
				return false;
			}
			$('#guibi_pro_info_tab').datagrid('load', {
				FProAppliTime : $('#pro_applitime').textbox('getValue'),
				FProName : $('#pro_name').textbox('getValue')
			});
		}
		//检查执行年份的格式
		function checkFProAppliTime(fProAppliTime){
			if(fProAppliTime ==""){ //空可放行
				return true;
			}else {
				 if(fProAppliTime.substring(0,2) =="19" && fProAppliTime.length ==4){ //年份以19年开头的放行
					 return true;
				 } else if(fProAppliTime.substring(0,2) =="20" && fProAppliTime.length ==4){ //年份以20年开头的放行
					 return true;
				 }else{
					 return false;
				 }
			}
		}
		//清除查询条件
		function clearGbTable() {
			$('#pro_applitime').textbox('setValue', '');
			$("#pro_name").textbox('setValue', '');
		}
		//	确认选择  获取所有的id  进行规避操作
		 function confirmKm(){
			 //var data1 = [{ "fproId": '', "pageOrder": '', "fproCode": '', "fproName": '', "typeName": '', "fproAttribute": '', "fproBudgetAmount": '' }];
			 var data1 = [];
			 var rows = $('#guibi_pro_info_tab').datagrid('getChecked');
	 		 var proids = '';
			 for (var i = 0; i < rows.length; i++) {
				 proids += rows[i].fproId + ',';
				 data1.push({ "fproId": rows[i].fproId, "pageOrder": i+1, 
         			"fproCode": rows[i].fproCode, "fproName": rows[i].fproName, 
         			"fproAppliPeople": rows[i].fproAppliPeople, "fproAttribute": rows[i].fproAttribute,
         			"fproBudgetAmount": rows[i].fproBudgetAmount}); 
				 }
			 
			//alert(proids);

			//var json_str = JSON.stringify(data1);
			//alert(json_str);

			$('#proids').val(proids);
            $('#guibi_tab').datagrid("loadData",data1);

			 //新增页面展示规避的列表信息
			closeFirstWindow();
		}
		//时间格式化
		function ProListDateFormat(val) {
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

		function format_fflowStauts(val, row) {
			if (val == 0) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">'
						+ " 暂存" + '</a>';
			} else if (val == 1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">'
						+ " 待审批" + '</a>';
			} else if (val == 2) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">'
						+ " 待审批" + '</a>';
			} else if (val == 3) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">'
						+ " 已审批" + '</a>';
			} else if (val == -1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">'
						+ " 已退回" + '</a>';
			}
		}


		function formatter_libName(val, row) {
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
		function detailPro(proId){
			var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+proId);
			win.window('open');
		}
		function format_oper(value, row, index){
			var v1='${proLibType }';
			var v2='${sbkLx }';
			
			var btn = "";
			btn = btn + "<table><tr style='width: 105px; height:20px'>";
			var btn1 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='detailPro("+row.fproId+")'>" 
						+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
						+ "</a></td>";
			var btn2 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='deletePro("+row.fproId+")'>删除</a></td>";
			var btn3 = "";
			if(v1=='1' && v2=='xmsb' && (row.fflowStauts=='0' || row.fflowStauts=='-1')){//申报库-项目申报库 + 未提交  显示修改
				btn3 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='editPro("+row.fproId+")'>"
						+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
						+"</a></td>";
			}else if(v1=='1' && v2=='xmsp'){//申报库-项目审批库 显示审批
				btn3 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='verdictPro("+row.fproId+")'>"
				+ "<img onmouseover='picVerdictOut(this)' onmouseout='picVerdictOver(this)' src='"+base+"/resource-modality/${themenurl}/verdict2.png'>"
				+ "</a></td>";
			}
		/* 		btn3 = "<td style='width:35px'><a href='javascript:void(0)' style='color:blue' onclick='verdictPro("+row.fproId+")'>"
				+ "<img onmouseover='picVerdictOut(this)' onmouseout='picVerdictOver(this)' src='"+base+"/resource-modality/${themenurl}/verdict2.png'>"
				+ "</a></td>"; */
			//结转
			var btn5 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='overPro("+row.fproId+")'>"
			+ "<img onmouseover='picOverOver(this)' onmouseout='picOverOut(this)' src='"+base+"/resource-modality/${themenurl}/over0.png'>"
			+ "</a></td>";
			
			btn = btn +  btn1 + "    " + btn3 ;
			if(v1==3 ){//结转 
				btn = btn + "    " + btn5 ;
			}
			btn = btn + "</td></tr></table>";
			return btn;
		}
	</script>
</body>
</html>

