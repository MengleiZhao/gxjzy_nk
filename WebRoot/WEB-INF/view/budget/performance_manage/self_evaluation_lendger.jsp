<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>



</head>
<body>
<style type="text/css">
input{
	width:150px;
}
select{
	width:150px;
}
.td-leap{
	width:20px;
}

.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.textbox-text{color:#666666;height: 25px; line-height: 25px}

.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.textbox-text{color:#666666;height: 25px; line-height: 25px}
.style1{color: red;}
.numberbox .textbox-text {text-align: left;}
.tabDiv{padding:10px;}
.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
.trtop{height: 10px;}
.trbody{height: 30px;}
.td1{width: 100px;}
.td2{height: 30px;width: 150px;} 
/* .textbox-text{color:#666666;height: 25px; line-height: 25px}
.style1{color: red;height: 40px;}
.numberbox .textbox-text {text-align: left;}
.tabDiv{padding:10px;}
.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
.td1{width: 100px;}
.td2{height: 30px;width: 150px;}
.trtop{height: 10px;}
.trbody{height: 30px;} */

</style>
<div class="easyui-layout" fit="true" style="color: #333333">
	<div data-options="region:'west',spilt:true" style="border-color: dce5e9; width:798px;" id="westDiv">
		
		<div class="easyui-layout" fit="true" >
			
			<div data-options="region:'center'" style="border-color: dce5e9">
				<table>
					<tr>
						<td>	
							<form id="project_eval_form" method="post" enctype="multipart/form-data">
							
							<div class="easyui-accordion" data-options="" id="easyAcc" style="width:750px;margin-left: 20px;">
						        	<!--第一个div  -->
						        	<div title="项目基本信息" style="" data-options="iconCls:'icon-xxlb'">
						        		<%@ include file="../self_evaluation/project_base_info.jsp" %>
						        	</div> 
																<!--第二个div  -->
									<div title="预算执行评价" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
										<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
											<tr>
												<td class="td1"><span class="style1">*</span>项目总预算</td>
												<td class="td2">
													<input class="easyui-textbox" type="text" id="F_fproAmount"  name="fproAmount" readonly="readonly"  data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"  style="height:30px;width:150px"  value="${budgetbean.fproAmount}"/>
												</td>
												<td style="width: 0px"></td>
												<td class="td1"><span class="style1">*</span>本年度预算</td>
												<td class="td2">
													<input class="easyui-textbox" type="text" id="F_fproAmountYear"  name="fproAmountYear" readonly="readonly"  data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" style="height:30px;width:150px" value="${budgetbean.fproAmountYear}"/>
													<input type="hidden" name="FProId" value="${bean.FProId }"/>
												</td>
											</tr>
											<tr>
												<td class="td1"><span class="style1">*</span>本年度执行数</td>
												<td class="td2">
													<input class="easyui-textbox" type="text" id="F_fproAmountYearActual"  name="fproAmountYearActual" readonly="readonly"  data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" style="height:30px;width:150px" value="${budgetbean.fproAmountYearActual}"/>
												</td>
												<td style="width: 0px"></td>
												<td class="td1"><span class="style1">*</span>执行率</td>
												<td class="td2">
													<input class="easyui-textbox" type="text" id="F_fexecRate"  name="fexecRate" readonly="readonly"  data-options="validType:'length[1,20]'" style="height:30px;width:150px" value="${budgetbean.fexecRate}"/>
												</td>
											</tr>
											<tr style="height: 70px;">
												<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>偏差原因分析</td>
												<td colspan="4">
													<input class="easyui-textbox" type="text" id="F_fdeviationDesc"  name="fdeviationDesc" readonly="readonly"  data-options="validType:'length[1,50]',multiline:true"   style="width:450px;height:70px;" value="${budgetbean.fdeviationDesc}"/>
												</td>
											</tr>
											<tr style="height: 70px;">
												<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>备注</td>
												<td colspan="4">
													<input class="easyui-textbox" type="text" id="F_fremark"  name="fremark" readonly="readonly"  data-options="validType:'length[1,50]',multiline:true"   style="width:450px;height:70px;" value="${budgetbean.fremark}"/>
												</td>
											</tr>
										</table>
									</div>
									<!--第3个div  -->
						        	<div title="绩效指标评价" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;height: 300px;">
						        		<div>
						        			<%-- <%@ include file="project_year_eval_lendger.jsp" %> --%>
						        			<jsp:include page="project_year_eval_lendger.jsp" /> 												
						        		</div>
						        	</div> 
																						<!--第4个div  -->
						        	<div title="评价报告" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;height: 300px;">
						        		<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
											<tr>
												<td class="td1"><span class="style1">*</span>自评负责人</td>
												<td class="td2">
													<input class="easyui-textbox" type="text" id="F_fevalUser" readonly="readonly"  name="fevalUser"  style="height:30px;width:150px" value="${fevalUser}"/>
												</td>
												<td style="width: 0px"></td>
												<td class="td1"><span class="style1">*</span>自评方式</td>
												<td class="td2">
													<select id="F_fevalMethod" class="easyui-combobox" name="fevalMethod" readonly="readonly"  style="height:30px;width:150px;" >
     													<option value="" >-请选择-</option>
     													<option value="1" <c:if test="${fevalMethod=='1'}">selected="selected"</c:if>>第三方评价</option>
     													<option value="2" <c:if test="${fevalMethod=='2'}">selected="selected"</c:if>>自主评价</option>
     													<option value="3" <c:if test="${fevalMethod=='3'}">selected="selected"</c:if>>其他</option>
     												</select>
												</td>
											</tr>
											<tr class="trbody">
												<td class="td1">附件</td>
												<td colspan="4">
												<c:if test="${!empty attac}">
													<c:forEach items="${attac}" var="att">
													<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a></br>
												</c:forEach>
												 </c:if>
												 <c:if test="${empty attac}">
												 	<span style="color:#999999">暂未上传附件</span>
												 </c:if>
											</tr>
										</table>
						        	</div>
						        </div>
						        
						        
				        	</form>
						</td>
					</tr>
				</table>
			</div>
			
			<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
				<div style="width:794px;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 0px">
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</div>
			</div>
		</div>
		
	</div>
						
</div>

	<script type="text/javascript">
	//查看附件
	function findAttacFile(id) {
		$.ajax({ 
			url: base+"/pfmlendgergl/attacFind?id="+id, 
			success: function(data){
				data=data.replace('\"','');
				data=data.replace('\"','');
				window.open(data);
	    }});
	}
	</script>

</body>
</html>

