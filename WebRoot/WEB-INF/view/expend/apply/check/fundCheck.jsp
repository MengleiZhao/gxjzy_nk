<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table cellpadding="0" cellspacing="0" class="window-table" style="width: 640px;">
	<tr class="trbody">
		<td class="window-table-td1"><span class="style1">*</span>资金性质</td>
		<td class="window-table-td2">
		<select id="fundSource" class="easyui-combobox"  editable="false" required="required" name="fundSource" style="width: 200px;height: 30px;" >
			<option value="0" <c:if test="${bean.fundSource==99 }">selected="selected"</c:if>>-请选择-</option>
			<option value="1" <c:if test="${bean.fundSource==0 }">selected="selected"</c:if>>财政拨款收入</option>
			<option value="2" <c:if test="${bean.fundSource==1 }">selected="selected"</c:if>>教育事业收入</option>
			<option value="3" <c:if test="${bean.fundSource==2 }">selected="selected"</c:if>>科研事业收入</option>
			<option value="4" <c:if test="${bean.fundSource==3 }">selected="selected"</c:if>>非同级拨款收入</option>
			<option value="5" <c:if test="${bean.fundSource==4 }">selected="selected"</c:if>>其他收入</option>
			<option value="6" <c:if test="${bean.fundSource==5 }">selected="selected"</c:if>>利息收入</option>
		</select></td>
		<td class="window-table-td1"><span class="style1">*</span>银行账户</td>
		<td class="window-table-td2">
			<input id="bankAccountId" class="easyui-combobox" required="required" editable="false" name="bankAccountId" 
			style="width: 200px;height: 30px;" 
			data-options="
					url:'${base }/lookup/lookupsJson?parentCode=YHZHLX&selected=${bean.bankAccountId }',
				    valueField: 'code',
                    textField: 'text',
                    formatter:function(row){
                    	var opts = $(this).combobox('options');
                    	var mytext = row[opts.textField];
                    	mytext = mytext.substring(mytext.lastIndexOf('_')+1,mytext.length);
						return 	mytext;
                    }
			"
			>
			<input id="bankAccountName" name="bankAccountName" type="hidden">
			<input hidden="hidden" name="economicCode" id="economicCode" />		
		</td>
	</tr>
	<tr class="trbody">
		<td class="window-table-td1"><span class="style1">*</span>资金来源</td>
		<td class="window-table-td2">
			<input id="economicTree" class="easyui-combotree" required="required" name="amountType"  editable="false" style="width: 200px;height: 30px;" 
				data-options="url:'${base }/yearsUnionBasic/fourTree?code=${indexCode }',animate:true,lines:true,">
		</td>
	</tr>
	
</table>


<script type="text/javascript">
	$(function(){
		//选择银行账户字典，存入银行账户名称
		$('#bankAccountId').combobox({
			onChange:function(newValue,oldValue){
				$('#bankAccountName').val(newValue);
			}
		});
		
	});
	
	$('#economicTree').combotree({
		onBeforeSelect:function(node){//设置只能选择底层编码
			if (!$(this).tree('isLeaf', node.target)) {
				alert("请选择底层科目！");
				/* $(this).tree('expand', node.target); //展开子节点 */
                return false;
            } 
        },
        onSelect:function(item){
			$('#economicCode').val(item.id);
        	
        },
	});
	
</script>
