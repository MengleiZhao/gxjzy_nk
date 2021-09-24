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
        .box {  
            /* .box 默认样式 */  
            margin: 200px 0 0 200px;  
            width: 200px;  
            height: 200px;  
            background-color: orange;  
            /*  
        box-shadow: h-shadow v-shadow blur spread color inset;  
        h-shadow    必需。水平阴影的位置。允许负值。    测试  
            v-shadow    必需。垂直阴影的位置。允许负值。    测试  
            blur    可选。模糊距离。    测试  
            spread  可选。阴影的尺寸。   测试  
            color   可选。阴影的颜色。请参阅 CSS 颜色值。   测试  
            inset   可选。将外部阴影 (outset) 改为内部阴影。  
            */  
            box-shadow: 0 0 50px 0 blue;  
            box-shadow: 210px 0 0 0 blue;  
            box-shadow: 210px 50px 0 0 blue;  
  
            box-shadow: -50px 0 50px 0 blue,  50px 0 50px  0 green;  
        }  
  
        .box:hover {  
            /* 鼠标悬浮时样式 */  
  
        }  
    </style>  
	<script type="text/javascript">
	
		function ESCAddEditForm(){
		/* 	//校验
			var flag = true;
			if($title=="") 
			{
				 alert("请输入科目编号！");
				 flag = false;
				}
				var r = /^\+?[1-9][0-9]*$/;  //判断是否为正整数 
				var flag = true;
			    if(!r.test($('#ExpendStandConf_code').val()) && flag == true){
			    	alert("科目编号请输入正整数！");
			    	flag = false;
			    } 	
			    if(!r.test($('#ExpendStandConf_id').val()) && flag == true){
			    	alert("上级科目编号请输入正整数！");
			    	flag = false;
			    } 	
			
			 */
			$('#ESCAddEditForm').form('submit', {
   				onSubmit: function(){ 
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				/* url:base+'/demo/save',  */
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#ESC_form').form('clear');
   						$("#ESC_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						closeWindow();
   						$('#ESCAddEditForm').form('clear');
   					}
   				} 
   			});		
		}
	</script>
    <div class="easyui-layout" fit="true">
    	<div region="center" border="false">
	    	<form id="ESCAddEditForm" action="${base}/ExpendStandConf/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
				<input type="hidden" name="feId" id="economic_id" value="${bean.feId}"/>
				<table border="0" cellpadding="0" cellspacing="0" class="main_table">
					<tr>
						<th >岗位级别：</th>
						<td >
							<input id="ESC_add_fpLevel" onchange="EL()" class="easyui-textbox" type="text" required="true" name="fpLevel" data-options="validType:'length[1,20]'" size="30" value="${bean.fpLevel}"/>
						</td>
						<th >岗位名称：</th>
						<td >
							<input class="easyui-textbox" type="text" id="ESC_add_fpName" name="fpName"required="required" data-options="validType:'length[1,20]'" size="30" value="${bean.fpName}"/>
						</td>
					</tr>
					<tr>
						<th >开支标准（下限）：</th>
						<td >
							<input class="easyui-textbox" type="text" id="ESC_add_fStandAmountD" name="fStandAmountD" required="required" data-options="validType:'length[1,50]'" size="30" value="${bean.fStandAmountD}"/>
						</td>
						<th >开支标准（上限）：</th>
						<td >
							<input class="easyui-textbox" type="text" id="ESC_add_fStandAmountU" name="fStandAmountU" required="required" data-options="validType:'length[1,50]'" size="30" value="${bean.fStandAmountU}"/>
						</td>
					</tr>
					<tr>
						<th >备注：</th>
						<td colspan="3">
							<input class="easyui-textbox" type="text" id="YB_fRemark" name="fRemark" data-options="validType:'length[1,50]'"  style="width:550px;height:100px" value="${bean.fRemark}"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div region="south" border="false" class="south">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="ESCAddEditForm();">保存</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow();">关闭</a>
		</div>
	</div>
	<script type="text/javascript">
		
		
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
										"</div>")
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

