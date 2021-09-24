<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<table cellpadding="0" cellspacing="0" border="0">
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;合同编号</td>
			<td colspan="4">
				<input id="F_fcCode" class="easyui-textbox" readonly="readonly" type="text"  name="fcCode" data-options="validType:'length[1,32]'" style="width: 563px" value="${bean.fcCode}"/>
			</td >
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;合同名称</td>
			<td colspan="4">
				<input class="easyui-textbox" type="text"  id="F_fcTitle" name="fcTitle" required="required" data-options="validType:'length[1,50]'" style="width: 563px" value="${bean.fcTitle}"/>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;合同分类</td>
			<td class="td2">
				<input class="easyui-combobox" id="F_fcTypeName" required="required" name="fcTypeName"  style="width: 200px" data-options="editable:false,panelHeight:'auto',
					url:'${base}/Formulation/lookupsJson?parentCode=HTFL&selected=${bean.fcType}',
					valueField:'text',
					textField:'text',
					onChange:showcg
				"/>
				<input id="F_fcType" name="fcType" value="${bean.fcType}" hidden="hidden"/>
			</td>
			<td class="td4">&nbsp;</td>
			<td class="td1"><span class="style1">*</span>&nbsp;合同份数</td>
			<td class="td2">
				<input id="F_fcNum" class="easyui-numberbox" required="required" name="fcNum" data-options="validType:'length[1,2]',precision:0,onChange:checkfenshu" style="width: 206px" value="${bean.fcNum}"/>
			</td>
		</tr>
		<tr class="trbody" id="cg1" hidden="hidden">
			<td class="td1"><span class="style1">*</span>&nbsp;采购订单</td>
			<td  colspan="4">
				<a onclick="fPurchNo_DC()"><input id="F_fPurchName" readonly="readonly" class="easyui-textbox" name="fPurchName" data-options="prompt:'单击打开选取采购订单'" value="${bean.fPurchName}" style="width: 563px"/></a>
				<input id="F_fPurchNo" hidden="hidden" type="text" name="fPurchNo" data-options="validType:'length[1,32]'" value="${bean.fPurchNo}"/>
			</td>
		</tr>
		<tr class="trbody" id="cg2">
			<td class="td1"><span class="style1">*</span>&nbsp;合同金额小写</td>
			<td class="td2">
				<input class="easyui-numberbox" id="F_fcAmount" name="fcAmount" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" style="width: 200px" value="${bean.fcAmount}"/>
			</td>
			<td class="td4">&nbsp;</td>
			<td class="td1"><span class="style1">*</span>&nbsp;合同金额大写</td>
			<td class="td2">
				<input id="F_fcAmountMax" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fcAmountMax" data-options="validType:'length[1,25]'" style="width: 206px" value="${bean.fcAmountMax}"/>
			</td >
		</tr>
		<%-- <tr class="trbody" id="aa" hidden="hidden">
			<td class="td1"><div id="cg3"><span class="style1">*</span>&nbsp;付款方式</div></td>
			<td class="td2">
				<div id="cg4">
				<input class="easyui-combobox" id="F_fPayType" name="fPayType.code" data-options="panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false" style="width: 200px" />
				</div>
			</td>
			<td class="td4">&nbsp;</td>
			<td class="td1">协同部门</td>
			<td class="td2" >
				<select id="F_assisDeptId" class="easyui-combobox" name="assisDeptId" data-options="validType:'length[1,20]',editable:false" style="width: 206px" >
					<option value="">--请选择--</option>
					<option value="14" <c:if test="${bean.assisDeptId==14}">selected="selected"</c:if> >设备与安技处</option>
					<option value="35" <c:if test="${bean.assisDeptId==35}">selected="selected"</c:if> >总务处</option>
					<option value="20" <c:if test="${bean.assisDeptId==20}">selected="selected"</c:if> >创业就业指导中心</option>
				</select>					
			</td>
		</tr> --%>
		
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;履约保证金</td>
			<td class="td2">
				<input id="fperformance" class="easyui-numberbox" required="required" name="fperformance" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" style="width: 206px" value="${bean.fperformance}"/>
			</td>
		</tr>
		
		<tr class="trbody" id="cc" hidden="hidden">
			<td class="td1"><span class="style1">*</span>是否制式合同</td>
			<td class="td2">
				<input type="radio" name="standard" value="0" <c:if test="${bean.standard==0}">checked="checked"</c:if> />否
				<input type="radio" name="standard" value="1" <c:if test="${bean.standard==1}">checked="checked"</c:if> />是
			</td>
			<td class="td4">&nbsp;</td>
		</tr>
		<tr class="trbody" id="bb" hidden="hidden">
			<td class="td1"><span class="style1">*</span>是否制式合同</td>
			<td class="td2">
				<input type="radio" name="standard" value="0" <c:if test="${bean.standard==0}">checked="checked"</c:if> />否
				<input type="radio" name="standard" value="1" <c:if test="${bean.standard==1}">checked="checked"</c:if> />是
			</td>
			<%-- <td class="td4">&nbsp;</td>
			<td class="td1">协同部门</td>
			<td class="td2" >
				<select id="F_assisDeptId" class="easyui-combobox" name="assisDeptId" data-options="validType:'length[1,20]',editable:false" style="width: 206px" >
					<option value="">--请选择--</option>
					<option value="14" <c:if test="${bean.assisDeptId==14}">selected="selected"</c:if> >设备与安技处</option>
					<option value="35" <c:if test="${bean.assisDeptId==35}">selected="selected"</c:if> >总务处</option>
					<option value="20" <c:if test="${bean.assisDeptId==20}">selected="selected"</c:if> >创业就业指导中心</option>
				</select>					
			</td> --%>
		</tr>
		<tr class="trbody" id="dd" hidden="hidden">
			<td class="td1"><span class="style1">*</span>是否预开发票</td>
			<td class="td2">
				<input type="radio" name="isinvoice" value="0" <c:if test="${bean.isinvoice==0}">checked="checked"</c:if> />否
				<input type="radio" name="isinvoice" value="1" <c:if test="${bean.isinvoice==1}">checked="checked"</c:if> />是
			</td>
			<td class="td4">&nbsp;</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>是否框架合同</td>
			<td class="td2">
				<input type="radio" name="iskjht" value="0" <c:if test="${bean.iskjht!=1}">checked="checked"</c:if> />否
				<input type="radio" name="iskjht" value="1" <c:if test="${bean.iskjht==1}">checked="checked"</c:if> />是
			</td>
			<td class="td4">&nbsp;</td>
		</tr>
		<tr class="trbody">
			<td class="td1">
				<span class="style1">*</span>&nbsp;合同文本
				<input type="file" multiple="multiple" id="fhtwb" onchange="upladFileMoreParams(this,'fhtwb','htgl01','fhtwbprogressNumber','htwbpercent','htwbtdf','htwbfiles','htwbprogid','htwbfileUrl')" hidden="hidden" accept=".pdf">
				<input type="text" id="htwbfiles" name="htwbfiles" hidden="hidden">
			</td>
			<td colspan="4" id="htwbtdf">
				<a onclick="$('#fhtwb').click()" style="font-weight: bold;" href="#">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
				</a>
				<c:forEach items="${formulationAttaList}" var="att">
					<c:if test="${att.serviceType=='fhtwb' }">
						<div style="margin-top: 10px;">
							<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a id="${att.id}" class="htwbfileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
						</div>
					</c:if>
				</c:forEach>
				<div id="htwbprogid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
					<div id="fhtwbprogressNumber" style="background:#3AF960;width:0px;height:10px" >
				 	</div>文件上传中...&nbsp;&nbsp;<font id="htwbpercent">0%</font> 
				</div>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;预计开始时间</td>
			<td class="td2">
				<input id="F_fContStartTime" class="easyui-datebox" class="dfinput" required="required" name="fContStartTime" data-options="validType:'length[1,20]',editable:false" style="width: 200px" value="${bean.fContStartTime}"/>
			</td >
			<td class="td4">&nbsp;</td>
			<td class="td1"><span class="style1">*</span>&nbsp;预计结束时间</td>
			<td class="td2">
				<input class="easyui-datebox"  class="dfinput"  id="F_fContEndTime" required="required" name="fContEndTime"  data-options="validType:'length[1,20]',editable:false" style="width: 206px" value="${bean.fContEndTime}"/>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1" ><span class="style1">*</span>&nbsp;合同情况说明</td>
			<td colspan="4">
				<input type="text" id="CF_fFlowStauts" name="fFlowStauts" hidden="hidden" value="${bean.fFlowStauts}"/>
				<input id="f_fRemark" class="easyui-textbox" type="text" required="required" name="fRemark" data-options="multiline:true" style="width: 563px;height: 90px" value="${bean.fRemark}"/>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
			<td class="td2">
				<input id="F_fDeptName" class="easyui-textbox" readonly="readonly" type="text"  name="fDeptName" data-options="validType:'length[1,50]'" style="width: 200px" value="${bean.fDeptName}"/>
			</td >
			<td class="td4">&nbsp;</td>
			<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
			<td class="td2">
				<input id="F_fOperator" class="easyui-textbox" readonly="readonly" type="text" required="required" name="fOperator" data-options="validType:'length[1,25]'" style="width: 206px" value="${bean.fOperator}"/>
			</td >
		</tr>
	</table>
