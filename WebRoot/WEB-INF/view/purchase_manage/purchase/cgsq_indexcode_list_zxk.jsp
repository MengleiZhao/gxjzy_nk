<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table id="cg_apply_dg" class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">采购名称
					<input id="cgsq_indexcode_fpName" name="fpName" style="width: 100px; height:25px;" class="easyui-textbox"></input>
					<%-- &nbsp;&nbsp;采购方式&nbsp;
					<input id="cgsq_indexcode_fpMethodStr" name="fpMethod.code"  class="easyui-combobox" style="width: 150px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=PURCHASE_METHOD',method:'get',valueField:'code',textField:'text',editable:false" /> --%>
					<%-- &nbsp;&nbsp;组织形式
					<c:if test="${empty bean.fpId}">
						<input id="F_fOrgType" name="fOrgType.code"  class="easyui-combobox" style="width: 100px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=CGORG_TYPE',method:'get',valueField:'code',textField:'text',editable:false" />
					</c:if>
					<c:if test="${!empty bean.fpId}">
						<input id="F_fOrgType" name="fOrgType.code"   class="easyui-combobox" style="width: 100px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=CGORG_TYPE&selected=${bean.fOrgType.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
					</c:if>
					&nbsp;&nbsp;采购方式
					<c:if test="${empty bean.fpId}">
					<input id="F_fpMethod" name="fpMethod.code"  class="easyui-combobox" style="width: 100px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=FSCGFS',method:'get',valueField:'code',textField:'text',editable:false" />
					</c:if>
					<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_1'}">
						<input id="F_fpMethod" name="fpMethod.code"   class="easyui-combobox" style="width: 150px; height:25px;" 
						data-options="url:'${base}/lookup/lookupsJson?parentCode=JZCGFS&selected=${bean.fpMethod.code}',
						method:'get',valueField:'code',textField:'text',editable:false"  />
					</c:if>
					<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_2'}">
						<input id="F_fpMethod" name="fpMethod.code"   class="easyui-combobox" style="width: 100px; height:25px;" 
						data-options="url:'${base}/lookup/lookupsJson?parentCode=FSCGFS&selected=${bean.fpMethod.code}',
						method:'get',valueField:'code',textField:'text',editable:false"  />
					</c:if>  --%>
					
					&nbsp;&nbsp;<a href="#" onclick="queryCgIdApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearCgIdApplyTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="cg_id_apply_Tab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/cgsqsp/cgsqPage?indexCode=${indexCode}',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fpCode',align:'center'" style="width: 15%">采购批次编号</th>
					<th data-options="field:'fpName',align:'center',resizable:false,sortable:true" style="width: 15%">采购名称</th>
					<th data-options="field:'fpAmount',align:'right',resizable:false,sortable:true" style="width: 15%">采购金额[元]</th>
					<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" style="width: 10%">申报部门</th>
					<th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 10%">申报时间</th>
					<!-- <th data-options="field:'fpMethod',align:'left',resizable:false,sortable:true" style="width: 10%">采购方式</th> -->
					<th data-options="field:'fCheckStauts',align:'center',resizable:false,sortable:true,formatter:formatPrice" style="width: 10%">审批状态</th>
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	//分页样式调整
	$(function(){
		
	});
	
	//显示搜索
	function spreadcg() {
		$('#helpTrcg').css("display", "");
		$('#retractcg').css("display", "");
		$('#spreadcg').css("display", "none");
	}
	//隐藏搜索
	function retractcg() {
		$('#helpTrcg').css("display", "none");
		$('#retractcg').css("display", "none");
		$('#spreadcg').css("display", "");
	}

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

	/* //操作栏创建
	function CZ(val, row) {
			return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick="cg_apply_detail(' + row.fpId + ')" class="easyui-linkbutton">'+
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   '</a></td></tr></table>';
	} */
	//操作栏创建
	function CZ(val, row) {
		var titlebegin='<table><tr style="width: 75px;height:20px">';
		//查看详情按钮
		var button1='<td style="width: 25px">'+
		   '<a href="#" onclick="cg_apply_detail(' + row.fpId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a></td>';
		//查看合同按钮
		var button2='<td style="width: 25px">'+
			'<a href="#" onclick="contract_list(' + row.fpId + ')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ht1.png">'+
			'</a></td>';
		var titleend='</tr></table>';
		
		var returnButton=titlebegin+button1;
		if(row.contractId !=null){
			returnButton=returnButton+button2;
		}
		return returnButton+titleend;
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
	
		
		//删除
		function cg_apply_delete(id) {
			if (confirm("确认删除吗？")) {
				$.ajax({
					type : 'POST',
					url : '${base}/cgsqsp/delete?id='+id,
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							$.messager.alert('系统提示', data.info, 'info');
							$('#cg_apply_Tab').datagrid("reload");
						} else {
							$.messager.alert('系统提示', data.info, 'error');
						}
					}
				});
			}
		}
	
		//修改
		function cg_apply_update(id) {
		var selections = $('#cg_apply_Tab').datagrid('getSelections');
		var win = creatSecondWin(' ', 970, 580, 'icon-search',"/cgsqsp/edit?id=" + id);
		win.window('open');
	   }
		
		//查看
		function cg_apply_detail(id) {
			var win = creatWin(' ', 970, 580, 'icon-search',"/cgsqsp/detail?id=" + id);
			win.window('open');
		}
		//查看合同
		function contract_list(id) {
			var win = creatSecondWin('合同信息', 970, 580, 'icon-search',"/Formulation/list?fpId=" + id);
			win.window('open');
		}
		//合同信息（先留着，看情况可能会调用这个,到时候 proId 需要换一下，后台代码也要相应修改）
		function htPro(proId) {
			var win = creatFirstWin('合同信息',1300,580,'icon-search','/Ledger/list?proId='+proId);
			win.window('open');
		}
		
		//点击查询
		function queryCgIdApply() {
			//alert($('#apply_time').val());
			$('#cg_id_apply_Tab').datagrid('load', {
				fpName:$('#cgsq_indexcode_fpName').val(),
				fpMethodStr:$('#F_fpMethod').val(),
				forgtype:$('#F_fOrgType').val()
			});
		}
		//清除查询条件
		function clearCgIdApplyTable() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#cgsq_indexcode_fpName").textbox('setValue','');
			$("#F_fpMethod").combobox('setValue','');
			$("#F_fOrgType").combobox('setValue','');
			$('#cg_id_apply_Tab').datagrid('load',{//清空以后，重新查一次
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
		
	</script>
</body>
</html>

