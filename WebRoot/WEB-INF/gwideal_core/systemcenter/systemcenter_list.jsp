<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<title>制度中心 </title>
<link rel="stylesheet" type="text/css" href="${base}/resource/css/systemcenter.css">
<style type="text/css">
 .textbox{
	border-radius:4px;
	border: 1px solid #D9E3E7;
}
.textbox, .textbox .textbox-text{
	background-color: #fff;
} 
</style>
<body>
<div class="" style="width:100%;height:100%;">
  	
  	<div >
  		<div class="bigDiv">
  		<div class="titleDiv"><strong>单 位 制 度 手 册 索 引</strong></div>
  			<div>
  				<div style="width: 96%;margin: 0 auto;">
  					<div style="height: 50px;">
  						<table class="system_tab1">
  							<tr>
  								<td style="width:30%;"><span id="guess" style="font-weight: bold; font-size: 16px;">猜你要找的是</span>&nbsp;&nbsp;<span id="seeMore" style="font-weight: bold; font-size: 12px;color:#008DFF;cursor:pointer;display:none;" onclick="IWantMore()">没有想要的结果，查看更多>></span></td>
  								<td style="width:12%"></td>
  								<td valign="top">
  									<div style=" text-align: right;height: 26px; padding-top: 10px;">
  										<%-- <a href="#" onclick="systemPrint()" style="font-size:10px;"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/list/dayin.png"></a>
  									&nbsp;&nbsp;&nbsp; --%>
  									
	  									<input id="fileName" style="width: 190px;height: 26px;" name="fileName" class="easyui-textbox"
										data-options="precision:2,iconWidth: 30,icons: [{iconCls:'icon-sousuo',handler: function(e){}}]" 
										/>
										
										&nbsp;
										<a href="#" id="index-search" onclick="seachSystem()">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/list/chaxun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
										</a>
									&nbsp;
										<a href="#" id="index-search" onclick="clearSystem()">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
										</a>
									&nbsp;
										<a href="#" id="index-select" onclick="multipleChoice()">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/list/duoxuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
										</a>
									&nbsp;
										<a href="#" id="index-download" onclick="systemDownload()">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/list/xiazai1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
										</a>
  									</div>
  								</td>
  							</tr>
  						</table>
  					</div>
  					<div style="width:87%; margin: 0 auto;">
  						<table class="system_tab2">
  							<thead id="systemData">
  								<tr>
	  								<c:forEach items="${cheterListType}" var="cheterType" varStatus="vct">
							  			<c:if test="${vct.index%6==0 && vct.index!=0 }"><tr>
								  			
							  			</c:if>
										<td class="system_tab2_td">
								  				<div class="tab2_div" onclick="openPDF('${cheterType.fileName}','${cheterType.systemId}',this)" onmousemove="bigTopColor(this)" onmouseout="normalTopColor(this)">
													<div class="div_top"></div>
													<div class="div_center1">
														<c:if test="${fn:length(cheterType.fileName)>12}">
															<span style="font-size: 12px;">${cheterType.fileName}</span>
														</c:if>
														<c:if test="${fn:length(cheterType.fileName)<=12}">
															<span style="font-size: 14px;">${cheterType.fileName}</span>
														</c:if>
													</div>
													<div class="div_center2"><fmt:formatDate value="${cheterType.updateTime}" pattern="yyyy年MM月dd日"/></div>
			  										<div class="div_bottom">&nbsp;
			  											<span>ID:</span><span class="systemId">${cheterType.systemId}</span>
			  											<div class="div_bottom_div" >
			  												<img src="${base}/resource-modality/${themenurl}/list/chakan.png">
			  												<c:if test="${cheterType.clickNum==null}">0</c:if>
			  												<c:if test="${cheterType.clickNum!=null}">${cheterType.clickNum}</c:if>
			  											</div>
			  										</div>
								  				</div>
								  			</td>
								  			<c:if test="${vct.last && ((fn:length(cheterListType)==1)||vct.index%6==0)}">
						  						<td></td> <td></td> <td></td> <td></td> <td></td>
											</c:if>
											<c:if test="${vct.last && (fn:length(cheterListType)==2||vct.index%6==1)}">
							  					<td></td> <td></td> <td></td> <td></td>
											</c:if>
											<c:if test="${ vct.last && (fn:length(cheterListType)==3||vct.index%6==2)}">
							  					<td></td> <td></td> <td></td>
											</c:if>
											<c:if test="${ vct.last && (fn:length(cheterListType)==4||vct.index%6==3)}">
							  					<td></td> <td></td>
											</c:if>
											<c:if test="${ vct.last && (fn:length(cheterListType)==5||vct.index%6==4)}">
							  					<td></td>
											</c:if>
		  							</c:forEach>
	  							</tr>
  							</thead>
  						</table>
  					</div>
  					<div class="searchDiv">
  						<div id="searchNum" style="display: none;">
  							您已选择&nbsp;<span id="totalNum" style="color:#008DFF;">0</span>&nbsp;个文件
  							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  						</div>
  					</div>
  				</div>
  				<div class="system_center">
  					<div style="font-weight: bold; font-size: 16px;width: 6.5%; float: left;">
  						&nbsp;我要更多
  					</div>
  					<div style="width: 87%;float: left;">
  						<table id="moreSystem" class="system_tab2">
  							<tr>
  								<c:forEach items="${cheterListAll}" var="cheter" varStatus="vs">
						  			<c:if test="${vs.index%6==0 && vs.index!=0 }"><tr></c:if>
						  			
						  			<td class="system_tab2_td">
						  				<div class="tab2_div" onclick="openPDF('${cheter.fileName}','${cheter.systemId}',this)"  onmousemove="bigTopColor(this)" onmouseout="normalTopColor(this)">
											<div class="div_top"></div>
											<div class="div_center1">
												<c:if test="${fn:length(cheter.fileName)>12}">
													<span style="font-size: 12px;">${cheter.fileName}</span>
												</c:if>
												<c:if test="${fn:length(cheter.fileName)<=12}">
													<span style="font-size: 14px;">${cheter.fileName}</span>
												</c:if>
											</div>
											<div class="div_center2"><fmt:formatDate value="${cheter.updateTime}" pattern="yyyy年MM月dd日"/></div>
	  										<div class="div_bottom">&nbsp;
	  											<span>ID:</span><span class="systemId">${cheter.systemId}</span>
	  											<div class="div_bottom_div" >
	  												<img src="${base}/resource-modality/${themenurl}/list/chakan.png">
	  												<c:if test="${cheter.clickNum==null}">0</c:if>
	  												<c:if test="${cheter.clickNum!=null}">${cheter.clickNum}</c:if>
	  											</div>
	  										</div>
						  				</div>
						  			</td>
						  				<c:if test="${vs.last && ((fn:length(cheterListAll)==1)||vs.index%6==0)}">
					  						<td></td> <td></td> <td></td> <td></td> <td></td>
										</c:if>
										<c:if test="${vs.last && (fn:length(cheterListAll)==2||vs.index%6==1)}">
						  					<td></td> <td></td> <td></td> <td></td>
										</c:if>
										<c:if test="${ vs.last && (fn:length(cheterListAll)==3||vs.index%6==2)}">
						  					<td></td> <td></td> <td></td>
										</c:if>
										<c:if test="${ vs.last && (fn:length(cheterListAll)==4||vs.index%6==3)}">
						  					<td></td> <td></td>
										</c:if>
										<c:if test="${ vct.last && (fn:length(cheterListAll)==5||vct.index%6==4)}">
						  					<td></td>
										</c:if>
	  							</c:forEach>
  							</tr>
  						</table>
  					</div>
  				</div>
  			</div>
  		</div>
  	
  	</div>
  	<form id="systemFormDownload" method="post">
  		<input type="hidden" id="systemId" name="systemId" value="">
  		<input type="hidden" id="fileName" name="fileName" value="">
  	</form>
  	
 </div>		


	<script type="text/javascript">
	var isFlag=true;	//区分是预览 还是多选
	var isStatus=false;
	var num=0;			//多选     选择的数量
	var arr=new Array();	//选中的id
	
	var filename;
	
	//查询
	function seachSystem(){
		if(isFlag==false){
			alert("请取消多选在查询！");
			return;
		}
		filename=$("#fileName").val();
		if(filename=="" || (filename==" "&&filename.length==0)){
			alert("请输入要查询的内容!");
			return;
		}
		
		 var tab =document.getElementById("systemData");
		 $.ajax({
			url : base+"/systemcentergl/systemList?fileName="+filename,
			type : "post",
			success : function(list) {
				var data=eval(list);
				if(data==null || data==""){
					alert("没有符合条件的数据！");
				}else{
					$("#moreSystem").empty();
					$("#seeMore").show();
					$(".searchDiv").css("border","none");
					$(".system_center").hide();
					
					$("#systemData").empty();
					$("#guess").text("查询结果");
					var row=tab.insertRow(-1);
					var str="";
					$.each(data,function(i,obj){
						if(i%6==0){
							//在末尾插入一行
							row = tab.insertRow(-1);
						}
						var cell = row.insertCell();
						cell.setAttribute("class","system_tab2_td");
						if((obj.fileName).length<13){
							str='<span style="font-size: 14px;">'+obj.fileName+'</span>';
						}else{
							str='<span style="font-size: 12px;">'+obj.fileName+'</span>';
						}
						var t=obj.releseTime;
						var time=getTime(t);
						 
						 $(cell).append(
							'<div class="tab2_div" onclick="openPDF(\''+obj.fileName+'\','+obj.systemId+',this)" onmousemove="bigTopColor(this)" onmouseout="normalTopColor(this)">'
								+'<div class="div_top"></div>'
								+'<div class="div_center1">'+str+'</div>'
								+'<div class="div_center2">'+time+'</div>'
								+'<div class="div_bottom">&nbsp;'
								+'<span>ID:</span><span class="systemId">'+obj.systemId+'</span>'
								+'<div class="div_bottom_div" >'
								+'<img src="${base}/resource-modality/${themenurl}/list/chakan.png"> '
								+getClicks(obj.clickNum)
								+'</div> </div> </div>'
						);
					});
						var c=data.length;
					 	if(c%6==1){
							var cell1 = row.insertCell();
							var cell2 = row.insertCell();
							var cell3 = row.insertCell();
							var cell4 = row.insertCell();
							var cell5 = row.insertCell();
						}else if(c%6==2){
							var cell1 = row.insertCell();
							var cell2 = row.insertCell();
							var cell3 = row.insertCell();
							var cell4 = row.insertCell();
						}else if(c%6==3){
							var cell1 = row.insertCell();
							var cell2 = row.insertCell();
							var cell3 = row.insertCell();
						}else if(c%6==4){
							var cell1 = row.insertCell();
							var cell2 = row.insertCell();
						}else if(c%6==5){
							var cell1 = row.insertCell();
						}
				}
			},
			error : function() {
				alert("出现异常啦...");
			}
		});
	}
	//查看更多
	function IWantMore(){
		if(isFlag==false){
			alert("请取消多选在查看更多！");
			return;
		}
		var tab =document.getElementById("moreSystem");
		$.ajax({
			url : base+"/systemcentergl/systemList?more="+filename,
			type : "post",
			success : function(list) {
				$(".searchDiv").css("border-bottom","1px solid #D9E3E7");
				$(".system_center").show();
				$("#moreSystem").empty();
				var data=eval(list);
				if(data==null || data==""){
					alert("没有更多数据了！");
				}else{
					var row=tab.insertRow(-1);
					var str="";
					$.each(data,function(i,obj){
						if(i%6==0){
							//在末尾插入一行
							row = tab.insertRow(-1);
						}
						var cell = row.insertCell();
						cell.setAttribute("class","system_tab2_td");
						if((obj.fileName).length<13){
							str='<span style="font-size: 14px;">'+obj.fileName+'</span>';
						}else{
							str='<span style="font-size: 12px;">'+obj.fileName+'</span>';
						}
						var t=obj.releseTime;
						var time=getTime(t);
						 
						 $(cell).append(
							'<div class="tab2_div" onclick="openPDF(\''+obj.fileName+'\','+obj.systemId+',this)" onmousemove="bigTopColor(this)" onmouseout="normalTopColor(this)">'
								+'<div class="div_top"></div>'
								+'<div class="div_center1">'+str+'</div>'
								+'<div class="div_center2">'+time+'</div>'
								+'<div class="div_bottom">&nbsp;'
								+'<span>ID:</span><span class="systemId">'+obj.systemId+'</span>'
								+'<div class="div_bottom_div" >'
								+'<img src="${base}/resource-modality/${themenurl}/list/chakan.png"> '
								+getClicks(obj.clickNum)
								+'</div> </div> </div>'
						);
					});
						var c=data.length;
					 	if(c%6==1){
							var cell1 = row.insertCell();
							var cell2 = row.insertCell();
							var cell3 = row.insertCell();
							var cell4 = row.insertCell();
							var cell5 = row.insertCell();
						}else if(c%6==2){
							var cell1 = row.insertCell();
							var cell2 = row.insertCell();
							var cell3 = row.insertCell();
							var cell4 = row.insertCell();
						}else if(c%6==3){
							var cell1 = row.insertCell();
							var cell2 = row.insertCell();
							var cell3 = row.insertCell();
						}else if(c%6==4){
							var cell1 = row.insertCell();
							var cell2 = row.insertCell();
						}else if(c%6==5){
							var cell1 = row.insertCell();
						}
				}
			},
			error : function() {
				alert("出现异常啦...");
			}
		});
	}
	//清除
	function clearSystem(){
		window.location.reload();
	}
	//下载
	function systemDownload(){
		if(isFlag==true||num==0){
			alert("还没有选择文件哦~");
			return;
		}
		var data=arr.join(",");
		$("#systemId").val(data);
		$("#systemFormDownload").attr("action","${base}/systemcentergl/systemDownload");
		$("#systemFormDownload").submit();
	}
	
	//打印
	function systemPrint(){
		
	}
	
	
	//预览PDF  和     多选  选中 样式改变
	function openPDF(fileName,attId,t){
		//预览pdf
		if(isFlag==true){
			//window.open(base+'/systemcentergl/viewPDF/'+fileName,'open');
			window.open(base+'/systemcentergl/viewPDF?systemId='+attId,'open');
		}else{
			//多选  选中判断  样式
			var color1=$(t).children(":first").css("background-color");
			var color2="rgb(208, 208, 208)";
			var sId=$(t).children(".div_bottom").children(".systemId").html();
			if(color1==color2){
				//判断该文件是否已经选择
				if(arr.length>0){
					if(arr.indexOf(sId)!=-1){
						alert("该文件已选择！");
						return;
					}
				}
				arr.push(sId);
				
				$(t).children(":first").css("background-color","#A0C1FF");
				num++;
				$("#totalNum").text(num);
				
			}else{
				$(t).children(":first").css("background-color","#D0D0D0");
				removeElement(arr,sId);
				num--;
				$("#totalNum").text(num);
			}
			
		}
	}
	//自定义删除数组元素
	function removeElement(arr,val){
		var num=arr.indexOf(val);
		if(num!=-1){
			arr.splice(num,1);
		}
	}
	
	//----多选---
	function multipleChoice(){
		if(isFlag==true){
			alert("请单击选择文件！");
			//清除鼠标样式
			$(".tab2_div").removeAttr("onmousemove");
			$(".tab2_div").removeAttr("onmouseout");
			$(".div_top").css("background-color","#D0D0D0");
			// 选择数量的 div 
			$("#searchNum").css("display","block");
			isFlag=false;
		}else{
			$(".tab2_div").attr("onmousemove","bigTopColor(this)");
			$(".tab2_div").attr("onmouseout","normalTopColor(this)");
			$(".div_top").css("background-color","#E2ECFF");
			$("#searchNum").css("display","none");
			isFlag=true;
			num=0;
			arr=[];
			$("#totalNum").text(num);
		}
		
	}
	
	//鼠标悬浮样式
	function bigTopColor(t){
		$(t).children(":first").css("background-color","#A0C1FF");  
	}
	function normalTopColor(t){
		if(isFlag==false){
			$(t).children(":first").css("background-color","#D0D0D0");
		}else{
			$(t).children(":first").css("background-color","#E2ECFF");
		}
	} 
	//时间格式化
	function getTime(val) {
		var t, y, m, d;
		if (val == null) {
			return "";
		}
		t = new Date(val);
		y = t.getFullYear();
		m = t.getMonth() + 1;
		d = t.getDate();
		
		// 可根据需要在这里定义时间格式  
		return y + '年' + (m < 10 ? '0' + m : m) + '月'
				+ (d < 10 ? '0' + d : d) + '日';
	}
	//浏览量
	function getClicks(num){
		if(num==null){
			return 0;
		}
		return num;
	}
	
	//标题跑马灯
	/*function marqueeInit(){
	    var title=document.title;
	    var arr=title.split("");
	    var e=arr.shift();
	    arr.push(e);
	    var marquee=arr.join("");
	    document.title=marquee;
	    window.setTimeout("marqueeInit()",1000);
	}
	window.onload=marqueeInit;
	*/
	</script>
</body>
</html>

