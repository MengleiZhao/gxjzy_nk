<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>

<style type="text/css">
/* .td1{
	width:200px;
	text-align:right;
}
input{
	width:100px;
} */
/* .sfwj{
	/* display:none; */
} */
</style>

<div class="win-div">
<form id="hotelstd_add_form" action="${base}/hotelStandard/save?outType=travel" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="id" id="hotelstd_add_id" value="${bean.id}"/>
					<div class="easyui-accordion" style="width:662px;margin-left: 20px;">
							<div title="住宿费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
								<table class="ourtable" cellpadding="0" cellspacing="0">
								
									<tr class="trbody">
										<td class="td1">地区</td>
										<td colspan="3">
											<input id="hotelstd_add_area" name="area" value="${bean.area }"
												class="easyui-textbox" data-options="required:true"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">住宿费标准（市级）</td>
										<td class="td2">
											<input id="hotelstd_add_normalPriceMax" name="normalPriceMax" value="${bean.normalPriceMax }"
												class="easyui-numberbox"/>
										</td>
										<td class="td1">住宿费标准（局级）</td>
										<td class="td2" style="width:150px;">
											<input id="hotelstd_add_normalPriceMid" name="normalPriceMid" value="${bean.normalPriceMid }"
												class="easyui-numberbox"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1" style="width:150px;">住宿费标准（其他人员）</td>
										<td colspan="3">
											<input id="hotelstd_add_normalPriceMin" name="normalPriceMin" value="${bean.normalPriceMin }"
												class="easyui-numberbox" />
										</td>
									</tr>
									
								</table>	
								<table class="ourtable" cellpadding="0" cellspacing="0">
								
								
										<tr class="trbody">
											<td class="td1" style="width:150px;">是否存在旺季</td>
											<td colspan="3">
												
												<input id="hotelstd_add_sfwj" name="hasBusy" value="1"
													type="radio" onclick="selectSfwj(this)" <c:if test="${bean.hasBusy==1 }">checked="checked"</c:if>/>是
												<input id="hotelstd_add_sfwj" name="hasBusy" value="0"
													type="radio" onclick="selectSfwj(this)" <c:if test="${bean.hasBusy!=1 }">checked="checked"</c:if>/>否 
												
											</td>
										</tr>
										
										
										
										<tr class="trbody sfwj" id="test">
											<td class="td1">旺季上浮比例（%）</td>
											<td class="td2" colspan="3">
												<input id="hotelstd_add_busyRate" name="busyRate" value="${bean.busyRate }"
													class="easyui-numberbox" style="width:170px;"/>
											</td>
										</tr>
								
										<tr class="trbody sfwj">
											<td class="td1">旺季开始时间</td>
											<td class="td2">
												<input id="hotelstd_add_busyDateStart" name="busyDateStart" value="${bean.busyDateStart }"
													class="easyui-datebox" style="width:170px;" />
											</td>
											<td class="td1">旺季结束时间</td>
											<td class="td2" style="width:150px;">
												<input id="hotelstd_add_busyDateEnd" name="busyDateEnd" value="${bean.busyDateEnd }"
													class="easyui-datebox" style="width:170px;"/>
											</td>
										</tr>
								
										<tr class="trbody sfwj">
											<td class="td1">旺季上浮价（市级）</td>
											<td class="td2">
												<input id="hotelstd_add_busyPriceMax" name="busyPriceMax" value="${bean.busyPriceMax }"
													class="easyui-numberbox" style="width:170px;"/>
											</td>
											<td class="td1">旺季上浮价（局级）</td>
											<td class="td2" style="width:150px;">
												<input id="hotelstd_add_busyPriceMid" name="busyPriceMid" value="${bean.busyPriceMid }"
													class="easyui-numberbox" style="width:170px;"/>
											</td>
										</tr>
								
										<tr class="trbody sfwj">
											<td class="td1" style="width:150px;">旺季上浮价（其他人员）</td>
											<td colspan="3">
												<input id="hotelstd_add_busyPriceMin" name="busyPriceMin" value="${bean.busyPriceMin }"
													class="easyui-numberbox" style="width:170px;"/>
											</td>
										</tr>
										
								</table>
						</div>
								
						<div title="伙食补助费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1">费用标准</td>
									<td colspan="3">
										<input id="hotelstd_add_costFood" name="costFood" value="${bean.costFood }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
						<div title="长途交通费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1">费用标准</td>
									<td colspan="3">
										<input id="hotelstd_add_costTrafficLong" name="costTrafficLong" value="${bean.costTrafficLong }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
						<div title="市内交通费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1">费用标准</td>
									<td colspan="3">
										<input id="hotelstd_add_costTrafficShort" name="costTrafficShort" value="${bean.costTrafficShort }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
						<div title="杂费" data-options="iconCls:'icon-xxlb',collapsed:true,collapsible:true" style="overflow:auto;margin-top:10px;">
							<table class="ourtable" cellpadding="0" cellspacing="0">
								<tr class="trbody">
									<td class="td1">费用标准</td>
									<td colspan="3">
										<input id="hotelstd_add_costExtras" name="costExtras" value="${bean.costExtras }"
											class="easyui-numberbox" data-options=""/>
									</td>
								</tr>
							</table>
						</div>
								
								
					</div>			
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
				<a href="javascript:void(0)" onclick="saveBean();">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
