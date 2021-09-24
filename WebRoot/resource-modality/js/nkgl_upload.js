/** 李安达 2019-1-7 **/

//创建全局变量的 xmlHttpRequest对象
var xmlHttpRequest;    
//XmlHttpRequest对象    
function createXmlHttpRequest(){    
    if(window.ActiveXObject){ //如果是IE浏览器    
        return new ActiveXObject("Microsoft.XMLHTTP");    
    }else if(window.XMLHttpRequest){ //非IE浏览器    
        return new XMLHttpRequest();    
    }    
} 
//文件上传
//pathNum-路径编码
function upladFile(obj,serviceType,pathNum,mark) {
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
  $("#percent").html(0 + '%');
  $("#progressNumber").css("width",""+0+"px");
  
  $('.win-left-bottom-div').hide();
  
  // 接收上传文件的后台地址 
  var url = base + "/attachment/uploadAtt?serviceType="+serviceType+"&pathNum="+pathNum;          
  //1.创建XMLHttpRequest组建    
  xmlHttpRequest = createXmlHttpRequest();  
  //post请求
  xmlHttpRequest.open("post", url, true);
  //请求成功回调
  xmlHttpRequest.onload = function (data) {
	  callback(mark);
	  var resObj = JSON.parse(data.currentTarget.response);
	  if(resObj.success && 'zdsy'==serviceType){
		  //如果是制度索引文件上传
		  var fileName = resObj.info.split("@")[1];
		  var fileId = resObj.info.split("@")[0];
		  fileName = fileName.replace('.pdf','');
		  $('#cheter_add_fileName').textbox('setValue',fileName);
		  $('#F_attachmentId').val(fileId);
		  $('#systemcenter_add_uploadbtn').hide();
	  }
  };
  //调用线程监听上传进度
  xmlHttpRequest.upload.addEventListener("progress", progressFunction, false);
  //把文件数据发送出去
  xmlHttpRequest.send(formData);
  //清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
  event.target.value=null;
}
	//监听进度线程，生成进度条
function progressFunction(evt) {
  if (evt.lengthComputable) {
	  //evt.loaded：文件上传的大小   evt.total：文件总的大小                    
      var percentComplete = Math.round((evt.loaded) * 100 / evt.total);    
      //加载进度条，同时显示信息          
      $("#progid").show();
      $("#percent").html(percentComplete + '%');
      //percentComplete*2  这个2是根据总像素大小来改变的，如果是300px就 *3
      $("#progressNumber").css("width",""+percentComplete*3+"px");   
  }
} 
//回调函数
function callback(mark) {
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
				        $('#tdf').append(
			    			"<div style='margin-top: 5px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this,\""+mark+"\")'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$(".fileUrl").each(function(){
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#files").val(s);
	    			$("#progid").hide();
	    	} else {
	    		alert(jsonResponse.info);
	    		$('#tdf').append(
    				"<div style='margin-top: 5px;'>"+
    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
    			);
	    		$("#progid").hide();
	    	}
        } else {
            alert("上传失败");
        }
        $('.win-left-bottom-div').show();
    }
}
//这个是通用的上传方法2
var progressNumberid="";
var percentid="";
var tdfid="";
var files="";
var progid="";
var serviceType="";
//文件上传
function upladFileParams(obj,serviceType,pathNum,progressNumberid,percentid,tdfid,filesid,progid) {
  this.percentid=percentid;
  this.progressNumberid=progressNumberid;
  this.tdfid=tdfid;
  this.serviceType=serviceType;
  this.filesid=filesid;
  this.progid=progid;
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
  
  $("#"+progid).show();
  $("#"+percentid).html(0 + '%');
  $("#"+progressNumberid).css("width",""+0+"px");   
  // 接收上传文件的后台地址 
  var url = base + "/attachment/uploadAtt?serviceType="+serviceType+"&pathNum="+pathNum;          
  //1.创建XMLHttpRequest组建    
  xmlHttpRequest = createXmlHttpRequest();  
  //回调函数
  xmlHttpRequest.onreadystatechange = callbackParams;
  //post请求
  xmlHttpRequest.open("post", url, true);
  xmlHttpRequest.onload = function () {
    // alert("上传完成!");
  };
  //调用线程监听上传进度
  xmlHttpRequest.upload.addEventListener("progress", progressFunctionParams, false);
  //把文件数据发送出去
  xmlHttpRequest.send(formData);
  //清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
  event.target.value=null;
}
	//监听进度线程，生成进度条
