<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="knot_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 709px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
					  <table cellpadding="0" cellspacing="0" class="ourtable" border="0" style="margin-top: 10px;">
							<tr class="trbody">
						   		<td class="td1-ys" style="padding-top: 10px"><span class="style_must">*</span>申报部门</td>
						     	<td class="td2" colspan="4">
							     	<input type="hidden" id="knot_add_FProBudgetAmount" name="FProBudgetAmount" value="${bean.FProBudgetAmount }"/>
							     	<input type="hidden" id="knot_add_fkId" name="fkId" value="${bean.fkId }"/>
							     	<input type="hidden" id="knot_add_FProId" name="FProId" value="${bean.FProId }"/>
							     	<input type="hidden" id="knot_add_flowStauts" name="flowStauts"/>
						     		<input id="knot_add_freqDept" name="freqDept" class="easyui-textbox" style="height:30px;width:540px"
						     		data-options="required:true,validType:'length[1,100]'" readonly="readonly"  prompt="请输入申报部门" value="${bean.freqDept }">
						     	</td>
						   	</tr>
							<tr class="trbody">
						   		<td class="td1-ys"><span class="style_must">*</span>项目名称</td>
						     	<td class="td2" colspan="4">
						     		<input id="knot_add_FProName" name="FProName" class="easyui-textbox" style="height:30px;width:540px"
						     		data-options="required:true,validType:'length[1,100]'" readonly="readonly"   value="${bean.FProName }">
						     	</td>
						   	</tr>
						   	
						   	<tr>
								<td class="td1"><span class="style1">*</span>项目开始时间</td>
								<td class="td2">
									<input class="easyui-datebox"   class="dfinput"  id="knot_add_proBeginTime"  name="proBeginTime" editable="false" required="required" data-options="validType:'length[1,20]'" style="width: 190px;" value="${bean.proBeginTime}"/>
								</td>
								
								<td style="width: 0px"></td>
								
								<td class="td1"><span class="style1">*</span>项目结束时间</td>
								<td class="td2">
									<input class="easyui-datebox"   class="dfinput"  id="knot_add_proEndTime"  name="proEndTime" editable="false" required="required" data-options="validType:'length[1,20]'" style="width: 185px;" value="${bean.proEndTime}"/>
								</td>
							</tr>
							
						   	
							<tr>
								<td class="td1"><span class="style1">*</span>申请日期</td>
								<td class="td2">
						     		<input class="easyui-datebox" type="text" id="knot_add_freqTime"  readonly="readonly"  name="freqTime" required="required"  style="width: 190px" value="${bean.freqTime}"/>
						     	</td>
								
								<td class="td4"></td>
								
								<td class="td1"><span class="style1">*</span>申报人</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="knot_add_freqUserName" readonly="readonly"   name="freqUserName" required="required"  style="width: 185px" value="${bean.freqUserName}"/>
								</td>
							</tr>
							
							<tr>
								<td class="td1"><span class="style1">*</span>项目实际支出金额</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="knot_add_FProOutAmount" readonly="readonly"   name="FProOutAmount" required="required" data-options="validType:'length[1,10]',iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" style="width: 190px" value="${bean.FProOutAmount}"/>
								</td>
								
								<td class="td4"></td>
								
								<td class="td1"><span class="style1">*</span>总预算完成率</td>
								<td class="td2">
										<input class="easyui-textbox" type="text" id="knot_add_FProEfficiency" readonly="readonly"  name="FProEfficiency" required="required"  style="width: 185px" value="${bean.FProEfficiency}%"/>
								</td>
							</tr>
							
							<tr>
								<td class="td1"><span class="style1">*</span>项目性质</td>
								<td class="td2">
						     		<input id="project_add_firstLevelCode" name="firstLevelCode" readonly="readonly" class="easyui-combobox" style="height:30px;width: 190px"
						     		data-options="url:'${base}/project/getSubject1?selected=${bean.firstLevelCode}',method:'get',valueField:'code',textField:'text',editable:false,validType:'selectValid'"/>
						     	</td>
								
								<td class="td4"></td>
								
								<c:if test="${djAmount !=0}">
									<td class="td1">冻结金额</td>
									<td class="td2">
										<input class="easyui-textbox" type="text" readonly="readonly" id="knot_add_djAmount" data-options="validType:'length[1,10]',iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" name="djAmount"  style="width: 185px" value="${djAmount}"/>
									</td>
								</c:if>
								<c:if test="${djAmount ==0} ">
									<td class="td1">11</td>
									<td class="td2">
										<input class="easyui-textbox"  type="text" id="knot_add_djAmount" data-options="validType:'length[1,10]',iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"   style="width: 190px" value="0"/>
									</td>
								</c:if>
								
							</tr>
							<tr class="trbody">
						    	<td class="td1-ys" colspan="6">
						    		<jsp:include page="detail/project-detail-fundssource.jsp" />
								</td>
						    </tr>
							<%-- <tr class="trbody">
						    	<td class="td1-ys" colspan="6">
						    		<jsp:include page="zhichu_detail.jsp" />
								</td>
						    </tr> --%>
							<tr style="height: 50px;">
								<td >
								</td>
							</tr>
							<tr style="height: 120px;">
								<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>项目验收结论</td>
								<td colspan="4">
									<%-- <input class="easyui-textbox" type="text" id="knot_FProMemo"  name=FProMemo data-options="validType:'length[1,200]',multiline:true"   style="width:540px;height:120px;" value="${bean.FProMemo}"/> --%>
									<textarea name="FProMemo"  id="knot_FProMemo"  class="textbox-text" oninput="textareaNum(this,'textareaNum1')" autocomplete="off"  style="width:540px;height:120px">${bean.FProMemo }</textarea>
								</td>
							</tr>
							<c:if test="${operType=='add'||operType=='edit' }">
								<tr>
									<td align="right" colspan="5" style="padding-right: 13px;">
									可输入剩余数：<span id="textareaNum1" class="1000">
										<c:if test="${empty bean.FProMemo}">1000</c:if>
										<c:if test="${!empty bean.FProMemo}">${1000-bean.FProMemo.length()}</c:if>
									</span>
									</td>
								</tr>
							</c:if>
							
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'jxsq','ysgl10')" hidden="hidden">
									<input type="text" id="files" name="files" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
										<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
								        <div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
								        </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
						    	    </div>
									<c:forEach items="${attac}" var="att">
										<div style="margin-top: 10px;">
											<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
									</c:forEach>
								</td>
							</tr>
						</table>												
				</div>
			</div>
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveKnot(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveKnot(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> 
			
	</div>
</form>
</div>
	<script type="text/javascript">	
	
	$("#knot_add_proBeginTime").datebox({
	    onSelect : function(beginDate){
	        $('#knot_add_proEndTime').datebox().datebox('calendar').calendar({
	            validator: function(date){
	                return beginDate <= date;
	            }
	        });
	    }
	});
		//保存
		function saveKnot(flowStauts) {
			//冻结金额
			var djAmount=$("#knot_add_djAmount").val();
			//支出金额
			var outAmount=$("#knot_add_FProOutAmount").val();
			if(outAmount==0){
				alert("该项目资金还没使用，无法结项");
				return false;
			}
			if(djAmount!=undefined && djAmount !=0){
				alert("该项目资金还有报销在审核中，无法结项");
				return false;
			}
			//附件的路径地址
			var s="";
			$(".fileUrl").each(function(){
				s=s+$(this).attr("id")+",";
			});
			$("#files").val(s);
			//设置审批状态
			$('#knot_add_flowStauts').val(flowStauts);
			//提交
			$('#knot_form').form('submit', {
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
				url : base + '/projectknot/save',
				success : function(data) {
					if (flag) {
						$.messager.progress('close');
					}
					data = eval("(" + data + ")");
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						//$("#tender_form").form("clear");
						 $('#pro_dg_5').datagrid("reload");
							$('#indexdb').datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
					}
				}
			});	
		}

	</script>
</body>

