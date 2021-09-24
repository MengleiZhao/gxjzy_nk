<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="inquiries_detail_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
							<!-- 第一个div -->
								<div title="供应商信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr>
										<td class="td1"><span class="style1">*</span>供应商名称</td>
											<td colspan="4">
													<input class="easyui-textbox" id="F_fwName"  name="fwName"  readonly="readonly"  style="width:555px;" value="${fwbean.fwName}"/>
														<!-- 隐藏域 --> 
													<input type="hidden" name="fmainid" id="F_fmianid" value="${mainid}"/>
													<input type="hidden" name="fwId" id="F_fwId" value="${fwbean.fwId}"/>
											</td>
											
											<td style="width: 0px"></td>

										</tr>
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>办公地址</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fwAddr"  name="fwAddr" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width:555px;height:30px;" value="${fwbean.fwAddr}"/>
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
													<input class="easyui-textbox" type="text" id="F_fwTel"  name="fwTel" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwTel}"/>
											</td>
										</tr>
										
										
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>备注</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_fwRemark"  name="fwRemark" readonly="readonly" data-options="validType:'length[1,50]'"   style="width:555px;height:70px;" value="${fwbean.fwRemark}"/>
											</td>
										</tr>
									</table>
								</div>
								
										<!-- 第2个div -->
								<div title="采购清单" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
 							  		<jsp:include page="qingdan_info.jsp" />												
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
	
	//报价单信息    设置列固定  左右滚动
	$('#dg').datagrid({
         frozenColumns: [[
                   			  { field: 'finqId', title: '主ID', width: 100,hidden:true },
                       	 	  { field: 'pmainId', title: '外键ID', width: 100 ,hidden:true},
                       	  	  { field: 'fplId', title: '采购清单id', width: 100 ,hidden:true},
                       	  	  {field:'fpurName',title:'采购品牌',width:100}
                       	 	 
       					 ]],
       					columns:[[
       					        {field:'fpurBrand',title:'采购品牌',width:100},
 						        {field:'fspecifModel',title:'规格型号',width:100},
 						        {field:'fnum',title:'采购数量',width:100},
								{ field: 'fproVendor', title: '生厂商名称', width: 130, editor:'textbox' },
       					        {field:'fproArea',title:'商品产地',width:130, editor:'textbox'},
       					       /*  {field:'fproVerdsion',title:'商品型号',width:100, editor:'textbox'},
       					        {field:'fproAmount',title:'商品数量',width:100,editor:'numberbox'}, */
       					        {field:'ffactoryPrice',title:'额定价格',width:100,editor:'numberbox'},
       					        {field:'fdiscountPrice',title:'优惠幅度',width:100,editor:'numberbox'},
       					        {field:'ffinalPrice',title:'优惠后总价',width:100,editor:'numberbox'},
       					        {field:'fisImpe',title:'是否进口',width:100,editor:'textbox'}
       					    ]]

});
	</script>
</body>