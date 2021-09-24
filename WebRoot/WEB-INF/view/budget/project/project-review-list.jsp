<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	<div class="list-top">
		<table class="top-table" id="top-table" cellpadding="0" cellspacing="0">
			<tr id="ps_top">
				<td class="top-table-search-pro" >
					<%@include file="project-search-base.jsp" %>
				</td>	
				<td align="right" style="padding-right: 10px">
					<a id='zk' href="#" onclick="zk()">
						<img style="vertical-align:bottom;text-align:left;"  src="${base}/resource-modality/${themenurl}/button/zk.png" >
					</a>
					<a id='sq' hidden="hidden" href="#" onclick="sq()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/sq.png" >
					</a>	
					&nbsp;
					<a href="#" onclick="queryProList('project-review-table');">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;
					<a href="#" onclick="clearProList('project-review-table');">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;
				 	<a href="#" onclick="saveReviewProject(2)">
						<img src="${base}/resource-modality/${themenurl}/button/tijiao1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td> 
			</tr>
			
			<tr id="history_top" style="display: none;">
				<td class="top-table-search-pro">
				</td>	
			 	<td align="right" style="padding-right: 10px">
				</td>
			</tr>
		</table>
	</div>
	
	 <div class="list-table-tab" style="height: 400px">
			<div class="tab-wrapper" id="project-review-tab2">
				<ul class="tab-menu">
					<li class="active"onclick="dataTabPSClick();">项目评审</li>
				    <li  onclick="dataTabHistoryClick();">评审记录</li>
				</ul>
				<div class="tab-content"> 
					<div style="height: 400px">
						<table id="project-review-table" class="easyui-datagrid"
							data-options="collapsible:true,url:'${base}/projectReview/projectPage?type=0',
							method:'post',fit:true,pagination:false,singleSelect: false,scrollbarSize:0,onLoadSuccess:projectPsTotal,
							selectOnCheck: true,remoteSort:true,nowrap:false,striped: true,fitColumns:true">
								<thead>
									<tr>
										<th data-options="field:'ck',checkbox:true" style="width: 2%"></th>
										<th data-options="field:'fproId',hidden:true"></th>
										<th data-options="align:'center',field:'pageOrder'" style="width: 5%">序号</th>
										<th data-options="align:'center',field:'fproCode'" style="width: 12%">项目编号</th>
										<th data-options="align:'center',field:'fproName'" style="width: 13%">项目名称</th>
										<th data-options="field:'bigProName',align:'center',formatter:isBig" width="15%">所属大项目名称</th>
										<th data-options="align:'center',field:'fproAppliPeople'" style="width: 10%">项目负责人</th>
										<th data-options="align:'center',field:'fproAppliDepart'" style="width: 10%">申报部门</th>
										<th data-options="align:'center',field:'planStartYear'" style="width: 10%">开始执行年份</th>
										<th data-options="align:'center',field:'fproAppliTime',formatter: ChangeDateFormat" style="width: 10%">申报时间</th>
										<th data-options="align:'right',field:'fproBudgetAmount',formatter:function(value,row,index){return fomatMoney(value,2);}" style="width: 10%">项目预算[元]</th>
										<th data-options="align:'center',field:'fext6',formatter: projectReviewStauts1" style="width: 10%">是否上报</th>
										<th data-options="align:'center',field:'operation',formatter: projectReviewOperation1" style="width: 10%">查看明细</th>
									</tr>
								</thead>
						</table>
					</div>
					
				<div style="height: 420px">
					<table id="project-review-table2" class="easyui-datagrid"
						data-options="collapsible:true,url:'${base}/projectReview/reviewDetailList',
						method:'post',fit:true,pagination:false,singleSelect: false,scrollbarSize:0,onLoadSuccess:projectPsTotal,
						selectOnCheck: true,remoteSort:true,nowrap:false,striped: true,fitColumns:true">
						<thead>
							<tr>
								<th data-options="field:'fproId',hidden:true"></th>
								<th data-options="align:'center',field:'planStartYear'" style="width: 8%">年份</th>
								<th data-options="align:'center',field:'reviewTime'" style="width: 8%">评审日期</th>
								<th data-options="align:'center',field:'accessoryId',formatter:filesshows" style="width: 5%">会议纪要</th>
								<th data-options="align:'center',field:'fproCode'" style="width: 15%">项目编号</th>
								<th data-options="align:'center',field:'fproName'" style="width: 15%">项目名称</th>
								<th data-options="field:'bigProName',align:'center',formatter:isBig" width="15%">所属大项目名称</th>
								<th data-options="align:'center',field:'fproAppliPeople'" style="width: 6%">项目负责人</th>
								<th data-options="align:'center',field:'fproAppliDepart'" style="width: 10%">申报部门</th>
								<th data-options="align:'center',field:'fproAppliTime',formatter: ChangeDateFormat" style="width: 8%">申报时间</th>
								<th data-options="align:'right',field:'fproBudgetAmount',formatter:listToFixed" style="width: 6%">项目预算[元]</th>
								<th data-options="align:'center',field:'fext6',formatter: projectReviewStauts2" style="width: 10%">是否上报</th>
								<th data-options="align:'center',field:'operation',formatter: projectReviewOperation2" style="width: 9%">查看明细</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div> 
	<div class="list-top" id="project-review-bottom" style="background-color: #f1fcf1;height: 30px;margin-top: 25px">
		<table cellpadding="0" cellspacing="0" style="width: 100%">
		<tr style="height: 30px">
			<td  style="white-space:nowrap">
				<div >
				<input type="file" multiple="multiple" id="hyjy" onchange="reviewupladFile(this,'hyjy','ysgl01')" hidden="hidden">
				<input type="text" id="files" name="files" hidden="hidden">
				&nbsp;&nbsp;<a onclick="$('#hyjy').click()" style="font-weight: bold;" href="#">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/uploadhyjy1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
				</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span id="tdf">
				<c:forEach items="${attaList}" var="att">
					<c:if test="${att.serviceType=='hyjy' }">
						
						<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
						
					</c:if>
				</c:forEach>
				</span>
					<span id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
						 <span id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
						 </span>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
					</span>
				</div>
				
			</td>	
			<td  style="white-space:nowrap" align="right" style="padding-right: 10px">
				&nbsp;&nbsp;评审总数：<a id="project-ps-total" style="color:#ff5454">0</a>个&nbsp;&nbsp;
				&nbsp;&nbsp;拟上报项目数：<a id="project-sb-total" style="color:#ff5454">0</a>个&nbsp;&nbsp;
				&nbsp;&nbsp;落选项目数：<a id="project-lx-total" style="color:#ff5454">0</a>个&nbsp;&nbsp;
			</td>		
		</tr>
		</table>
	</div>
	<form id="review-form" method="post" style="display: none;">
		<input type="hidden" id="review-FProCode" name="FProCode">
		<input type="hidden" id="review-FProName" name="FProName">
		<input type="hidden" id="review-planStartYear" name="planStartYear">
	</form>
