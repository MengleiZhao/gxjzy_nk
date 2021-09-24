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
						
						<c:if test="${sbkLx=='yssb'}">
							<a href="#" onclick="ysplsb();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/plsb1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</c:if>
						<c:if test="${sbkLx=='yssp'}">
							<a href="javascript:void(0)" onclick="yssp();">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
							<a href="javascript:void(0)" onclick="">
					 				<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</c:if>
						
						<a href="#" onclick="">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/cklz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
				
		</table>   
	</div>



	<div class="list-table">
		<table id="ys_pro_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/project/yxprojectPage',
			method:'post',fit:true,pagination:true,singleSelect: false,scrollbarSize:0,
			selectOnCheck: true,remoteSort:true,nowrap:false,striped: true,fitColumns:true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'fproId',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fproCode',align:'left'" width="10%">项目编号</th>
						<th data-options="field:'fproName',align:'left'" width="15%">项目名称</th>
						<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
						<th data-options="field:'fproAppliDepart',align:'center'" width="10%">申报部门</th>
						<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: ProListDateFormat" width="10%">申报时间</th>
						<th data-options="field:'fproBudgetAmount',align:'left'" width="10%">项目预算（元）</th>
						<th data-options="field:'fext4',align:'center',formatter:yssbzt" width="10%">上报状态</th>
						<th data-options="field:'fflowStauts',align:'center',formatter:ysspzt" width="10%">审批状态</th>
						<th data-options="field:'operation',align:'left'" width="10%">操作</th>
					</tr>
				</thead>
			</table>
	</div>
</div>


<script type="text/javascript">
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



//一上上报状态
function yssbzt(val,row) {
	if(val=='10'){
		return "未上报";
	}
	if(val=='11'){
		return "已上报";
	}
}
//一上审批状态
function ysspzt(val,row) {
	if(val=='21'){
		return "待审批";
	}
	if(val=='29'){
		return "已审批";
	}
}


//一上批量上报
function ysplsb() {
	var data="";
	var checkedItems = $('#ys_pro_dg').datagrid('getChecked');
	$.each(checkedItems, function(index, item){
    	data +=item.fproId + ',';
    }); 
	
	
	var data2="";
	var checkedItems = $('#ys_pro_dg').datagrid('getRows');
	$.each(checkedItems, function(index, item){
    	data2 +=item.fproId + ',';
    });  
	
	if(data=='') {
		alert('请选择申报项目');
	} else {
		$.ajax({ 
			type: 'POST', 
			url: base+'/project/yssb?fproIdLi='+data+'&fproIdLi2='+data2,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$("#ys_pro_dg").datagrid('reload'); 
					$("#indexdb").datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		});
	}
}

function yssp() {
	var data="";
	var checkedItems = $('#ys_pro_dg').datagrid('getRows');
	$.each(checkedItems, function(index, item){
    	data +=item.fproId + ',';
    });
	
	$.ajax({ 
		type: 'POST', 
		url: base+'/project/yssp?fproIdLi='+data,
		dataType: 'json',  
		success: function(data){ 
			if(data.success){
				$.messager.alert('系统提示',data.info,'info');
				$("#ys_pro_dg").datagrid('reload'); 
				$("#indexdb").datagrid('reload');
			}else{
				$.messager.alert('系统提示',data.info,'error');
			}
		} 
	});
}
</script>
</body>

