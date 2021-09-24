<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
					<div class="easyui-accordion" data-options="multiple:true" style="width:662px;margin-left: 0px;">
						<div  data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
							<table cellpadding="0" cellspacing="0" class="ourtable">
								<tr class="trbody">
									<td class="td1">归档位置</td>
									<td colspan="4">
										<input class="easyui-textbox"  id="a_fToPosition" name="fToPosition" <c:if test="${archiving.fToPosition!=null}">readonly="readonly"</c:if> required="required" data-options="validType:'length[1,100]',prompt:'请填写具体归档位置'" style="width: 555px" value="${archiving.fToPosition}"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
<script type="text/javascript">

</script>