</div>
<script type="text/javascript">
//加载tab页
flashtab('project-review-tab2');

var flashCount=0;
$('#project-review-table').datagrid({
	onBeforeLoad : function (param){
		if(flashCount>1){
			return false;
		}else{
			flashCount=flashCount+1;
			return true;
		}
	}
});
$('#project-review-table2').datagrid({
	onLoadSuccess: function (data) {
        //指定列进行合并操作
        $(this).datagrid("autoMergeCellss", ['planStartYear']);
        $(this).datagrid("autoMergeCellss", ['reviewTime']);
			//$(this).datagrid('freezeRow',0);
	}
});

//评审状态变化-项目评审
function projectReviewStauts1(val, row, index) {
	if(val=='2'){
		return  '<a  class="easyui-linkbutton">'+
		   '<img onclick="shangBaoSelect(this,2, '+(parseInt(row.pageOrder)-1)+')"  src="'+base+'/resource-modality/${themenurl}/list/yes2.png">'+
		   '</a>'+
		   '&nbsp;&nbsp;<a  class="easyui-linkbutton">'+
		   '<img onclick="shangBaoSelect(this,-1, '+(parseInt(row.pageOrder)-1)+')"  src="'+base+'/resource-modality/${themenurl}/list/no1.png">'+
		   '</a>';
	}else{
		if(val=='-1'){
			return  '<a  class="easyui-linkbutton">'+
			   '<img onclick="shangBaoSelect(this,2, '+(parseInt(row.pageOrder)-1)+')"  src="'+base+'/resource-modality/${themenurl}/list/yes1.png">'+
			   '</a>'+
			   '&nbsp;&nbsp;<a  class="easyui-linkbutton">'+
			   '<img onclick="shangBaoSelect(this,-1, '+(parseInt(row.pageOrder)-1)+')"  src="'+base+'/resource-modality/${themenurl}/list/no2.png">'+
			   '</a>';
		}else{
			  $('#project-review-table').datagrid('updateRow',{
			    	index: index,
			    	row: {
			    		fext6: '2',
			    	}
			    });
			return  '<a  class="easyui-linkbutton">'+
			   '<img onclick="shangBaoSelect(this,2, '+(parseInt(row.pageOrder)-1)+')"  src="'+base+'/resource-modality/${themenurl}/list/yes2.png">'+
			   '</a>'+
			   '&nbsp;&nbsp;<a  class="easyui-linkbutton">'+
			   '<img onclick="shangBaoSelect(this,-1, '+(parseInt(row.pageOrder)-1)+')"  src="'+base+'/resource-modality/${themenurl}/list/no1.png">'+
			   '</a>';
		}
	}
		
}