function progressFunctionParams(evt) {
  if (evt.lengthComputable) {
	  //evt.loaded：文件上传的大小   evt.total：文件总的大小                    
      var percentComplete = Math.round((evt.loaded) * 100 / evt.total);    
      //加载进度条，同时显示信息          
      $("#"+percentid).html(percentComplete + '%');
      //percentComplete*2  这个2是根据总像素大小来改变的，如果是300px就 *3
      $("#"+progressNumberid).css("width",""+percentComplete*3+"px");   
  }
} 
//回调函数
function callbackParams() {
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
				        $('#'+tdfid).append(
			    			"<div class='"+serviceType+"' style='margin-top: 5px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl"+serviceType+"' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$(".fileUrl"+serviceType).each(function(){ 
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#"+filesid).val(s);
	    			$("#"+progid).hide();
	    	} else {
	    		$('#'+tdfid).append(
    				"<div style='margin-top: 5px;'>"+
    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
    			);
	    		$("#"+progid).hide();
	    	}
        } else {
            alert("上传失败");
        }
    }
}

//取消上传
function abortUpload(){
  xmlHttpRequest.abort();//请求中止
}

//附件删除
function deleteAttac(obj,mark){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: base+'/attachment/delete/'+obj.id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$(obj).parent().remove();
					if(mark=='zdsy'){
						//如果是制度索引新增
						$('#systemcenter_add_uploadbtn').show();
					}
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
}


//发票文件上传
//pathNum-路径编码
function upladFp(obj,serviceType,pathNum,mark) {
var files = obj.files;
var id =obj.id;
var i=id.lastIndexOf("\_");
var index=id.substring(i+1,id.length);
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
$("#percent").html(0 + '%');
$("#progressNumber").css("width",""+0+"px");

$('.win-left-bottom-div').hide();

// 接收上传文件的后台地址 
var url = base + "/attachment/uploadFp?serviceType="+serviceType+"&pathNum="+pathNum+"&index="+index;          
//1.创建XMLHttpRequest组建    
xmlHttpRequest = createXmlHttpRequest();  
//post请求
xmlHttpRequest.open("post", url, true);
//请求成功回调
xmlHttpRequest.onload = function (data) {
	  callback1(serviceType);
};
//调用线程监听上传进度
//xmlHttpRequest.upload.addEventListener("progress", progressFunction, false);
//把文件数据发送出去
xmlHttpRequest.send(formData);
//清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
event.target.value=null;
}
//回调函数
function callback1(serviceType) {
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
			        var i=datainfo.lastIndexOf("\@");
			        var id=datainfo.substring(0,i);
			        var index=datainfo.substring(i+1,datainfo.length);
			        var firstid='';
			        switch (serviceType) {
			        case 'travelincity'://差旅
			        	firstid = "#incityfp_";
			            break;
			        case 'traveloutside':
			        	firstid = "#outsidefp_";
			            break;
			        case 'travelhotel':
			        	firstid = "#hotelfp_";
			        	break;
			        case 'comm':
			        	firstid = "#commfp_";
			        	break;
			        case 'directly':
			        	firstid = "#directlyfp_";
			        	break;
			        case 'meetTrain':
			        	firstid = "#meetTrainfp_";
			        	break;
			        case 'hotel':
			        	firstid = "#fp_";
			            break;
			        case 'car':
			        	firstid = "#carfp_";
			        	break;
			        case 'meeting':
			        	firstid = "#meetingfp_";
			        	break;
			        case 'receptionfood':
			        	firstid = "#foodfp_";
			        	break;
			        case 'receptionother':
			        	firstid = "#otherfp_";
			        	break;
			        case 'costRent':
			        	firstid = "#costRentfp_";
			        	break;
			        case 'trainzonghe':
			        	firstid = "#zonghefp_";
			        	break;
			        case 'mix':
			        	firstid = "#mixfp_";
			        	break;
			        case 'travelfete':
			        	firstid = "#fetefp_";
			        	break;
			        case 'travelother':
			        	firstid = "#otherfp_";
			        	break;
			        case 'contract':
			        	firstid = "#contractfp_";
			        	break;
			        case 'current':
			        	firstid = "#currentfp_";
			        	break;
			        case 'hotelAttend':
			        	firstid = "#hotelAttendfp_";
			        	break;
			        case 'outsideAttend':
			        	firstid = "#outsideAttendfp_";
			        	break;
			    } 
 		 	//放入附件id
		        $(firstid+ index).val(id);     
	    	} 
      } else {
          alert("上传失败");
      }
      $('.win-left-bottom-div').show();
  }
}

