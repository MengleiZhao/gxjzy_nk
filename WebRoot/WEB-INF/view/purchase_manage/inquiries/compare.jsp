<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
  <body>
	<style type="text/css">
/* 	.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
	.textbox-readonly{background-color: #f6f6f6;color: #999999} */
	.textbox-text{color:#666666;height: 25px; line-height: 25px}
	.style1{color: red;height: 40px;}
	.numberbox .textbox-text {text-align: left;}
	.tabDiv{padding:10px;}
	.ourtable{font-size: 12px;width: 100%;color: #666666;font-family: "微软雅黑";text-align: center;}
	.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
	.td1{height: 30px;width: 100px;background-color: #cce2ed}
	.td2{height: 30px;width: 150px;}
	.trtop{height: 10px;}
	.trbody{height: 30px;}
	table tr:nth-child(2n){background-color: #edf6fa} 
	</style>

	<div class="easyui-layout" style="overflow-x:scroll;" fit="true">
		<form id="compare_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
						<!--  左侧div基本信息-->
			<div data-options="region:'west',split:true" style="width='100%';border-color: #dce5e9;" id="westDiv">
				<table  class="ourtable"   width="100%" >					
					<tr>
						<td>
							<div class="easyui-accordion" data-options="" id="easyAcc"  width="100%">
								<!-- 第一个div -->
								<div title="公司/物品/报价（元）" data-options="iconCls:'icon-xxlb'" style="overflow:auto;">
									
									<table id="tb" cellpadding="0" cellspacing="0"   width="100%"  class="ourtable" border="1" >
										<!--循环数据   获得供应商个数  -->
										<tr>
											<th width="10%">物品名称</th>
											<th width="10%">品牌|规格</th>
											<th width="10%">数量</th>
											<c:forEach items="${sel}" var="li">
												<th >${li.selName}</th>
											</c:forEach>
										</tr>

										<!--循环数据   获得品目信息 -->
										<c:forEach items="${qdList}" var="qd" varStatus="count1">
												<tr>
													<td class="td2">${qd.fpurName}</td>
													<td class="td2">${qd.fpurBrand}|${qd.fspecifModel}</td>
													<td class="td2">${qd.fnum}</td>
													<c:forEach items="${sel}" var="li">
														<c:forEach items="${li.inqList}" var="ti">
														<c:if test="${ti.fplId==qd.mainId}">
															<td id="id_${ti.finqId}" class="td2">
																<table cellpadding="0" cellspacing="0"  width="100%"  border="1">
																	<tr>
																		<td class="td1" width="30%">单价</td>
																		<td class="td2"  width="70%">${ti.ffactoryPrice}</td>
																	</tr>
																	<tr>
																		<td class="td1">合议价</td>
																		<td class="td2">${ti.ffactoryPrice-ti.fdiscountPrice}</td>
																	</tr>
																	<tr>
																		<td class="td1">是否进口</td>
																		<td class="td2">${ti.fisImpe}</td>
																	</tr>
																	<tr>
																		<td class="td1">生产商</td>
																		<td class="td2">${ti.fproVendor}</td>
																	</tr>
																	<tr>
																		<td class="td1">生产地区</td>
																		<td class="td2">${ti.fproArea}</td>
																	</tr>
																	<tr>
																		<td class="td1">产品型号</td>
																		<td class="td2">${ti.fproVerdsion}</td>
																	</tr>
																</table>
															</td>
														</c:if>
														</c:forEach>
													</c:forEach>
												</tr>
											</c:forEach>
										<!--循环数据   获得供应商个数  -->
										<tr>
											<th class="td1" colspan="3">总价</th>
											<c:forEach items="${sel}" var="li">
												<th class="td1">${li.totalPrice}</th>
											</c:forEach>
										</tr>
										
										
									</table>
								</div>

							</div>
						</td>
				</tr>
		</table>
		<div style="width:900px;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 10px">
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
	</div>
			
		</form>


</div>
</body>
<script type="text/javascript">
//显示详情tab
</script>
</html>