//选中是否上报
function shangBaoSelect(obj,type,index) {
	  $('#project-review-table').datagrid('updateRow',{
	    	index: index,
	    	row: {
	    		fext6: type,
	    	}
	    });
		var rows = $("#project-review-table").datagrid("getRows"); //这段代码是获取当前页的所有行。
		var pstotal=rows.length;
		var sbtotal=0;
		for(var i=0;i<rows.length;i++)
		{
		//获取每一行的数据
			if(rows[i].fext6=='2'){
				sbtotal++;
			}
		}
		$('#project-sb-total').html(sbtotal);  //拟上报总数
		$('#project-lx-total').html(pstotal-sbtotal);  //落选数量
}


//项目评审操作-项目评审
function projectReviewOperation1(val, row) {
		return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="selectProject1(' + row.fproId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a>'+
		   '</td><td style="width: 25px">'+
		   '<a href="#" onclick="editProject1(' + row.fproId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
		   '</a>'+
		   '</td></tr></table>';
}

//查看项目信息-项目评审
function selectProject1(id) {
	var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+id+'?logType=2');
	win.window('open');
}
//修改项目信息-项目评审只可以修改大项目字段
function editProject1(id) {
	var win=creatWin('修改-项目信息',1030,630,'icon-search','/projectReview/edit/'+id);
	win.window('open');
}

function dataTabPSClick(){
	$("#project-review-table").datagrid('reload');
	$("#ps_top").show();
	$("#history_top").hide();
	$("#project-review-bottom").show();
}
function dataTabHistoryClick(){
	$("#project-review-table2").datagrid('reload');
	$("#ps_top").hide();
	$("#history_top").show();
	$("#project-review-bottom").hide();
}

//右下角计算评审总数
function projectPsTotal(){
	var rows = $("#project-review-table").datagrid("getRows"); //这段代码是获取当前页的所有行。
	var total=rows.length;
	$('#project-ps-total').html(total); //评审总数
	$('#project-sb-total').html(total);  //拟上报总数
	$('#project-lx-total').html(0);  //落选数量
}

