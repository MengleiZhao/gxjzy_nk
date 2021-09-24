<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>

<div class="easyui-layout" style="width:100%;height:100%; 
  	background: linear-gradient(to bottom,#2B9FFF 0,#cbf1ff 40%,#D3F5FF 50%,#cbf1ff 60%,#51B3FF 100%);">
  	
  	<div data-options="region:'center'" >
  		<table style="width:60%; height:100%; margin: 0 auto; ">
	  		<tr>
	  		
	  		<c:forEach items="${attList }" var="att" varStatus="vs">
	  			<c:if test="${vs.index%5==0 && vs.index!=0 }"></tr><tr></c:if>
	  			<td style="margin: 15px; ">
	  				<div style=" height:210px; width:210px;
	  					text-align: center; vertical-align: center; cursor: pointer;
	  					background-image:url(${base}/resource-modality/img/bg-book.png);  
						background-size:100% 100%;
						background-position: center center;"
						
						onclick="openPDF('${att.id}')"
						>
						<br><br><br><br>
		  				<span style="font-size: 20px; color: orange; font-weight: bold; margin: 0 auto;">${fn:substring(att.originalName,0,att.originalName.indexOf('.pdf')) }</span> 
	  				</div>
	  			</td>
	  		</c:forEach>
	  			
	  		</tr>		
  		</table>
  	
  	</div>
  	
  	
 </div>		


	<script type="text/javascript">
	
	function openPDF(attId){
		window.open(base+'/systemcentergl/viewPDF/'+attId,'open');
	}
	
	function addCheter() {
		var win = creatWin('新增-制度文件', 740, 450, 'icon-search', '/systemcentergl/add');
		win.window('open');
	}
	</script>
</body>
</html>

