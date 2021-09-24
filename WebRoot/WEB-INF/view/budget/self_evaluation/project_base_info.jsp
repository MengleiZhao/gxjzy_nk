<%@ page language="java" pageEncoding="UTF-8"%>
<style type="text/css">
.style_must{
	color:red
}
</style>
<!-- hidden -->
<input type="hidden" name="FProId" value="${bean.FProId }"/>
<input id="path_pro_acco" type="hidden" name="lxyjFiles"/>
<input id="path_pro_plan" type="hidden" name="ssfaFiles"/>
<input id="path_pro_FAccoAttName" type="hidden" name="FAccoAttName" value="${bean.FAccoAttName }"/>
<input id="path_pro_FPlanAttName" type="hidden" name="FPlanAttName" value="${bean.FPlanAttName }"/>
<!-- 审批状态 -->
<input id="" type="hidden" name="FFlowStauts" value="${bean.FFlowStauts}"/>
<!-- <input id="" type="hidden" name="" value=""/> -->

<table class="ourtable" border="0" style="width:540px">
     			<tr class="trbody">
     				<td class="td1"><span class="style_must">*</span>项目名称
     				</td>
     				<td class="td2" colspan="4" >
     					<input id="project_add_FProName" name="FProName" class="easyui-textbox" style="height: 30px;width:435px"
     					data-options="required:false" readonly="readonly" prompt="请输入项目名称" value="${bean.FProName }">
     				</td>
   				<tr>
     				<td class="td1">&nbsp;&nbsp;项目编号
     				</td>
     				<td class="td2" colspan="4">
     					
     					<input class="easyui-textbox" data-options="required:false" readonly="readonly" 
     					style="height: 30px;width:435px" name="FProCode" 
	     					<c:if test="${operation=='add'}">
	     						value="${projectCode }"
	     					</c:if>
	     					<c:if test="${operation!='add'}">
	     						value="${bean.FProCode }"
	     					</c:if>
     					/>
     					
     				</td>
   				</tr>
     			<tr class="trbody">
     				<td class="td1"><span class="style_must" >*</span>项目类型</td>
     				<td class="td2">
     					<input id="project_add_FProType" name="FProType.code"  class="easyui-combobox" style=" height: 30px;width:150px;" readonly="readonly"
						data-options="url:'${base}/lookup/lookupsJson?parentCode=PRO-TYPE&selected=${bean.FProType.code }',method:'get',valueField:'code',textField:'text',editable:false"/>
     				</td>
     				<td class="td-leap"></td>
     				<td class="td1"><span class="style_must">*</span>项目预算金额</td>
     				<td class="td2">
     					<input class="easyui-numberbox" readonly="readonly" style="height: 30px;width:150px" data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]"
     					precision="2"
     					id="pro_add_FProBudgetAmount" name="FProBudgetAmount" value="${bean.FProBudgetAmount }"/>
     				</td>
     			</tr>
     			<tr class="trbody">
     				<td class="td1"><span class="style_must">*</span>是否采购${bean.FProcurementYn}</td>
     				<td class="td2">
     					<input type="radio" onclick="changeCgjeInput()" disabled="disabled" style="width:10px" name="FProcurementYn" value="1" <c:if test="${bean.FProcurementYn==1 }">checked="checked"</c:if>/>是
     					<input type="radio" onclick="changeCgjeInput()" disabled="disabled" style="width:10px" name="FProcurementYn" value="0" <c:if test="${bean.FProcurementYn==0 or empty bean.FProcurementYn}">checked="checked"</c:if>/>否
     				</td>
     				<td class="td-leap"></td>
     				<td class="td1" id="th_cgje"><span class="style_must">*</span>采购金额</td>
     				<td class="td2" id="td_cgje" >
     					<input class="easyui-numberbox" readonly="readonly" id="input_cgje" data-options="iconWidth: 30,icons: [{iconCls:'icon-wanyuan',handler: function(e){}}]" 
     					name="FProcurementAmount" value="${bean.FProcurementAmount }" precision="2">
     				</td>
     			</tr>
     			<tr class="trbody">
     				<td class="td1">&nbsp;&nbsp;项目负责人</td>
     				<td class="td2">
     					<div ondblclick="chooseXmfzr()">
      					<input class="easyui-textbox" style="height: 30px;width:150px"  data-options="required:false" readonly="readonly"
      					id="project-add-FProHead" name="FProHead" prompt=""  value="${bean.FProHead }"
      					>
     					</div>
     				</td>
     				<td class="td-leap"></td>
     				<td class="td1"><span class="style_must">*</span>申报人
     				</td>
     				<td class="td2">
     					<input class="easyui-textbox" style="height: 30px;width:150px"  data-options="required:false"  readonly="readonly"
     					id="project-add-FProAppliPeople"  name="FProAppliPeople" value="${sbr }" readonly="readonly">
     				</td>
     			</tr>
     			<tr class="trbody">
     				<td class="td1"><span class="style_must">*</span>申报部门</td>
     				<td class="td2">
     					<div ondblclick="">
     						<input class="easyui-textbox" style="height: 30px;width:150px"  data-options="required:false" readonly="readonly" name="FProAppliDepart" prompt=""
     						value="${sbbm }" readonly="readonly">
     					</div>
     				</td>
     				<td class="td-leap"></td>
     				<td class="td1">&nbsp;&nbsp;项目申报年份</td>
     				<td class="td2">
     					<input class="easyui-textbox" style="height:30px;width:150px"  data-options="required:false" readonly="readonly" name="FProAppliTime" value="${sbsj }" prompt="" readonly="readonly">
     				</td>
     			</tr>
     			<tr class="trbody">
     				<td class="td1">&nbsp;&nbsp;是否持续性项目</td>
     				<td class="td2">
     					<input type="radio" disabled="disabled" style="width:10px" name="FContinuousYn" value="1" <c:if test="${bean.FContinuousYn==1 }"> checked="checked"</c:if>/>是
     					<input type="radio" disabled="disabled" style="width:10px" name="FContinuousYn" value="0" <c:if test="${bean.FContinuousYn==0 }"> checked="checked"</c:if>/>否
     				</td>
     				<td class="td-leap"></td>
     				<td class="td1">&nbsp;&nbsp;项目属性</td>
     				<td class="td2">
     					<select class="easyui-combobox" style="height: 30px;width:150px"  data-options="required:false" readonly="readonly" name="FProAttribute" >
     						<option value="" >-请选择-</option>
     						<option value="1" <c:if test="${bean.FProAttribute==1 }"> selected="selected"</c:if>>部门预算项目</option>
     						<option value="2" <c:if test="${bean.FProAttribute==2 }"> selected="selected"</c:if>>省直专项</option>
     						<option value="3" <c:if test="${bean.FProAttribute==3 }"> selected="selected"</c:if>>省对下转移支付项目</option>
     					</select>
     				</td>
     			</tr>
     			<tr class="trbody">
     				<td class="td1">&nbsp;&nbsp;项目预算周期</td>
     				<td class="td2">
     					<select class="easyui-combobox" style="height: 30px;width:150px"  data-options="required:false" readonly="readonly" name="FProBudgetCycle" >
     						<option value="">-请选择-</option>
     						<option value="1" <c:if test="${bean.FProBudgetCycle==1 }"> selected="selected"</c:if>>年</option>
     						<option value="2" <c:if test="${bean.FProBudgetCycle==2 }"> selected="selected"</c:if>>月</option>
     						<option value="3" <c:if test="${bean.FProBudgetCycle==3 }"> selected="selected"</c:if>>季度</option>
     					</select>
     				</td>
     				<td class="td-leap"></td>
     				<td class="td1">&nbsp;&nbsp;滚动周期</td>
     				<td class="td2">
     					<input class="easyui-numberbox" style="height: 30px;width:150px"  data-options="required:false" readonly="readonly" name="FProRollingCycle" value="${bean.FProRollingCycle }" prompt="">
     				</td>
     			</tr>
     			<tr class="trbody">
     				<td class="td1"><span class="style_must" >*</span>项目类别</td>
     				<td class="td2">
     					<select id="project_add_FProClass"  style="height: 30px;width:150px" class="easyui-combobox" readonly="readonly" data-options="required:false" name="FProClass" >
     						<option value="">-请选择-</option>
     						<option value="1" <c:if test="${bean.FProClass==1 }"> selected="selected"</c:if>>常规性项目</option>
     						<option value="2" <c:if test="${bean.FProClass==2 }"> selected="selected"</c:if>>一次性跨年项目</option>
     						<option value="3" <c:if test="${bean.FProClass==3 }"> selected="selected"</c:if>>一次性非跨年项目</option>
     					</select>
     				</td>
     				<td class="td-leap"></td>
     				<td class="td1"><!-- &nbsp;&nbsp;项目序号 --></td>
     				<td class="td2">
     					<%-- <input class="easyui-numberbox" data-options="required:false" name="FProNum" value="${bean.FProNum }" prompt=""> --%>
     				</td>
     			</tr>
     			<tr class="trbody">
     				<td class="td1">&nbsp;&nbsp;是否开始执行</td>
     				<td class="td2" >
     					<input type="radio" disabled="disabled" style="width:10px" name="FIsExecute" value="1" <c:if test="${bean.FIsExecute==1 }"> checked="checked"</c:if>/>是
     					<input type="radio" disabled="disabled" style="width:10px" name="FIsExecute" value="0" <c:if test="${bean.FIsExecute==0 }"> checked="checked"</c:if>/>否
     				</td>
     				<td class="td-leap"></td>
     				<td class="td1">&nbsp;&nbsp;是否置顶</td>
     				<td class="td2">
      				<input type="radio" disabled="disabled" style="width:10px" name="FExt2" value="1" <c:if test="${bean.FExt2==1 }"> checked="checked"</c:if>/>是
      				<input type="radio" disabled="disabled" style="width:10px" name="FExt2" value="99" <c:if test="${bean.FExt2!=0 }"> checked="checked"</c:if>/>否
     				</td>
     			</tr>
     			<tr class="trbody">
     				<td class="td1">立项依据</td>
     				<td class="td2" colspan="4">
     					<input class="easyui-textbox" style="width:435px;height:95px" readonly="readonly"
     					 data-options="multiline:true,required:false" name="FProAccording" value="${bean.FProAccording }">
     				</td>
     			</tr>
     			<tr class="trbody">
					<td class="td1">
						立项依据附件
						<input type="file" multiple="multiple" id="f1" onchange="upFile1()" hidden="hidden">
						<input type="text" id="files1" name="lxyjFiles" hidden="hidden">
					</td>
					<td colspan="5" id="tdf1">
						<c:if test="${operation!='detail' }">
						<a onclick="$('#f1').click()" style="font-weight: bold;" href="#">
							<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/shangchuan2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/shangchuan1.png')"
							/> 
						</a>
						</c:if>
						<c:forEach items="${attaList1}" var="att">
							<div style="margin-top: 10px;">
								<a href='#' style="color: #666666;font-weight: bold;">${att.FAttacName}</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="${base}/resource-modality/${themenurl}/sccg.png">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a id="${att.FAttacName}" class="fileUrl1" href="#" style="color:red" onclick="deleteAttac1(this)">删除</a>
							</div>
						</c:forEach>
					</td>
				</tr>
	  			<tr class="trbody">
	  				<td class="td1">实施方案</td>
	  				<td class="td2" colspan="4">
	  					<input class="easyui-textbox" style="width:435px;height:95px" readonly="readonly"
	  					 data-options="multiline:true,required:false" name="FExplain" value="${bean.FExplain }"/>
	  				</td>
	  			</tr>
	  			<tr class="trbody">
				<td class="td1">
					实施方案附件
					<input type="file" multiple="multiple" id="f2" onchange="upFile2()" hidden="hidden">
					<input type="text" id="files2" name="ssfaFiles" hidden="hidden">
				</td>
				<td colspan="5" id="tdf2">
					<c:if test="${operation!='detail' }">
					<a onclick="$('#f2').click()" style="font-weight: bold;" href="#">
						<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
							onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/shangchuan2.png')"
							onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/shangchuan1.png')"
						/> 
					</a>
					</c:if>
					<c:forEach items="${attaList2}" var="att">
						<div style="margin-top: 10px;">
							<a href='#' style="color: #666666;font-weight: bold;">${att.FAttacName}</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="${base}/resource-modality/${themenurl}/sccg.png">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a id="${att.FAttacName}" class="fileUrl2" href="#" style="color:red" onclick="deleteAttac2(this)">删除</a>
						</div>
					</c:forEach>
				</td>
			</tr>