//保存所选项目项目
function saveReviewProject(type) {
	var sbdata="";
	var lxdata="";
	var rows = $("#project-review-table").datagrid("getChecked"); //这段代码是获取当前页的所有行。
	if(rows.length==0) {
		alert("请选择需要上报的项目");
		return;
	}
	for(var i=0;i<rows.length;i++)
	{
	//获取每一行的数据
		if(rows[i].fext6=='2'){
			if(sbdata=="") {
				sbdata =rows[i].fproId ;
			}else{
				sbdata =sbdata+"," +rows[i].fproId ;
			}
		}else{
			if(lxdata=="") {
				lxdata =rows[i].fproId ;
			}else{
				lxdata =lxdata+"," +rows[i].fproId ;
			}
		}
	}
	
	var files=$("#files").val();
	$.ajax({ 
		type: 'POST', 
		url: base+'/projectReview/saveReview?sbIdList='+sbdata+'&lxIdList='+lxdata+'&files='+files,
		dataType: 'json',
		success: function(data){ 
			if(data.success){
				$.messager.alert('系统提示',data.info,'info');
				flashCount=0;
				$('#tdf').empty();
				$('#project-review-table').datagrid('reload');
				$('#project-review-table2').datagrid('reload');
			}else{
				$.messager.alert('系统提示',data.info,'error');
				closeWindow();
			}
		}
	});
}

