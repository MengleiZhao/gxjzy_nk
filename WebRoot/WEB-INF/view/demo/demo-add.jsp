<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>

</head>
<body>
	<div class="easyui-layout" fit="true">
		<form id="demo_add_form" action="${base}/demo/save"
			method="post" data-options="novalidate:true" class="easyui-form"
			enctype="multipart/form-data">
			<div region="center" border="false"
				style="background: #fff; border-bottom: 1px solid #ccc;position:relative;">

				<table cellpadding="5" cellspacing="0" class="a_table" width="100%">
				<!-- 隐藏域 -->
				<input type="hidden" name="id" value="${bean.id }"/>
				<input type="hidden" id="attIds" name="attIds">
					<tr>
						<th class="br">名称：</th>
						<td class="br"><div ><input type="text" style="width: 200px;""
							id="demo_add_name" name="name" class="easyui-textbox" value="${bean.name}"
							></input></div>

						</td>
						<th class="br">手机号码：</th>
						<td class="br">
							<input type="text" style="width: 200px;"
							id="demo_add_phoneNumber" name="phoneNumber" class="easyui-numberbox" value="${bean.phoneNumber}"></input>
						</td>
					</tr>
					<!-- 附件操作 start -->
					<tr>
		          		<th>附件：</th>
		          		<td colspan="3" id="tdf">
							<table width="100%" id="copypic" border="0px">
								<tr>
									<td style="border: 0">
										<input type="file" id="f" name="demoFiles" style='width:50%' onchange="doUpload(this)"/> 
										<input type="button" class="button-1" value="添加附件" onclick="addcopy('copypic');" />
										<!-- <input type="button" onclick="deletecopy(this,'copypic')" value="删除附件"/> -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 附件操作 end -->
					<!-- <tr>
						<td>
							<div  id="progressBar" class="easyui-progressbar" data-options="value:0" style="width:150px;"></div>
    						<span id="percentage"></span>
						</td>
					</tr> -->
					
				</table>


			</div>
			<div region="south" border="false"
				style="text-align: center;padding: 2px 2px 2px 2px;">
				<a href="javascript:void(0)" class="easyui-linkbutton"
					iconcls="icon-ok" onclick="saveDemo()">保存</a> <a
					href="javascript:void(0)" class="easyui-linkbutton"
					iconcls="icon-cancel" onclick="closeWindow()">关闭</a>
			</div>
		</form>
	</div>
	
	
	<script type="text/javascript">
	/* $(function(){
		$('#demo_add_name').onclick(function(){
			alert(123)
		})
	})
	window.onload=function(){
		$('#demo_add_name').onclick(function(){
			alert(123)
		})
	} */
	function saveDemo(){
		$('#demo_add_form').form('submit', {
   				onSubmit: function(){ 
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				url:base+'/demo/save', 
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeWindow();
   						$('#demo_add_form').form('clear');
   						$("#demo_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						closeWindow();
   						$('#demo_add_form').form('clear');
   					}
   				} 
   			});		
	}
	function lawHelpaddressSearch(selectType){
		var jdId = $('#lawHelp_add_street').combobox('getValue');
		var jwId = $('#lawHelp_add_streetJwh').combobox('getValue');
		var win=creatSearchDataWin('选择-地址信息',630,450,'icon-add',"/stdAddress/refList?selectType="+selectType+ "&jdId=" + jdId+ "&jwhId=" + jwId);
	    win.window('open');
	} 
	function lawHelpaddressSearch1(ref){
		var ret = ref.split("@");
		$("#law_add_addressId").val(ret[0]);
		$("#lawHelp_add_address").val(ret[1]);
		
		
	}
	 
	//动态增加的文件个数
	var copynum = 1;
	//动态增加添加附件的行
	function addcopy(id){
	    var row,cell,str;
	    row = eval("document.all."+id).insertRow();
		    if(row != null ){
				cell = row.insertCell();
				cell.style="border:0";
				str="<input type=\"file\"  id=\"f"+copynum+"\" name=\"demoFiles\" style='width:50%' onchange='doUpload(this)'><input class=\""+"button-1"+"\" type=\""+"button"+"\" value=\""+"删除附件"+"\" onclick=\"deletecopy(this,'copypic');\">"
				cell.innerHTML=str;
			}
		copynum++;
	}
	//删除附件的行
	function deletecopy(obj,id){
		var rowNum,curRow;
		curRow = obj.parentNode.parentNode;
		rowNum = eval("document.all."+id).rows.length - 1;
		eval("document.all["+'"'+id+'"'+"]").deleteRow(curRow.rowIndex);
		copynum--;
	} 
	
	
	
	function doUpload(obj){
		var formData = new FormData();
		formData.append("demoFiles", obj.files[0]);
		$.ajax({  
	         url: base + '/demo/uploadAtt' ,  
	         type: 'post',  
	         data: formData,  
	         cache: false,
	         processData: false,
	         contentType: false,
	         async: false,
	         dataType:'json',
		    success:function(data){
		    	 if(data.success==true){
				        alert('上传成功!');
			       	 	//放入附件id
			       	 	var attid = data.info;
			       	 	var ids = $('#attIds').val();
			       	 	$('#attIds').val(ids + attid + ',');
		    	} else {
		    		alert('上传失败！');
		    	}
		     },
		     error:function(){
		    	 alert('上传失败！');
		     }
	    });
	}
	
	function progressFunction(evt){
		var curr=evt.loaded;
		var total=evt.total;
		process=curr/total*100;
		//alert(process);
		$('#progressBar').progressbar('setValue',progress);
	}

	</script>

</body>
</html>

