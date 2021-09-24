<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>

<script type="text/javascript">
	window.onload = function (){
		//PDFObject.embed(base+"/resource-modality/img/pdf.pdf","#test1313");
		//PDFObject.embed("D://test/hellowpdf.pdf");
	};
</script>

<body>
	<div style="height:300px; width:300px;" id="test1313" >
	</div>
	
		<!-- 1、pdf.pdf -->
		<embed src="${base}/resource-modality/img/pdf.pdf" width="300px" height="300px" />
		<%-- 
		
			--%>
			
		<!-- 2、object -->
		<object data="${base}/resource-modality/img/pdf.pdf" type="application/pdf" width="300" height="200">
			<a href="${base}/resource-modality/img/pdf.pdf">test.pdf</a>
			</object> 
		
		<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/zhanchun2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/zhanchun1.png')"
							onclick="openPdf()"
						/>
		
		<!-- 3、href -->			
		<a href="${base}/resource-modality/${themenurl}/button/zhanchun1.png">测试图片</a>
		<a href="${base}/resource-modality/img/pdf.pdf" target="blank">测试pdf</a>
		
		<!-- 4、loadfile -->
		44444
		<object id="pdf1" width="500" height="400" classid="clsid:CA8A9780-280D-11CF-A24D-444553540000">
			<param name="src" value="pdf.pdf">
		</object>
</body>


<script type="text/javascript">
/* var pdff = document.getElementById('pdf1');
pdff.LoadFile(base+"/resource-modality/img/pdf.pdf"); */
//pdf1.SetShowToolbar (false);

	function openPdf(){
		//window.location.href=base+'/resource-modality/img/button/zhanchun2.png';
		window.location.href=base+'/resource-modality/img/pdf.pdf';
	}
</script>