var reviewxmlHttpRequest;    
//reviewXmlHttpRequest对象    
function createreviewXmlHttpRequest(){    
  if(window.ActiveXObject){ //如果是IE浏览器    
      return new ActiveXObject("Microsoft.XMLHTTP");    
  }else if(window.XMLHttpRequest){ //非IE浏览器    
      return new XMLHttpRequest();    
  }    
} 
//文件上传
function reviewupladFile(obj,serviceType,pathNum,mark) {
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
reviewxmlHttpRequest = createreviewXmlHttpRequest();  
//post请求
reviewxmlHttpRequest.open("post", url, true);
//请求成功回调
reviewxmlHttpRequest.onload = function (data) {
	reviewcallback(mark);
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
reviewxmlHttpRequest.upload.addEventListener("progress", progressFunction, false);
//把文件数据发送出去
reviewxmlHttpRequest.send(formData);
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
function reviewcallback(mark) {
  //5。接收响应数据
  //判断对象的状态是交互完成
  if (reviewxmlHttpRequest.readyState == 4) {
      //判断http的交互是否成功
      if (reviewxmlHttpRequest.status == 200) {
          //获取服务器段输出的纯文本数据
          var responseText = reviewxmlHttpRequest.responseText;
          //文本数据转换成json
          var jsonResponse = JSON.parse(responseText);
	    	 if(jsonResponse.success==true){
	    		 var atttext="";
	    		    //获取controller 返回的对象信息
			        var datainfo = jsonResponse.info;
	    		    //如果上传了多个文件，返回的string就有多个，使用逗号分割，现在截取
	    		 	var infoArray = datainfo.split(',');	
	    		 	for(var i=0; i< infoArray.length; i++){
	    		 		var info = infoArray[i];
	    		 		var inf = info.split('@');
	    		 		var id = inf[0];//附件id
	    		 		var name = inf[1];//附件名称
	    		 		atttext=atttext+"<span><a href='"+base+"/attachment/download/"+id+"' style='color: #666666;font-weight: bold;'>"+name+"</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;"+
			    				"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
			    				"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+id+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this,\""+mark+"\")'>删除</a>"+
			    				"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
	    		 		
	    		 	}
	    		 	  $('#tdf').append(
	    		 			 atttext
			    		);
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
  				"<span style='margin-top: 10px;'>"+
  					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
  					"&nbsp;&nbsp;&nbsp;&nbsp;"+
  					"<img style='display:none;vertical-align:middle' src='"+base+"/resource-modality/img/sccg.png'>"+
  					"<img style='vertical-align:middle' src='"+base+"/resource-modality/img/scsb.png'>"+
  					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='fail' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a></span>"
  			);
	    		$("#progid").hide();
	    	}
      } else {
          alert("上传失败");
      }
      $('.win-left-bottom-div').show();
  }
}




//评审状态变化-审批记录
function projectReviewStauts2(val, row) {
	if(val == 2){
		return '<a  class="easyui-linkbutton">'+
			   '<img   src="'+base+'/resource-modality/${themenurl}/list/yes2.png">'+
			   '</a>'+
			   '&nbsp;&nbsp;<a  class="easyui-linkbutton">'+
			   '<img   src="'+base+'/resource-modality/${themenurl}/list/no1.png">'+
			   '</a>';
	}else {
		return '<a  class="easyui-linkbutton">'+
			   '<img   src="'+base+'/resource-modality/${themenurl}/list/yes1.png">'+
			   '</a>'+
			   '&nbsp;&nbsp;<a  class="easyui-linkbutton">'+
			   '<img   src="'+base+'/resource-modality/${themenurl}/list/no2.png">'+
			   '</a>';
	}
		
}

//项目评审操作-审批记录
function projectReviewOperation2(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="selectProject2(' + row.fproId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a>'+
		   '</td></tr></table>';
}

//查看项目信息
function selectProject2(id) {
	var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+id+'?logType=2');
	win.window('open');
}
//自定义合并方法
$.extend($.fn.datagrid.methods, {
    autoMergeCellss: function(jq, fields) {
        return jq.each(function() {
            var target = $(this);
            if (!fields) {
                fields = target.datagrid("getColumnFields");
            }
            var rows = target.datagrid("getRows");
            var i = 0,
            j = 0,
            temp = {};
            for (i; i < rows.length; i++) {
            	//更改高度
            	 $('.datagrid-row').css('height','32px');
                var row = rows[i];
                j = 0;
                for (j; j < fields.length; j++) {
                    var field = fields[j];
                    var tf = temp[field];
                    if (!tf) {
                        tf = temp[field] = {};
                        tf[row[field]] = [i];
                    } else {
                        var tfv = tf[row[field]];
                        if (tfv) {
                            tfv.push(i);
                        } else {
                            tfv = tf[row[field]] = [i];
                        }
                    }
                }
            }
            $.each(temp,
            function(field, colunm) {
                $.each(colunm,
                function() {
                    var group = this;
                    if (group.length > 1) {
                        var before, after, megerIndex = group[0];
                        for (var i = 0; i < group.length; i++) {
                            before = group[i];
                            after = group[i + 1];
                            if (after && (after - before) == 1) {
                                continue;
                            }
                            var rowspan = before - megerIndex + 1;
                            if (rowspan > 1) {
                                target.datagrid('mergeCells', {
                                    index: megerIndex,
                                    field: field,
                                    rowspan: rowspan
                                });
                            }
                            if (after && (after - before) != 1) {
                                megerIndex = after;
                            }
                        }
                    }
                });
            });
        });
    }
});

//附件显示
function filesshows(val,row){
	if (val=="" || val==null) {
		return '<table><tr style="width: 75px;height:20px"><td><a href="#" class="easyui-linkbutton">无附件' + '</a></td>'
		+'</table>';
	}else if (val!=null) {
	var data = val.split(',');
		if(data.length>0){
		return 	'<table><tr style="width: 75px;height:20px"><td><a href="#" onclick="accessorys(\''+val+'\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + '</a></td>'
				+'</table>';
		}else{
			return 	'<table><tr style="width: 75px;height:20px"><td><a href="#" onclick="downloadFiless(\'' + data[0]+ '\')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + '</a></td>'
			+'</table>';
		}
	}
}
function accessorys(val){
	$.ajax({
		url: base+ "/project/historyAttaListEntryIdS?id="+val+"",
		type : 'post',
		async : true,
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				for( var i=0; i<json.length;i++){
					var id = json[i].id;
					downloadFiless(id);
				}
		}
	});
	
	
	}
	
