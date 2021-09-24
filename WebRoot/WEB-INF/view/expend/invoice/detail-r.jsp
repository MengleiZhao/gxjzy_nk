<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
	<script type="text/javascript">
		var names = new Array();
		function invoiceVerify(){
			//校验
			//form 提交
			var flag=false;
			$('#invoiceVerifyForm').form('submit', {
				onSubmit: function(){ 
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				dataType:'json',
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					var invoice = JSON.parse(data);
					if (invoice.success=='true') {
						if(confirm('该发票信息真实有效！是否查看发票详情？')){
							creatSecondWin('查看-发票信息','700','500','icon-search','/invoice/detailR/'+data);
						}
					} else if (invoice.success=='false') {
						alert('未查询到该发票信息！');
					}
				} 
			});
		}
		
	</script>
	
    <div class="easyui-layout" fit="true">
    
    	<div region="center" border="false">
	    	<form id="invoiceVerifyForm" action="${base}/invoice/verify" method="post" data-options="novalidate:true" class="easyui-form">
	    		<table>
	    			<tr>
	    				<th><span style="color:red;">*</span>发票代码</th>
	    				<td>
	    					<input class="easyui-textbox" name="fpdm" id="inVe_fpdm" value=${invoice.fpdm }/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th><span style="color:red;">*</span>发票号码</th>
	    				<td>
	    					<input class="easyui-textbox" name="fphm" id="inVe_fphm"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th><span style="color:red;">*</span>开票日期</th>
	    				<td>
	    					<input class="easyui-datebox" name="kprq" id="inVe_kprq"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th><span style="color:red;">*</span>校验码后六位</th>
	    				<td>
	    					<input class="easyui-textbox" name="checkCode" id="inVe_checkCode"/>
	    				</td>
	    			</tr>
	    			<!-- <tr>
	    				<th><span style="color:red;">*</span>不含税金额</th>
	    				<td>
	    					<input class="easyui-textbox" name="noTaxAmount" id="inVe_noTaxAmount"/>
	    				</td>
	    			</tr> -->
	    		
				</table>
			</form>
		</div>
		
		<div region="south" border="false" class="south">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="invoiceVerify();">保存</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow();">关闭</a>
		</div>
		
	</div>
</body>
</html>

