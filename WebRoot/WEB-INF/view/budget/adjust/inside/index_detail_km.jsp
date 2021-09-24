<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'north'" border="false" style="padding: 5px;">
		<span style="margin-left: 20px">支出预算事项：</span><input style="height: 30px; width:180px;" class="easyui-textbox" id="ckm_query_qName"/>
		<a href="javascript:void(0)" onclick="chooseKmQuery()">
			<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a> 
		<a href="javascript:void(0)" onclick="clearKmQuery()">
			<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a> 
	</div>
	<div data-options="region:'center'" border="false" >
		<table id="project-choose-km-tree"  class="easyui-treegrid" style="width:100%;"
            data-options="
            	<c:if test="${fProOrBasic==0}">
				url: '${base}/project/treezJbZckm?ejProCode=${ejProCode }&year=${ejplanStartYear }&fEcCode=${fEcCode}',
				</c:if>
				<c:if test="${fProOrBasic==1||fProOrBasic==2}">
				url: '${base}/project/treezZckm?sCode=${sCode }&year=${ejplanStartYear }',
				</c:if>
                method: 'get',
                rownumbers: true,
                idField: 'code',
                treeField: 'text',
                method: 'get',
                onDblClickRow:function(row) { 
                	confirmOutcome1(row);
				}
            ">
        <thead>
            <tr>
                <th data-options="field:'text'" width="50%">支出预算事项</th>
                <th data-options="field:'code'" width="50%">科目代码</th>
            </tr>
        </thead>
    </table> 
	</div>
	
	
	<div data-options="region:'south'" border="false" style="height: 80px;line-height: 80px;text-align: center;">
		<div style="text-align: left;height: 20px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：请双击完成选择</span>
		</div>
		<div style="height: 20px;">
		<a href="javascript:void(0)" onclick="closeFirstWindow()">
			<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
		</div>
	</div>
</div>

    
    

<script type="text/javascript">
function confirmOutcome1(row){
	var rIndex = '${rIndex}';
	var fProOrBasic = '${fProOrBasic}';
	var id = "";
	if(fProOrBasic=='0'){
		id = "pro_outcomes_table";
	}
	if(fProOrBasic=='1'){
		id = "pro_outcomes_table_id";
	}
	if(fProOrBasic=='2'){
		id = "pro_outcomes_table_essb_id";
	}
	var subName = $('#'+id).datagrid('getEditor',{
		index: rIndex,
		field : 'subName'  
	});
	var subCode = $('#'+id).datagrid('getEditor',{
		index: rIndex,
		field : 'subCode'  
	});
	var activity = $('#'+id).datagrid('getEditor',{
		index: rIndex,
		field : 'activity'  
	});
	$(subName.target).textbox('setValue', row.text);
	$(subCode.target).textbox('setValue', row.code);
	$(activity.target).textbox('setValue', row.text);
	closeSecondWindow();
}
</script>
</body>
</html>