//文件上传
function upladFileMoreParams(obj,serviceType,pathNum,progressNumberid,percentid,tdfid,filesid,progid,classid) {
	
  this.percentid=percentid;
  this.progressNumberid=progressNumberid;
  this.tdfid=tdfid;
  this.serviceType=serviceType;
  this.filesid=filesid;
  this.progid=progid;
  this.classid=classid;
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
  
  $("#"+progid).show();
  $("#"+percentid).html(0 + '%');
  $("#"+progressNumberid).css("width",""+0+"px");   
  // 接收上传文件的后台地址 
  var url = base + "/attachment/uploadAtt?serviceType="+serviceType+"&pathNum="+pathNum;          
  //1.创建XMLHttpRequest组建    
  xmlHttpRequest = createXmlHttpRequest();  
  //回调函数
  xmlHttpRequest.onreadystatechange = callbackMoreParams;
  //post请求
  xmlHttpRequest.open("post", url, true);
  xmlHttpRequest.onload = function () {
    // alert("上传完成!");
  };
  //调用线程监听上传进度
  xmlHttpRequest.upload.addEventListener("progress", progressFunctionMoreParams, false);
  //把文件数据发送出去
  xmlHttpRequest.send(formData);
  //清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
  event.target.value=null;
}
	//监听进度线程，生成进度条
function progressFunctionMoreParams(evt) {
  if (evt.lengthComputable) {
	  //evt.loaded：文件上传的大小   evt.total：文件总的大小                    
      var percentComplete = Math.round((evt.loaded) * 100 / evt.total);    
      //加载进度条，同时显示信息          
      $("#"+percentid).html(percentComplete + '%');
      //percentComplete*2  这个2是根据总像素大小来改变的，如果是300px就 *3
      $("#"+progressNumberid).css("width",""+percentComplete*3+"px");   
  }
} 
//回调函数
function callbackMoreParams() {
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
				        $('#'+tdfid).append(
			    			"<div class='"+serviceType+"' style='margin-top: 5px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='"+classid+"' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$("."+classid).each(function(){ 
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#"+filesid).val(s);
	    			$("#"+progid).hide();
	    	} else {
	    		$('#'+tdfid).append(
    				"<div style='margin-top: 5px;'>"+
    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='"+classid+"' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
    			);
	    		$("#"+progid).hide();
	    	}
        } else {
            alert("上传失败");
        }
    }
}

