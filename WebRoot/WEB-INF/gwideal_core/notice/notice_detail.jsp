<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links-umeditor.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
  
  <body onload=" contentSet()">
  	<div class="easyui-layout" fit="true" style="color: #333333">
  		<div data-options="region:'center',spilt:true" 
				style="text-align: center; height: 500px;" >
				<table style="width:90%; margin: 0 auto; margin-top: 20px;" >
		    		<tr>
		    			<td style="text-align: center; font-size: 22px;">
		    				${bean.noticeTitle}
		    			</td>
		    		</tr>
		    		<tr>
		    			<td style="text-align: center; padding-top: 20px; color: gray;">
		    				发布时间：
		    				${fn:substring(bean.releaseTime,0,16)}
		    			</td>
		    		</tr>
		    		<tr>
		    			<td style="text-align: right;">
		    				<a href="#" onclick="tgdy()">
		    					<img src="${base}/resource-modality/${themenurl}/print.png"/>
		    				</a>
		    			</td>
		    		</tr>
		   		</table>
		   		<table style="border-top:solid 1px black;border-collapse: collapse; width:90%; margin: 0 auto;">
		    		<tr>
		    			<td style="">
		    				${bean.content}
		    			</td>
		    		</tr>
		    		<tr>
		    			<td style="padding-top: 30px; text-align: left;">
		    				附件：
		    				<c:forEach items="${attac}" var="attac">
						<c:if test="${attac.serviceType=='tzgg' }">
							<div style="margin-top: 10px;">
							<a href='${base}/attachment/download/${attac.id}' style="color: #666666;font-weight: bold;">${attac.originalName}</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							
							</div>
						</c:if>
					</c:forEach>
		    			</td>
		    		</tr>
		    	</table>
		</div>
  		<div data-options="region:'south',spilt:true" 
				style="text-align: center;" align="center" >
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
						onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi2.png')"
						onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi1.png')"
					/>
				</a>
		</div>
  	</div>
  	
	
	
	
<script type="text/javascript"> 
function viewFj(id){
	window.open('');
	/* $.ajax({ 
		url: base+"/systemcentergl/attacFind?id="+id, 
		success: function(data){
			data=data.replace('\"','');
			data=data.replace('\"','');
			window.open(data);
    }}); */
}
function tgdy(){
	window.print();
}
//时间格式化
function ChangeDateFormat() {
    var t, y, m, d, h, i, s;
    t = new Date();
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}

//显示富文本编辑器
UM.getEditor('content');

//附件地址显示
function getFilePath(){  
    var input = document.getElementById("noticeFi");
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


//提交
function saveNotice(){
	
	//传入带格式文本
	var arr = [];
    arr.push(UM.getEditor('content').getContent());
    var contentString = arr.join("\n");
   	$("#contentString").val(contentString);

	//判断
	var flag = true;
	var $title=$.trim($("#notice_add_noticeTitle").val());
	if($title=="") 
	{
		 alert("请输入公告标题！");
		 flag = false;
	}
	/*
	var r = /^\+?[1-9][0-9]*$/;  //判断是否为正整数 
    if(!r.test($('#notice_add_noticeNum').val()) && flag == true){
    	alert("排序号请输入正整数！");
    	flag = false;
    } 
	
	var $content=$.trim($("#contentString").val());
	if($content=="" && flag == true) 
	{
		 alert("请输入公共内容！");
		 flag = false;
	}
	*/

	//传入附件地址
	var noticeFi = getFilePath();
	$("#noticeFile").val(noticeFi);
	
	//获得是否置顶的值
	var ch = $('input:radio:checked').val();
	$("#stickNotice").val(ch);
	
   	//提交
	if(flag){
		$('#notice_add_form').submit();	
	}
}

//AJAX
$('#notice_add_form').form({
    url:'/nkgl/notice/save',
    onSubmit: function(){
		// do some check
		// return false to prevent submit;
    },
    success:function(data){
			alert("c");
    	alert(date.info);
			window.close();
    }
});

function contentSet(){
	var content = $("#contentString").val();
	UM.getEditor('content').ready(function() {
		//设置编辑器的内容
		content =$('#contentString').val();
		UM.getEditor('content').setContent(content, false);
	});
	
	//显示已有附件
	if($("#attacName").text().length != 0) {
		$("#att").css("display","");
		$("#noticeFi").attr("disabled",true);
	}
	
	//显示时间
	if($("#notice_add_releaseTime").val().length == 0) {
		$("#releaseTi").css("display","none");	
	}
}

</script>

  </body>
</html>
