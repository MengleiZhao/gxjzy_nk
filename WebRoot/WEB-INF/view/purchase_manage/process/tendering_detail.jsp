<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="tendering_detail_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
									<!-- 第一个div -->
					<div title="招标基本信息" data-options="iconCls:'icon-xxlb'"
						style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<!-- 表单样式参考 -->
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>招标名称</td>
								<td class="td2">
									<input id="F_fbiddingName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fbiddingName" data-options="validType:'length[1,30]'" style="width: 200px" value="${bean.fbiddingName}"/>
								</td>
								<td class="td4">
									<!-- 隐藏域 --> 
									<input type="hidden" name="fpId" id="F_fcId" value="${bean.fpId}"/>
									<input type="hidden" name="fbId" id="F_fbId" value="${bean.fbId}"/>
								</td>

								<td class="td1"><span class="style1">*</span>开标时间</td>
								<td class="td2">
									<input class="easyui-datebox"  class="dfinput" id="F_fstartTime"  name="fstartTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fstartTime}"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>招标编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fbiddingCode"  name=fbiddingCode  readonly="readonly" required="required"  data-options="validType:'length[1,50]'"   style="width:200px;" value="${bean.fbiddingCode}"/>
								</td>
								
								<td style="width: 0px">
								</td>

								<td class="td1"><span class="style1">*</span>采购批次编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fpCodeName"  name="F_fpCodeName"  style="width:200px;" readonly="readonly" value="${Fpcode}"/>
								</td>
								
								
							</tr>
							<tr class="trbody">
								<td class="td1">附件</td>
								<td colspan="4">
								<c:if test="${!empty attac}">
								<c:forEach items="${attac}" var="att">
									<c:if test="${att.serviceType=='zhaobdj' }">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a></br>
									</c:if>
								</c:forEach>
								</c:if>
								<c:if test="${empty attac}">
									<span style="color:#999999">暂未上传附件</span>
								</c:if>
							</tr>
						</table>
					</div>

													<!--第二个div  -->
					<div title="招标人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr>
								<td class="td1"><span class="style1">*</span>招标单位</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_ftendUnitName"  name="ftendUnitName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.ftendUnitName}"/>
								</td>
								
								<td class="td4"></td>
								
								<td class="td1"><span class="style1">*</span>传真</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_ftendFax"  name="ftendFax" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.ftendFax}"/>
								</td>
							</tr>
							
							
							<tr>
								<td class="td1"><span class="style1">*</span>联系人</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_ftendUser"  name="ftendUser" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.ftendUser}"/>
								</td>
								
								<td style="width: 0px"></td>
								
								<td class="td1"><span class="style1">*</span>联系人电话</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_ftendUserTel"  name="ftendUserTel" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.ftendUserTel}"/>
								</td>
							</tr>
							
							
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>招标单位地址</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_ftendUnitAddr"  name="ftendUnitAddr" readonly="readonly" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.ftendUnitAddr}"/>
								</td>
							</tr>
						</table>
					</div>
											<!-- 第三个div -->
					<div title="代理人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
					  		<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr>
								<td class="td1"><span class="style1">*</span>代理机构</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_fagentName"  name="fagentName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fagentName}"/>
								</td>
								
								<td class="td4"></td>
								
								<td class="td1"><span class="style1">*</span>传真</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_fagentFax"  name="fagentFax" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fagentFax}"/>
								</td>
							</tr>
							
							
							<tr>
								<td class="td1"><span class="style1">*</span>联系人</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_fagentUser"  name="fagentUser" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fagentUser}"/>
								</td>
								
								<td style="width: 0px"></td>
								
								<td class="td1"><span class="style1">*</span>联系人电话</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_fagentUserTel"  name="fagentUserTel" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fagentUserTel}"/>
								</td>
							</tr>
							
							
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>代理机构地址</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fagentAddr"  name=fagentAddr readonly="readonly" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${bean.fagentAddr}"/>
								</td>
							</tr>
						</table>												
					</div>
				</div>
			</div>
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
			
			
			<%-- <div class="win-right-div" data-options="region:'east',split:true">
				<jsp:include page="../../check_system.jsp" />
			</div> --%>
	</div>
</form>


	</div>
	<script type="text/javascript">	
	 //寻找相关制度
	function findSystemFile(id) {
		$.ajax({ 
			url: base+"/cheter/systemFind?id="+id, 
			success: function(data){
				data=data.replace('\"','');
				data=data.replace('\"','');
				window.open(data);
	    }});
	} 
	 
	//查看附件
	function findAttacFile(id) {
		$.ajax({ 
			url: base+"/cgprocess/attacFind?id="+id, 
			success: function(data){
				data=data.replace('\"','');
				data=data.replace('\"','');
				window.open(data);
	    }});
	}
		
		


		
</script>
</body>
<script type="text/javascript">
//显示详情tab
</script>
</html>

