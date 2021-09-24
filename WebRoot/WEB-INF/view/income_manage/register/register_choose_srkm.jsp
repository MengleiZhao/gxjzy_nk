<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'north'" border="false" style="padding: 5px;">
		支出预算事项：<input style="height: 30px; width:180px;" class="easyui-textbox" id="ckm_query_qName"/>
		<a href="javascript:void(0)" onclick="chooseKmQuery()">
			<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a> 
		<a href="javascript:void(0)" onclick="clearKmQuery()">
			<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
	<div data-options="region:'center'" border="false" >
		<table id="project-choose-km-tree"  class="easyui-treegrid" style="width:95%;"
            data-options="
                url: '${base}/srregister/treeListSrkm',
                method: 'get',
                rownumbers: true,
                idField: 'code',
                treeField: 'text',
                method: 'get',
                onDblClickRow:function(row) { 
                	confirmOutcome(row);
				}
            ">
        <thead>
            <tr>
                <th data-options="field:'text'" width="50%">会计收入科目</th>
                <th data-options="field:'code'" width="50%">科目代码</th>
                <!-- <th data-options="field:'id'" width="15%" align="right">科目id</th>
                <th data-options="field:'parentCode'" width="20%" align="right">上级科目代码</th> -->
            </tr>
        </thead>
    </table> 
	</div>
	
	
	<div data-options="region:'south'" border="false" style="height: 100px;line-height: 80px;text-align: center;">
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
	

	function chooseKmQuery(){
		var name = $('#ckm_query_qName').textbox('getValue');
		if(name!=''){
			$('#project-choose-km-tree').treegrid('load', {
				qName: name,
				id: ''
			});
		}
		
	}
	function confirmOutcome(rIndex){
		if(!rIndex.leaf){
			alert("请选择子节点");
			return;
		};
		var node = $('#project-choose-km-tree').treegrid('getSelected');
		$('#F_indexName').textbox('setValue',node.text);//科目名称
		$('#arriveIndexId').val(node.code);//科目ID
		
		closeFirstWindow();
	}
	
	//清除查询条件
	function clearKmQuery() {
		$('#project-choose-km-tree').treegrid('load');
	}
</script>
</body>

</html>
	