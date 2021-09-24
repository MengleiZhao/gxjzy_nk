<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body style="background-color: #eff5f7">


<script type="text/javascript">
var base='${base}';
var queryYear = '${year}';
var queryDepartId = '${departId}';
</script>

<style type="text/css">
</style>


<div class="easyui-layout" style="width:100%;height:100%; 
  	background: #fff; ">
  	<div  style="height:10px;">
	</div>
<div style="width:790px;padding-left:20px;">
				<div class="easyui-accordion" data-options="" style=" width:99%;">
					<div title="指标信息" data-options="iconCls:'icon-xxlb'" style="width:760px; height: 250px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width:760px;padding-top: 10px;">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>归属部门</td>

								<td class="td2">
									<input style="width: 200px;" name="indexCode" class="easyui-textbox"
									value="${bean.deptName}" readonly="readonly"/>
								</td>
								
								<td class="td3" ></td>
								<td class="td1"><span class="style1">*</span>部门编码</td>

								<td class="td2">
									<input style="width: 200px;" name="indexName" class="easyui-textbox"
									value="${bean.deptCode}" readonly="readonly"/>
								</td>
								
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>二级名称</td>
								<td class="td2">
									<input style="width: 200px;" class="easyui-textbox" readonly="readonly"
									value="${bean.expItemName}" readonly="readonly">
								</td>
								
								<td class="td3">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="bId" value="${bean.bId}" />
									<!-- 部门编码 --><input type="hidden" name="deptCode" value="${bean.deptCode}" />
									<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}"/>
								</td>
								<td class="td1"><span class="style1">*</span>二级代码</td>

								<td class="td2">
									<input style="width: 200px;" name="deptName" class="easyui-textbox"
									value="${bean.expItemCode}" readonly="readonly"/>
								</td>	
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>指标名称</td>

								<td class="td2">
									<input style="width: 200px;" name="expItemName" class="easyui-textbox"
									value="${bean.indexName}" readonly="readonly"/>
								</td>	
								
								<td class="td3"></td>

								<td class="td1"><span class="style1">*</span>指标编码</td>
								<td class="td2">
									<input style="width: 200px;" name="indexCode" class="easyui-textbox"
									value="${bean.indexCode}" readonly="readonly"/>
								</td>
							</tr>
							
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>资金性质</td>

							<td class="td2">
									<select id="property" class="easyui-combobox" name="property" style="width: 200px;" disabled="disabled">
										<option value="1">财政性资金</option>
										<option value="2">非财政性资金</option>
									</select>
           							
								<td class="td3"></td>

								<td class="td1"><span class="style1">*</span>预算年度</td>
								<td class="td2">
									<input style="width: 200px;" name="years" class="easyui-numberbox"
									value="${bean.years}" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>指标金额</td>
								<td class="td2">
									<input style="width: 200px;" name="pfAmount" class="easyui-numberbox"
									data-options="precision:2,iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" 
									value="${bean.pfAmount}" readonly="readonly"/>
								</td>	
								
								<td class="td3"></td>

								<td class="td1"><span class="style1">*</span>指标类型</td>
								<td class="td2">
									<input style="width: 200px;" class="easyui-textbox" readonly="readonly"
									value='<c:if test="${bean.indexType==0}">基本指标</c:if><c:if test="${bean.indexType==1}">项目指标</c:if>' readonly="readonly">
								</td>
							</tr>
							
						</table>
					</div>
					
					<div title="批复信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;">
						<table cellpadding="0" cellspacing="0" class="ourtable" style="width:760px;padding-top: 10px;">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>批复金额</td>

								<td class="td2">
									<input style="width: 200px;" name="pfAmount" class="easyui-numberbox"
									data-options="precision:2,iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" 
									value="${bean.pfAmount}" readonly="readonly"/>
								</td>	
								
								<td class="td3"></td>

								<td class="td1">
								<!-- <span class="style1">*</span> -->
								批复日期</td>
								<td class="td2">
									<input style="width: 200px;" name="appDate" class="easyui-datebox"
									value="${bean.appDate}" readonly="readonly"/>
								</td>
								
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>剩余金额</td>
								<td class="td2">
									<input style="width: 200px;" name="syAmount" class="easyui-numberbox"
									data-options="precision:2,iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" 
									value="${bean.syAmount}" readonly="readonly"/>
								</td>
								
								<td class="td3">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="bId" value="${bean.bId}" />
									<!-- 部门编码 --><input type="hidden" name="deptCode" value="${bean.deptCode}" />
									<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}"/>
								</td>

								<td class="td1"><span class="style1">*</span>冻结金额</td>
								<td class="td2">
									<input style="width: 200px;" name="djAmount" class="easyui-numberbox"
									data-options="precision:2,iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" 
									value="${bean.djAmount}" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="历史记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;">
						<!-- 查询 -->
						<!-- <div class="list-top"> -->
							<table class="top-table" cellpadding="0" cellspacing="0" style="padding-bottom: 9px;">
								<tr>
									<td class="top-table-search" id="quota_list_top1" style="width: 75%">
										<!-- &nbsp;&nbsp;支出事项&nbsp;
										<input id="quota_list_query_indexCode_1" style="width: 140px;height:25px;" class="easyui-numberbox"/> -->
										
										支出事项：
										<select id="quota_list_query_fType_1" style="width: 90px;height:25px;background-color:#f0f5f7;border:none;
										 color: #737272;text-align: center;text-align-last: center;margin-top: 6px;">
										<!-- //费用类型1、收入	2、还款	3、直接报销		4、申请报销		5、借款	6、采购支付		7、合同报销 -->
											<option value="">-请选择-</option>
											<option value="3">直接报销</option>
											<option  value="4">申请报销</option>
											<option value="5">借款申请</option>
											<option value="6">采购支付</option>
											<option value="7">合同报销</option>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;操作人：
										<input id="quota_list_query_userName_1" style="width: 90px;height:25px;" class="easyui-textbox"/>
										
										&nbsp;&nbsp;&nbsp;&nbsp;金额区间：
										<input id="c_cAmountBegin"  name="" style="width: 80px;height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" validType="numberBegin[c_cAmountEnd]" class="easyui-numberbox"></input>
										&nbsp;-&nbsp;
										<input id="c_cAmountEnd" name="" style="width: 80px;height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" class="easyui-numberbox"></input>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a href="#" onclick="searchData();">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
										</a>
										&nbsp;&nbsp;
										<a href="#" onclick="clearSearchData();">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
										</a>
									</td>
								</tr>
							</table>   
						<!-- </div> -->
					<div style="height: 410px;">
						<table class="easyui-datagrid" id="index-xdmx" 
							data-options="collapsible:true,url:'${base}/cockDetail/searchZCList?code=${code}&departId=${departNameId}',
							method:'post',fit:true,pagination:true,singleSelect: false,
							selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:true">
								<thead>
									<tr>
										<th data-options="field:'lId',hidden:true"></th>
										<th data-options="field:'url',hidden:true"></th>
										<th data-options="field:'num',align:'center'" style="width: 6%">序号</th>
										<th data-options="field:'billsCode',align:'left',formatter:formatCellTooltip" style="width: 24%">单据编号</th>
										<th data-options="field:'fType',align:'center',formatter: zcmxYT" style="width: 12%">支出事项</th>
										<th data-options="field:'amount',align:'right',formatter:getPlus" style="width: 13%">支出金额(元)</th>
										<th data-options="field:'time',align:'center',formatter: zcsjFormat" style="width: 12%">经办时间</th>
										<th data-options="field:'username',align:'center'" style="width: 8%">经办人</th>
										<th data-options="field:'department',align:'center',formatter:formatCellTooltip" style="width: 20%">经办部门</th>
										<th data-options="field:'cz',align:'center',formatter:CZ" style="width: 8%">操作</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
	<div class="win-left-bottom-div" style="height:38px;margin-bottom:16px ;padding:0px; position: absolute;bottom: 0;left: 46%">
		<a href="javascript:void(0)" onclick="closeFreeWindow('four_window')">
		<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</div>
