<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<div class="list-top" style="margin-top: 10px">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search" class="queryth">
					&nbsp;&nbsp;具体业务&nbsp;
					<input id="apply_list_top_proActivity" style="width: 150px;height:25px;" class="easyui-textbox"/>
					&nbsp;&nbsp;
					<a href="#" onclick="queryApplyRegister();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearTableRegister();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addProDetailRegister(${proId})">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>

<div data-options="region:'center'">
 	<div class="list-table-tab" style="height: 50%; width:98%; margin-left: 1%; border: none;position: relative; ">
		<div class="tab-wrapper" id="quota-tab-register" >
			<div class="tab-content">
				<div style="height: 355px;margin-left: 1%;">
					<table class="easyui-datagrid" id="index-xdmx" 
					data-options="collapsible:true,url:'${base}/indexDetailRegister/jsonPagination?proId=${proId}',
					method:'post',fit:true,pagination:true,nowrap:false,striped: true,fitColumns:true,rownumbers:true">
						<thead>
							<tr>
								<th data-options="field:'rId',hidden:true"></th>
								<th data-options="field:'proId',hidden:true"></th>
								<th data-options="field:'proActivity',align:'center'" style="width: 36%">具体业务</th>
								<th data-options="field:'amount',align:'center',formatter:getPlus" style="width: 13%">支出金额(元)</th>
								<th data-options="field:'time',align:'center',formatter: zcsjFormat" style="width: 18%">登记时间</th>
								<th data-options="field:'userName',align:'center'" style="width: 15%">登记人</th>
								<th data-options="field:'department',align:'center'" style="width: 17%">登记部门</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="window-left-bottom-div" >
	&nbsp;&nbsp;
	<a href="javascript:void(0)" onclick="closeWindow()">
	<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
</div>
	<script type="text/javascript">
	//type为指标类型1位基本2为项目
	flashtab("quota-tab-register");

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
		}else{
			val=0;
			return  Math.abs(val.toFixed(2));
		}
	}
	
	function addProDetailRegister(proId){
		var win = creatFirstWin('明细新增',800,580,'icon-search','/indexDetailRegister/add?proId='+proId);
		win.window('open');
	}
	
	function queryApplyRegister(){
		$("#index-xdmx").datagrid('load',{
			proActivity:$("#apply_list_top_proActivity").textbox('getValue').trim(),
		});
	}
	
	function clearTableRegister(){
		$("#apply_list_top_proActivity").textbox('setValue','');
		$("#index-xdmx").datagrid('load',{});
	}
	</script>