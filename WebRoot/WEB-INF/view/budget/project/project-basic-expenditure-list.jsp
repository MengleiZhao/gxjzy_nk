<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 ">
		<!-- 所属库 -->
		<input id="project_list_FProLibType" value="${proLibType }" type="hidden"/>
		<input id="project_list_sbkLx" value="${sbkLx }" type="hidden"/>
	</div>
	
	<div class="list-top">
		<table class="top-table" id="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search-pro" class="queryth" style="padding-left: 5px;width:675px;">
					
					<div class="top-table-search-td" style="width:675px;">
					&nbsp;&nbsp;预算年度&nbsp;
					<input id="pro_list_query_planStartYear" style="width: 150px;height:25px;" class="easyui-numberbox"/>

					&nbsp;&nbsp;项目名称&nbsp;
					<input id="pro_list_query_FProName" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;申报部门&nbsp;
					<input id="pro_list_query_FProAppliDepart" style="width: 150px;height:25px;" class="easyui-textbox"/></br>
					</div>
					<div id='othersearchtd' class="top-table-search-td" hidden="hidden" style="margin-bottom: 10px;">
					&nbsp;&nbsp;项目编码&nbsp;
					<input id="pro_list_query_FProCode" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;负责人&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="pro_list_query_FProAppliPeople" style="width: 150px;height:25px;" class="easyui-textbox"/>
					</div>
					
					
				</td>	
				<td align="right" style="padding-right: 10px">
					<a  id='zk' href="#" onclick="zk()">
						<img style="vertical-align:bottom;text-align:left;"  src="${base}/resource-modality/${themenurl}/button/zk.png" >
					</a>
					<a id='sq' hidden="hidden" href="#" onclick="sq()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/sq.png" >
					</a>
						&nbsp;&nbsp;
					<a href="#" onclick="queryProList('pro_dg_${listid}');">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearProList('pro_dg_${listid}');">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<c:if test="${proLibType==1 && sbkLx=='xmsb' }">
						<a href="#" onclick="addPro()">
							<img src="${base}/resource-modality/${themenurl}/button/jbzcsb1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/jbzcsb2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/jbzcsb1.png')"
							/>
						</a>
					</c:if>
					<c:if test="${proLibType==1 && sbkLx=='xmsb' && settime=='open'}">
						<a href="#" onclick="openSetTime('${timeid}');">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/pzsj1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</c:if>
				</td>
			
		</table>   
	</div>

	<div class="list-table">
		<table id="pro_dg_${listid}" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/project/projectPageData?proLibType=${proLibType}&sbkLx=${sbkLx}&FProOrBasic=0',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'center'" width="15%">基本支出编号</th>
						<th data-options="field:'fproName',align:'center',formatter:formatCellTooltip" width="20%">基本支出名称</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" width="10%">申报时间</th>
						<th data-options="field:'fproBudgetAmount',align:'right',formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">基本支出预算[元]</th>
						<c:if test="${sbkLx=='xmsb' }">
							<th data-options="field:'fflowStauts',align:'center',formatter:format_fflowStauts" width="10%">审批状态</th>
						</c:if>
						<th data-options="field:'operation',align:'center',formatter:format_oper" width="10%">操作</th>
					</tr>
				</thead>
			</table>
	</div>
	<div class="list-top" id="project_resolve_bottom" style="background-color: #f1fcf1;height: 30px">
		<table cellpadding="0" cellspacing="0">
		<tr style="height: 30px">
			<td>
				<a style="color: #ff6800">&nbsp;&nbsp;✧操作说明：项目预算申报时间:&nbsp;&nbsp;<fmt:formatDate value="${timebean.addStartTime }" pattern="yyyy-MM-dd HH:mm"/>&nbsp;&nbsp;~&nbsp;&nbsp;<fmt:formatDate value="${timebean.addEndTime }" pattern="yyyy-MM-dd HH:mm"/>，请注意申报时间及时申报。</a>
			</td>		
		</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
function openSetTime (id){
	var win=creatWin('配置时间', 500,430, 'icon-search', '/project/setAddAndCheckTime?id='+id+'&fDataType=1');
	win.window('open');
}