<script type="text/javascript">
$("#loan_ledger_list_top_estChargeTime1").datebox({
    onSelect : function(beginDate){
        $('#loan_ledger_list_top_estChargeTime2').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

 function fPurchNo_DC() {
	var win = creatFirstWin('选择采购单', 940, 600, 'icon-search',
			'/PurchaseApply/PurchNoList');
	win.window('open');
} 

function checkfenshu(newValue) {
	if(newValue>10){
		alert("合同份数不能超过十份");
		$('#F_fcNum').numberbox("setValue","");
	}
}
var startdayCon='';
var enddayCon='';
$("#F_fContStartTime").datebox({
    onSelect : function(beginDate){
    	startdayCon = beginDate;
    	enddayCon =new Date(enddayCon);
    	var d = (enddayCon-startdayCon)/86400000+1;
    	
    	if(d>0){
    		$('#trDayNum').numberbox("setValue",d);
    		$('#personDay2').val(d);
    		$('#personDay2').val(d);
    	} else {
    		$('#trDayNum').numberbox("setValue", "");
    		$('#personDay2').val("");
    		$('#personDay2').val("");
    	}
        $('#F_fContEndTime').datebox().datebox('calendar').calendar({
            validator: function(date){
	                return beginDate <= date;
            }
        });
    }
}); 

function showcg(newValue) {
	if(newValue == '支出合同'){
		$('#cg').show();
	}else{
		$('#cg').hide();
	}
}
</script>