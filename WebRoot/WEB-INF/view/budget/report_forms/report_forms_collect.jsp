<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>

<style type="text/css">
 .datagrid-cell {
     text-overflow: ellipsis;
 }
 /* 边框样式 */
.datagrid-body td{
  border-bottom: 1px dashed #ccc;
  border-right: 1px dashed #ccc;
}
.datagrid-htable tr td{
	border-right: 1px solid #fff;
	border-bottom: 1px solid #fff;
}
.progressbar-value,
.progressbar-value .progressbar-text {
  color: #000000;		
}		
</style>
				<!----------------------------- 报表2 界面 ------------------------------>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="data_index_top">
				<td class="top-table-search-pro" style="width:95%">
					预算年度
					<select class="easyui-combobox" id="second_select_year" style="width: 120px;height: 25px;" data-options="editable:false, panelHeight:'auto'">
						<c:forEach items="${yearList}" var="ye">
							<option value="${ye}" <c:if test="${ye == year}">selected="selected"</c:if>>&nbsp;${ye }</option>
						</c:forEach>
					</select>
					&nbsp;&nbsp;申报阶段
					<select class="easyui-combobox" id="analysisType" name="analysisType" style="width: 80px;height: 25px;" data-options="editable:false, panelHeight:'auto'">
						<option value="1" selected="selected">一上</option>
						<option value="3">一下</option>
						<option value="4">二上</option>
						<option value="5">二下</option>
					</select>
					&nbsp;&nbsp;数据状态
					<select class="easyui-combobox" id="dataType" name="dataType" style="width: 120px;height: 25px;" data-options="editable:false, panelHeight:'auto'">
						<option value="1" selected="selected">过程</option>
						<option value="2">终稿</option>
					</select>
					&nbsp;&nbsp;
					部门
					<input class="easyui-combotree" id="deptSelect" name="secondLevelCode" style="width: 380px;height: 25px;" data-options="url:'${base}/bData/deptTree',editable:false,multiple:true, panelHeight:'auto'">
						<%-- <option value="allDept">所有部门</option>
						<c:forEach var="i" items="${deptList}" varStatus="val">
							<option value="${i.id}">${i.name}</option>
						</c:forEach>
					</select> --%>
					&nbsp;&nbsp;<a href="#" onclick="data_collect_query();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clear_data_collect();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td align="right" style="padding-right: 10px;width:70px;">
					<a href="#" onclick="exportDataReportCollect();">
						<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>   
	</div>
	
	<div class="list-table">
		<table id="report_forms" class="easyui-datagrid" 
		data-options="collapsible:true,url:'${base}/bData/reportCollectDataByType?year=${year}',
			method:'post',fit:true,pagination:false,singleSelect: false,rowStyler:function(index,row){
			if (row[2]=='合计' || row[3]=='总计'){ return 'background-color:#EFEFEF;color:black;font-weight:bold;'; }},rownumbers:true,
		onLoadSuccess: loadSuccessMethod, selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:true,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="align:'center'" style="width: 10%">301</th>
					<th data-options="align:'center'" style="width: 10%">302</th>
					<th data-options="align:'center'" style="width: 10%">303</th>
					<th data-options="align:'center'" style="width: 10%">310</th>
					<c:forEach	var="i" items="${subjectList}" varStatus="val">
						<th data-options="align:'center'">${i.code}</th>
					</c:forEach>
				</tr>
				<tr>
					<th data-options="field:'6',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">工资福利支出</th>
					<th data-options="field:'7',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">商品与服务支出</th>
					<th data-options="field:'8',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">对个人与家庭的补助</th>
					<th data-options="field:'9',align:'right',halign: 'center',resizable:true,sortable:true,formatter:listToFixed" style="width: 10%">资本性支出</th>
					<c:forEach	var="i" items="${subjectList}" varStatus="val">
						<th data-options="field:'${val.index+10}',align:'right',halign: 'center',formatter:listToFixed,resizbale:true" style="width: 12%">${i.name}</th>
					</c:forEach>
				</tr>
			</thead>
			<thead frozen="true">
				<tr>	
					<!-- <th data-options="rowspan:2,field:'0',align:'center'" style="width: 5%">序号</th> -->
					<th data-options="colspan:2,align:'center'" style="">项目类型</th>
					<th data-options="rowspan:2,field:'3',align:'center',resizbale:true" style="width: 12%">项目名称</th>
					<th data-options="rowspan:2,field:'4',align:'center',resizbale:true" style="width: 15%">申报部门</th>
					<th data-options="rowspan:2,field:'5',align:'right',halign: 'center',resizbale:true,styler: function (value, row, index)
					{ return 'background-color:#EFEFEF;color:black;'},formatter:listToFixed" style="width: 10%">项目总额</th>
				</tr>
				<tr>
					<th data-options="field:'1',align:'center',resizable:true,formatter:lineFeedMehtod" style="width: 5%">1级</th>
					<th data-options="field:'2',align:'center',resizable:true,formatter:lineFeedMehtod" style="width: 5%">2级</th>
				</tr>
			</thead>
		</table>
	</div>
				

