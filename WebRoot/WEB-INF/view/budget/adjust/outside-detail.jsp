<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

  
<body>
<div class="win-div">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:662px;margin-left: 20px">
					<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1">操作人</td>

								<td class="td2"><input style="width: 200px;" id=""
									name="opUser" class="easyui-textbox"
									value="${bean.opUser}" readonly="readonly"></input>
								</td>
								
								<td class="td4">
									<!-- 隐藏域 -->
									<input type="hidden" name="aId" value="${bean.aId}" />
									<input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="outsideFlowStauts"/>
									<input type="hidden" name="stauts" value="${bean.stauts}" id="outsideStauts"/>
									<input type="hidden" name="accountStauts" value="${bean.accountStauts}" />
									<input type="hidden" name="userName" value="${bean.fuserName}" />
									<input type="hidden" name="userId" value="${bean.fuserId}" />
									<input type="hidden" name="nCode" value="${bean.nCode}" />
									<input type="hidden" name="deptCode" value="${bean.deptCode}" />
								</td>

								<td class="td1">调整时间</td>
								<td class="td2"><input style="width: 200px;"
									id="outsideOpTime" name="opTime" class="easyui-datebox"
									value="${bean.opTime}" readonly="readonly"></input>
								</td>
							</tr>


							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">调整说明</p></td>
								<td colspan="4">
									<input class="easyui-textbox" data-options="multiline:true" name="exteDesc" style="width:555px;height:70px" value="${bean.exteDesc}" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
					
					
					<div title="指标调整" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="outside/zbtz.jsp"/>
					</div>

				</div>
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</div>	
</body>

