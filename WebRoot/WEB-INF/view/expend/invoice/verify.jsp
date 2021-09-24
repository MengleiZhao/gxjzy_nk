<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<style>
	.td1-ys{
		width: 180px;
	}
	td{
	}
</style>
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
							showInfo(invoice);
						}
					} else if (invoice.success=='false') {
						alert('未查询到该发票信息！');
					}
				} 
			});
		}
		
		function showInfo(invoice){
			$('#td_fpdm').text(invoice.fpdm);
			$('#td_fphm').text(invoice.fphm);
			$('#td_kprq').text(invoice.kprq);
			$('#td_xfMc').text(invoice.xfMc);
			$('#td_fplxName').text(invoice.fplxName);
			$('#td_sfMc').text(invoice.sfMc);
			$('#td_sfCode').text(invoice.sfCode);
			$('#td_xfNsrsbh').text(invoice.xfNsrsbh);
			$('#td_xfContact').text(invoice.xfContact);
			$('#td_xfBank').text(invoice.xfBank);
			$('#td_gfMc').text(invoice.gfMc);
			$('#td_gfNsrsbh').text(invoice.gfNsrsbh);
			$('#td_gfContact').text(invoice.gfContact);
			$('#td_gfBank').text(invoice.gfBank);
			$('#td_code').text(invoice.code);
			$('#td_num').text(invoice.num);
			$('#td_del').text(invoice.del);
			$('#td_taxamount').text(invoice.taxamount);
			$('#td_goodsamount').text(invoice.goodsamount);
			$('#td_sumamount').text(invoice.sumamount);
			$('#td_quantityAmount').text(invoice.quantityAmount);
			$('#td_remark').text(invoice.remark);
			$('#win-invoice-info').window('open');
		}
		
	</script>
	
    <div class="easyui-layout" fit="true">
    
    	<div region="center" border="false">
	    	<form id="invoiceVerifyForm" action="${base}/invoice/verify" method="post" data-options="novalidate:true" class="easyui-form">
	    		<table>
	    			<tr class="trbody">
	    				<td class="td1-ys"><span style="color:red;">*</span>发票代码</td>
	    				<td>
	    					<input class="easyui-numberbox" name="fpdm" id="inVe_fpdm" data-options="required:false,validType:'fpdm'"/>
	    					<script>
	    					$(function () {

	    				        $('#inVe_fpdm').numberbox('textbox').attr('maxlength', 12);

	    				    });
	    					</script>
	    				</td>
	    			</tr>
	    			<tr class="trbody">
	    				<td class="td1-ys"><span style="color:red;">*</span>发票号码</td>
	    				<td>
	    					<input class="easyui-numberbox" name="fphm" id="inVe_fphm" data-options="required:false,validType:'fphm'"/>
	    					<script>
	    					$(function () {

	    				        $('#inVe_fphm').numberbox('textbox').attr('maxlength', 8);

	    				    });
	    					</script>
	    				</td>
	    			</tr>
	    			<tr class="trbody">
	    				<td class="td1-ys"><span style="color:red;">*</span>开票日期</td>
	    				<td>
	    					<input class="easyui-datebox" editable="fasle" name="kprq" id="inVe_kprq"/>
	    				</td>
	    			</tr>
	    			<tr class="trbody">
	    				<td class="td1-ys"><span style="color:red;">*</span>校验码后六位</td>
	    				<td>
	    					<input class="easyui-numberbox" name="checkCode" id="inVe_checkCode" data-options="required:false,validType:'yzmhlw'"/>
	    					<script>
	    					$(function () {

	    				        $('#inVe_checkCode').numberbox('textbox').attr('maxlength', 6);

	    				    });
	    					</script>
	    				</td>
	    			</tr>
	    			<!-- <tr class="trbody">
	    				<td class="td1-ys"><span style="color:red;">*</span>不含税金额</td>
	    				<td>
	    					<input class="easyui-textbox" name="noTaxAmount" id="inVe_noTaxAmount"/>
	    				</td>
	    			</tr> -->
	    		
				</table>
			</form>
			
			    <div id="win-invoice-info" class="easyui-window" 
			    	data-options="iconCls:'icon-search',title:'查看-发票信息',closed: true,minimizable: false,maximizable: false,collapsible: false,
			    	" 
			    	style="width:1100px;height:600px;padding:10px;">
			        <table cellpadding="0" cellspacing="0" class="ourtable" style="width:100%">
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>发票代码</td>
							<td id="td_fpdm"></td>
							<td class="td1-ys" style="margin-left: 250"><span style="color:red;">*</span>发票号码</td>
							<td id="td_fphm"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>开票日期</td>
							<td id="td_kprq"></td>
							<td class="td1-ys"><span style="color:red;">*</span>销售方名称</td>
							<td id="td_xfMc"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>发票类型名称</td>
							<td id="td_fplxName"></td>
							<td class="td1-ys"><span style="color:red;">*</span>省份名称</td>
							<td id="td_sfMc"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>省份代码</td>
							<td id="td_sfCode"></td>
							<td class="td1-ys"><span style="color:red;">*</span>纳税人识别号</td>
							<td id="td_xfNsrsbh"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>销售方地址、电话</td>
							<td id="td_xfContact"></td>
							<td class="td1-ys"><span style="color:red;">*</span>销售方开户行及账号</td>
							<td id="td_xfBank"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>购买方名称</td>
							<td id="td_gfMc"></td>
							<td class="td1-ys"><span style="color:red;">*</span>购买方纳税人识别号</td>
							<td id="td_gfNsrsbh"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>购买方地址、电话</td>
							<td id="td_gfContact"></td>
							<td class="td1-ys"><span style="color:red;">*</span>购买方开户行及账号</td>
							<td id="td_gfBank"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>校验码</td>
							<td id="td_code"></td>
							<td class="td1-ys"><span style="color:red;">*</span>机器编号</td>
							<td id="td_num"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>是否作废</td>
							<td id="td_del"></td>
							<td class="td1-ys"><span style="color:red;">*</span>税额合计</td>
							<td id="td_taxamount"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>合计</td>
							<td id="td_goodsamount"></td>
							<td class="td1-ys"><span style="color:red;">*</span>价税合计</td>
							<td id="td_sumamount"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>数量</td>
							<td id="td_quantityAmount"></td>
							<td class="td1-ys"><span style="color:red;">*</span>备注</td>
							<td id="td_remark"></td>
						</tr>
						<tr class="trbody">
							<td class="td1-ys"><span style="color:red;">*</span>updateTime</td>
							<td id="td_updateTime"></td>
						</tr>
					</table>
			    </div>
				
		</div>
		
		<div region="south" border="false" class="south">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="invoiceVerify();" >校验</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow();">关闭</a>
		</div>
		
	</div>
</body>
</html>

