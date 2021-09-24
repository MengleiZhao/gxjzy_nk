<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="cg_apply_dg" class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">采购批次编号&nbsp;
					<input id="cgbx_fpCode" name="fpCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称&nbsp;
					<input id="cgbx_fpName" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					
					
					&nbsp;&nbsp;申请部门&nbsp;
					<input id="cgbx_fDeptName" name="fDeptName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;
					<a href="#" onclick="queryCgApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearCgApplyTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
				
		</table>
	</div>



	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="cg_reimb_Tab" class="easyui-datagrid"
		data-options="collapsible:true,url:'${base}/cgsqsp/reimbJsonPagination',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'number',align:'center'" style="width: 4%">序号</th>
					<th data-options="field:'fpCode',align:'center'" style="width: 14%">采购批次编号</th>
					<th data-options="field:'fpName',align:'center',resizable:false" style="width: 15%">采购名称</th>
					<th data-options="field:'fpAmount',align:'right',resizable:false,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">采购金额[元]</th>
					<th data-options="field:'payAmount',align:'right',resizable:false,formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">付款金额[元]</th>
					<th data-options="field:'fReqTime',align:'center',resizable:false,formatter: ChangeDateFormat" style="width: 9%">申请日期</th>
					<th data-options="field:'fDeptName',align:'center',resizable:false" style="width: 13%">申请部门</th>
					<th data-options="field:'fUserName',align:'center',resizable:false" style="width: 13%">申请人</th>
					<th data-options="field:'fIsReceive',align:'center',resizable:false,formatter:formatIsReceive" style="width: 9%">验收状态</th>
					<th data-options="field:'reimbStatus',align:'center',resizable:false,formatter:formatPrice" style="width: 9%">报销状态</th>
					<th data-options="field:'name',align:'center',resizable:false,formatter:CZ" style="width: 9.5%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
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
		//点击查询
		function queryCgApply() {
			$('#cg_reimb_Tab').datagrid('load', {
				fpCode:$('#cgbx_fpCode').val(),
				fpName:$('#cgbx_fpName').val(),
				fDeptName:$('#cgbx_fDeptName').val(),
			});
		}
		//清除查询条件
		function clearCgApplyTable() {
			$("#cgbx_fpCode").textbox('setValue','');
			$("#cgbx_fpName").textbox('setValue','');
			$("#cgbx_fDeptName").textbox('setValue','');
			$('#cg_reimb_Tab').datagrid('load',{//清空以后，重新查一次
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
			if (row.rId==''||row.rId==null){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 未发起" + '</a>';
			}else{
				
				if (val == 0) {
					return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
				} else if (val == -1) {
					return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
				} else if (val ==-4) {
					return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
				} else if (val == 9) {
					return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
				} else {
					return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
				}
			}
		}
		//操作栏创建
		function CZ(val, row) {
			if (c == 1 || c == 2) {
				return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					   '<a href="#" onclick="editReimburse(' + row.rId + ',0,'+row.type+')" class="easyui-linkbutton">'+
					   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
					   '</a></td><td style="width: 25px">'+
					   '<a href="#" onclick="reCall(\'cg_reimb_Tab\',' + row.rId + ',\'/reimburse/reimburseReCall\')" class="easyui-linkbutton">'+
					   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
					   '</a></td></tr></table>';
			} else if(c == 0 || c == -1 || c == -4) {
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
						'<a href="#" onclick="editReimburse(' + row.rId + ',0)" class="easyui-linkbutton">'+
				   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   		'</a>'+ '</td><td style="width: 25px">'+
						'<a href="#" onclick="editReimburse(' +row.rId + ',1)" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
						'</a>' + '</td><td style="width: 25px">'+
						'</a></td></tr></table>';
					/* 	
						'<a href="#" onclick="deleteReimburse(' + row.rId + ',' + row.type + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
						'</a></td></tr></table>'; */
			}else if(row.rId==null){
				return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				   '<a href="#" onclick="addReimburse(' + row.fpId + ')" class="easyui-linkbutton">'+
				   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/bx1.png">'+
				   '</a></td></tr></table>';
			}else{
				//c==9审批通过无法撤回
				return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					   '<a href="#" onclick="editReimburse(' + row.rId + ',0)" class="easyui-linkbutton">'+
					   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
					   '</a></td><td style="width: 25px">'+
						'<a href="#" onclick="exportReimHtml(' + row.rId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/dy1.png">'+
					   '</a></td></tr></table>';
			}
			
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
							$('#cg_reimb_Tab').datagrid("reload");
						} else {
							$.messager.alert('系统提示', data.info, 'error');
						}
					}
				});
			}
		}
		//查看/修改 页面跳转
		function editReimburse(id,type) {
			var title = null;
			if(type==0){
				title="采购报销明细";
				var win = creatWin(title, 1105, 580, 'icon-search', "/cgsqsp/editReimb?id="+ id +"&editType="+ type);
				win.window('open');
			}else{
				title="采购报销-修改";
				var win = creatWin(title, 1105, 580, 'icon-search', "/cgsqsp/editReimb?id="+ id +"&editType="+ type);
				win.window('open');
			}
		}
		//新增
		function addReimburse(id) {
			var win = creatWin('报销-新增', 1105, 580, 'icon-search',"/cgsqsp/addReimb?id=" + id);
			win.window('open');
		}
		
		function formatIsReceive(val){
			if(val=='2'){
				return "已验收";
			}
		}
		
</script>
</body>
</html>