$("#pro_list_query_FProAppliTime1_"+${listid}).datebox({
    onSelect : function(beginDate){
        $('#pro_list_query_FProAppliTime2_'+${listid}).datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

function initCombobox(){
	$('#pro_query_subject1').combobox({
	    onChange:function(newValue,oldValue){
	       //重置二级分类选择
	        $('#pro_query_subject2').combobox('reload','${base}/project/getSubject2?parentCode='+newValue);
	    }
	});
}

function queryProList(id){ 
	$("#"+id).datagrid('load',{
		FProCode:$('#pro_list_query_FProCode').textbox('getValue').trim(),
		FProName:$('#pro_list_query_FProName').textbox('getValue').trim(),
		FProAppliDepart:$('#pro_list_query_FProAppliDepart').textbox('getValue').trim(),
		FProAppliPeople:$('#pro_list_query_FProAppliPeople').textbox('getValue').trim(),
		planStartYear:$('#pro_list_query_planStartYear').numberbox('getValue'),
	});
}

function clearProList(id){//清除
	$('#pro_list_query_FProCode').textbox('setValue','');
	$('#pro_list_query_FProName').textbox('setValue','');
	$('#pro_list_query_FProAppliDepart').textbox('setValue','');
	$('#pro_list_query_FProAppliPeople').textbox('setValue','');
	$('#pro_list_query_planStartYear').numberbox('setValue','');
	$("#"+id).datagrid('load',{});//重新加载
}

function addPro(){
	 var win=creatWin('基本支出信息申报', 1230,630, 'icon-search', '/project/add?fproOrBasic=0');
	 win.window('open');
}
function detailPro(id){
	var win=creatWin('查看-基本支出信息', 1230,630, 'icon-search', '/project/detail/'+id);
	win.window('open');
}
function editPro(id){
	var win=creatWin('修改-基本支出信息', 1230,630, 'icon-search', '/project/edit/'+id);
	win.window('open');
}
function verdictPro(id){
	var win=creatWin('审批', 1230,630, 'icon-search', "/project/verdict/"+id+"?listid=${listid}");
	win.window('open');
}
function deletePro(id){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: '${base}/project/delete/'+id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success) {
					$.messager.alert('系统提示',data.info,'info');
					$("#pro_dg_${listid }").datagrid('reload');
				}else {
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
}
function expListlawHelp(){
	 //var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
	  //win.window('open');
	if(confirm("按当前查询条件导出？")){
	   var queryForm = document.getElementById("lawHelp_list_form");
		queryForm.setAttribute("action","${base}/demo/expList");
		queryForm.submit();
	}
}

/* function transitionType(val){
	if(val==0){
		return "基本支出";
	}
	if(val==1){
		return "项目支出";
	}
} */
//在线帮助
 function helpDemo(){
	window.open("./resource/onlinehelp/zzzx/demo/help.html");
} 

function overPro(proId){
	if(confirm("确认将该项目转移至结转库？")){
		//需要弹出修改页面提供项目结转修改
		var win=creatWin('结转-项目信息',1230,630,'icon-search',"/project/over/"+proId+"?listid=${listid}");
		win.window('open');
		
	}
}
function format_oper(value, row, index){
	var proLibType = '${proLibType}';//所属库 1：备选库 2：上报库   3：执行中 4：已完结
	var sbkLx = '${sbkLx }';//申报库类型 项目申报xmsb审批xmsp台账xmtz(页面跳转参数)
	var btn = "";
	btn = btn + "<table><tr style='width: 105px; height:20px'>";
	//详情
	var btn1 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='detailPro("+row.fproId+")'>" 
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
				+ "</a></td>";
	//删除
	var btn2 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='deletePro("+row.fproId+")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/delete1.png'>"
				+ "</a></td>";
	var btn3 = "";
	if(proLibType=='1' && sbkLx=='xmsb' && (row.fflowStauts=='0' || row.fflowStauts=='-11' || row.fflowStauts=='-14')){//申报库-项目申报库 + 未提交  显示修改
		//修改
		btn3 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='editPro("+row.fproId+")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
				+ "</a></td>";
	}else if(proLibType=='1' && sbkLx=='xmsp'){//申报库-项目审批库 显示审批
		//审批
		btn3 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='verdictPro("+row.fproId+")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/check1.png'>"
				+ "</a></td>";
	}else {//申报库-项目审批库 显示审批
		btn3 = '<td style="width:25px"><a href="#" onclick="reCall(\'pro_dg_${listid}\','+row.fproId+',\'/project/reCall\')">'
				+ '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'
				+ '</a></td>';
	}
	
	/* var btn3 = "<td style='width:35px'><a href='javascript:void(0)' style='color:blue' onclick='verdictPro("+row.fproId+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/verdict2.png'>"
	+ "</a></td>"; */
	
	//结转
	var btn5 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='overPro("+row.fproId+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/over1.png'>"
	+ "</a></td>";
	
	//采购
	var btn6 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='cgPro("+row.fproId+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/cg1.png'>"
	+ "</a></td>";
	
	/* var btn7 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='htPro("+row.fproId+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/ht1.png'>"
	+ "</a></td>"; */
	
	//支出记录
	var btn7 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='zhichuDetail("+"\""+row.fproCode+"\""+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/zcjl1.png'>"
	+ "</a></td>";
	
	btn = btn +  btn1  + btn3;
	if(proLibType==3 ){//结转 
		btn = btn + " "  + btn6;
	}
	console.log(row.fflowStauts);
	if(proLibType==1 && sbkLx=='xmsb' && (row.fflowStauts==0||row.fflowStauts==-11 || row.fflowStauts=='-14')) {
		btn = btn + btn2;
	}
	if(proLibType==4) {
		btn = btn + btn6 + btn7;
	}
	btn = btn + "</td></tr></table>";
	return btn;
}
function format_fflowStauts(val, row){
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
	} else if (val == 11) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	} else if (val == 12) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	} else if (val == 19) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
	} else if (val == -11) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
	}else if (val == -14) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
	}
}
//设置结项审批状态
function format_fproStauts(val, row) {
	if (val == "0") {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
	} else if (val == "-1") {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
	} else if (val == "9") {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已完结" + '</a>';
	} else  if (val == "1"){
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	}else  {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未结项" + '</a>';
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

function choose_depart_prolist(){
	var win = creatFirstWin('选择-申报部门',600,500,'icon-search','/project/choDepart?inputId=xmsb_query_FProAppliDepart');
	win.window('open');
}

//支出记录
function zhichuDetail(proCode) {
	var win = parent.creatWin('支出记录追踪', 970, 580, 'icon-search', '/project/zhichuDetail?fProCode='+proCode);
	win.window('open');
}
function cgPro(proId) {
	var win = creatFirstWin('采购信息',1300,580,'icon-search','/cgsqsp/list?proId='+proId);
	win.window('open');
	
}
function htPro(proId) {
	var win = creatFirstWin('合同信息',1300,580,'icon-search','/Ledger/list?proId='+proId);
	win.window('open');
}
</script>
</body>