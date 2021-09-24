<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div style="width: 536px;height: 225px;">
<form id="projectResolveFiles" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div style="width: 536px;height: 180px" borger="0">
		<table id="projectResolveFilesTable" class="ourtable" style="width: 536px;height: 110px">
			<tr class="trbody">
				<td class="td1" valign="top" style="padding-top: 25px">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;附件
					<input type="file" multiple="multiple" id="yskzsfj" onchange="upladFileRefund(this,'tfgl03','zcgl09')" hidden="hidden">
					<input type="text" id="filesRefund" name="files" hidden="hidden">
					<input type="hidden" name="fId" id="id" value="${id}"/>
				</td>
				<td colspan="4" id="tdfs" valign="top" style="padding-top: 25px">
					<c:if test="${openType=='add'||openType=='edit'}">
					<a onclick="$('#yskzsfj').click()" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					
					<c:if test="${hasFile!='true'&&openType=='detail' }">
						<span style="margin-top: 55px">当前没有选择任何附件</span>
					</c:if>
					
					<div id="progids" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
						<div id="progressNumbers" style="background:#3AF960;width:0px;height:10px" >
				 		</div>文件上传中...&nbsp;&nbsp;<font id="percents">0%</font>
					 </div>
					<c:forEach items="${projectResolveAttaList}" var="att">
						<c:if test="${att.serviceType=='tfgl03'}">
							<div style="margin-top: 10px;">
							<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<c:if test="${openType=='add'||openType=='edit'}">
							<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/sccg.png">
							&nbsp;&nbsp;&nbsp;&nbsp;
								<a id="${att.id}" class="fileUrls" href="#" style="color:red" onclick="deleteAttacFileRefund(this)">删除</a>
							</c:if>
							</div>
						</c:if>
					</c:forEach>
				</td>
			</tr>				
		</table>
	</div>	
	<div class="win-left-bottom-div" style="height: 30px;line-height: 47px">
		<c:if test="${openType=='add'||openType=='edit'}">
			<a href="javascript:void(0)" onclick="projectResolveFilesSave()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
		</c:if>
		<a href="javascript:void(0)" onclick="closeFirstWindow()">
		<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</form>
</div>
<script type="text/javascript">
function projectResolveFilesSave(){
	//放入附件id
	var s = "";
	$(".fileUrls").each(function(){
		s=s+$(this).attr("id")+",";
	});
	closeFirstWindow();
	var index = '${index}';
	var fliesType = '${fliesType}';
	accept();
	$('#'+fliesType).datagrid('updateRow',{
		index: index,
		row: {
			fileFid: s,
		}
	});
}

//文件上传
//pathNum-路径编码
function upladFileRefund(obj,serviceType,pathNum,mark) {
var files = obj.files;
var size=files[0].size;
if(size==0){
	  alert("不允许上传空文件");
	  return false;
}
var formData = new FormData();
//判断有没有选中附件信息
if(files==null || files=="null"|| files.length==0){
	  alert("请选择附件上传");
	  return false;
}
//把所有的附件都存入变量，准备传给后台
for(var i=0; i< files.length; i++){
	 formData.append("attFiles",files[i]);
} 
//初始化进度条为0
$("#percents").html(0 + '%');
$("#progressNumbers").css("width",""+0+"px");

$('.win-left-bottom-div').hide();

// 接收上传文件的后台地址 
var url = base + "/attachment/uploadAtt?serviceType="+serviceType+"&pathNum="+pathNum;          
//1.创建XMLHttpRequest组建    
xmlHttpRequest = createXmlHttpRequest();  
//post请求
xmlHttpRequest.open("post", url, true);
//请求成功回调
xmlHttpRequest.onload = function (data) {
	  callbackRefund(mark);
};
//调用线程监听上传进度
xmlHttpRequest.upload.addEventListener("progress", progressFunctionRefund, false);
//把文件数据发送出去
xmlHttpRequest.send(formData);
//清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
event.target.value=null;
}
	//监听进度线程，生成进度条
function progressFunctionRefund(evt) {
if (evt.lengthComputable) {
	  //evt.loaded：文件上传的大小   evt.total：文件总的大小                    
    var percentComplete = Math.round((evt.loaded) * 100 / evt.total);    
    //加载进度条，同时显示信息          
    $("#progids").show();
    $("#percents").html(percentComplete + '%');
    //percentComplete*2  这个2是根据总像素大小来改变的，如果是300px就 *3
    $("#progressNumbers").css("width",""+percentComplete*3+"px");   
}
}

//回调函数
function callbackRefund(mark) {
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
	    		 		var name = inf[1];//附件名称
				        $('#tdfs').append(
			    			"<div style='margin-top: 5px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrls' href='#' style='color:red' onclick='deleteAttacFileRefund(this,\""+mark+"\")'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			/* var s = "";
	    			$(".fileUrls").each(function(){
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#filesRefund").val(s);
	    			var index = '${index}';
	    			var fliesType = '${fliesType}';
	    			$('#'+fliesType).datagrid('updateRow',{
						index: index,
						row: {
							fileFid: s,
						}
					}); */
	    			$("#progids").hide();
	    	} else {
	    		alert(jsonResponse.info);
	    		$('#tdfs').append(
    				"<div style='margin-top: 5px;'>"+
    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrls' href='#' style='color:red' onclick='deleteAttacFileRefund(this)'>删除</a><div>"
    			);
	    		$("#progids").hide();
	    	}
        } else {
            alert("上传失败");
        }
        $('.win-left-bottom-div').show();
    }
}
//删除附件
function deleteAttacFileRefund(obj){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: base+'/attachment/delete/'+obj.id,
			dataType: 'json',  
			success: function(data){
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$(obj).parent().remove();
					var files = "";
	    			$(".fileUrls").each(function(){
	    				files = files+$(this).attr("id")+",";
	    			});
					var index = '${index}';
					var fliesType = '${fliesType}';
					$('#'+fliesType).datagrid('updateRow',{
						index: index,
						row: {
							fileFid: files,
						}
					});
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
}
</script>
</body>