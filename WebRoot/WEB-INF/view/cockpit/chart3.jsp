<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table>
	<tr>
		<td colspan="2" style="text-align: left;"><span style="font-weight: bold; font-size: 18px; color: #666666;">各部门差旅费支出情况</span></td>
	</tr>
</table>
<div style="height: 15px;"></div>
<table style="height: 300px; width:100%; color: #666666; border: #d8e2e6 solid 1px; padding: 0; margin: 0" >
	

	<tr style="background-color: #bfe2f2; font-weight: bold; font-size: 12px;">
		<td style="text-align: center; border-right: #d8e2e6 solid 1px; width:40%">
			部门名称
		</td>
		<td style="text-align: center;  width:40%">
			支出金额（元）
		</td>
		
	</tr>

	<c:forEach items="${departTravels }" var="data" varStatus="vs">
		
		<tr style="<c:if test="${vs.index%2!=0 }">background-color: #eff5f7;</c:if>font-size: 12px;">
			<td style="text-align: center; border-right: #d8e2e6 solid 1px;">
				${data[0]} 
			</td>
			<td style="text-align: center;">
				${data[1] }
			</td>
			
		</tr>
	</c:forEach>
</table>

