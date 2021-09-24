<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="inquiries_dg_a"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">采购批次编号&nbsp;
					<input id="inquiries_fpCode" name="fpCode" style="width: 100px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;采购名称
					<input id="inquiries_fpName" name="fpName" style="width: 100px; height:25px;" class="easyui-textbox"></input>
				<%-- &nbsp;&nbsp;采购方式&nbsp;
					<input id="inquiries_fpMethodStr" name="fpMethod.code"  class="easyui-combobox" style="width: 150px; height:25px;" data-options="url:'${base}/lookup/lookupsJson?parentCode=PURCHASE_METHOD',method:'get',valueField:'code',textField:'text',editable:false" /> --%>
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
										<input id="F_fpMethod" name="fpMethod.code"   class="easyui-combobox" style="width: 100px; height:25px;" 
										data-options="url:'${base}/lookup/lookupsJson?parentCode=JZCGFS&selected=${bean.fpMethod.code}',
										method:'get',valueField:'code',textField:'text',editable:false"  />
									</c:if>
									<c:if test="${!empty bean.fOrgType.code && bean.fOrgType.code=='CGORG_TYPE_2'}">
										<input id="F_fpMethod" name="fpMethod.code"   class="easyui-combobox" style="width: 100px; height:25px;" 
										data-options="url:'${base}/lookup/lookupsJson?parentCode=FSCGFS&selected=${bean.fpMethod.code}',
										method:'get',valueField:'code',textField:'text',editable:false"  />
									</c:if>  --%>
									
					&nbsp;&nbsp;<a href="#" onclick="queryInquiries();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearInquiriesTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="list-table" style="height: 300px">
		<table id="cgsq_Tab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgsqsp/cginquiriesPage',
			method:'post',fit:true,pagination:true,singleSelect: true,selectOnCheck: true,
			checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:'true',name:'test' "></th>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'number',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fpCode',align:'left'" style="width: 20%">采购批次编号</th>
					<th data-options="field:'fpName',align:'left',resizable:false,sortable:true" style="width: 20%">采购名称</th>
					<th data-options="field:'fpAmount',align:'left',resizable:false,sortable:true" style="width: 10%">采购金额[元]</th>
					<th data-options="field:'fDeptName',align:'left',resizable:false,sortable:true" style="width: 10%">申报部门</th>
					<th data-options="field:'fReqTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">申报时间</th>
					<th data-options="field:'fUserName',align:'left',resizable:false,sortable:true" style="width: 10%">申请人</th>
					<!-- <th data-options="field:'fpMethod',align:'left',resizable:false,sortable:true" style="width: 10%">采购方式</th> -->
					<th data-options="field:'fCheckStauts',align:'left',resizable:false,sortable:true,formatter:flowStautsSet" style="width: 10%">审批状态</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	<div class="list-top">
		<table id="inquiries_dg_b"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>	
				<td align="right" style="padding-right: 10px">
					<a href="#" onclick="addSelqingdan()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="GetChecked()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/bijia1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>				
			</tr>
		</table>
	</div>
	
	<div class="list-table" style="height: 300px">
		<table id="winner_tab" class="easyui-datagrid"
			data-options="collapsible:true,
			method:'post',fit:true,pagination:true,singleSelect: false,selectOnCheck: true,
			checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:'true',name:'test' "></th>
					<th data-options="field:'fmainId',hidden:true"></th>
					<th data-options="field:'fpId',hidden:true"></th>
					<th data-options="field:'fwId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'selName',align:'left'" style="width: 15%">供应商名称</th>
					<th data-options="field:'selAddr',align:'left'" style="width: 20%">办公地址</th>
					<th data-options="field:'selUser',align:'left',resizable:false,sortable:true" style="width: 10%">联系人</th>
					<th data-options="field:'selTel',align:'left',resizable:false,sortable:true" style="width: 10%">联系电话</th>
					<th data-options="field:'selRemark',align:'left',resizable:false,sortable:true" style="width: 20%">备注</th>
					<th data-options="field:'ffinalPrice',align:'left'" style="width: 10%">总报价[元]</th>
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:formatter_bijia" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
	
	
</div>
<script type="text/javascript">
	$(function(){
		$('#cgsq_Tab').datagrid({
			onLoadSuccess : function(data){
				$('#cgsq_Tab').datagrid('selectRow',0);
				//console.log(node);
				var row = $('#cgsq_Tab').datagrid('getSelected');//获取选中行的数据
			    var pid=row.fpId;
				$("#winner_tab").datagrid({
			 			url : '${base}/cginquiries/cginquiriesPage?pid='+pid,	
			 		});
				},
		});
	});
	
	$('#winner_tab').datagrid({
		 onLoadSuccess: function () {   //隐藏表头的checkbox
             //$("#winner_tab").parent().find("div .datagrid-header-check").children("input[type=\"checkbox\"]").eq(0).attr("style", "display:none;");
             $(".datagrid-header-check").html("");
		 } 
	});
	
	//点击查询
	function queryInquiries() {
		//alert($('#apply_time').val());
		$('#cgsq_Tab').datagrid('load', {
			fpCode:$('#inquiries_fpCode').val(),
			fpName:$('#inquiries_fpName').val(),
			forgtype:$('#F_fOrgType').val()
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
	
	//清除查询条件
	function clearInquiriesTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#inquiries_fpCode").textbox('setValue','');
		$("#inquiries_fpName").textbox('setValue','');
		$("#F_fOrgType").combobox('setValue','');
		$('#cgsq_Tab').datagrid('load',{//清空以后，重新查一次
		});
	}
		//设置审批状态
		var c;
		function flowStautsSet(val, row) {
			c = val;
			if (val == 0) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
			} else if (val == -1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
			} else if (val == 9) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
			} else {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
			}
		}
		//操作栏创建
		function formatter_bijia(val, row) {
				return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
						'<a href="#" onclick="detail(' + row.fwId + ',' + row.fmainId + ')" class="easyui-linkbutton">'+
				   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
				   		'</a>'+ '</td><td style="width: 25px">'+
						'<a href="#" onclick="edit(' + row.fwId + ',' + row.fmainId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
						'</a>' + '</td><td style="width: 25px">'+
						'<a href="#" onclick="deleteinfo(' + row.fmainId + ')" class="easyui-linkbutton">'+
						'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
						'</a></td></tr></table>';
		}
		
	//双击上面的单元格刷新下面的表格	
	$("#cgsq_Tab").datagrid({
		onClickRow: function(){//选中单元格 双击事件	 
		var row = $('#cgsq_Tab').datagrid('getSelected');//获取选中行的数据
	    var pid=row.fpId;
		$("#winner_tab").datagrid({
	 			url : '${base}/cginquiries/cginquiriesPage?pid='+pid,	
	 		});
		},
	});
	//查看
	function detail(wid,mainid) {
		var win = parent.creatWin('查看', 780, 580, 'icon-search',"/cginquiries/detail?wid="+wid+"&mainid="+mainid );
		win.window('open');
	}
	
	//修改
	function edit(wid,mainid) {
		var row = $('#cgsq_Tab').datagrid('getSelected');//获取选中行的数据
		var pid=row.fpId;//页面传值    进行保存
		var win = parent.creatWin('修改', 780, 580, 'icon-search',"/cginquiries/edit?wid="+wid+"&mainid="+mainid+"&fpid="+pid );
		win.window('open');
   }
	
	//删除
	function deleteinfo(id) {
 	 	 if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/cginquiries/delete?id='+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#cgsq_Tab').datagrid("reload");
						 $("#winner_tab").datagrid("reload");

					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		} 
	}

	
	//下边表格新增供应商报价清单信息
	function addSelqingdan() {
		var row = $('#cgsq_Tab').datagrid('getSelected');//获取选中行的数据
		if(!row){
			alert("请选中一条数据进行报价清单登记");
		}else{
			var pid=row.fpId;//页面传值    进行保存
			var win = parent.creatWin('新增', 780, 580, 'icon-search', '/cginquiries/add?fpid='+pid);
			win.window('open');
		}
	}
	
	
    //单选 事件
/*     $('#winner_tab').datagrid({
          onCheck: function(index, data) { 
             alert(data[0]);alert(data[1]);alert(data[2]);
             alert(index );
                
          }
    }); */
     //获取选中的行内容进行比价操作
     function GetChecked(){
    	var row = $('#cgsq_Tab').datagrid('getSelected');//获取选中行的数据
	    var pid=row.fpId;
     	 var checkedItems = $('#winner_tab').datagrid('getChecked');
      	var len = $("input:checkbox:checked").length; 
      	if(len<2){
    	  alert("请选择两行以上数据进行比较！");
     	 }
     	 var data = '';
     	 $.each(checkedItems, function(index, item){
    	  data +=item.fmainId + ',';
      	});     
    	 var win = creatFirstWin('对比报价信息', 900, 800, 'icon-search', '/cginquiries/compare?data='+data+'&fplid='+pid);
 	 	win.window('open');
  }
</script>
</body>