$("#hotelstd_add_busyDateStart").datebox({
    onSelect : function(beginDate){
        $('#hotelstd_add_busyDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
            	return beginDate <= date;
            }
        });
    }
});
$(function(){
	/* var v =  $('#normalPriceMax').numberbox('getValue');
	alert(v); */
	//判断淡旺季区域是否隐藏
	initDwjAccodion();
	//上浮比例输入框失去焦点,自动计算旺季价格
	initAutoCalBusyPrice();
	
});
function initAutoCalBusyPrice(){
	/* $('#hotelstd_add_area').textbox({
		onChange:function(){
			autoCalBusyPrice();
		}
	}); */
	$('#hotelstd_add_busyRate').numberbox({
		onChange:function(newValue,oldValue){
			//自动计算上浮后金额			
			autoCalBusyPrice();
		}
	});
}
function initDwjAccodion(){
	var sfwj = $('input[name="hasBusy"]:checked').val();
	if(sfwj==1){
		$('tr.sfwj').css('display','');
	} else {
		$('tr.sfwj').css('display','none');
	}
}
function selectSfwj(obj){
	initDwjAccodion();
}
function saveBean(){
	$('#hotelstd_add_form').form('submit', {
		onSubmit: function(){ 
			flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		}, 
		success:function(data){
			if(flag){
				$.messager.progress('close');
			}
			data=eval("("+data+")");
			if(data.success){
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#hotelstd_add_form').form('clear');
				$('#hotestd_dg').datagrid('reload'); 
			}else{
				$.messager.alert('系统提示', data.info, 'error');
			}
		} 
	});		
}
function MMddFormatter(date) {
    //获取年份
    //var y = date.getFullYear();
    //获取月份
    var m = date.getMonth() + 1;
    //获取天
    var d = date.getDate();
    return m + '-' + d;
}
function autoCalBusyPrice(){
	//normalPriceMax normalPriceMid normalPriceMin
	//$('#normalPriceMax').numberbox('setValue','80');
	var p1 =  $('#hotelstd_add_normalPriceMax').numberbox('getValue');
	var p2 =  $('#hotelstd_add_normalPriceMid').numberbox('getValue');
	var p3 =  $('#hotelstd_add_normalPriceMin').numberbox('getValue');
	var rate = parseFloat($('#hotelstd_add_busyRate').numberbox('getValue')) / 100;
	
	if(!isNaN(rate)){
		rate = rate + 1;
		if(!isNaN(p1)){
			var p11 = p1 * rate;
			$('#hotelstd_add_busyPriceMax').numberbox('setValue',p11);
		}
		if(!isNaN(p2)){
			var p22 = p2 * rate;
			$('#hotelstd_add_busyPriceMid').numberbox('setValue',p22);
		}
		if(!isNaN(p3)){
			var p33 = p3 * rate;
			$('#hotelstd_add_busyPriceMin').numberbox('setValue',p33);
		}
	}
	//var v =  $('#hotelstd_add_area').textbox('getValue');
}
/* $.fn.datebox.defaults.formatter = function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return m+'/'+d+'/'+y;
} */
</script>
</body>