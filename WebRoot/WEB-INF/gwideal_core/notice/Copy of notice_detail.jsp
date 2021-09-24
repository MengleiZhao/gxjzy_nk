<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links-umeditor.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
  
  <body onload=" contentSet()">
    <div id="main">
		<form id="notice_add_form" action="/nkgl/notice/save"
			method="post" data-options="novalidate:true" class="easyui-form"
			enctype="multipart/form-data">
			<div region="center" border="false"
				style="background: #fff; border-bottom: 1px solid #ccc;position:relative;">
				
				<h2 class="subfild">
            	<span>基本信息</span>
           		</h2>
				<div class="subfild-content base-info">
				
					<input type="hidden" name="noticeId" value="${bean.noticeId}"/>
					
					<div class="kv-item ue-clear">
	                	<label>公告标题<span style="color: red">*</span></label>
	                	<div class="kv-item-content">
	            			<input type="text" id="notice_add_noticeTitle" name="noticeTitle" value="${bean.noticeTitle}"/>
	                    </div>
	                    <span class="kv-item-tip">标题字数限制在15个字符</span>
	                </div>
	                
	                <div class="kv-item ue-clear">
	                	<label>副标题</label>
	                	<div class="kv-item-content">
	            			<input type="text" id="notice_add_noticeSubtitle" name="noticeSubtitle" value="${bean.noticeSubtitle}"></input>
	                    </div>
	                    <span class="kv-item-tip">标题字数限制在30个字符</span>
	                </div>
	                
	                <div class="kv-item ue-clear">
	                	<label>发布人<span style="color: red">*</span></label>
	                	<div class="kv-item-content">
	            			<input type="text" id="notice_add_releaseUser" name="releaseUser" value="${bean.releaseUser}" readonly="readonly"></input>
	                    </div>
	                </div>
	                
	                <div class="kv-item ue-clear time" id="releaseTi">
	                	<label>发布时间<span style="color: red">*</span></label>
	                	<div class="kv-item-content">
	            			<input type="text" id="notice_add_releaseTime" name="releaseTime" value="${bean.releaseTime}" readonly="readonly"></input>
	                        <i class="time-icon"></i>
	                    </div>
	                </div>
              
	                <div class="kv-item ue-clear">
	                	<label>是否置顶<span style="color: red">*</span></label>
	                	<!--<input id="notice_add_noticeNum" name="noticeNum" value="${bean.num}"></input>-->
	                	<div class="kv-item-content">
	                    	<span class="choose">
	                            <span class="checkboxouter">
	                                <input type="radio" value="1" name="stick1" />
	                                <span class="radio" ></span>
	                            </span>
	                            <span class="text">是</span>
	                        </span>
	                    	<span class="choose">
	                            <span class="checkboxouter">
	                                <input type="radio" value="2" name="stick1" checked="checked"/>
	                                <span class="radio"></span>
	                            </span>
	                            <span class="text">否</span>
	                        </span>
	                        
	                    </div>
	                    <input type="hidden" id="stickNotice" name="stick"/>
	                    <input type="hidden" name="noticeNum" value="${bean.noticeNum}"/>
	                </div>
                
                
	                <!-- <div class="kv-item ue-clear">
	                	<label>附件</label>
	                	<div>
	                		<input type="hidden" id="noticeFile" name="noticeFile"/>
	            			<input name="noticeFi" type="file" id="noticeFi"/>
	                    </div>
	                </div> -->
	                
	                 <div class="kv-item ue-clear" id="att" style="display: none;">
	                	<label>已上传附件</label>
	                	<label style="color: blue;" id="attacName">${attac.noticeAttacName}</label>
	                	<label><a>删除</a></label>
	                </div>
	                
	                
	                <div class="subfild-content remarkes-info">
            			<div class="kv-item ue-clear">
                			<label>公告内容</label>
                				<div class="kv-item-content">
									<textarea id="content" style="width:800px;height:240px;"></textarea>
									<textarea id="contentString" style="display:none;" name="contentString">${bean.content}</textarea>	
								</div>
                		</div>
            		</div>
				
				</div>

			</div>
			
			
		</form>
	</div>
	
<script type="text/javascript"> 
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
