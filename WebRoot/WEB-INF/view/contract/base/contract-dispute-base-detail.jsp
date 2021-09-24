<%-- <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> --%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="easyui-accordion" data-options="multiple:true" style="width:662px;margin-left: 0px;">
					<div title="" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table cellpadding="0" cellspacing="0"  class="ourtable">
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;解决方式</td>
										<td class="td2">
											<input class="easyui-combobox" id="F_fDisType" readonly="readonly" required="required" name="fDisType.code" style="width: 200px" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=JFJJFS&selected=${dispute.fDisType.code}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'">
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>&nbsp;是否外聘律师</td>
										<td class="td2">
											<input type="radio" name="fLawyer" value="0" onclick="javascript:return false" <c:if test="${dispute.fLawyer=='0'}">checked="checked"</c:if> />否
											<input type="radio" name="fLawyer" value="1" onclick="javascript:return false" <c:if test="${dispute.fLawyer=='1'}">checked="checked"</c:if> />是
										</td>
									</tr>
									<tr class="trbody" style="height: 110px">
										<td class="td1"><span class="style1">*</span>&nbsp;争议描述</td>
										<td colspan="4">
											<input hidden="hidden" name="fDisId" value="${dispute.fDisId}">
											<input  class="easyui-textbox" readonly="readonly" required="required" id="Dis_fDisRemark" name="fDisRemark" data-options="validType:'length[1,200]',multiline:true" style="width: 555px;height:100px" value="${dispute.fDisRemark}"/>
										</td>
									</tr>
									<tr class="trbody" style="height: 110px">
										<td class="td1"><span class="style1">*</span>&nbsp;处理结果</td>
										<td colspan="4">
											<input class="easyui-textbox" readonly="readonly" required="required" id="Dis_fDisResult" name="fDisResult" data-options="validType:'length[1,200]',multiline:true" style="width: 555px;height:100px" value="${dispute.fDisResult}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
										</td>
										<td colspan="4" id="tdfhtjf">
											<c:forEach items="${disputeAttaList}" var="att">
												<c:if test="${att.serviceType=='htjf' }">
													<div >
														<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													</div>
												</c:if>
											</c:forEach>
										</td>
									</tr>
								</table>
							</div>
						</div>
<script type="text/javascript">
var c5=0;


$('#dispute_fcType').combobox({  
    onChange:function(newValue,oldValue){  
	var sel2=$('#dispute_fcType').combobox('getValue');
	if(sel2!="1"){
		$('#cg1').hide();
		$('#cg2').hide();
		//$('#dispute_fPurchNo').next(".textbox").show();
	}else{
		$('#cg1').show();
		$('#cg2').show();
		//$('#dispute_fPurchNo').next(".textbox").hide();
	} 
    }
}); 
function disputeSaveForm(){
	
	var s="";
	$(".fileUrl5").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files5").val(s); 
	
	var plan = getPlan();
	$('#disputetInfo').form('submit', {
			onSubmit:function(param){ 
				param.planJson=plan;
				 flag=$(this).form('enableValidation').form('validate');
			}, 
			url:'${base}/Dispute/save',
			type:'post',
			/* data:{'fFileSrc':$('#dispute_fFileSrc').val()}, */
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#dispute_dg').form('clear');
					$('#dispute_dg').datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});		
	}
	function fPurchNo_DC(){
		//var node=$('#dispute_dg').datagrid('getSelected');
		var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
		win.window('open');
	}
	function quota_DC(){
		//var node=$('#dispute_dg').datagrid('getSelected');
		var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
		win.window('open');
	}
	var c =0;
	function upt_upFile() {
		/* console.log(document.getElementById("upt_fFileSrc1"));
		var src = getFilePath();
		alert(getFilePath()); */
		c ++;
		var src = $('#upt_fFileSrc1').val();
		/* var srcs =src+','+$('#upt_fi1').val();
		$('#upt_fi1').val(srcs); */
		$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a><a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>删除</a></div>");
	} 
	function deleteF1(val){
		var child=document.getElementById(val.id);
		child.parentNode.removeChild(child);
	}
</script>