</div>
<script type="text/javascript">

//查询
function searchData() {
	var fType=$("#quota_list_query_fType_1").val();
	var userName=$("#quota_list_query_userName_1").val();
	var moneyStart=$("#c_cAmountBegin").val();
	var moneyEnd=$("#c_cAmountEnd").val();
	$('#index-xdmx').datagrid('load',{
		fType:fType,
		userName:userName,
		moneyStart:moneyStart,
		moneyEnd:moneyEnd
	});
}
//清除查询条件
function clearSearchData() {
	$("#quota_list_query_fType_1 option:first").prop("selected",'selected');
	$("#quota_list_query_userName_1").textbox('setValue','');
	$("#c_cAmountBegin").textbox('setValue','');
	$("#c_cAmountEnd").textbox('setValue','');
	$('#index-xdmx').datagrid('load',{//清空以后，重新查一次
	});
}

//操作栏创建
function CZ(val, row) {
	return'<table style="margin:0 auto"><tr style="width: 75px;height:20px;"><td style="width: 25px;">'+
	   '<a href="#" onclick="indexDetail(\''+row.lId+'\',\''+row.url+'\')" class="easyui-linkbutton">'+
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
function add0(m){return m<10?'0'+m:m }
//时间格式化
function zcsjFormat(val) {
    if(val==null){
  	  return "";
    }
    var time = new Date(val);
    var y = time.getFullYear();
    var m = time.getMonth()+1;
    var d = time.getDate();
    var h = time.getHours();
    var mm = time.getMinutes();
    var s = time.getSeconds();
   /*  return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm)+':'+add0(s); */
   return y+'-'+add0(m)+'-'+add0(d); 
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
	
</body>
</html>

