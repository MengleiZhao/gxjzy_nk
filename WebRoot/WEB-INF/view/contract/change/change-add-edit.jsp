<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="window-div">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="合同信息" data-options="collapsible:false" style="overflow:auto;margin-top:10px;">
					<jsp:include page="../change/contract-formulation-base-change.jsp"/>
				</div>
			</div>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="签约方信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				<jsp:include page="../base/contract-formulation-sign-base.jsp"/>
				</div>
			</div>
			<%-- <div id="recePlanId2" hidden="hidden">
			<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
				<div title="采购清单" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				  	<jsp:include page="../change/contract_cg_mingxi_detail_change.jsp" />												
				</div>
			</div>
			</div> --%>
			<%-- <div id="recePlanId" hidden="hidden">
			<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
				<div title="変更后采购清单" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				  	<jsp:include page="../base/contract_cg_mingxi.jsp" />												
				</div>	
			</div>
			</div> --%>
			<div id="filingPlanId2" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="付款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-filing-edit-plan-detail_change.jsp"/>
				</div>
			</div>
			</div>
			<div id="filingPlanId" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="变更后付款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../base/contract-filing-edit-plan.jsp"/>
				</div>
			</div>
			</div>
			<div id="proceedsPlanId2" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="收款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-proceeds-edit-plan-detail_change.jsp"/>
				</div>
			</div>
			</div>
			<div id="proceedsPlanId"  hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="变更后收款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-proceeds-edit-plan-change.jsp"/>
				</div>
			</div>
			</div>
			<!-- 附件信息 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
			<div title="附件信息" data-options="collapsed:false,collapsible:false"
				style="overflow:auto;">		
				<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
					<tr>
						<td class="td1" style="width:55px;text-align: left">
							&nbsp;&nbsp;附件
							<input type="file" multiple="multiple" id="fhtnd" onchange="upladFileMoreParams(this,'fhtnd','htgl01','fhtndprogressNumber','htndpercent','htndtdf','htndfiles','htndprogid','htndfileUrl')" hidden="hidden">
							<input type="text" id="htndfiles" name="files" hidden="hidden">
						</td>
						<td colspan="4" id="htndtdf">
							<a onclick="$('#fhtnd').click()" style="font-weight: bold;" href="#">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
							</a>
							<c:forEach items="${changeAttaList}" var="att">
								<c:if test="${att.serviceType=='fhtnd' }">
									<div style="margin-top: 10px;">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/sccg.png">
										&nbsp;&nbsp;&nbsp;&nbsp;
										<a id="${att.id}" class="htndfileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
									</div>
								</c:if>
							</c:forEach>
							<div id="htndprogid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
								<div id="fhtndprogressNumber" style="background:#3AF960;width:0px;height:10px" >
							 	</div>文件上传中...&nbsp;&nbsp;<font id="htndpercent">0%</font> 
							</div>
						</td>
					</tr>
				</table>
			</div>
			</div>
		</div>
<script type="text/javascript">
flashtab('contract-formulation-add');
$(document).ready(function() {
	
});
//flashtab_pro_add('project-tab');
function flashtab(tabid) {
 var $wrapper = $('#'+tabid),
  $allTabs = $wrapper.find('.tab-content > div'),
  $tabMenu = $wrapper.find('.tab-menu li');
  $line = $('<div class="line"></div>').appendTo($tabMenu);
 
 $allTabs.not(':first-of-type').hide();  
 $tabMenu.filter(':first-of-type').find(':first').width('100%');
 
 $tabMenu.each(function(i) {
   $(this).attr('data-tab', 'tab'+i);
 });
 
 $allTabs.each(function(i) {
   $(this).attr('data-tab', 'tab'+i);
 });
 
 $tabMenu.on('click', function() {
   var dataTab = $(this).data('tab');
   $getWrapper = $(this).closest($wrapper);
   
   $getWrapper.find($tabMenu).removeClass('active');
   $(this).addClass('active');
   
   $getWrapper.find('.line').width(0);
   $(this).find($line).animate({'width':'100%'}, 'fast');
   $getWrapper.find($allTabs).hide();
   $getWrapper.find($allTabs).filter('[data-tab='+dataTab+']').show();
 });
}


