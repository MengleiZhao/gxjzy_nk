<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="cg_lendger_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">采购批次编号&nbsp;
					<input id="ledger_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称&nbsp;
					<input id="ledger_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="ledger_fDeptName" name="fDeptName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;
					<a href="#" onclick="queryCgLendgerApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearCgLendgerTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="exportCGLedger()">
						<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>


	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="cgledger_list" class="easyui-datagrid"
<c:if test="${!empty indexCode}">data-options="collapsible:true,url:'${base}/cgsqLedger/cgledgerPage?indexCode=${indexCode }',</c:if>
<c:if test="${empty indexCode}">data-options="collapsible:true,url:'${base}/cgsqLedger/cgledgerPage',</c:if>
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'fIsContract',hidden:true"></th>
					<th data-options="field:'fContractSts',hidden:true"></th>
					<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fpCode',align:'center'" style="width: 15%">采购批次编号</th>
					<th data-options="field:'fpName',align:'center',resizable:false,sortable:true" style="width: 21%">采购名称</th>
					<th
						data-options="field:'fpAmount',align:'center',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}"
						style="width: 10%">采购金额[元]</th>
					<th
						data-options="field:'fOrgName',align:'center',resizable:false,sortable:true"
						style="width: 20%">供应商名称</th>
					<th
						data-options="field:'fUserName',align:'center',resizable:false,sortable:true"
						style="width: 10%">申请人</th>
					<th
						data-options="field:'fDeptName',align:'center',resizable:false,sortable:true"
						style="width: 15%">申请部门</th>
					<th
						data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat"
						style="width: 15%">申请时间</th>
					<!-- <th
						data-options="field:'fpMethod',align:'center',resizable:false,sortable:true"
						style="width: 10%">采购方式</th> -->
					<th
						data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ"
						style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<form id="form_cgapply_export" method="post" enctype="multipart/form-data">
	<input id="form_cgapply_export_fpCode" type="hidden" name="fpCode">
	<input id="form_cgapply_export_fpName" type="hidden" name="fpName">
	<input id="form_cgapply_export_fDeptName" type="hidden" name="fDeptName">
</form>
<script type="text/javascript">
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
	
		//点击查询
		function queryCgLendgerApply() {
			$('#cgledger_list').datagrid('load', {
				fpCode:$('#ledger_fpCode').val(),
				fpName:$('#ledger_fpName').val(),
				fDeptName:$('#ledger_fDeptName').val(),
				/* fCheckStauts:$('#ledger_fCheckStauts').val() */
			});
		}
		//清除查询条件
		function clearCgLendgerTable() {
			$("#ledger_fpCode").textbox('setValue','');
			$("#ledger_fpName").textbox('setValue','');
			$("#ledger_fDeptName").textbox('setValue','');
			/* $("#ledger_fCheckStauts").textbox('setValue',''); */
			$('#cgledger_list').datagrid('load',{//清空以后，重新查一次
			});
		}
		
		/* //根据选择的组织形式，来请求采购方式
		$("#F_fOrgType").combobox({
			onChange: function (n,o) {
				if(n==""||n==null||n=="undefined"){
					 $('#F_fpMethod').combobox('setValues','');
				}
				if(n=="CGORG_TYPE_1"){	//集中采购
					 $('#F_fpMethod').combobox({
						    url:'${base}/lookup/lookupsJson?parentCode=JZCGFS&selected=${bean.fpMethod.code}',
						});
				}
				if(n=="CGORG_TYPE_2"){	//分散采购
					 $('#F_fpMethod').combobox({
						    url:'${base}/lookup/lookupsJson?parentCode=FSCGFS&selected=${bean.fpMethod.code}',
					});
				}
				
			}
		}); */
	//设置审批状态
	var c;
	function formatPrice(val, row) {
		c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
		}
	}

	//操作栏创建
	function CZ(val, row) {
		return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="cgsq_lendger_detail(' + row.fpId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				'</a></td><td style="width: 25px">'+
				'<a href="#" onclick="cgsq_lendger_HT(' + row.fpId + ','+row.fIsContract+','+row.fContractSts+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ht1.png">'+
				'</a></td><td style="width: 25px">'+
				'<a href="#" onclick="cgsq_lendger_ZC(' + row.fpId + ','+row.fIsContract+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/zcjl1.png">'+
				'</a></td></tr></table>';
	}
	
	//跳转查看页面
	function cgsq_lendger_detail(id) {
		var win = creatWin('采购台账查看', 850, 550, 'icon-search', "/cgsqsp/ledgerdetail?id="+ id);
		win.window('open');
	}
	function cgsq_lendger_HT(id,type,status) {
		if(type == 1){
			if(status == 1){
				var win = creatWin('采购合同查看', 850, 550, 'icon-search', "/cgsqsp/detailHT?id="+ id);
				win.window('open');
			}else{
				alert("该采购单暂未签订合同");
			}
		}else{
			alert("该采购单不签订合同");
		}
	}
	function cgsq_lendger_ZC(id,type) {
		if(type == 1){
			var win = creatWin('采购支出记录查看', 850, 550, 'icon-search', "/cgsqsp/ledgerdetail?id="+ id);
			win.window('open');
		}else{
			alert("该采购单不签订合同");
		}
	}

	//合同台账导出
	function exportCGLedger() {
		if(confirm('是否导出？')){
		var code=$("#ledger_fpCode").textbox('getValue').trim();
		var name=$("#ledger_fpName").textbox('getValue').trim();
		var dept=$("#ledger_fDeptName").textbox('getValue').trim();
			$('#form_cgapply_export_fpCode').val(code);
			$('#form_cgapply_export_fpName').val(name);
			$('#form_cgapply_export_fDeptName').val(dept);
			$('#form_cgapply_export').attr('action','${base}/cgsqLedger/export');
			$('#form_cgapply_export').submit();
		}
	}
</script>
</body>
</html>