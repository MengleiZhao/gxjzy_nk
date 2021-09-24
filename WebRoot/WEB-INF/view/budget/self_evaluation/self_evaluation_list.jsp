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
					<input id="eval_pro_proCode" name="fproCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;项目名称
					<input id="eval_pro_proName" name="fproName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;<a href="#" onclick="queryEvalPro();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearEvalProTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table> 
	</div>
		
		
		
	<div class="list-table">
		<table id="eval_pro_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/selfevaluation/evalprojectPage?FExt7=${type }',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'fproId',hidden:true"></th>
					<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
					<th data-options="field:'fproCode',align:'left'" width="20%">项目编号</th>
					<th data-options="field:'fproName',align:'left'" width="16%">项目名称</th>
					<th data-options="field:'fproAppliPeople',align:'left'" width="8%">申报人</th>
					<th data-options="field:'fproAppliDepart',align:'left'" width="11%">申报部门</th>
					<th data-options="field:'typeName',align:'left'" width="10%">项目类别</th>
					<th data-options="field:'fproAppliTime',align:'left',resizable:false,sortable:true,formatter: ProListDateFormat" width="12%">申报时间</th>
					<th data-options="field:'fproBudgetAmount',align:'left'" width="10%">项目预算（万元）</th>
					<th data-options="field:'operation',align:'left',formatter:format_oper" width="9%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	

</div>

	<script type="text/javascript">

	
	//点击查询
		function queryEvalPro() {
			//alert($('#apply_time').val());
			$('#eval_pro_tab').datagrid('load', {
				FProCode:$('#eval_pro_proCode').val(),
				FProName:$('#eval_pro_proName').val()
			});
		}
		//清除查询条件
		function clearEvalProTable() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#eval_pro_proCode").textbox('setValue','');
			$("#eval_pro_proName").textbox('setValue','');
			$('#eval_pro_tab').datagrid('load',{//清空以后，重新查一次
			});
		}
		
	//检查执行年份的格式
		function checkPlanStartYear(planStartYear){
			if(planStartYear ==""){ //空可放行
				return true;
			}else {
				 if(planStartYear.substring(0,2) =="19" && planStartYear.length ==4){ //年份以19年开头的放行
					 return true;
				 } else if(planStartYear.substring(0,2) =="20" && planStartYear.length ==4){ //年份以20年开头的放行
					 return true;
				 }else{
					 return false;
				 }
			}
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
			return '<table><tr style="width: 75px;height:20px">'+
			/* '<td style="width:25px"><a href="javascript:void(0)" style="color:blue" onclick=detailPro('+row.fproId+')>'+ 
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			'</a></td>'+ */
		   '<td style="width: 25px"><a href="#" onclick=proEval('+ row.fproId +') class="easyui-linkbutton">'+ 
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/selfeval1.png">'+
		   '</a></td></tr></table>';
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/selfeval1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/selfeval2.png';
	}		
	//进行项目自评
	function proEval(id){
		var win = creatWin(' ', 970, 630, 'icon-search',"/selfevaluation/proeval?id=" + id+"&type="+${type});
		win.window('open'); 
	}
	/* function detailPro(proId){
		var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+proId);
		win.window('open');
	} */
	
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

