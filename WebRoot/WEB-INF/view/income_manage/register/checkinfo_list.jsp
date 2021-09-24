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
		
		<div class="tabletop">
			<table style="font-size: 12px;">
					<tr>
						<td style="width: 80px;">项目编号：</td>
						<td style="width: 140px">
							<input id="pro_code" name=""style="width: 150px;height:25px;" class="easyui-textbox"></input>
						</td>
						<td style="width: 80px;">项目名称：</td>
						<td style="width: 140px">
							<input id="pro_name" name=""style="width: 150px;height:25px;" class="easyui-textbox"></input>
						</td>
						
						<td style="width: 30px;"></td>				
						<td style="width: 26px;">
							<a href="#" onclick="queryApply();">
								<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>				
						<td style="width: 3px;"></td>			
						<td>
							<a href="#" onclick="clearTable();">
								<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>						
					</tr>
				</table> 
		</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 405px;">	
			<table id="zb_tab"
				data-options="collapsible:true,url:'${base}/project/projectPageData',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'center'" width="22%">项目编号</th>
						<th data-options="field:'fproName',align:'center'" width="15%">项目名称</th>
						<th data-options="field:'typeName',align:'center'" width="12%">项目类型</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ProListDateFormat" width="8%">申报时间</th>
						<th data-options="field:'fproBudgetAmount',align:'left'" width="10%">项目预算（万元）</th>
						<th data-options="field:'fflowStauts',align:'center',formatter:format_fflowStauts" width="10%">审批状态</th>
						<!-- <th data-options="field:'operation',align:'center',formatter:format_oper" width="8%">操作</th> -->
						<th data-options="field:'fproLibType',align:'center',formatter:formatter_libName" width="7%">所属库</th> -->
				</tr>
				</thead>
			</table>
		</div>
	
	</div>
	
	<div data-options="region:'south'" style="text-align: center;">
		<a href="javascript:void(0)" onclick="check()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeFirstWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</div>

	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#zb_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	
	//点击查询
	 function queryApply() {
		$('#zb_tab').datagrid('load',{
			fProCode : $('#pro_code').textbox('getValue'),
			FProName : $('#pro_name').textbox('getValue')
		});
	}
		//清除查询条件
		function clearTable() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#pro_code").textbox('setValue','');
			$("#pro_name").textbox('setValue','');
		}
	
	//显示搜索
	function spread() {
		$('#helpTr').css("display", "");
		$('#retract').css("display", "");
		$('#spread').css("display", "none");
	}
	//隐藏搜索
	function retract() {
		$('#helpTr').css("display", "none");
		$('#retract').css("display", "none");
		$('#spread').css("display", "");
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
	

/* 叶注销 */
	/* //操作栏创建
	function format_oper(val, row) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick=check("'+ row.fproCode +'","'+row.fproName+'") class="easyui-linkbutton">'+ 
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td></tr></table>';
	}
	 */
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}		
 	
	
	//选择 选中数据  
		function check(code,name) {
		//叶添加
			var index=$('#zb_tab').datagrid('getRowIndex',$('#zb_tab').datagrid('getSelected'));
			var tr = $('#zb_tab').datagrid('getRows');
			var name = $(tr[index])[0].fproName;
			var code = $(tr[index])[0].fproCode;
		
			$("#F_fproCode").textbox('setValue', code);
			$("#F_fproName").val(name);
			closeFirstWindow();

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

