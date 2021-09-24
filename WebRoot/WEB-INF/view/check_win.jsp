<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div style="height: 376px;width: 496px;">
	<div style="width: 496px;height: 310px">
		<div style="width: 456px;height: 290px;margin-left: 20px;overflow:auto">
			<table cellpadding="0" cellspacing="0" style="width: 456px">
				<tr style="height: 40px">
					<td>审批人</td>
					<td>
						${checkWinUserName}
					</td>
				</tr>
				<tr style="height: 40px">
					<td>审批结果</td>
					<td>
						<c:if test="${checkWinResult==1||checkWinResult==2}"><span style="color: green;font-weight: bold;">通过</span></c:if>
						<c:if test="${checkWinResult==0}"><span style="color: red;font-weight: bold;">不通过</span></c:if>
					</td>
				</tr>
				<tr style="height: 40px">
					<td>审批时间</td>
					<td>
						${checkWinTime}
					</td>
				</tr>
				<tr>
					<td>审批意见</td>
					<td>
						<c:if test="${checkWinResult==1||checkWinResult==2}"><input class="easyui-textbox" data-options="multiline:true,required:false,validType:'length[0,500]'" id="checkWinRemake" style="width:350px;height:70px;" value="同意"></c:if>
						<c:if test="${checkWinResult==0}"><input class="easyui-textbox" data-options="multiline:true,required:false,validType:'length[0,500]'" id="checkWinRemake" style="width:350px;height:70px;" value="不同意"></c:if>
					</td>
				</tr>
				<tr style="height: 40px;">
					<td>是否上传附件</td>
					<td><input id="filecheck" onclick="changefile()" type="checkbox" value="0" ></td>
				</tr>
				<tr hidden="hidden" id ="checkid">
					<td>
						&nbsp;&nbsp;
						<input type="file" id="fspjl" multiple="multiple" onchange="check_File(this,'spjl','spjl01')" hidden="hidden">
						<input type="text" id="spjlFiles" name="spjlFiles" hidden="hidden" >
					</td>
					<td colspan="4" id="tdspjl">
						<a onclick="$('#fspjl').click()" style="margin-left:4px;font-weight: bold;" href="#">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
						</a>
						<c:forEach items="${CheckAttaList}" var="att">
							<c:if test="${att.serviceType=='spjl' }">
								<div style="margin-top: 10px;">
								<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
								&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
								</div>
							</c:if>
						</c:forEach>
						<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
							<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
						 	</div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div style="width: 496px;height: 66px;line-height: 66px;text-align: center;">
		<a href="javascript:void(0)" onclick="saveCheckResult(${checkWinResult})">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeCheckWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</div>
<script type="text/javascript">
function saveCheckResult(result) {//result通过为1、不通过为0
	var filesValue = $('#spjlFiles').val();
	if($("#p").find("textarea").hasClass("validatebox-invalid")==true){
		alert('请按要求填写审批意见');
	}else if(filesValue==null){
		alert('请上传文件');
	}else{
		if(!confirm("是否确认提交")) {
			return;
		}
		var remake = $('#checkWinRemake').textbox('getValue');
		$('#fcheckResult').val(result);//页面审批内容隐藏域的id为remakeValue
		$('#fcheckRemake').val(remake);
		var spjlFiles=$('#spjlFiles').val();
		$('#spjlFile').val(spjlFiles);
		closeCheckWindow();//关闭页面
		check(result);//执行原页面的保存方法，所有的审批审核审定方法名称为check();
	}
}
//是否上传附件点击事件
function changefile(){
	var sel1=$('#filecheck').val();
	if(sel1=="0"){
		$('#filecheck').val(1);
		$('#checkid').show();
	}else{
		$('#filecheck').val(0);
		$('#checkid').hide();
	} 
	
}

//附件删除
function deleteAttac(obj){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: base+'/attachment/delete/'+obj.id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$(obj).parent().remove();
					$('#spjlFiles').val(null);
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
} 

//文件上传
function check_File(obj,serviceType,pathNum) {
	var files = obj.files;
	var size=files[0].size;
	  if(size==0){
		  alert("不允许上传空文件");
		  return false;
	  }
	var formData = new FormData();
	var spjlFile=$('#spjlFiles').val();
	var file=spjlFile.length;
	if(file==0){
		//判断有没有选中附件信息
		if(files==null || files=="null" || files.length==0){
			  alert("请选择附件上传");
			  return false;
		}
		//把所有的附件都存入变量，准备传给后台
		for(var i=0; i< files.length; i++){
			 formData.append("attFiles",files[i]);   
		} 
		//初始化进度条为0
		$("#percent1").html(0 + '%');
		$("#progressNumber1").css("width",""+0+"px");   
		// 接收上传文件的后台地址 
		var url = base + "/attachment/uploadAtt?serviceType="+serviceType+"&pathNum="+pathNum;          
		//1.创建XMLHttpRequest组建    
		xmlHttpRequest = createXmlHttpRequest();  
		//回调函数
		xmlHttpRequest.onreadystatechange = callback1;
		//post请求
		xmlHttpRequest.open("post", url, true);
		xmlHttpRequest.onload = function () {
		  // alert("上传完成!");
		};
		//调用线程监听上传进度
		xmlHttpRequest.upload.addEventListener("progress", progressFunction1, false);
		//把文件数据发送出去
		xmlHttpRequest.send(formData);
	}else {
		alert("只允许上传一个 附件");
	}
	
}
	//监听进度线程，生成进度条
function progressFunction1(evt) {
if (evt.lengthComputable) {
	  //evt.loaded：文件上传的大小   evt.total：文件总的大小                    
    var percentComplete = Math.round((evt.loaded) * 100 / evt.total);    
    //加载进度条，同时显示信息          
    $("#percent1").html(percentComplete + '%');
    //percentComplete*2  这个2是根据总像素大小来改变的，如果是300px就 *3
    $("#progressNumber1").css("width",""+percentComplete*2+"px");   
}
} 

	
//回调函数
function callback1() {
  //5。接收响应数据
  //判断对象的状态是交互完成
  if (xmlHttpRequest.readyState == 4) {
      //判断http的交互是否成功
      if (xmlHttpRequest.status == 200) {
          //获取服务器段输出的纯文本数据
          var responseText = xmlHttpRequest.responseText;
          //文本数据转换成json
          var jsonResponse = JSON.parse(responseText);
	    	 if(jsonResponse.success==true){
	    		    //获取controller 返回的对象信息
			        var datainfo = jsonResponse.info;
	    		    //如果上传了多个文件，返回的string就有多个，使用逗号分割，现在截取
	    		 	var infoArray = datainfo.split(',');	
	    		 	for(var i=0; i< infoArray.length; i++){
	    		 		var info = infoArray[i];
	    		 		var inf = info.split('@');
	    		 		var id = inf[0];//附件id
	    		 		var name = inf[1];//附件名称、
	    		 		
	    		 		 $('#tdspjl').append(
	 			    			"<div style='margin-top: 10px;'>"+
	 			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
	 			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
	 			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
	 			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
	 			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
	 			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$(".fileUrl").each(function(){
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#spjlFiles").val(s);
		       	 	
	    	} else {
	    		alert(data.info);
	    		$('#tdspjl').append(
	    				"<div style='margin-top: 10px;'>"+
	    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
	    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
	    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
	    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
	    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
	    			);
	    	}
      } else {
          alert("上传失败");
      }
  }
  
 

}	
</script>
