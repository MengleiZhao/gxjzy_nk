<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
  <body>

	<div class="easyui-layout" fit="true">
		<form id="self_eval_temp_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
			<div title="筛选规则配置" data-options="iconCls:'icon-xxlb'"
				style="overflow:auto;margin-top: 10px;height: 250px;">
				<!--规则的table  -->
				<table cellpadding="0" cellspacing="0" class="top-table" border="0">
					<tr class="trbody">
						<td style="width: auto;height: 100px">
							<span class="style1">*</span>登录风格</td>
						<td style="width: auto;height: 100px">
							<input class="easyui-datebox" class="dfinput" id="F_fevalDateStart" name="fevalDateStart" style="width: 150px;" /></td>
						<td style="width: auto;height: 100px">
							<input class="easyui-datebox" class="dfinput" id="F_fevalDateEnd" name="fevalDateEnd" style="width: 150px;"/></td>
					</tr>
					<tr class="trbody">
						<td style="width: auto;height: 100px">
							<span class="style1">*</span>背景图片</td>
						<td style="width: auto;height: 100px">
							<input class="easyui-datebox" class="dfinput" id="F_fevalDateStart1" name="fevalDateStart1" style="width: 150px;"/></td>
						<td style="width: auto;height: 100px">
							<input class="easyui-datebox" class="dfinput" id="F_fevalDateEnd1" name="fevalDateEnd1" style="width: 150px;"/></td>
					</tr>
				</table>
			</div>

			<div data-options="region:'south'"  style="height: 51px;width: 100%; border: 0px;">
				<div style="width:796px;height: 50px;text-align: center;float: left;">
					<a href="javascript:void(0)" onclick="finalSaveEval()">
					 	<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
<script type="text/javascript">
//显示详情tab
</script>
</html>

