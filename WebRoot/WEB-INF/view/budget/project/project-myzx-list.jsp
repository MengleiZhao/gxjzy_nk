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
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search-pro" class="queryth">
					<%-- &nbsp;&nbsp;项目编号&nbsp;
					<input id="pro_list_query_fproCode_${listid}" style="width: 150px;height:25px;" class="easyui-textbox"/>
					
					&nbsp;&nbsp;项目名称&nbsp;
					<input id="pro_list_query_fproName_${listid}" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;支出类型&nbsp;
					<select id="essb_FProOrBasic_${listid}" class="easyui-combobox" data-options="required:true,editable:false" name="FProOrBasic" style="height:25px; width: 150px;">
     					<option selected="selected" value="">-请选择-</option>
     					<option value="0">基本支出</option>
     					<option value="1">项目支出</option>
     				</select>
					<c:if test="${listid==2}">
						&nbsp;&nbsp;上报状态：&nbsp;
						<input id="pro_list_query_FFlowStauts_${listid}" style="width: 150px;height: 25px" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',url:'${base}/lookup/lookupsJson?parentCode=SPZT',method:'POST',valueField:'code',textField:'text',editable:false"/>
					</c:if>
					
					<c:if test="${listid==5}">
						&nbsp;&nbsp;执行进度区间&nbsp;
						<select id="pro_list_query_efficiency1_${listid}" name="" style="width: 150px;height:25px;" class="easyui-combobox">
							<option value="">--请选择--</option>
							<%@include file="../../percentage.jsp" %>
						</select>
						&nbsp;-&nbsp;
						<select id="pro_list_query_efficiency2_${listid}" name="" style="width: 150px;height:25px;" class="easyui-combobox">
							<option value="">--请选择--</option>
							<%@include file="../../percentage.jsp" %>
						</select>
					</c:if>
					
					<c:if test="${listid==6||listid==8 || listid==9}">
						&nbsp;&nbsp;申报时间&nbsp;
						<input id="pro_list_query_FProAppliTime1_${listid}" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[pro_list_query_FProAppliTime2_${listid}]"/>
						&nbsp;-&nbsp;
						<input id="pro_list_query_FProAppliTime2_${listid}" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[pro_list_query_FProAppliTime1_${listid}]"/>
					</c:if>
					&nbsp;&nbsp;
					<a href="#" onclick="queryProList(${listid});">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearProList(${listid});">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td> --%> 
					<%@include file="project-search-base.jsp" %>
				</td>	
				<td align="right" style="padding-right: 10px">
					<a  id='zk' href="#" onclick="zk()">
						<img style="vertical-align:bottom;text-align:left;"  src="${base}/resource-modality/${themenurl}/button/zk.png" >
					</a>
					<a id='sq' hidden="hidden" href="#" onclick="sq()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/sq.png" >
					</a>	
					&nbsp;&nbsp;
					<a href="#" onclick="queryProList('pro_dg_listid');">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearProList('pro_dg_listid');">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>



	<div class="list-table">
		<table id="pro_dg_listid" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/project/projectPageData?proLibType=${proLibType}&sbkLx=${sbkLx}',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'center'" width="15%">项目编号</th>
						<th data-options="field:'fproName',align:'center',formatter:format_fproName" width="15%">项目名称</th>
						<th data-options="field:'bigProName',align:'center',formatter:isBig" width="15%">所属大项目名称</th>
						<th data-options="field:'fproOrBasic',align:'center',formatter:transitionType1" width="10%">支出类型</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ProListDateFormat" width="10%">申报时间</th>
						<th data-options="field:'fproBudgetAmount',align:'right',formatter:listToFixed" width="10%">项目预算[元]</th>
						<th data-options="field:'syAmount',align:'right',formatter:listToFixed" width="10%">剩余金额[元]</th>
						<th data-options="field:'djAmount',align:'right',formatter:listToFixed" width="10%">冻结金额[元]</th>
						<th data-options="field:'efficiency',align:'center',formatter:zbzxjd" width="10%">执行进度</th>
						<th data-options="field:'fjzspzt',align:'center',formatter:format_fproStauts" width="10%">结项状态</th>
						<th data-options="field:'operation',align:'center',formatter:format_oper" width="10%">操作</th>
					</tr>
				</thead>
			</table>
	</div>
</div>