<!-- <form id="form_data_export" method="post" >
	<input type="hidden" id="data_index_export_indexCode" name="index_indexCode" value="">
</form> -->
</div>

<script type="text/javascript">
$(function(){
	$('#second_select_year').combobox({
		onChange:function (newVal,oldVal){
			addTabs('报表二','${base}/bData/reportCollectJsp?year='+newVal);
		}
	});
	$('#deptSelect').combotree({
		onCheck : function (node, checked){
			if(checked){
				//选中所有部门
				if(node.id==-1){
					var valArr = $('#deptSelect').combotree('tree').tree('getChecked');
					if(valArr.length>0){
						for (var i = 0; i < valArr.length; i++) {
							if(valArr[i].text!=node.text){
								$('#deptSelect').combotree('tree').tree('uncheck',valArr[i].target);
							}
						}
					}
				}else{
					var node = $('#deptSelect').combotree('tree').tree('find', -1);
					$('#deptSelect').combotree('tree').tree('uncheck',node.target);
				}
			}
		}
	});
});

function loadSuccessMethod(data){
    //指定列进行合并操作
    $(this).datagrid("autoMergeCells", ['1']);
    $(this).datagrid("autoMergeCells", ['2']);
    //固定行
	$(this).datagrid('freezeRow',0);
}
function valMethod(val,row){
	if(val=='' || val==null){
		return;
	}
	return val.toFixed(2);
}
function lineFeedMehtod(val,row){
	if(val==''||val==null ||val=='合计' ){
		return val;
	}
	var t=val.split('').join('<br>');
	return t;
}
//点击查询
function data_collect_query() {
	var year=$('#second_select_year').combobox('getValue');
	var analysisType = $('#analysisType').combobox('getValue');
	var dataType = $('#dataType').combobox('getValue');
	var deptList=new Array();
	var checkVal=$('#deptSelect').combotree('tree').tree('getChecked');
	if(checkVal.length>0){
		for (var i = 0; i < checkVal.length; i++) {
			deptList.push(checkVal[i].id);
		}
	}/* else{
		alert('请选择部门!');
		return;
	} */
	$('#report_forms').datagrid('load', {
		deptArr : deptList.join(','),
		analysisType : analysisType,
		dataType:dataType
	});
}
//清除查询条件
function clear_data_collect() {
	//重新加载
	addTabs('报表二','${base}/bData/reportCollectJsp');
}

//导出
function exportDataReportCollect(){
	var  time=ChangeDateFormat(new Date());
	var rows = $('#report_forms').datagrid('getRows');
		$('#report_forms').datagrid('toExcel', {
	    filename: '报表二.xls',
	    rows: rows,
	    worksheet: 'Worksheet'
	}); 
}
//自定义合并方法
$.extend($.fn.datagrid.methods, {
    autoMergeCells: function(jq, fields) {
        return jq.each(function() {
            var target = $(this);
            if (!fields) {
                fields = target.datagrid("getColumnFields");
            }
            var rows = target.datagrid("getRows");
            var i = 0,
            j = 0,
            temp = {};
            for (i; i < rows.length; i++) {
            	//更改高度
            	 $('.datagrid-row').css('height','32px');
                var row = rows[i];
                j = 0;
                for (j; j < fields.length; j++) {
                    var field = fields[j];
                    var tf = temp[field];
                    if (!tf) {
                        tf = temp[field] = {};
                        tf[row[field]] = [i];
                    } else {
                        var tfv = tf[row[field]];
                        if (tfv) {
                            tfv.push(i);
                        } else {
                            tfv = tf[row[field]] = [i];
                        }
                    }
                }
            }
            $.each(temp,
            function(field, colunm) {
                $.each(colunm,
                function() {
                    var group = this;
                    if (group.length > 1) {
                        var before, after, megerIndex = group[0];
                        for (var i = 0; i < group.length; i++) {
                            before = group[i];
                            after = group[i + 1];
                            if (after && (after - before) == 1) {
                                continue;
                            }
                            var rowspan = before - megerIndex + 1;
                            if (rowspan > 1) {
                                target.datagrid('mergeCells', {
                                    index: megerIndex,
                                    field: field,
                                    rowspan: rowspan
                                });
                            }
                            if (after && (after - before) != 1) {
                                megerIndex = after;
                            }
                        }
                    }
                });
            });
        });
    }
});
</script>
</body>