//发票文件上传
//pathNum-路径编码
function upladExport(obj,serviceType,pathNum,mark) {
	accept1();
var files = obj.files;
var id =obj.id;
var i=id.lastIndexOf("\_");
var index=id.substring(i+1,id.length);
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
//接收上传文件的后台地址 
var url = base + "/attachment/uploadExport";          
//1.创建XMLHttpRequest组建    
xmlHttpRequest = createXmlHttpRequest();  
//post请求
xmlHttpRequest.open("post", url, true);
//请求成功回调
xmlHttpRequest.onload = function (data) {
	callbackExport(serviceType);
};
//调用线程监听上传进度
//xmlHttpRequest.upload.addEventListener("progress", progressFunction, false);
//把文件数据发送出去
xmlHttpRequest.send(formData);
//清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
event.target.value=null;
}
//回调函数
function callbackExport(serviceType) {
//5。接收响应数据
//判断对象的状态是交互完成
if (xmlHttpRequest.readyState == 4) {
    //判断http的交互是否成功
    if (xmlHttpRequest.status == 200) {
        //获取服务器段输出的纯文本数据
        var responseText = xmlHttpRequest.responseText;
        //文本数据转换成json
        if(responseText!=''){
        	var jsonResponse = JSON.parse(responseText);
	    	 if(jsonResponse.success==true){
	    		    //获取controller 返回的对象信息
			        var datainfo =eval("(" + jsonResponse.info + ")");
			        for (var i = 0; i < datainfo.length; i++) {
						$('#mingxi-dg').datagrid('appendRow', {
							oppositeUnit:datainfo[i].oppositeUnit,
							idCard:datainfo[i].idCard,
							planMoney:datainfo[i].planMoney,
							planTime:ChangeDateFormat(datainfo[i].planTime),
							invoiceKindShow:datainfo[i].invoiceKindShow
						});
					}
			        var rows = $('#mingxi-dg').datagrid('getRows');
			        var num1 = 0;
			        for (var i = 0; i < rows.length; i++) {
			       	 if (!isNaN(parseFloat(rows[i]['planMoney']))) {
			   	    	 num1 += parseFloat(rows[i]['planMoney']);
			       	 }
			   	}
			        
			      //给两个框赋值
			        $('#costOther_span').html(fomatMoney(num1,2)+" [元]");
			     	$('#fregisterAmount').val(num1.toFixed(2));
	    	}
        }else{
        	 alert("导入失败！");
        }
    } else {
        alert("导入失败！");
    }
}


//这个是通用的上传方法3
//文件上传
function upladFileParamsOther(obj,serviceType,pathNum,progressNumberid,percentid,tdfid,filesid,progid) {
  this.percentid=percentid;
  this.progressNumberid=progressNumberid;
  this.tdfid=tdfid;
  this.serviceType=serviceType;
  this.filesid=filesid;
  this.progid=progid;
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
  
  $("#"+progid).show();
  $("#"+percentid).html(0 + '%');
  $("#"+progressNumberid).css("width",""+0+"px");   
  // 接收上传文件的后台地址 
  var url = base + "/attachment/uploadAtt?serviceType="+serviceType+"&pathNum="+pathNum;          
  //1.创建XMLHttpRequest组建    
  xmlHttpRequest = createXmlHttpRequest();  
  //回调函数
  xmlHttpRequest.onreadystatechange = callbackParamsOther;
  //post请求
  xmlHttpRequest.open("post", url, true);
  xmlHttpRequest.onload = function () {
    // alert("上传完成!");
  };
  //调用线程监听上传进度
  xmlHttpRequest.upload.addEventListener("progress", progressFunctionParamsOther, false);
  //把文件数据发送出去
  xmlHttpRequest.send(formData);
  //清空value （作用：删除文件后再上传同一个文件，onchange方法不调用）
  event.target.value=null;
}
	//监听进度线程，生成进度条
function progressFunctionParamsOther(evt) {
  if (evt.lengthComputable) {
	  //evt.loaded：文件上传的大小   evt.total：文件总的大小                    
      var percentComplete = Math.round((evt.loaded) * 100 / evt.total);    
      //加载进度条，同时显示信息          
      $("#"+percentid).html(percentComplete + '%');
      //percentComplete*2  这个2是根据总像素大小来改变的，如果是300px就 *3
      $("#"+progressNumberid).css("width",""+percentComplete*3+"px");   
  }
} 
//回调函数
function callbackParamsOther() {
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
				        $('#'+tdfid).append(
			    			"<div class='"+serviceType+"' style='margin-top: 5px;'>"+
			    				"<a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl"+serviceType+"' href='#' style='color:red' onclick='deleteAttacOther(this)'>删除</a><div>"
			    		);
	    		 		
	    		 	}
	    		 	//放入附件id
	    			var s="";
	    			$(".fileUrl"+serviceType).each(function(){ 
	    				s=s+$(this).attr("id")+",";
	    			});
	    			$("#"+filesid).val(s);
	    			$("#"+progid).hide();
	    	} else {
	    		$('#'+tdfid).append(
    				"<div style='margin-top: 5px;'>"+
    					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;"+
    					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
    					"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
    					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl"+serviceType+"' href='#' style='color:red' onclick='deleteAttacOther(this)'>删除</a><div>"
    			);
	    		$("#"+progid).hide();
	    	}
        } else {
            alert("上传失败");
        }
    }
}

//取消上传
function abortUpload(){
  xmlHttpRequest.abort();//请求中止
}

//附件删除
function deleteAttacOther(obj,mark){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: base+'/attachment/delete/'+obj.id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$(obj).parent().remove();
					if(mark=='zdsy'){
						//如果是制度索引新增
						$('#systemcenter_add_uploadbtn').show();
					}
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
}

}