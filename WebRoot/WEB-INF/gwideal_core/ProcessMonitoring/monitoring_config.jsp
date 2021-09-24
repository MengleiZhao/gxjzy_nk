<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<style type="text/css">
.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.textbox-text{color:#666666;height: 25px; line-height: 25px}
.style1{color: red;height: 40px;}
.numberbox .textbox-text {text-align: left;}
.tabDiv{padding:10px;}
.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
.span{font-size: 12px;color: #666666;font-family: "微软雅黑"}
.td1{width: 100px;}
.td2{height: 30px;width: 150px;}
.trtop{height: 10px;}
.trbody{height: 30px;}

.title{}
.apptest{width: 80px;text-align: center;height: 46px;background: url('${base}/resource-modality/${themenurl}/skin_/liuchenyuandian.png');}
.ab{width: 138px;height: 46px;text-align: center;background:url('${base}/resource-modality/${themenurl}/skin_/liuchenweidinyi.png')no-repeat;}
.shenpi{width: 80px;height: 46px;text-align: center;background:url('${base}/resource-modality/${themenurl}/skin_/caiwushendingkongbai.png')no-repeat;}
</style>  
	<script type="text/javascript">
    var c=0;
	//附件上传
	function upFile() {
		var url = $("#f").val();
		var urlli = url.split(',');
		var fAssType= "ZCLX-01";
		for(var i=0; i< urlli.length; i++){
			var fileurl=urlli[i];
			var filename = fileurl.split('\\');
			$('#tdf').append(
				"<div style='margin-top: 10px;'>"+
					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
					"&nbsp;&nbsp;&nbsp;&nbsp;"+
					"<img id='imgt"+c+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
					"<img id='imgf"+c+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+fileurl+"' class='fileUrl' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
			);
			c++;
			fileurl = encodeURI(encodeURI(fileurl));
			$.ajax({
				async:false,
				type:"POST",
		        url:base+"/Storage/storageFile?fileurl="+fileurl,
		        data:{"fAssType":fAssType},
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
		var filename = a.id;
		var fAssType= $("#S_fAssType").val();
		filename = encodeURI(encodeURI(filename));  
		$.ajax({
			type:"POST",
	        url:base+"/Storage/storageFileDelete?filename="+filename,
	        data:{"fAssType":fAssType},
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
		function MCAddEditForm(){
			$('#MCAddEditForm').form('submit', {
				onSubmit: function(){ 
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				//data:{'FPId':$('#TPD_FPId').val()},
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#MCAddEditForm').form('clear');
   						$("#wf_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});		
		}
		function TPDFormSS(){
			$('#MCAddEditForm').form('submit', {
   				onSubmit: function(){ 
   					
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				
   				//url:base+'/demo/save',
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#MCAddEditForm').form('clear');
   						$("#wf_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						$('#MCAddEditForm').form('clear');
   					}
   				} 
   			});		
		}
		
		function depart(){
			var win=creatFirstWin('原配置单号',840,450,'icon-search','/wflow/departCodeList');
			win.window('open');
		}
		function fTransUser(){
			var win=creatFirstWin('姓名部门',840,450,'icon-search','/Alloca/nameAndDept');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#wf_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		
		
	</script>
    <div class="easyui-layout" fit="true" style="color: #333333">
   		<div data-options="region:'north',split:true"style="width: 100%;height:370px;border-color: dce5e9" id="westDiv">
	   		<div>
	   		<form id="MCAddEditForm" action="${base}/wflow/tNodeConfSave" method="post" data-options="novalidate:true" enctype="multipart/form-data">
	   			<div style="width:190px;margin-top:20px;margin-left: 20px;border:1px #dce5e9 solid;float: left;">
					<div>
						<span style="margin-top: 50px;margin-left: 20px;font-size: 14px;font-family:'微软雅黑';font-weight: bold;" >${FPName }</span><br><br>
						<span style="margin-left: 20px;">1.本功能用于展示工作流，可以通过右侧添加编辑审批人，新增审批节点一级删除审批节点</span><br><br>
						<span style="margin-left: 20px;">2.审批角色配置后即可生效，流程节点修改后需要保存更新生效</span><br><br>
						<span style="margin-left: 20px;">3.流程修改后新产生的数据才会按照新流程流转</span>
					</div>
				</div>
				<div style="width:540px;margin-top:20px;margin-right:20px;border:1px #dce5e9 solid;float: right;">
	   				<input type="hidden" name="Idkey" id="TPD_FPId" value="${idkey}"/>
					<table id="newDg"  style="margin-top:20px;margin-left:20px;margin-bottom: 20px;" border="0" cellpadding="0" cellspacing="0">
						<tbody>
						<tr id="da">
							<td style="height: 33px;width: 78px"><img style="vertical-align:bottom;height: 34px" src="${base}/resource-modality/${themenurl}/skin_/tijiaoren1.png"></td>
							<td ><a onclick="app()" ><img style="vertical-align:bottom;margin-left:20px;" src="${base}/resource-modality/${themenurl}/skin_/liuchentianjia1.png"></a></td>
							<td></td>
							<td></td>
							<td></td>
							<%-- <td ><img style="vertical-align:bottom;margin-left:0px;" src="${base}/resource-modality/${themenurl}/skin_/dianjicaiwushending.png"></td> --%>
						</tr>
						<c:if test="${openType=='edit'}">
							<c:forEach items="${TNC}" var="bean1" varStatus="i">
								<tr>
									<td class='apptest'>${bean1.number}</td>
									<td class="ab" style="width: 138px;height: 46px;"><input type='hidden' name='c' id='TNC_FNId${i.count }' value='${bean1.FNId}'/><span id='sb${i.count }' style="color: #ffffff">${bean1.pid.name}</span></td>
									<td ><a onclick="nameDepart(this)"><img style="vertical-align:bottom;margin-right: 10px;" src="${base}/resource-modality/${themenurl}/skin_/liuchenxiugai.png"></a></td>
									<td><a onclick="nextadd(${i.count})"><img style="vertical-align:bottom;margin-right: 10px;" src="${base}/resource-modality/${themenurl}/skin_/liuchentianjia.png"><a></a></td>
									<td><a onclick="deleteName(this)"><img style="vertical-align:bottom;margin-right: 10px;" src="${base}/resource-modality/${themenurl}/skin_/liuchensanchu.png"></a>
										<input type="hidden" name="b" value="${bean1.pid.id}" id="TNC_pid${i.count }" />
										<input type="hidden" name="departId" value="${bean1.departId}" id="TNC_departId${i.count }" />
										<input type="hidden" name="departName" value="${bean1.departName}" id="TNC_departName${i.count }" />
										<input value="${bean1.FNName}" type="hidden" name="FNName" id="TNC_FNName${i.count }" />
									</td>
									<%-- <td style="text-align: center;width: 20px;height: 46px;"><input <c:if test="${bean1.FNName=='财务审定'}">checked="checked"</c:if> style="margin-top: 8px;" onclick="finance(this)" type="radio" name="fIsAuthor" ><input value="${bean1.FNName}" type="hidden" name="FNName" id="TNC_FNName${i.count }" /></td> --%>
								</tr> 
							</c:forEach>
						</c:if>
						<tr >
							<td style="height: 33px;width: 78px"><img style="vertical-align:bottom;height: 34px" src="${base}/resource-modality/${themenurl}/skin_/liuchenjieshu1.png"></td>
							<td></td>
						</tr>
						</tbody>
					</table>
				</div>
			   	</form>
			</div>
		</div>
		<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
			<div style="text-align: center;">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="MCAddEditForm();">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	</div>	
	<script type="text/javascript">
	function app(){
		 var tb = document.getElementById("newDg"); 
		 var rowsnumber=tb.rows.length-1;
         var newTr = tb.insertRow(rowsnumber);//添加新行，trIndex就是要添加的位置 
         var newTd1 = newTr.insertCell(); 
         newTd1.className="apptest";
         newTd1.innerHTML = "<td id='apptest'>"+rowsnumber+"</td>";
         var newTd2 = newTr.insertCell(); 
         newTd2.innerHTML ="<td class='ab' style='width: 138px;height: 46px;'><input type='hidden' name='c' id='TNC_FNId"+rowsnumber+"' value='${bean.FNId}'/><span id='sb"+rowsnumber+"' style='color: #ffffff'>未定义</span></td>"; 
         newTd2.className="ab";
         var newTd5 = newTr.insertCell(); 
         newTd5.innerHTML ="<a onclick='nameDepart(this)'><td style='width: 78px;height: 46px;'><img  style='vertical-align:bottom;margin-right: 10px;' src='"+base+"/resource-modality/${themenurl}/skin_/liuchenxiugai.png'></a></td>"; 
         var newTd3 = newTr.insertCell(); 
         newTd3.innerHTML ="<a onclick='nextadd("+rowsnumber+")'><td style='width: 78px;height: 46px;'><img style='vertical-align:bottom;margin-right: 10px;' src='"+base+"/resource-modality/${themenurl}/skin_/liuchentianjia.png'></a></td>"; 
         var newTd4 = newTr.insertCell(); 
         newTd4.innerHTML ="<td style='width: 78px;height: 46px;'><a onclick='deleteName(this)'><img style='vertical-align:bottom;margin-right: 10px;' src='"+base+"/resource-modality/${themenurl}/skin_/liuchensanchu.png'></a><input type='hidden' name='b' id='TNC_pid"+rowsnumber+"' />"
         +"<input type='hidden' name='departId' id='TNC_departId"+rowsnumber+"' /><input type='hidden' name='departName' id='TNC_departName"+rowsnumber+"' /><input type='hidden' name='FNName' value=' ' id='TNC_FNName"+rowsnumber+"' /></td>"; 
        // var newTd6 = newTr.insertCell(); 
        // newTd6.innerHTML ="<td style='text-align: center;width: 78px;height: 46px;'><input style='margin-top: 8px;margin-left: 57px' onclick='finance(this)' type='radio' name='fIsAuthor' ><input type='hidden' name='FNName' value=' ' id='TNC_FNName"+rowsnumber+"' /></td>"; 
	}
	//选择流程节点处理人
	function nameDepart(rowsnumber){
		//console.log($(rowsnumber).parent('td').siblings('td')[0].innerHTML)
		var win=creatFirstWin('选择流程节点处理人',840,450,'icon-search','/wflow/nameDepartRole?id='+$(rowsnumber).parent('td').siblings('td')[0].innerHTML);
		win.window('open');
	}
	//在下个节点添加
	function nextadd(obj){
		//console.log(obj)
		var tb = document.getElementById("newDg"); 
		var rowsnumber=obj+1;
        var newTr = tb.insertRow(rowsnumber);//添加新行，trIndex就是要添加的位置 
        var newTd1 = newTr.insertCell(); 
        newTd1.className="apptest";
        newTd1.innerHTML = "<td id='nihao'>"+rowsnumber+"</td>";
        var newTd2 = newTr.insertCell(); 
        newTd2.innerHTML ="<td class='ab' style='width: 138px;height: 46px;'><input type='hidden' name='c' id='TNC_FNId"+rowsnumber+"' value='${bean.FNId}'/><span id='sb"+rowsnumber+"' style='color: #ffffff'>未定义</span></td>"; 
        newTd2.className="ab";
        var newTd5 = newTr.insertCell(); 
        newTd5.innerHTML ="<a onclick='nameDepart(this)'><td style='width: 78px;height: 46px;'><img  style='vertical-align:bottom;margin-right: 10px;' src='"+base+"/resource-modality/${themenurl}/skin_/liuchenxiugai.png'></a></td>"; 
        var newTd3 = newTr.insertCell(); 
        newTd3.innerHTML ="<a onclick='nextadd("+rowsnumber+")'><td style='width: 78px;height: 46px;'><img style='vertical-align:bottom;margin-right: 10px;' src='"+base+"/resource-modality/${themenurl}/skin_/liuchentianjia.png'></a></td>"; 
        var newTd4 = newTr.insertCell(); 
        newTd4.innerHTML ="<td style='width: 78px;height: 46px;'><a onclick='deleteName(this)'><img style='vertical-align:bottom;margin-right: 10px;' src='"+base+"/resource-modality/${themenurl}/skin_/liuchensanchu.png'></a><input type='hidden' name='b' id='TNC_pid"+rowsnumber+"' />"
        +"<input type='hidden' name='departId' id='TNC_departId"+rowsnumber+"' /><input type='hidden' name='departName' id='TNC_departName"+rowsnumber+"' /><input type='hidden' name='FNName' value=' ' id='TNC_FNName"+rowsnumber+"' /></td>"; 
      //  var newTd6 = newTr.insertCell(); 
       // newTd6.innerHTML ="<td style='text-align: center;width: 78px;height: 46px;'><input style='margin-top: 8px;margin-left: 57px' onclick='finance(this)' type='radio' name='fIsAuthor' ><input type='hidden' name='FNName' value=' ' id='TNC_FNName"+rowsnumber+"' /></td>"; 
		//重新拍一下序号
        var tr=$('#newDg').children().children();
		for (var int = 1; int < tr.length-1; int++) {
			var c = $(tr[int]).children();
			c[0].innerHTML=(int);
			($(c[1]).children())[0].id="TNC_FNId"+int;
			($(c[1]).children())[1].id="sb"+int;
			($(c[4]).children())[1].id="TNC_pid"+int;
			($(c[4]).children())[2].id="TNC_departId"+int;
			($(c[4]).children())[3].id="TNC_departName"+int;
			($(c[5]).children())[1].id="TNC_FNName"+int;
			
		}
	}
	//删除
	function deleteName(obj){
		$(obj).parent().parent().remove();  
		var tr=$('#newDg').children().children();
		//重新拍一下序号
		for (var int = 1; int < tr.length-1; int++) {
			var c = $(tr[int]).children();
			c[0].innerHTML=(int);
			($(c[1]).children())[0].id="TNC_FNId"+int;
			($(c[1]).children())[1].id="sb"+int;
			($(c[4]).children())[1].id="TNC_pid"+int;
			($(c[4]).children())[2].id="TNC_departId"+int;
			($(c[4]).children())[3].id="TNC_departName"+int;
			($(c[5]).children())[1].id="TNC_FNName"+int;
		}
	}
	
	function finance(obj){
		//选中的下个input属性
		var danxuan = $('input[type=radio][name="fIsAuthor"]:checked')[0].nextSibling;
		var id=danxuan.id;
		danxuan.value="财务审定";
		var radio = document.getElementsByName("fIsAuthor");
		for (var int = 0; int < radio.length; int++) {
			if(radio[int].nextSibling.id!=id){
				radio[int].nextSibling.value="";
			}
		}

		/* var id=obj.nextSibling.id;
		var n=$(obj).parent('td').siblings('td')[0].innerHTML
		var v=$('#'+id).val();
		//console.log($(obj).parent('td')[0].style.background);
		if(v==null||v==""){
			$('#'+id).val("财务审定");
			(obj.children)[0].src=base+"/resource-modality/${themenurl}/skin_/yisheweicaiwushending1.png";
			var tr=$('#newDg').children().children();
			 for (var int = 1; int < tr.length-1; int++) {
				if(int!=n){
					var c = $(tr[int]).children();
					(($(c[5]).children())[0]).children[0].src="";
					/* c[5].style.backgroundImage="";
				}
			 }
		}else{
			$('#'+id).val(null);
			//(obj.children)[0].src=base+"/resource-modality/${themenurl}/skin_/caiwushending1.png";
			 var tr=$('#newDg').children().children();
			 for (var int = 1; int < tr.length-1; int++) {
					var c = $(tr[int]).children();
					(($(c[5]).children())[0]).children[0].src=base+"/resource-modality/${themenurl}/skin_/caiwushending1.png";
			 }
		} */
		
	}
	
	$(function(){
		
		
	});
	var c1 =0;
	function upFile1() {
		c1 ++;
		var src = $('#a_fFileSrc1').val();
		$('#fi1').val(src);
		$('#S_a_f1').append("<div id='c1"+c1+"'><a href='#' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c1"+c1+")'>删除</a></div>");
	} 
	function deleteF1(val){
		var child=document.getElementById(val.id);
		child.parentNode.removeChild(child);
	}
		var names = new Array();
		function streetChange(streetCode){
			$('#userStreetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
		}
		function departSelect(selectType){
			var win=creatSearchDataWin('选择-部门',590,400,'icon-add',"/depart/refUserDepart/"+selectType);
		    win.window('open');
		} 
		function departReturnSelect(ret){
			if (ret == "clear") {
		       $("#user_depart").html("");
			}

		    if (ret!="&&&&" && ret != undefined && ret != null && ret.indexOf("&&") != -1 && ret != "cancel") {
		    	var retArray = ret.split("&&");
		        var str= new Array(); 
		       	str=retArray[2].split(","); 
		       	for(var i=0;i<str.length-1 ;i++){
		       		if(null!=str[i]){
		       			var str1= new Array();
		       			str1=str[i].split(":");
		       			var div1 = $("#user_depart");
		       			if(!isUserTreeExist(str1[0]) && !isUserTreeExist(str1[1])){
							names.push(str1[0]);	
							div1.html("<div  style='float:left;margin-left:8px;margin-top:8px;' > "+
										"<input type='hidden' name='depart.id' id='departIds' value='"+str1[0]+"'/>"+
										"<span title='"+str1[1]+"'>"+((str1[1].length>8)?str1[1].substring(0,8)+"...":str1[1])+"</span>"+
										"<img src='${base}/resource/images/cancelDepart.jpg' style='cursor:pointer;margin-left:5px;height:15px;width:15px;' onclick = 'cancelUserDepart(this)' title='删除' id='"+str1[0]+"'/>"+
										"</div>");
						}
		       		}
		       	}
		    }
		}
		function isUserTreeExist(name){
			for(var i=0; i<names.length; i++){
				if(names[i] == name){
					return true;
				}
			}
			return false;
		}
		function deleteCF(){
			var row = $('#CS_dg').datagrid('getSelected');
			var selections = $('#wf_dg').datagrid('getSelections');
				if(confirm("确认删除吗？")){
					$.ajax({ 
						type: 'POST', 
						url: '${base}/Formulation/delete/'+row.fcId,
						dataType: 'json',  
						success: function(data){ 
							if(data.success){
								$.messager.alert('系统提示',data.info,'info');
								$("#wf_dg").datagrid('reload');
							}else{
								$.messager.alert('系统提示',data.info,'error');
							}
						} 
					}); 
				}
		}
		function cancelUserDepart(obj){
			var id=obj.id;
			if(names.length>0)
			{
				for(i=0; i<names.length; i++){
					if(names[i] == id){
						names.splice(i,1);
					}
				}
			}
			$(obj).parent().remove();
		}
		function checkMobileNo(){
			var mobile=$("#user_edit_mobileNo").textbox("getValue");
			var id=$("#user_edit_id").val();
			var tag="0";
			if(mobile!=''){
				 $.ajax({
		  			   type : "post",
		  			   url : "${base}/user/mobileCheck",
		  			   data:{"mobileNo":mobile,"id":id},
		  			   dataType: 'json',  
					   async: false,
		  			   success : function(data){
		  				   if(data.success){ 	
		  			   	     $.messager.alert('系统提示', "手机号在系统中已存在，请更换手机号！", 'info');
		  			   	     tag="1";
		  			   	   }else{
		  			   		 tag="0"; 
		  			   	   }  
		  			   }
		  		   })
			}
			 if(tag=="0"){
		    	return true; 
		     }else if(tag=="1"){
		    	return false; 
		     }
		}
	</script>
</body>
</html>