<script type="text/javascript">
$("#pro_list_query_FProAppliTime1_"+${listid}).datebox({
    onSelect : function(beginDate){
        $('#pro_list_query_FProAppliTime2_'+${listid}).datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

/* 
function queryProList(id){ 
	if(id==1){
		$("#pro_dg_"+id).datagrid('load',{
			//FProCode:$("#pro_list_query_fproCode_"+id).textbox('getValue').trim(), 
			FProName:$("#pro_list_query_fproName_"+id).textbox('getValue').trim(),
			FProOrBasic:$("#essb_FProOrBasic_"+id).textbox('getValue').trim(),
		});
	}
	if(id==2){
		var flowStauts = $("#pro_list_query_FFlowStauts_"+id).textbox('getValue');
		if(flowStauts=="SPZT-01"){
			flowStauts="-11";//已退回-11（备选库）
		} else if(flowStauts=="SPZT-02"){
			flowStauts="0";//暂存0（备选库）
		} else if(flowStauts=="SPZT-03"){
			flowStauts="11";//待审批11（备选库）
		} else if(flowStauts=="SPZT-04"){
			flowStauts="19";//已审批19（备选库）
		} 
		
		$("#pro_dg_"+id).datagrid('load',{
			// FProCode:$("#pro_list_query_fproCode_"+id).textbox('getValue').trim(), 
			FProName:$("#pro_list_query_fproName_"+id).textbox('getValue').trim(),
			FProOrBasic:$("#essb_FProOrBasic_"+id).textbox('getValue').trim(),
			FFlowStauts:flowStauts,
		});
	}
	if(id==5){
		$("#pro_dg_"+id).datagrid('load',{
			// FProCode:$("#pro_list_query_fproCode_"+id).textbox('getValue').trim(), 
			FProName:$("#pro_list_query_fproName_"+id).textbox('getValue').trim(),
			efficiency1:$("#pro_list_query_efficiency1_"+id).textbox('getValue'),
			FProOrBasic:$("#essb_FProOrBasic_"+id).textbox('getValue').trim(),
			efficiency2:$("#pro_list_query_efficiency2_"+id).textbox('getValue')
		});
	}
	if(id==6||id==8||id==9){
		$("#pro_dg_"+id).datagrid('load',{
			// FProCode:$("#pro_list_query_fproCode_"+id).textbox('getValue').trim(), 
			FProName:$("#pro_list_query_fproName_"+id).textbox('getValue').trim(),
			FProAppliTime1:$("#pro_list_query_FProAppliTime1_"+id).datebox('getValue').trim(),
			FProOrBasic:$("#essb_FProOrBasic_"+id).textbox('getValue').trim(),
			FProAppliTime2:$("#pro_list_query_FProAppliTime2_"+id).datebox('getValue').trim(),
		});
	}
} 

function clearProList(id){
	$("#essb_FProOrBasic_"+id).combobox('setValue','');
	if(id==1){
		// $("#pro_list_query_fproCode_"+id).textbox('setValue',''); 
		$("#pro_list_query_fproName_"+id).textbox('setValue','');
	}
	if(id==2){
		$("#pro_list_query_FFlowStauts_"+id).textbox('setValue','');
		// $("#pro_list_query_fproCode_"+id).textbox('setValue',''); 
		$("#pro_list_query_fproName_"+id).textbox('setValue','');
	}
	if(id==5){
		// $("#pro_list_query_fproCode_"+id).textbox('setValue',''); 
		$("#pro_list_query_fproName_"+id).textbox('setValue','');
		
		 $("#pro_list_query_efficiency1_"+id).combobox('setValue','');
		$("#pro_list_query_efficiency2_"+id).combobox('setValue','');
	}
	if(id==6||id==8||id==9){
		// $("#pro_list_query_fproCode_"+id).textbox('setValue',''); 
		$("#pro_list_query_fproName_"+id).textbox('setValue','');
		$("#pro_list_query_FProAppliTime1_"+id).datebox('setValue','');
		$("#pro_list_query_FProAppliTime2_"+id).datebox('setValue','');
	}
	$("#pro_dg_"+id).datagrid('load',{});
} */

function detailPro(proId){
	var win=creatWin('查看-结项信息',970, 580,'icon-search',"/projectknot/detail?id=" + proId);
	win.window('open');
}
function editPro(id){
	var win=creatWin('修改-项目信息',970, 580,'icon-search',"/projectknot/edit?proId="+id);
	win.window('open');
}
function verdictPro(id){
	var win=creatWin('审批-项目信息',1230,630,'icon-search',"/project/verdict/"+id+"?listid=${listid}");
	win.window('open');
}
function deletePro(id){
		if(confirm("确认删除吗？")){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/project/delete/'+id,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$("#pro_dg_${listid }").datagrid('reload');
					}else{
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

function overPro(proId){
	if(confirm("确认将该项目转移至结转库？")){
		/* $.ajax({
			url:base+'/project/over/'+proId,
			dataType:'json',
			success:function(data){
				alert(data.info);
				if(data.success){
					$("#pro_dg_${listid }").datagrid('reload'); 
				}else{
				}
			}
		}); */
		
		//需要弹出修改页面提供项目结转修改
		var win=creatWin('结转-项目信息',890,580,'icon-search',"/project/over/"+proId+"?listid=${listid}");
		win.window('open');
		
	}
}
//项目名称加链接
function format_fproName(value, row){
	return "<a href='javascript:void(0)' style='color:blue' onclick='detailPro("+row.fproId+")'>" +row.fproName+ "</a>";
}
//操作
function format_oper(value, row, index){
	var btn =  "<table><tr style='width: 105px; height:20px'>";
	//详情
	var btn1 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='detailPro("+row.fproId+")'>" 
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
				+ "</a></td>";
	//删除
	var btn2 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='deletePro("+row.fproId+")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/delete1.png'>"
				+"</a></td>";
	//修改
	var btn3 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='editPro("+row.fproId+")'>"
			+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
			+"</a></td>";
	//结项
	var btn4 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='finishPro("+row.fproId+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/gongyong1.png'>"
	+ "</a></td>";
	//结转
	var btn5 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='overPro("+row.fproId+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/over1.png'>"
	+ "</a></td>";
	
	//采购
	var btn6 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='cgPro("+"\""+row.fproCode+"\""+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/cg1.png'>"
	+ "</a></td>";
	
	
	//项目支出登记
	var btn7 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='registerProDetail("+"\""+row.fproId+"\""+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/dengji1.png'>"
	+ "</a></td>";
	
	//撤回
	var btn8 = "<td style='width:25px'><a href='#' onclick='reCall(\"pro_dg_listid\","+row.fproId+",\"/project/ProReCall\")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/reCall1.png'>"
				+ "</a></td>";
	if(row.fjzspzt=='-1' || row.fjzspzt=='-4'){//被退回，就修改和查看
		btn = btn +btn1+btn5 ;
	}else if(row.fjzspzt=='1'){ //送审了，只能查看
		btn = btn +btn1+btn8 ;
	}else if(row.fjzspzt=='0' ){ //暂存，可以查看和修改
		btn = btn +btn1 +btn5;
	}else if(row.fjzspzt=='9' ){
		btn = btn +btn1 ;
	}else{
		btn = btn +btn5 ;//未发起，可以点击结转
	}
	var user = '${user}';
	if(user=='1'){
		btn = btn +btn4+btn6+btn7+ "</td></tr></table>";
	}else{
		btn = btn +btn4+btn6+ "</td></tr></table>";
	}
	return btn;
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

function choose_depart_prolist(){
	var win = creatFirstWin('选择-申报部门',600,500,'icon-search','/project/choDepart?inputId=xmsb_query_FProAppliDepart');
	win.window('open');
}
//结项
 function finishPro(proId) {
	var win = parent.creatWin('部门', 970, 580, 'icon-search', '/project/deptList?id='+proId);
			//?id='+proId
	win.window('open');
} 

//项目支出登记
function registerProDetail(proId) {
	var win = parent.creatWin('项目支出登记', 970, 580, 'icon-search', '/indexDetailRegister/registerProJsp?proId='+proId);
	win.window('open');
}

//采购
function cgPro(fproCode) {
	var win = creatFirstWin('采购信息',1300,580,'icon-search','/cgsqsp/list?proId='+fproCode+"&sign=0");
	win.window('open');
	
}
function htPro(proId) {
	var win = creatFirstWin('合同信息',1300,580,'icon-search','/Ledger/list?proId='+proId);
	win.window('open');
}

function transitionType1(val){
	if(val==0){
		return "基本支出";
	}
	if(val==1){
		return "项目支出";
	}
}
</script>
</body>

