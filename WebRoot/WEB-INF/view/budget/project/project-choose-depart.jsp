<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'center'" border="false" >
		<table id="project-choose-depart-dg"  class="easyui-datagrid" style="width:100%;"
            data-options="
                url: '${base}/depart/jsonPagination',
                method: 'post',
                rownumbers: true,
                method: 'get',
				checkbox: true,
				singleSelect:true,
				onDblClickRow:confirmDepart,
            ">
        <thead>
            <tr>
                <th data-options="field:'name'" width="50%">部门名称</th>
                <th data-options="field:'code'" width="45%" align="left">部门代码</th>
            </tr>
        </thead>
    </table> 
	</div>
	<div data-options="region:'south'" border="false" style="margin-left: 5px; text-align: center;height: 30px;line-height: 30px">
		<span style="color: red">请双击选择部门</span>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
			iconcls="icon-ok" onclick="confirmDepart()">确认选择</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconcls="icon-cancel" onclick="closeFirstWindow()">取消</a>  -->
	</div>
</div>

    
    

	<script type="text/javascript">
	function confirmDepart(){
		var row = $('#project-choose-depart-dg').datagrid('getSelected');
		var selections = $('#project-choose-depart-dg').datagrid('getSelections');
		if(row!=null&&selections.length==1){
			$('#'+'${inputId}').textbox('setValue',row.name);
			closeFirstWindow();
		}else{
			 //$.messager.alert('系统提示','请选择申报部门！','info');
			 alert('请选择申报部门！');
		}
	}
	</script>
</body>

</html>
	