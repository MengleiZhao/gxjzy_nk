<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="tender_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
									<!-- 第一个div -->
					<div title="招标基本信息"   id="zbjbxxdiv" data-options="iconCls:'icon-xxlb'"
						style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<!-- 表单样式参考 -->
							<tr class="trbody">
							<td class="td1"><span class="style1">*</span>采购批次编号</td>
								<td class="td2">
									<c:if test="${empty bean.fbId}">
										<a href="javascript:void(0)" onclick="checkCGCode()">
											<input class="easyui-textbox" id="F_fpCodeName"  name="F_fpCodeName"  style="width:200px;" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkCGCode()}}]" value="${Fpcode}"/>
										</a>
									</c:if>
									<c:if test="${!empty bean.fbId}">
											<input class="easyui-textbox" id="F_fpCodeName"  name="F_fpCodeName"  style="width:200px;" readonly="readonly" value="${Fpcode}"/>
									</c:if>
								</td> 
								<td class="td4">
									<!-- 隐藏域 --> 
									<input type="hidden" name="fpId" id="F_fcId" value="${bean.fpId}"/>
									<input type="hidden" name="fbId" id="F_fbId" value="${bean.fbId}"/>
									<input type="hidden" name="F_fpCode" id="F_fpCode" value="${bean.fpId}"/><!--接收采购的主键id 与上面相同  -->
								</td>
								<td class="td1"><span class="style1">*</span>招标名称</td>
								<td class="td2">
									<input id="F_fbiddingName" class="easyui-textbox" type="text" required="required" name="fbiddingName" data-options="validType:'length[1,30]'" style="width: 200px" value="${bean.fbiddingName}"/>
								</td>
								
								
								
								
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>招标编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fbiddingCode"  name=fbiddingCode  readonly="readonly" required="required"  data-options="validType:'length[1,50]'"   style="width:200px;" value="${bean.fbiddingCode}"/>
								</td>
								
								<td style="width: 0px">
								<td class="td1"><span class="style1">*</span>开标时间</td>
								<td class="td2">
									<input class="easyui-datebox"  class="dfinput" id="F_fstartTime"  name="fstartTime"required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${bean.fstartTime}"/>
								</td>
								
							</tr>
							
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="fcggl_add" onchange="upladFile(this,'zhaobdj','cggl03')" hidden="hidden">
									<input type="text" id="files" name="addFiles" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<c:if test="${operType=='add'||operType=='edit'}">
									<a onclick="$('#fcggl_add').click()" style="font-weight: bold;" href="#">
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									</c:if>
									<div id="progid" style="background:#EFF5F7;width:300px;height:15px;margin-top:5px;display: none" >
								        <div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
								        </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
						    	    </div>
									<c:forEach items="${attac}" var="att">
										<c:if test="${att.serviceType=='zhaobdj' }">
											<div style="margin-top: 10px;">
											<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<c:if test="${operType=='add'||operType=='edit'}">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
												<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
											</c:if>
											</div>
										</c:if>
									</c:forEach>
								</td>
							</tr>
							<tr></tr>
							<tr></tr>
						</table>
					</div>
													<!--第二个div  -->
								<div title="供应商信息"  id="gysxxdiv"  data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>供应商名称</td>
											<td colspan="4">
												<a href="javascript:void(0)" onclick="checkSel()">
													<input class="easyui-textbox" id="F_fwName"  name="fwName"  readonly="readonly"  style="width:555px;" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkSel()}}]" value="${fwbean.fwName}"/>
												</a>
											</td>
										</tr>										
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>办公地址</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fwAddr"  name="fwAddr" readonly="readonly" required="required" data-options="validType:'length[1,200]'" style="width:555px;" value="${fwbean.fwAddr}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>联系人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fwuserName"  name="fwuserName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwuserName}"/>
											</td>
											<td class="td4"></td>
											<td class="td1"><span class="style1">*</span>联系人电话</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_fwTel"  name="fwTel" readonly="readonly" required="required" data-options="validType:'tel'" style="width: 200px" value="${fwbean.fwTel}"/>
											</td>
										</tr>
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>备注</td>
											<td colspan="4">
												<textarea name="fwRemark"  id="F_fwRemark"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:555px;height:70px;resize:none">${fwbean.fwRemark }</textarea>
												<%-- <input class="easyui-textbox" type="text" id="F_fwRemark"  name="fwRemark" readonly="readonly" data-options="validType:'length[1,200]',multiline:true"   style="width:555px;height:70px;" value="${fwbean.fwRemark}"/>
											 --%>
											</td>
										</tr>
										<c:if test="${operType=='add'||operType=='edit' }">
											<tr>
												<td align="right" colspan="6" style="padding-right: 00px;">
												可输入剩余数：<span id="textareaNum1" class="200">
													<c:if test="${empty fwbean.fwRemark}">200</c:if>
													<c:if test="${!empty fwbean.fwRemark}">${200-fwbean.fwRemark.length()}</c:if>
												</span>
												</td>
											</tr>
										</c:if>
									</table>
								</div>
													<!--第三个div  -->
					<div title="代理人信息"   id="dlrxxdiv" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
					  		<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr>
								<td class="td1"><span class="style1">*</span>代理机构</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_fagentName"  name="fagentName" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fagentName}"/>
								</td>
								
								<td class="td4"></td>
								
								<td class="td1"><span class="style1">*</span>传真</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_fagentFax"  name="fagentFax" required="required" data-options="validType:'fax'" style="width: 200px" value="${bean.fagentFax}"/>
								</td>
							</tr>
							
							
							<tr>
								<td class="td1"><span class="style1">*</span>联系人</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_fagentUser"  name="fagentUser" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${bean.fagentUser}"/>
								</td>
								
								<td style="width: 0px"></td>
								
								<td class="td1"><span class="style1">*</span>联系人电话</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="F_fagentUserTel"  name="fagentUserTel" required="required" data-options="validType:'tel'" style="width: 200px" value="${bean.fagentUserTel}"/>
								</td>
							</tr>
							
							
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>代理机构地址</td>
								<td colspan="4">
									<textarea name="fagentAddr"  id="F_fagentAddr"  class="textbox-text"  oninput="textareaNum(this,'textareaNum2')" autocomplete="off"   style="width:555px;height:70px;resize:none">${bean.fagentAddr}</textarea>
									
									<%-- <input class="easyui-textbox" type="text" id="F_fagentAddr"  name=fagentAddr data-options="validType:'length[1,200]',multiline:true"   style="width:555px;height:70px;" value="${bean.fagentAddr}"/>
								 --%>
								</td>
							</tr>
							<c:if test="${operType=='add'||operType=='edit' }">
								<tr>
									<td align="right" colspan="5" style="padding-right: 0px;">
									可输入剩余数：<span id="textareaNum2" class="200">
										<c:if test="${empty bean.fagentAddr}">200</c:if>
										<c:if test="${!empty bean.fagentAddr}">${200-bean.fagentAddr.length()}</c:if>
									</span>
									</td>
								</tr>
							</c:if>
						</table>												
					</div>
				</div>
			</div>

						
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveTendering()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeSecondWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=采购管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
          //弹出批次详情页面
    		function checkCGCode() {   			
    		    var win = creatFirstWin('采购批次信息', 840, 450, 'icon-search', '/cgprocess/baseinfo');
    			win.window('open');  			
    		}
		//保存
		function saveTendering() {
			//附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s);
			//提交
			$('#tender_form').form('submit', {
				onSubmit : function() {
					flag = $(this).form('enableValidation').form('validate');
					if (flag) {
						$.messager.progress();
					}else{
						//校验不通过，就打开第一个校验失败的手风琴
						openAccordion();
					}
					return flag;
				},
				url : base + "/cgprocess/save?bid="+$('#F_fpCode').val(),
				success : function(data) {
					if (flag) {
						$.messager.progress('close');
					}
					data = eval("(" + data + ")");
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeSecondWindow();
						//$("#tender_form").form("clear");
						 $("#tenderingTab").datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
						closeSecondWindow();
						$('#tender_form').form('clear');
					}
				}
			});	
		}


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
		
</script>
</body>
</html>

