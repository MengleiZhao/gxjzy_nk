<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<table cellpadding="0" cellspacing="0" class="ourtable"> 	<!-- 表单样式参考 -->
		<tr class="trbody">
			<td class="td1">
				&nbsp;&nbsp;合同文本
				<input type="file" multiple="multiple" id="f" onchange="upFile()" hidden="hidden">
				<input type="text" id="files1" name="files1" hidden="hidden">
			</td>
			<td colspan="4" id="tdf1">
				<c:if test="${openType=='edit'}">
					<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
						<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</c:if>
				<c:forEach items="${filingattac}" var="att">
					<div style="margin-top: 10px;">
						<a href='#' style="color: #666666;font-weight: bold;">${att.fAttacName}</a>
						<c:if test="${filingattac==null}">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="${base}/resource-modality/${themenurl}/sccg.png">
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a id="${att.fAttacName}" class="fileUrl1" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
						</c:if>
					</div>
				</c:forEach>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1">
				&nbsp;&nbsp;其他附件
				<input type="file" multiple="multiple" id="f1" onchange="upFile1()" hidden="hidden">
				<input type="text" id="files2" name="files2" hidden="hidden">
			</td>
			<td colspan="4" id="tdf2">
					<c:if test="${openType=='edit'}">
					<a onclick="$('#f1').click()" style="font-weight: bold;" href="#">
						<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</c:if>
				<c:forEach items="${filinOthergattac}" var="otheratt">
					<div style="margin-top: 10px;">
						<a href='#' style="color: #666666;font-weight: bold;">${otheratt.fAttacName}</a>
						<c:if test="${filinOthergattac==null}">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="${base}/resource-modality/${themenurl}/sccg.png">
							&nbsp;&nbsp;&nbsp;&nbsp;
						<a id="${otheratt.fAttacName}" class="fileUrl2" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
						</c:if>
					</div>
				</c:forEach>
			</td>
		</tr>
	</table>
<script type="text/javascript">
var c=0;
//附件上传
function upFile() {
	var url = $("#f").val();
	var urlli = url.split(',');
	for(var i=0; i< urlli.length; i++){
		var filingfileurl=urlli[i];
		var filename = filingfileurl.split('\\');
		$('#tdf1').append(
			"<div style='margin-top: 10px;'>"+
				"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<img id='imgt"+c+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
				"<img id='imgf"+c+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+filingfileurl+"' class='fileUrl1' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
		);
		c++;
		filingfileurl = encodeURI(encodeURI(filingfileurl));
		$.ajax({
			async:false,
			type:"POST",
	        url:base+"/Filing/filingFile?filingfileurl="+filingfileurl,
	        success:function(data){
		    	if($.trim(data)=="true"){
					$('#imgt'+i).css('display','');
		    	} else {
					$('#imgf'+i).css('display','');
		    	}
	        }
	    });
	}	
} 


//附件删除AJAX
function deleteAttac(a){
	var filename1 = a.id;
	filename1 = encodeURI(encodeURI(filename1));  
	$.ajax({
		type:"POST",
        url:base+"/Filing/filingFileDelete?filename1="+filename1,
        success:function(data){
        	if($.trim(data)=="true"){
				//删除div
	        	$(a).parent().remove();
        		alert("附件删除成功！");
        	} else {
        		alert("附件删除失败！");
        	}
        }
    });
}

var c1=0;
//附件上传
function upFile1() {
	var url = $("#f1").val();
	var urlli = url.split(',');
	for(var i=0; i< urlli.length; i++){
		var filingfileurl=urlli[i];
		var filename = filingfileurl.split('\\');
		$('#tdf2').append(
			"<div style='margin-top: 10px;'>"+
				"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<img id='imgt1"+c1+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
				"<img id='imgf1"+c1+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+filingfileurl+"' class='fileUrl2' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
		);
		c1++;
		filingfileurl = encodeURI(encodeURI(filingfileurl));
		$.ajax({
			async:false,
			type:"POST",
	        url:base+"/Filing/filingFile?filingfileurl="+filingfileurl,
	        success:function(data){
		    	if($.trim(data)=="true"){
					$('#imgt1'+i).css('display','');
		    	} else {
					$('#imgf1'+i).css('display','');
		    	}
	        }
	    });
	}	
} 

</script>
