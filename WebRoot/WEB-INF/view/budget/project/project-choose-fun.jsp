<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html>
<body>
<div class="easyui-layout" fit="true" style="margin-top: 10px">
	<div data-options="region:'center'" border="false" >
		<table id="project-choose-fun-tree"  class="easyui-treegrid" style="width:100%;margin-top: 10px"
            data-options="
				url: '${base}/project/findProFunSub',
                method: 'get',
                rownumbers: true,
                idField: 'funCode',
                treeField: 'funName',
                method: 'get',
                onDblClickRow:function(row) { 
                
                	confirmOutcome2(row);
				}
            ">
        <thead>
            <tr>
                <th data-options="field:'funName'" width="50%">功能科目名称</th>
                <th data-options="field:'funCode'" width="50%">功能科目代码</th>
            </tr>
        </thead>
    </table> 
	</div>
	
	<div data-options="region:'south'" border="false" style="height: 80px;text-align: center;">
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
	function confirmOutcome2(row){
		
		var rIndex = '${rIndex}';
		var id1 = 'outcome7_'+ rIndex;
		var id2 = 'outcome8_'+ rIndex;
		var id3 = 'outcome9_'+rIndex;
		$('#'+id1).val(row.funName);
		$('#'+id2).val(row.funCode);
		$('#'+id3).text(row.funName);
		closeFirstWindow();
	}
</script>
</body>

</html>
	