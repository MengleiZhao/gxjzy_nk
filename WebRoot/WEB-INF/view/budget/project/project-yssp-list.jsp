<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
			<input id="project_list_FProLibType" value="${proLibType }" type="hidden"/>
			<input id="project_list_sbkLx" value="${sbkLx }" type="hidden"/>
		<table class="top-table" cellpadding="0" cellspacing="0">
			<!-- 所属库 -->
				<tr>
					<!-- <td class="top-table-td1">
						项目编号：
					</td> 
					<td class="top-table-td2">
						<input id="pro_query_fProCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					</td> -->
					
					<td class="top-table-td1" style="width: 120px">
						项目开始执行年份：
					</td> 
					<td class="top-table-td2">
						<input id="pro_query_subject1" 
     					 class="easyui-textbox" style="height:25px; font-size: 14px;"
     					 data-options=""  value="2019"/>
					</td>
					
					
					
					
					<c:if test="${proLibType==3}">
						<td class="top-table-td2">
							<div style="display: none">
							<input id="pro_query_FProAppliDepart"  style="width: 150px;height:25px;" class="easyui-textbox" 
								prompt="<双击选择申报部门>" readonly="readonly" ></input>
							</div>
						</td>
						
					</c:if>
					<td style="width: 26px;">
						<a href="javascript:void(0)" onclick="queryPro();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"
							/>
						</a>
					</td>
					
					<td style="width: 8px;"></td>
					
					<td style="width: 26px;">
						<a href="#" onclick="clearProTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"
							/>
						</a>
					</td>
					
					<c:if test="${proLibType==1 && sbkLx=='xmsb' }">
						<td align="right" style="padding-right: 10px">
							<a href="#" onclick="addPro()">
								<img src="${base}/resource-modality/${themenurl}/button/xmsb1.png"
									onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xmsb2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xmsb1.png')"
								/>
							</a>
						</td>
					</c:if>
					
					<td align="right" style="padding-right: 10px">
						项目预算总额：                                                     上报项目总额：
						<input type="button" value="通过">
						<input type="button" value="不通过">
						<input type="button" value="查看流转">
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
				
		</table>   
	</div>



	<div class="list-table">
		<table id="pro_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/project/projectPageData?proLibType=${proLibType }&sbkLx=xmtz',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'left'" width="10%">项目编号</th>
						<th data-options="field:'fproName',align:'left'" width="15%">项目名称</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ProListDateFormat" width="10%">申报时间</th>
						<th data-options="field:'fproBudgetAmount',align:'left',formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">项目预算（元）</th>
						<th data-options="field:'sbzt',align:'center',formatter:format_fflowStauts" width="10%">上报状态</th>
						<th data-options="field:'fflowStauts',align:'center',formatter:format_fflowStauts" width="10%">审批状态</th>
						<th data-options="field:'operation',align:'left',formatter:format_oper" width="10%">操作</th>
					</tr>
				</thead>
			</table>
	</div>
</div>


<script type="text/javascript">


function initCombobox(){
	$('#pro_query_subject1').combobox({
	    onChange:function(newValue,oldValue){
	       //重置二级分类选择
	        $('#pro_query_subject2').combobox('reload','${base}/project/getSubject2?parentCode='+newValue);
	    }
	});
}
/* $(function(){
	//定义双击事件
	$('#pro_dg').datagrid({
		onDblClickRow :function(rowIndex,rowData){
			alert(rowData.fproId)
			detailPro(rowData.fproId);
		}
	});
	
}); */ 
/* $(function(){//测试
	$.ajax({
		url:'${base}/project/projectPageData',
		dataType:'text',
		success:function(data){
			alert(data)
		}
	})
}) */
function queryPro(){  
	$('#pro_dg').datagrid({
		url:'${base}/project/projectPageData',
		queryParams:{
			fProCode:$('#pro_query_fProCode').textbox('getValue'),
			firstLevelCode:$('#pro_query_subject1').combobox('getValue'),
			secondLevelCode:$('#pro_query_subject2').combobox('getValue'),
			FProAppliDepart:$('#pro_query_FProAppliDepart').textbox('getValue'),
			
			proLibType:$('#project_list_FProLibType').val(),
			sbkLx:$('#project_list_sbkLx').val()
		}
	});
}
function addPro(){
	 var win=creatWin('项目信息申报',1230,630,'icon-search','/project/add');
	  win.window('open');
}
function detailPro(proId){
	var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+proId);
	win.window('open');
}
function editPro(id){
	var win=creatWin('修改-项目信息',1230,630,'icon-search',"/project/edit/"+id);
	win.window('open');
}
function verdictPro(id){
	var win=creatWin('审批-项目信息',1230,630,'icon-search',"/project/verdict/"+id);
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
						$("#pro_dg").datagrid('reload');
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
//在线帮助
 function helpDemo(){
	window.open("./resource/onlinehelp/zzzx/demo/help.html");
} 
function test(val){
	alert('test')
}
function overPro(proId){
	if(confirm("确认将该项目转移至结转库？")){
		$.ajax({
			url:'${base}/project/over/'+proId,
			dataType:'json',
			success:function(data){
				alert(data.info);
				if(data.success){
					$("#pro_dg").datagrid('reload'); 
				}else{
				}
			}
		});
	}
}
function format_oper(value, row, index){
	var v1=$('#project_list_FProLibType').val();
	var v2=$('#project_list_sbkLx').val();
	
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
function clearProTable(){
	$('#pro_query_fProCode').textbox('setValue','');
	$('#pro_query_subject1').textbox('setValue','');
	$('#pro_query_subject2').combobox('setValue','');
	$('#pro_query_FProAppliDepart').textbox('setValue','');
	queryPro();
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
function picVerdictOver(obj){
	obj.src=base+'/resource-modality/${themenurl}/verdict2.png';
}
function picVerdictOut(obj){
	obj.src=base+'/resource-modality/${themenurl}/verdict1.png';
}
function picFinishOver(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/finish1.png';
}
function picFinishOut(obj){
	obj.src=base+'/resource-modality/${themenurl}/finish2.png';
}
function picOverOver(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/over1.png';
}
function picOverOut(obj){
	obj.src=base+'/resource-modality/${themenurl}/over0.png';
}

function choose_depart_prolist(){
	var win = creatFirstWin('选择-申报部门',600,500,'icon-search','/project/choDepart');
	win.window('open');
}
</script>
</body>