var c=0;
$('#F_fcAmount').numberbox({
    onChange:function(newValue,oldValue){
    	$('#F_fcAmountMax').textbox('setValue',convertCurrency(newValue));
    }
});
$('#f_fSignName').textbox({
    onChange:function(newValue,oldValue){
    	if(newValue=='' || newValue==undefined){
    		return false;
    	}
    	if(newValue != '${findSign.fSignName}'){
    		//$('#F_fcTitle').textbox('textbox').css('background','red');
    		$('#f_fSignName').textbox('textbox').css('color','red');
    	}else{
    		$('#f_fSignName').textbox('textbox').css('color','');
    	}
    	$('#F_fContractor').val(newValue);
    }
});

var c1 =0;
function upFile1() {
	c1 ++;
	var src = $('#a_fFileSrc1').val();
	$('#fi1').val(src);
	$('#f_a_f1').append("<div id='c1"+c1+"'><a href='#' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c1"+c1+")'>删除</a></div>");
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
	var row = $('#CF_dg').datagrid('getSelected');
	var selections = $('#CF_dg').datagrid('getSelections');
		if(confirm("确认删除吗？")){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/Formulation/delete/'+row.fcId,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$("#CF_dg").datagrid('reload');
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

var num = 0;
  $('#F_fcTypeName').combobox({  
        onSelect:function(rec){
        	if(num<2){
        		num+=1;
        		var fcType = '${bean.fcType}';
        		if(fcType=="HTFL-01"){
        			$('#cg1').show();
        			$('#cg2').show();
        			$('#cg3').show();
        			$('#cg4').show();
        			$('#bb').html('');
            		$('#aa').show();
            		$('#cc').show();
            		$('#dd').hide();
            		var assisDeptId = '${bean.assisDeptId}';
            		var standard = '${bean.standard}';
            		var html = "";
            		var html1 = "";
            			html +="<td class=\"td1\"><div id=\"cg3\"><span class=\"style1\">*</span>&nbsp;付款方式</div></td>"+
        	        		"<td class=\"td2\"><div id=\"cg4\"><input class=\"easyui-combobox\" id=\"F_fPayType\" name=\"fPayType.code\" data-options=\"editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false\" style=\"width: 200px\" /></div></td>"+
        	        		"<td class=\"td4\">&nbsp;</td><td class=\"td1\">协同部门</td><td class=\"td2\" ><select id=\"F_assisDeptId\" class=\"easyui-combobox\" name=\"assisDeptId\" data-options=\"validType:'length[1,20]',editable:false\" style=\"width: 206px\" ><option value=\"\">--请选择--</option><option value=\"14\"";
        	    		if(assisDeptId==14){
        	    			html +="selected=\"selected\"";
        	       		}
        	       		html+=">设备与安技处</option><option value=\"35\" ";
        	    		if(assisDeptId==35){
        	    			html +="selected=\"selected\"";
        	       		}
        	    			html +=">总务处</option><option value=\"20\"";
        	    		if(assisDeptId==20){
        	    			html +="selected=\"selected\"";
        	       		}
            			html+=">创业就业指导中心</option></select></td>";
            			html1+="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
            			if(standard==0){
            				html1+=" checked=\"checked\" ";
            			}
            			html1+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
        				if(standard==1){
        					html1+=" checked=\"checked\"";
        				}		
        				html1+=" />是</td><td class=\"td4\">&nbsp;</td>";
            		$('#aa').html(html);
            		$('#cc').html(html1);
            		$.parser.parse("#aa");
            		$.parser.parse("#cc");
        			$('#fLandlineTd').hide();
        			$('#f_fLandlinePhone').hide();
        			$('#finish_fLandlinePhone').textbox({required:false});
        			$('#fTaxpayerNum_show').hide();
        			$('#f_fTaxpayerNum').textbox({required:false});
        			$('#fAddress_show').hide();
        			$('#f_fAddress').textbox({required:false});
        			$('#F_fcAmount').numberbox('readonly',true);
        			$('#fCardNo_show').show();
        			$('#fBankName_show').show();
        			$('#recePlanId').show();
        			$.parser.parse("#recePlanId");
        			$('#plan_contract_dg').datagrid('reload');
        			$('#proceedsPlanId').hide();
        			$('#filingPlanId').show();
        			$.parser.parse("#filingPlanId");
        			$('#filing-edit-plan-dg').datagrid('reload');
        		}
        		
        		if(fcType=="HTFL-02"){
        			$('#cg1').hide();
        			$('#cg2').show();
        			$('#cg3').show();
        			$('#cg4').show();
        			$('#bb').html('');
            		$('#aa').show();
            		$('#cc').show();
            		$('#dd').show();
            		var assisDeptId = '${bean.assisDeptId}';
            		var standard = '${bean.standard}';
            		var isinvoice = '${bean.isinvoice}';
            		var html = "";
            		var html1 = "";
            		var html2 = "";
            			html +="<td class=\"td1\"><div id=\"cg3\"><span class=\"style1\">*</span>&nbsp;付款方式</div></td>"+
        	        		"<td class=\"td2\"><div id=\"cg4\"><input class=\"easyui-combobox\" id=\"F_fPayType\" name=\"fPayType.code\" data-options=\"editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false\" style=\"width: 200px\" /></div></td>"+
        	        		"<td class=\"td4\">&nbsp;</td><td class=\"td1\">协同部门</td><td class=\"td2\" ><select id=\"F_assisDeptId\" class=\"easyui-combobox\" name=\"assisDeptId\" data-options=\"validType:'length[1,20]',editable:false\" style=\"width: 206px\" ><option value=\"\">--请选择--</option><option value=\"14\"";
        	    		if(assisDeptId==14){
        	    			html +="selected=\"selected\"";
        	       		}
        	       		html+=">设备与安技处</option><option value=\"35\" ";
        	    		if(assisDeptId==35){
        	    			html +="selected=\"selected\"";
        	       		}
        	    			html +=">总务处</option><option value=\"20\"";
        	    		if(assisDeptId==20){
        	    			html +="selected=\"selected\"";
        	       		}
            			html+=">创业就业指导中心</option></select></td>";
            			html1+="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
            			if(standard==0){
            				html1+=" checked=\"checked\" ";
            			}
            			html1+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
        				if(standard==1){
        					html1+=" checked=\"checked\"";
        				}		
        				html1+=" />是</td><td class=\"td4\">&nbsp;</td>";
        				
        				html2+="<td class=\"td1\"><span class=\"style1\">*</span>是否预开发票</td><td class=\"td2\"><input type=\"radio\" name=\"isinvoice\" value=\"0\" ";
            			if(isinvoice==0){
            				html2+=" checked=\"checked\" ";
            			}
            			html2+="/>否<input type=\"radio\" name=\"isinvoice\" value=\"1\"";
        				if(isinvoice==1){
        					html2+=" checked=\"checked\"";
        				}		
        				html2+=" />是</td><td class=\"td4\">&nbsp;</td>";
            		$('#aa').html(html);
            		$('#cc').html(html1);
            		$('#dd').html(html2);
            		$.parser.parse("#aa");
            		$.parser.parse("#cc");
            		$.parser.parse("#dd");
        			$('#fLandlineTd').show();
        			$('#F_fcAmount').numberbox('readonly', false);
        			$('#f_fLandlinePhone').show();
        			$('#finish_fLandlinePhone').textbox({required: true});
        			$('#fTaxpayerNum_show').show();
        			$('#f_fTaxpayerNum').textbox({required: true});
        			$('#fAddress_show').show();
        			$('#f_fAddress').textbox({required: true});
        			$('#fCardNo_show').show();
        			$('#fBankName_show').show();
        			$('#recePlanId').hide();
        			$('#proceedsPlanId').show();
        			$('#filingPlanId').hide();
        			$.parser.parse("#proceedsPlanId");
        			$('#proceeds-edit-plan-dg-change').datagrid('reload');
        		}
        		if(fcType=="HTFL-03"){
        			$('#cg1').hide();
        			$('#cg2').hide();
        			$('#cg3').hide();
        			$('#cg4').hide();
        			$('#aa').hide();
            		$('#cc').hide();
            		$('#aa').html('');
            		$('#cc').html('');
            		$('#bb').show();
            		$('#dd').hide();
            		var assisDeptId = '${bean.assisDeptId}';
            		var standard = '${bean.standard}';
            		var html = "";
            			html +="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
            			if(standard==0){
            				html+=" checked=\"checked\" ";
            			}
            			html+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
        				if(standard==1){
        					html+=" checked=\"checked\"";
        				}		
        				html+=" />是</td>";
            		$('#bb').html(html);
            		$.parser.parse("#bb");
        			$('#fLandlineTd').hide();
        			$('#fCardNo_show').hide();
        			$('#fBankName_show').hide();
        			$('#f_fLandlinePhone').hide();
        			$('#finish_fLandlinePhone').textbox({required:false});
        			$('#fTaxpayerNum_show').hide();
        			$('#f_fTaxpayerNum').textbox({required:false});
        			$('#fAddress_show').hide();
        			$('#f_fAddress').textbox({required:false});
        			$('#recePlanId').hide();
        			$('#fTaxpayerNum_show').hide();
        			$('#proceedsPlanId').hide();
        			$('#filingPlanId').hide();
        		}
        		if('${bean.fcTitle}' != '${findById.fcTitle}'){
        			$('#F_fcTitle').textbox('textbox').css('color','red');
        		}
        		if('${bean.fcNum}' != '${findById.fcNum}'){
        			$('#F_fcNum').numberbox('textbox').css('color','red');
        		}
        		if('${bean.fcAmount}' != '${findById.fcAmount}'){
        			$('#F_fcAmount').numberbox('textbox').css('color','red');
        		}
        		if('${bean.fcAmountMax}' != '${findById.fcAmountMax}'){
        			$('#F_fcAmountMax').textbox('textbox').css('color','red');
        		}
        		if('${bean.fperformance}' != '${findById.fperformance}'){
        			$('#fperformance').numberbox('textbox').css('color','red');
        		}
        		date=ChangeDateFormatReq('${bean.fContStartTime}');
        		date1=ChangeDateFormatReq('${findById.fContStartTime}');
        		if(date != date1){
        			$('#F_fContStartTime').datebox('textbox').css('color','red');
        		}
        		date2=ChangeDateFormatReq('${bean.fContEndTime}');
        		date3=ChangeDateFormatReq('${findById.fContEndTime}');
        		if(date2 != date3){
        			$('#F_fContEndTime').datebox('textbox').css('color','red');
        		}
        		if('${bean.fRemark}' != '${findById.fRemark}'){
        			$('#f_fRemark').textbox('textbox').css('color','red');
        		}
        		if('${signInfo.fSignName}' != '${findSign.fSignName}'){
        			$('#f_fSignName').textbox('textbox').css('color','red');
        		}
        		if('${signInfo.fLandlinePhone}' != '${findSign.fLandlinePhone}'){
        			$('#finish_fLandlinePhone').textbox('textbox').css('color','red');
        		}
        		if('${signInfo.fConcUser}' != '${findSign.fConcUser}'){
        			$('#f_fConcUser').textbox('textbox').css('color','red');
        		}
        		if('${signInfo.fConcTel}' != '${findSign.fConcTel}'){
        			$('#f_fConcTel').textbox('textbox').css('color','red');
        		}
        		if('${signInfo.fTaxpayerNum}' != '${findSign.fTaxpayerNum}'){
        			$('#f_fTaxpayerNum').textbox('textbox').css('color','red');
        		}
        		if('${signInfo.fAddress}' != '${findSign.fAddress}'){
        			$('#f_fAddress').textbox('textbox').css('color','red');
        		}
        		if('${signInfo.fCardNo}' != '${findSign.fCardNo}'){
        			$('#f_fCardNo').textbox('textbox').css('color','red');
        		}
        		if('${signInfo.fBankName}' != '${findSign.fBankName}'){
        			$('#f_fBankName').textbox('textbox').css('color','red');
        		}
        		return false;
        	}
       	if(rec.code=='' || rec.code==undefined){
       		return false;
       	}
    	if(rec.code=="HTFL-01"){
    		$('#F_fcType').val("HTFL-01");
    		$('#cg1').show();
    		$('#cg2').show();
    		$('#cg3').show();
    		$('#cg4').show();
    		$('#bb').html('');
    		$('#aa').show();
    		$('#cc').show();
    		$('#dd').hide();
    		var assisDeptId = '${bean.assisDeptId}';
    		var standard = '${bean.standard}';
    		var html = "";
    		var html1 = "";
    			html +="<td class=\"td1\"><div id=\"cg3\"><span class=\"style1\">*</span>&nbsp;付款方式</div></td>"+
	        		"<td class=\"td2\"><div id=\"cg4\"><input class=\"easyui-combobox\" id=\"F_fPayType\" name=\"fPayType.code\" data-options=\"editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false\" style=\"width: 200px\" /></div></td>"+
	        		"<td class=\"td4\">&nbsp;</td><td class=\"td1\">协同部门</td><td class=\"td2\" ><select id=\"F_assisDeptId\" class=\"easyui-combobox\" name=\"assisDeptId\" data-options=\"validType:'length[1,20]',editable:false\" style=\"width: 206px\" ><option value=\"\">--请选择--</option><option value=\"14\"";
	    		if(assisDeptId==14){
	    			html +="selected=\"selected\"";
	       		}
	       		html+=">设备与安技处</option><option value=\"35\" ";
	    		if(assisDeptId==35){
	    			html +="selected=\"selected\"";
	       		}
	    			html +=">总务处</option><option value=\"20\"";
	    		if(assisDeptId==20){
	    			html +="selected=\"selected\"";
	       		}
    			html+=">创业就业指导中心</option></select></td>";
    			html1+="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
    			if(standard==0){
    				html1+=" checked=\"checked\" ";
    			}
    			html1+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
				if(standard==1){
					html1+=" checked=\"checked\"";
				}		
				html1+=" />是</td><td class=\"td4\">&nbsp;</td>";
    		$('#aa').html(html);
    		$('#cc').html(html1);
    		$.parser.parse("#aa");
    		$.parser.parse("#cc");
    		$('#fLandlineTd').hide();
    		$('#f_fLandlinePhone').hide();
    		$('#finish_fLandlinePhone').textbox({required:false});
    		$('#fTaxpayerNum_show').hide();
    		$('#f_fTaxpayerNum').textbox({required:false});
    		$('#fAddress_show').hide();
    		$('#f_fAddress').textbox({required:false});
    		$('#F_fcAmount').numberbox('readonly',true);
    		$('#fCardNo_show').show();
    		$('#fBankName_show').show();
    		$('#recePlanId').show();
    		$.parser.parse("#recePlanId");
    		$('#plan_contract_dg').datagrid('reload');
    		$('#proceedsPlanId').hide();
    		$('#filingPlanId').show();
    		$.parser.parse("#filingPlanId");
    		$('#filing-edit-plan-dg').datagrid('reload');
    		
    		acceptContract();
    		editIndexContract == undefined;
    		var cg = $('#plan_contract_dg').datagrid('getRows');
    		for(var i = cg.length-1 ; i >= 0 ; i--){
    			$('#plan_contract_dg').datagrid('deleteRow',i);
    		}
    		$("#F_fPurchNo").val('');
			$("#F_fPurchName").textbox('setValue',''); 
			$("#F_fcAmount").numberbox('setValue',0); 
			$('#F_fcAmountMax').textbox('setValue',convertCurrency(0));
		}
    	
    	if(rec.code=="HTFL-02"){
    		$('#F_fcType').val("HTFL-02");
    		$('#cg1').hide();
    		$('#cg2').show();
    		$('#cg3').show();
    		$('#cg4').show();
    		$('#bb').html('');
    		$('#aa').show();
    		$('#cc').show();
    		$('#dd').show();
    		var assisDeptId = '${bean.assisDeptId}';
    		var standard = '${bean.standard}';
    		var isinvoice = '${bean.isinvoice}';
    		var html = "";
    		var html1 = "";
    		var html2 = "";
    			html +="<td class=\"td1\"><div id=\"cg3\"><span class=\"style1\">*</span>&nbsp;付款方式</div></td>"+
	        		"<td class=\"td2\"><div id=\"cg4\"><input class=\"easyui-combobox\" id=\"F_fPayType\" name=\"fPayType.code\" data-options=\"editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false\" style=\"width: 200px\" /></div></td>"+
	        		"<td class=\"td4\">&nbsp;</td><td class=\"td1\">协同部门</td><td class=\"td2\" ><select id=\"F_assisDeptId\" class=\"easyui-combobox\" name=\"assisDeptId\" data-options=\"validType:'length[1,20]',editable:false\" style=\"width: 206px\" ><option value=\"\">--请选择--</option><option value=\"14\"";
	    		if(assisDeptId==14){
	    			html +="selected=\"selected\"";
	       		}
	       		html+=">设备与安技处</option><option value=\"35\" ";
	    		if(assisDeptId==35){
	    			html +="selected=\"selected\"";
	       		}
	    			html +=">总务处</option><option value=\"20\"";
	    		if(assisDeptId==20){
	    			html +="selected=\"selected\"";
	       		}
    			html+=">创业就业指导中心</option></select></td>";
    			html1+="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
    			if(standard==0){
    				html1+=" checked=\"checked\" ";
    			}
    			html1+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
				if(standard==1){
					html1+=" checked=\"checked\"";
				}		
				html1+=" />是</td><td class=\"td4\">&nbsp;</td>";
				
				html2+="<td class=\"td1\"><span class=\"style1\">*</span>是否预开发票</td><td class=\"td2\"><input type=\"radio\" name=\"isinvoice\" value=\"0\" ";
    			if(isinvoice==0){
    				html2+=" checked=\"checked\" ";
    			}
    			html2+="/>否<input type=\"radio\" name=\"isinvoice\" value=\"1\"";
				if(isinvoice==1){
					html2+=" checked=\"checked\"";
				}		
				html2+=" />是</td><td class=\"td4\">&nbsp;</td>";
    		$('#aa').html(html);
    		$('#cc').html(html1);
    		$('#dd').html(html2);
    		$.parser.parse("#aa");
    		$.parser.parse("#cc");
    		$.parser.parse("#dd");
    		$('#fLandlineTd').show();
    		$('#F_fcAmount').numberbox('readonly',false);
    		$('#f_fLandlinePhone').show();
    		$('#finish_fLandlinePhone').textbox({required:true});
    		$('#fTaxpayerNum_show').show();
    		$('#f_fTaxpayerNum').textbox({required:true});
    		$('#fAddress_show').show();
    		$('#f_fAddress').textbox({required:true});
    		$('#fCardNo_show').show();
    		$('#fBankName_show').show();
    		$('#recePlanId').hide();
    		$('#proceedsPlanId').show();
    		$('#filingPlanId').hide();
    		$.parser.parse("#proceedsPlanId");
    		$('#proceeds-edit-plan-dg-change').datagrid('reload');

    		acceptPlan();
    		editIndex = undefined;
    		var cgS = $('#filing-edit-plan-dg').datagrid('getRows');
    		for(var s = cgS.length-1 ; s >= 0 ; s--){
    			$('#filing-edit-plan-dg').datagrid('deleteRow',s);
    		}

    		acceptContract();
    		editIndexContract == undefined;
    		var cg = $('#plan_contract_dg').datagrid('getRows');
    		for(var i = cg.length-1 ; i >= 0 ; i--){
    			$('#plan_contract_dg').datagrid('deleteRow',i);
    		}
    		$("#F_fPurchNo").val('');
			$("#F_fPurchName").textbox('setValue',''); 
			$("#F_fcAmount").numberbox('setValue',0); 
			$('#F_fcAmountMax').textbox('setValue',convertCurrency(0));
		}
    	if(rec.code=="HTFL-03"){
    		$('#F_fcType').val("HTFL-03");
    		$('#cg1').hide();
    		$('#cg2').hide();
    		$('#cg3').hide();
    		$('#cg4').hide();
    		$('#aa').hide();
    		$('#cc').hide();
    		$('#dd').hide();
    		$('#aa').html('');
    		$('#cc').html('');
    		$('#bb').show();
    		var assisDeptId = '${bean.assisDeptId}';
    		var standard = '${bean.standard}';
    		var html = "";
    			html +="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
    			if(standard==0){
    				html+=" checked=\"checked\" ";
    			}
    			html+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
				if(standard==1){
					html+=" checked=\"checked\"";
				}		
				html+=" />是</td>";
    		$('#bb').html(html);
    		$.parser.parse("#bb");
    		$('#fLandlineTd').hide();
    		$('#fCardNo_show').hide();
			$('#fBankName_show').hide();
    		$('#f_fLandlinePhone').hide();
    		$('#finish_fLandlinePhone').textbox({required:false});
    		$('#fTaxpayerNum_show').hide();
    		$('#f_fTaxpayerNum').textbox({required:false});
    		$('#fAddress_show').hide();
    		$('#f_fAddress').textbox({required:false});
    		$('#recePlanId').hide();
    		$('#fTaxpayerNum_show').hide();
    		$('#proceedsPlanId').hide();
    		$('#filingPlanId').hide();
    		
    		acceptPlan();
    		editIndex = undefined;
    		var cgS = $('#filing-edit-plan-dg').datagrid('getRows');
    		for(var s = cgS.length-1 ; s >= 0 ; s--){
    			$('#filing-edit-plan-dg').datagrid('deleteRow',s);
    		}
    		
    		acceptContract();
    		editIndexContract == undefined;
    		var cg = $('#plan_contract_dg').datagrid('getRows');
    		for(var i = cg.length-1 ; i >= 0 ; i--){
    			$('#plan_contract_dg').datagrid('deleteRow',i);
    		}

    		$("#F_fPurchNo").val('');
			$("#F_fPurchName").textbox('setValue',''); 
			$("#F_fcAmount").numberbox('setValue',0); 
			$('#F_fcAmountMax').textbox('setValue',convertCurrency(0));
		}
        }
    });  
   /*  function getFilePath(){  
        var input = document.getElementById("CF_file");
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
    }   */
		//baocun

//校验不通过，就打开第一个校验失败的标签页
function openInvalidTab(tabid) {
	//获取所有标签页
	var $wrapper = $('#' + tabid), $allTabs = $wrapper
			.find('.tab-content > div');
	for (var i = 0; i < $allTabs.length; i++) {
		var forflag = true;
		//获取标签页标记
		var datab = $allTabs[i].getAttribute('data-tab');
		$('div[data-tab="' + datab + '"] input').each(function() {
			//打开校验不通过的标签
			if ($(this).hasClass("validatebox-invalid")) {
				$('li[data-tab="' + datab + '"]').click();
				forflag = false;
				return false;
			}
		});

		if (forflag == false) {
			return forflag;
		}

	}
	//循环每个标签页
}
//送审
function CFFormSS(stauts) {
	//审批状态
	var fFlowStauts = $("#CF_fFlowStauts").val(stauts);
	var s = "";
	$(".htwbfileUrl").each(function() {
		s = s + $(this).attr("id") + ",";
	});
	$("#htwbfiles").val(s);
	var ss = "";
	$(".htndfileUrl").each(function() {
		ss = ss + $(this).attr("id") + ",";
	});
	$("#htndfiles").val(ss);
	//校验合同信息
	var filesValue = $("#htwbfiles").val();
	if (filesValue == null || filesValue == '') {
		alert("请上传合同文本");
	} else {
		//校验签约方信息
		var type = $("#F_fcType").val();//合同分类	
		var signName = $("#f_fSignName").textbox('getValue');//签约方名称
		var concUser = $("#f_fConcUser").textbox('getValue');//联系人
		var concTel = $("#f_fConcTel").textbox('getValue');//联系电话
		var bankName = $("#f_fBankName").textbox('getValue');//开户银行
		var cardNo = $("#f_fCardNo").textbox('getValue');//银行账户 
		var landlinePhone = $("#finish_fLandlinePhone").textbox('getValue');//座机联系方式
		var taxpayerNum = $("#f_fTaxpayerNum").textbox('getValue');//纳税人识别号
		var address = $("#f_fAddress").textbox('getValue');//地址
		//支出合同
		if (type == 'HTFL-01'){
			var fcAmount = isNaN(parseFloat($('#F_fcAmount').textbox('getValue')))?0:parseFloat($('#F_fcAmount').textbox('getValue')); //合同金额
			var totalAmount = isNaN(parseFloat($('#totalAmount').val()))?0:parseFloat($('#totalAmount').val());//付款计划总额
			if(fcAmount!=totalAmount){
				alert('合同金额和付款计划总额不一致，请核对！');
				return false;
			}
			/* var fPayType = $('#F_fPayType').combobox('getValues');
			if(stauts == '1'){
			if(fPayType==''){
				alert('请选择付款方式！');
				return false;
			}
			} */
			var plan = getPlan();
			var contractJson = contractJsons();
			if (bankName == '' || signName == '' || concUser == '' || concTel == '' || cardNo == '') {
				alert("请完善签约方信息");
				return;
			}else if (('' == plan || null == plan || '[]' == plan) && type == 'HTFL-01') {
				alert("请正确填写付款计划");
				return;
			} else {
					//var assisDeptId = $('#F_assisDeptId').combobox('getValues');
				/* if(fcAmount>=50000){
					if(assisDeptId==''){
						alert('合同金额大于等于50000，需选择协同部门！');
						return false;
					}
				}else{
					if(assisDeptId!=''){
						alert('合同金额小于50000，请勿选择协同部门！');
						return false;
					}
				} */
				$('#CFAddEditForm').form('submit',{
							onSubmit : function(param) {
								param.planJson = plan;
								flag = $(this).form('enableValidation').form('validate');
								if (flag) {
									$.messager.progress();
								}
								return flag;
							},
							data : {
								'fFlowStauts' : fFlowStauts
							},
							success : function(data) {
								$.messager.progress('close');
								data = eval("(" + data + ")");
								if (data.success) {
									$.messager.alert('系统提示', data.info,
											'info');
									$('#CFAddEditForm').form('clear');
									$("#CF_dg").datagrid('reload');
									$('#filing_dg').datagrid('reload');
									closeWindow();
								} else {
									$.messager.alert('系统提示', data.info,
											'error');
								}
							}
						});
			}
		} else { //其他合同
			if(type == 'HTFL-02'){
				if (bankName == '' || signName == '' || concUser == '' || concTel == '' || cardNo == '' || landlinePhone == '' || taxpayerNum == '' || address == '') {
					alert("请完善签约方信息");
					return;
				}
				var pay = getPlanProceeds();
				if(stauts == '1'){
				if (('' == pay || null == pay || '[]' == pay) && type == 'HTFL-02') {
					alert("请完善收款计划");
					return;
				}
				}
				var F_fcAmount = isNaN(parseFloat($('#F_fcAmount').textbox('getValue')))?0:parseFloat($('#F_fcAmount').textbox('getValue')); //合同金额
				var totalAmounts = isNaN(parseFloat($('#totalAmount').val()))?0:parseFloat($('#totalAmount').val());//付款计划总额
				if(F_fcAmount!=totalAmounts){
					alert('合同金额和收款计划总额不一致，请核对！');
					return false;
				}
				/* var fPayTypes = $('#F_fPayType').combobox('getValues');
				if(fPayTypes==''){
					alert('请选择收款方式！');
					return false;
				} */
				var json = getPlanProceeds();
				//var assisDeptIds = $('#F_assisDeptId').combobox('getValues');
				/* if(F_fcAmount>=50000){
					if(assisDeptIds==''){
						alert('合同金额大于等于50000，需选择协同部门！');
						return false;
					}
				}else{
					if(assisDeptIds!=''){
						alert('合同金额小于50000，请勿选择协同部门！');
						return false;
					}
				} */
				$('#CFAddEditForm').form('submit',{
							onSubmit : function(param){
								param.proceedsJson = json;
								flag = $(this).form('enableValidation')
										.form('validate');
								if (flag) {
									$.messager.progress();
								}
								return flag;
							},
							data : {
								'fFlowStauts' : fFlowStauts
							},
							success : function(data) {
								$.messager.progress('close');
								data = eval("(" + data + ")");
								if (data.success) {
									$.messager.alert('系统提示', data.info,
											'info');
									$('#CFAddEditForm').form('clear');
									$("#CF_dg").datagrid('reload');
									$('#filing_dg').datagrid('reload');
									closeWindow();
								} else {
									$.messager.alert('系统提示', data.info,
											'error');
								}
							}
						});
			}else{
				if ( signName == '' || concUser == '' || concTel == '' ) {
					alert("请完善签约方信息");
					return;
				}
				//var assisDept = $('#F_assisDeptId').combobox('getValues');
				/* if(assisDept==''){
					alert('非经济类合同需选择协同部门！');
					return false;
				} */
				$('#CFAddEditForm').form('submit',{
						onSubmit : function(param){
							flag = $(this).form('enableValidation')
									.form('validate');
							if (flag) {
								$.messager.progress();
							}
							return flag;
						},
						data : {
							'fFlowStauts' : fFlowStauts
						},
						success : function(data) {
							$.messager.progress('close');
							data = eval("(" + data + ")");
							if (data.success) {
								$.messager.alert('系统提示', data.info,
										'info');
								$('#CFAddEditForm').form('clear');
								$("#CF_dg").datagrid('reload');
								$('#filing_dg').datagrid('reload');
								closeWindow();
							} else {
								$.messager.alert('系统提示', data.info,
										'error');
							}
						}
					});
			}
		}
	}

}

function BudgetIndexCode() {
	var win = creatFirstWin('选择指标', 600, 580, 'icon-search',
			'/apply/choiceIndex');
	win.window('open');
}

function fProCode_DC() {
	var win = creatFirstWin(' ', 800, 550, 'icon-search',
			'/Formulation/fProCode');
	win.window('open');
}
function quota_DC() {
	var win = creatFirstWin('选择-预算指标编号', 860, 580, 'icon-add',
			'/Formulation/BudgetIndexCode');
	win.window('open');
}
</script>
</body>