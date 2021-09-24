<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
    <table id="proceeds-edit-plan-dg-detail" class="easyui-datagrid" style="width:700px;height:auto;"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				url: '${base}/Formulation/proceedsmingxi?id=${bean.fcId}&type=0',
				method: 'post',
				scrollbarSize:0,
				rownumbers:true,
			">
		<thead>
			<tr>
				<th data-options="field:'fProceedsProperty',align:'center',
						editor:{
							editable:true,
							type:'combotree',
							options:{
								required:false,
								editable:false,
								valueField:'text',
								textField:'text',
								validType:'selectValid',
								method:'post',
								url:'${base}/Expiration/lookupsJson?parentCode=FKXZ'
							}
						}"style="width: 17%">收款性质</th>
				<th data-options="field:'fProceedsCondition',align:'center'"style="width: 38%">收款条件</th>
				<th data-options="field:'fProceedsTime',align:'center',formatter:ChangeDateFormat"style="width: 22%">预计收款时间</th>
				<th data-options="field:'fProceedsAmount',align:'center'"style="width: 22%">预计收款金额(元)</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
//完成后计算总额并设置
var loadplan = 0;
$('#proceeds-edit-plan-dg').datagrid({
	onLoadSuccess : function(data){
		var rows = data.rows;
		var amount = 0.00;
		loadplan += 1;
		for(var i = 0 ;i<rows.length; i++){
			amount = parseFloat(amount) + parseFloat(rows[i].fProceedsAmount);
		}
		$('#totalAmount').val(amount);
		$('#F_fcAmount').numberbox('setValue',amount);
	}
});
		//计算总额
function setFsumMoney(newValue,oldValue) {
			if(newValue==undefined || oldValue==undefined){
				return false;
			}
			var totalFsumMoney = 0;
			var fsumMoney = 0;
			var index=$('#proceeds-edit-plan-dg').datagrid('getRowIndex',$('#proceeds-edit-plan-dg').datagrid('getSelected'));
			var rows = $('#proceeds-edit-plan-dg').datagrid('getRows');
			for(var i=0;i<rows.length;i++){
				if(i==index){
					fsumMoney=parseFloat(newValue);
				}else{
					totalFsumMoney+=addNum(rows,i);
				}  
			 
			}
			totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
			totalFsumMoney=parseFloat(totalFsumMoney);
			$('#totalAmount1').val(totalFsumMoney);
		}
//未编辑或者已经编辑完毕的行
function addNum(rows,index){
	var amount=rows[index]['fProceedsAmount'];
	return parseFloat(amount); 
}
</script>