</table>
<script type="text/javascript">
$(function(){
	changeCgjeInput();
})

//显示/隐藏 采购金额 输入框
function changeCgjeInput(){
	var sfcg = 	$('input:radio[name="FProcurementYn"]:checked').val();
	if(sfcg==0){
		$('#th_cgje').hide();
		$('#td_cgje').hide();
	}else if(sfcg==1){
		$('#th_cgje').show();
		$('#td_cgje').show();
	}
}

function test06192117(){
	/* var win=creatFirstWin('选择-项目负责人',600,550,'icon-search','/project/toChooseKm');
	win.window('open'); */
	alert('test');
}
//设置附件信息
function setAccoFile(){
	var s="";
	$(".fileUrl1").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files1").val(s);
}
function setPlanFile(){
	var s="";
	$(".fileUrl2").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files2").val(s);
}

//附件上传
var c1=0;
function upFile1() {
	var url = $("#f1").val();
	var urlli = url.split(',');
	for(var i=0; i< urlli.length; i++){
		var fileurl=urlli[i];
		var filename = fileurl.split('\\');
		$('#tdf1').append(
			"<div style='margin-top: 10px;'>"+
				"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<img id='imgt1"+c1+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
				"<img id='imgf1"+c1+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+fileurl+"' class='fileUrl1' href='#' style='color:red' onclick='deleteAttac1(this)'>删除</a><div>"
		);
		c1++;
		fileurl = encodeURI(encodeURI(fileurl));
		$.ajax({
			async:false,
			type:"POST",
	        url:base+"/project/uploadFile?fileurl="+fileurl+"&type=lxyj",
	        success:function(data){
		    	if($.trim(data)=="true"){
					$('#imgt1'+i).css('display','');
		    	} else {
					$('#imgf1'+i).css('display','');
		    	}
	        }
	    });
	}	
} 
var c2=0;
function upFile2() {
	var url = $("#f2").val();
	var urlli = url.split(',');
	for(var i=0; i< urlli.length; i++){
		var fileurl=urlli[i];
		var filename = fileurl.split('\\');
		$('#tdf2').append(
			"<div style='margin-top: 10px;'>"+
				"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;"+
				"<img id='imgt2"+c2+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
				"<img id='imgf2"+c2+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
				"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+fileurl+"' class='fileUrl2' href='#' style='color:red' onclick='deleteAttac2(this)'>删除</a><div>"
		);
		c1++;
		fileurl = encodeURI(encodeURI(fileurl));
		$.ajax({
			async:false,
			type:"POST",
	        url:base+"/project/uploadFile?fileurl="+fileurl+"&type=ssfa",
	        success:function(data){
		    	if($.trim(data)=="true"){
					$('#imgt2'+i).css('display','');
		    	} else {
					$('#imgf2'+i).css('display','');
		    	}
	        }
	    });
	}	
} 
//附件删除AJAX
function deleteAttac1(a){
	var filename = a.id;
	filename = encodeURI(encodeURI(filename));  
	$.ajax({
		type:"POST",
        url:base+"/proejct/deleteFile?filename="+filename+"&type=lxyj",
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
function deleteAttac2(a){
	var filename = a.id;
	filename = encodeURI(encodeURI(filename));  
	$.ajax({
		type:"POST",
        url:base+"/proejct/deleteFile?filename="+filename+"&type=ssfa",
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
</script>