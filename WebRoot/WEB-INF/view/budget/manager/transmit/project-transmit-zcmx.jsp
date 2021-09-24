<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style type="text/css">
	 .datagrid-cell {
	     text-overflow: ellipsis;
	 }
	 /* 边框样式 */
	.datagrid-body td{
	  border: none;
	}
	.datagrid-htable tr td{
		 border: none;
	}
	.progressbar-value,
	.progressbar-value .progressbar-text {
	  color: #000000;		
	}		
}
</style>
<!-- 查询区 -->
  <div data-options="region:'north'" style="height:36px;">
		<div style="height:100%">
			<table cellpadding="0" cellspacing="0" style="height: 100%; width:100%;">
				<tr>
					<td>
						<span style="font-size: 12px; margin-left:10px;color: #182C4D;">操作人</span>
						<input id="tranject_zcmx_name" style="width: 90px;height:22px;" class="easyui-textbox"/>
						<span style="font-size: 12px; color: #182C4D;">操作时间</span>
						<input id="tranject_zcmx_time1" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateBegin[tranject_zcmx_time2]"/>
						&nbsp;-&nbsp;
						<input id="tranject_zcmx_time2" style="width: 150px;height:25px;" class="easyui-datebox" editable="false" validType="dateEnd[tranject_zcmx_time1]"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" onclick="searchData();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearSearchData();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					
					<td align="right" style="padding:7px 10px 0px 0px;width:70px;">
						<a href="#" onclick="exportData3();">
							<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
							/>
						</a>
					</td>
				</tr>
			</table>   
		</div>
  </div>
  
  
<div style="height: 390px; ">
<table id="index-xdmx" class="easyui-datagrid"
	data-options="collapsible:true,url:'${base}/transmit/zcmxPage?code=${code}',
	method:'post',fit:true,pagination:true,singleSelect: false,
	selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true">
		<thead>
			<tr>
				<th data-options="field:'lId',hidden:true"></th>
				<th data-options="field:'num',align:'center'" style="width: 6%">序号</th>
				<th data-options="field:'time',align:'center',formatter: ChangeDateFormat" style="width: 15%">操作时间</th>
				<th data-options="field:'username',align:'center'" style="width: 8%">操作人</th>
				<th data-options="field:'amount',align:'right',formatter:getPlus" style="width: 12%">支出金额(元)</th>
				<th data-options="field:'fType',align:'center',formatter: zcmxYT" style="width: 10%">支出事项</th>
				<th data-options="field:'department',align:'center'" style="width: 15%">申请部门</th>
				<th data-options="field:'indexCode',align:'center'" style="width: 12%">指标编码</th>
				<th data-options="field:'indexName',align:'left'" style="width: 18%">指标名称</th>
				<th data-options="field:'cz',align:'center',formatter:zcmxCZ" style="width: 5%">操作</th>
			</tr>
		</thead>
	</table>
</div>

<div style="height:30px; margin-top:10px;" align="center">
	<a href="javascript:void(0)" onclick="closeFreeWindow('four_window')">
	<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
</div>


<form id="form_data_export_excel" method="post" >
	<input type="hidden" id="list_index_export_indexCode" name="code" value="${code}">
	<input type="hidden" id="list_index_export_userName" name="userName" value="">
	<input type="hidden" id="list_index_export_time1"  name="searchTime1" value="">
	<input type="hidden" id="list_index_export_time2"  name="searchTime2" value="">
</form>
<script type="text/javascript">

$("#tranject_zcmx_time1").datebox({
    onSelect : function(beginDate){
        $('#tranject_zcmx_time2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
//导出
function exportData3(){
		
	if(confirm('是否按查询条件导出？')){
		var userName=$('#tranject_zcmx_name').val();
		var time1=$('#tranject_zcmx_time1').val();
		var time2=$('#tranject_zcmx_time2').val();
		
		$("#list_index_export_userName").val(userName);
		$("#list_index_export_time1").val(time1);
		$("#list_index_export_time2").val(time2);
		
		$("#form_data_export_excel").attr('action','${base}/transmit/exportData3');
		$("#form_data_export_excel").submit();
	}
}


//查询
function searchData() {
	var userName=$("#tranject_zcmx_name").textbox('getValue').trim();
	var time1=$("#tranject_zcmx_time1").datebox('getValue').trim();
	var time2=$("#tranject_zcmx_time2").datebox('getValue').trim();
	$('#index-xdmx').datagrid('load',{
		userName:userName,
		searchTime1:time1,
		searchTime2:time2
	});
}
//清除查询条件
function clearSearchData() {
	$("#tranject_zcmx_name").textbox('setValue','');
	$("#tranject_zcmx_time1").textbox('setValue','');
	$("#tranject_zcmx_time2").textbox('setValue','');
	$('#index-xdmx').datagrid('load',{//清空以后，重新查一次
	});
}




function zcmxCZ(val, row) {
	var url = "'"+row.url+"'";
	
	return'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	   '<a href="#" onclick="editZCMX(' + url + ')" class="easyui-linkbutton">'+
	   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
	   '</a></td></tr></table>';
}

function zcmxYT(val, row) {
	//1、收入	2、还款	3、直接报销		4、申请报销		5、借款	6、采购支付		7、合同报销
	if(val==1) {
		return "收入";
	} else if(val==2) {
		return "还款";
	} else if(val==3) {
		return "直接报销";
	} else if(val==4) {
		return "申请报销";
	} else if(val==5) {
		return "借款";
	} else if(val==6) {
		return "采购支付";
	} else if(val==7) {
		return "合同报销";
	}
}

function editZCMX(url) {
	var type = url.substring(1,8);
	if(type=='ull') {
		alert("没有传入地址");
	} else if(type=='project'){
		var win = creatWin('查看', 1230,630, 'icon-search',url);
		win.window('open');
	}  else if(type=='Enforci') {
		var win = creatFirstWin('查看', 970, 580,'icon-search',url);
		win.window('open');
	}  else {
		var win = creatWin('查看', 970, 580, 'icon-search',url);
		win.window('open');
	}
}
//金额转为正数
function getPlus(val){
	if(val != null && val != ""){
		return Math.abs(val.toFixed(2));
	} else {
		val=0;
		return  Math.abs(val.toFixed(2));
	}
}
</script>