function downloadFiless(id){
	if(id==null){
		alert("没有相关附件！");
		return;
	}
	//window.open(base+'/systemcentergl/viewPDF/'+fileName,'open');
	  window.open(base+'/attachment/download/'+id,'open');
	  
}
function queryProList(datagridID){
	flashCount=flashCount-1;
	$("#"+datagridID).datagrid('load',{
		FProCode:$('#pro_list_query_FProCode').textbox('getValue').trim(),
		FProName:$('#pro_list_query_FProName').textbox('getValue').trim(),
		FProAppliDepart:$('#pro_list_query_FProAppliDepart').textbox('getValue').trim(),
		FProAppliPeople:$('#pro_list_query_FProAppliPeople').textbox('getValue').trim(),
		planStartYear:$('#pro_list_query_planStartYear').numberbox('getValue'),
		FProOrBasic:$('#pro_list_query_FProOrBasic').combobox('getValue').trim()=='--请选择--'?'':$('#pro_list_query_FProOrBasic').combobox('getValue').trim(),
	});
};
function clearProList(datagridID){
	$('#pro_list_query_FProCode').textbox('setValue','');
	$('#pro_list_query_FProName').textbox('setValue','');
	$('#pro_list_query_FProAppliDepart').textbox('setValue','');
	$('#pro_list_query_FProAppliPeople').textbox('setValue','');
	$('#pro_list_query_planStartYear').numberbox('setValue','');
	$('#pro_list_query_FProOrBasic').combobox('setValue','--请选择--');
	flashCount=flashCount-1;
	$("#"+datagridID).datagrid('load',{});
}
/**
 * 预算模块的查询方法
 * @param datagridID 表的id
 * @author 陈睿超
 */
function queryProList2(datagridID){
	$("#"+datagridID).datagrid('load',{
		FProCode:$('#pro_list_query_FProCode2').textbox('getValue').trim(),
		FProName:$('#pro_list_query_FProName2').textbox('getValue').trim(),
		FProAppliDepart:$('#pro_list_query_FProAppliDepart2').textbox('getValue').trim(),
		FProAppliPeople:$('#pro_list_query_FProAppliPeople2').textbox('getValue').trim(),
		planStartYear:$('#pro_list_query_planStartYear2').numberbox('getValue'),
		FProOrBasic:$('#pro_list_query_FProOrBasic2').combobox('getValue').trim()=='--请选择--'?'':$('#pro_list_query_FProOrBasic2').combobox('getValue').trim(),
	});
}
function clearProList2(datagridID){
	$('#pro_list_query_FProCode2').textbox('setValue','');
	$('#pro_list_query_FProName2').textbox('setValue','');
	$('#pro_list_query_FProAppliDepart2').textbox('setValue','');
	$('#pro_list_query_FProAppliPeople2').textbox('setValue','');
	$('#pro_list_query_planStartYear2').numberbox('setValue','');
	$('#pro_list_query_FProOrBasic2').combobox('setValue','--请选择--');
	$("#"+datagridID).datagrid('load',{});
}
function zk2(){//展开
	$('#zk2').hide();
	$('#sq2').show();
	//搜索栏框变大
	$('#top-table').css('height', '80px');
	$('#othersearchtd2').css('margin-top:', '0px');
	$('#othersearchtd2').show();
}
function sq2(){//收起
	$('#sq2').hide();
	$('#zk2').show();
	//搜索栏框变小
	$('#top-table').css('height', '40px');
	$('#othersearchtd2').hide();
}
</script>
</body>