<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<table class="ourtable">  	<!-- 表单样式参考 -->
			<tr class="trbody">
			<td class="td1">
				&nbsp;&nbsp;合同文本
				<!-- <input type="file" multiple="multiple" id="f" onchange="upFile()" hidden="hidden">
				<input type="text" id="files1" name="files1" hidden="hidden"> -->
			</td>
			<td colspan="4" id="tdf1">
				<%-- <c:if test="${filingattac==null}">
					<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
						<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</c:if> --%>
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
				<%-- <c:if test="${filinOthergattac==null}">
					<a onclick="$('#f1').click()" style="font-weight: bold;" href="#">
						<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</c:if> --%>
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
var c1 =0;
function upFile1() {
	/* console.log(document.getElementById("a_fFileSrc1"));
	var src = getFilePath();
	alert(getFilePath()); */
	c1 ++;
	var src = $('#a_fFileSrc1').val();
	var srcs =src+','+$('#fi1').val();
	$('#fi1').val(srcs);
	$('#f_a_f1').append("<div id='c1"+c1+"'><a href='#' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c1"+c1+")'>删除</a></div>");
} 
function deleteF1(val){
	var child=document.getElementById(val.id);
	child.parentNode.removeChild(child);
}
var v =0;
function upFile() {
	v ++;
	var src = $('#a_fFileSrc').val();
	$('#fi').val(src);
	$('#f_a_f').append("<div id='v"+v+"'><a href='#' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF(v"+v+")'>删除</a></div>");
} 

function deleteF(val){
	var child=document.getElementById(val.id);
	child.parentNode.removeChild(child);
}

function getFilePath(){  
    var input = document.getElementById("a_fFileSrc1");
	if(input){//input是<input type="file">Dom对象  
        if(window.navigator.userAgent.indexOf("MSIE")>=1){  //如果是IE    
            input.select();      
          return document.selection.createRange().text;      
        }      
        else if(window.navigator.userAgent.indexOf("Firefox")>=1){  //如果是火狐  {      
            if(input.files){      
                return input.files.item(0).getAsDataURL();      
            }      
            return input.value;      
        }      
        return input.value;   
    }  
}  
</script>
