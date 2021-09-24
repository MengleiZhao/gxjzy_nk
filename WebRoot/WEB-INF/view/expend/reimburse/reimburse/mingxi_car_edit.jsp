<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
	.input_amonut{
		width: 150px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.input_amonut1{
		width: 410px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.fp_span{
		width:85px;
		margin-bottom:5px;
		display: inline-block;
	}
	.fp_span1{
		width:85px;
		margin-bottom:5px;
		margin-left:15px;
		display: inline-block;
	}
</style>
<div id="dlgdiv" class="easyui-dialog"
     style="width: 800px; height: 550px; padding: 10px 10px" closed="true"
     buttons="#dlgdiv-buttons">
        <div id="divlarge"></div>
</div>
<c:forEach items="${cost}" var="cost" varStatus="st">
<form id="form_${st.index}">
	<table id="tableId_${st.index}" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:26%">
					<p style=" color:#0000CD;">${cost.costName}</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_useAmount_${st.index}" >${cost.costAmount}元</p>
				</td>
				<td>
					<a id="append_${cost.num-1}" onclick="append(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
			<c:forEach items="${cost.couponList}" var="fp1" varStatus="st1">		
			<tbody id="cost_${fp1.num-1}" >
			<tr>
				<td class="td1">
					<input  type="hidden" id="costName_${fp1.num-1}" name="costName" value="${cost.costName}"/>
					<input  type="hidden" id="costAmount_${fp1.num-1}" name="costAmount" value="${cost.costAmount}"/>
					&nbsp;&nbsp;<span id="costFp_${fp1.num-1}">发票${st1.index+1}</span>
					<input type="text" id="fp_${fp1.num-1}" name="fileId" hidden="hidden" value="${fp1.fileId}" >
					<input type="file" id="image_${fp1.num-1}" onchange="upImageFile(this)" hidden="hidden" >
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_${fp1.num-1}">
					<c:if test="${fp1.fileId==null||empty fp1.fileId}">
					<a onclick="clickUpFile(this)" id="click_${fp1.num-1}" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>
					<c:if test="${fp1.fileId!=null&&!empty fp1.fileId}">
					<img style="vertical-align:bottom;margin-left:30px;width: 100px; height: 73px;" src="${base}/attachment/download/${fp1.fileId}" onclick="yl(this.src)"/><a style="color:red" href="#" onclick="deleteImage(this)" id="sc_${fp1.num-1}">    删除</a>
					</c:if>	
					<c:if test="${st1.index !=0}">
					<a onclick="deleteCars(this)" style="float: right;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
					</c:if>		
				</td>	
			</tr>

			<tr>
				<td class="td2" colspan="5" >
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount"  id="amount_${fp1.num-1}"  onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp1.amount}" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_${fp1.num-1}" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="${fp1.tax}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_${fp1.num-1}" type="date" required="required"
							value="${fn:substring(fp1.time, 0, 10)}" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input class="input_amonut1" name="remark" id="remark_${fp1.num-1}" 
							value="${fp1.remark}" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_${fp1.num-1}">
								<c:if test="${fp1.fileId!=null&&!empty fp1.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/zp.png">
								</c:if>
								<c:if test="${fp1.fileId==null||empty fp1.fileId}">
									<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
								</c:if>
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_${fp1.num-1}">
								<c:if test="${fp1.fileId!=null&&!empty fp1.fileId}">
				        			<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/wcf.png">
								</c:if>
							</span>
						</p>
					</div>
				</td>	
			</tr>
			</tbody>
		</c:forEach>		
	</table>
</form>
<div style="height:10px"></div>	
</c:forEach>
<script type="text/javascript">
var index =${x};
var a =0;
$(function(){
/* 	for(var i=0; i<=index; i++){
		
	$('#startTime' + i).change(function(){
		countDays(i);
		});
	$('#endTime' + i).change(function(){
		countDays(i);
		});
	} */
});
//计算报销金额
function addAmonut(obj){
	var totalAmount=0;
    var tags = [];
    $(".a").each(function(i,e){
        tags[i]= e.value;
        var num =parseFloat(tags[i]);
        if(!isNaN(num)){
        	totalAmount+=num;
        }
      });
    $('#p_amount').html(fomatMoney(totalAmount,2)+" [元]");
    $('#reimburseAmount').val(totalAmount.toFixed(2));
    $('#payeeAmount').val(totalAmount.toFixed(2));
      countDays(obj);
      cx();
}

/* //打开页面计算报销金额
addBXAmonut();
function addBXAmonut(){
	var totalAmount=0;
    var tags = [];
    $(".a").each(function(i,e){
        tags[i]= e.value;
        var num =parseFloat(tags[i]);
        if(!isNaN(num)){
        	totalAmount+=num;
        }
      });
    $('#p_amount').html(fomatMoney(totalAmount,2)+" [元]");
    $('#skAccount').val(totalAmount);
    $('#payeeAmount').val(totalAmount);
}
 */
function countDays(obj){
	var id=obj.id;
	var j=id.lastIndexOf("\_");
	var i=id.substring(j+1,id.length);
	var time1 =new Date($('#startTime_' + i).val());
	var time2 =new Date($('#endTime_' + i).val());
	var d = (time2 - time1) / 86400000 + 1;
	if (d > 0) {
		var amount =parseFloat($('#amount_' + i).val());
		if(!isNaN(amount)){
			var average =(amount/d).toFixed(2);
			$('#average_' + i).val(average);
		}
	$('#days_' + i).val(d);
	}else{
	$('#days_' + i).val("");
	}
}



function append(obj){

		index=index+1;
	    var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		var id =fromNum[1].id;
		var i=id.lastIndexOf("\_");
	    var j=parseInt(id.substring(i+1,id.length));
		var addItem = $('#'+fromNum[1].id).clone(true);
		addItem.attr('id', "cost_" + index);
		var amount = addItem.find('#amount_'+j ); //根据id查找子元素
		var tax = addItem.find('#tax_'+j);
		var time = addItem.find('#time_'+j);
		var remark = addItem.find('#remark_'+j);
		var fp = addItem.find('#fp_'+j);
		var image = addItem.find('#image_'+j);
		var zfbimagetd = addItem.find('#zfbimagetd_'+j);
		var click = addItem.find('#click_'+j);
		var sc = addItem.find('#sc_'+j);
		var checkTrue = addItem.find('#checkTrue_' +j);
		var checkRepet = addItem.find('#checkRepet_' +j);
		var costFp = addItem.find('#costFp_' +j);
		var append = addItem.find('#append_' +j);
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		costFp.attr("id", "costFp_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		append.attr("id", "append_" + index); //改变克隆子元素节点
		$('#' + fromNum[1].id).after(addItem);
		$('#zfbimagetd_' + index).empty();
		$('#zfbimagetd_' + index)
				.append(
						'<a onclick="clickUpFile(this)" id="click_'
								+ index
								+ '" style="font-weight: bold;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
								+'<a onclick="deleteCars(this)" style="float: right;" href="#">'
								+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
								+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[2].id;
			$('#' + s).html("发票"+i);
			}
		//a = a + 1;
	}

	//将表单序列化成json格式的数据(但不适用于含有控件的表单，例如复选框、多选的select)
	(function($) {
		$.fn.serializeJson = function() {
			var jsonData1 = {};
			var serializeArray = this.serializeArray();
			// 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
			$(serializeArray).each(
					function() {
						if (jsonData1[this.name]) {
							if ($.isArray(jsonData1[this.name])) {
								jsonData1[this.name].push(this.value);
							} else {
								jsonData1[this.name] = [ jsonData1[this.name],
										this.value ];
							}
						} else {
							jsonData1[this.name] = this.value;
						}
					});
			// 再转成[{"id": "12", "name": "aaa", "pwd":"pwd1"},{"id": "14", "name": "bb", "pwd":"pwd2"}]的形式
			var vCount = 0;
			// 计算json内部的数组最大长度
			for ( var item in jsonData1) {
				var tmp = $.isArray(jsonData1[item]) ? jsonData1[item].length
						: 1;
				vCount = (tmp > vCount) ? tmp : vCount;
			}

			if (vCount > 1) {
				var jsonData2 = new Array();
				for (var i = 0; i < vCount; i++) {
					var jsonObj = {};
					for ( var item in jsonData1) {
						jsonObj[item] = jsonData1[item][i];
					}
					jsonData2.push(jsonObj);
				}
				return JSON.stringify(jsonData2);
			} else {
				return "[" + JSON.stringify(jsonData1) + "]";
			}
		};
	})(jQuery);
	
	
	(function($) {
		$.fn.cs = function() {
			var jsonData1 = {};
			var serializeArray = this.serializeArray();
			// 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
			$(serializeArray).each(
					function() {
						if (jsonData1[this.name]) {
							if ($.isArray(jsonData1[this.name])) {
								jsonData1[this.name].push(this.value);
							} else {
								jsonData1[this.name] = [ jsonData1[this.name],
										this.value ];
							}
						} else {
							jsonData1[this.name] = this.value;
						}
					});
			// 再转成[{"id": "12", "name": "aaa", "pwd":"pwd1"},{"id": "14", "name": "bb", "pwd":"pwd2"}]的形式
			var vCount = 0;
			// 计算json内部的数组最大长度
			for ( var item in jsonData1) {
				var tmp = $.isArray(jsonData1[item]) ? jsonData1[item].length
						: 1;
				vCount = (tmp > vCount) ? tmp : vCount;
			}

			if (vCount > 1) {
				var jsonData2 = new Array();
				for (var i = 0; i < vCount; i++) {
					var jsonObj = {};
					for ( var item in jsonData1) {
						jsonObj[item] = jsonData1[item][i];
					}
					jsonData2.push(jsonObj);
				}
				return jsonData2;
			} else {
				return jsonData1;
			}
		};
	})(jQuery);
	
	function clickUpFile(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
			$('#image_'+ j).click();
	}

	//上传图片文件转化为base64在页面显示
	function upImageFile(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
		if(obj==null||obj=="") {
			return;
		}
		var files = obj.files;
		var formData = new FormData();
		for(var i=0; i< files.length; i++){
			formData.append("imageFile",files[i]);//图片文件
			/* formData.append("imageType",type); //类型1支付宝、2微信 */
			$.ajax({ 
				url: base + '/base64/uploadImage' ,
				type: 'post',  
		        data: formData,
		        cache: false,
		        processData: false,
		        contentType: false,
		        async: false,
		        dataType:'json',
		        success:function(data){
		        	
		        	upladFp(obj,"cost","fp06",j);
		        	var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		        	$('#zfbimagetd_'+j).empty();
		        	$('#image_'+j).val("");
		        	var x=fromNum[1].id.lastIndexOf("\_");
		   	     var y=fromNum[1].id.substring(x+1,fromNum[1].id.length);
		        	if(y!=j){
		        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px;width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)" />'
	    			        	+'<a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>'
	    			        		+'<a onclick="deleteCars(this)" style="float: right;" href="#">'
	    							+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
	    							+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		        	}else{
		        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px;width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)" />'
	    			        	+'<a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
		        	}
		        	
		        	$('#checkTrue_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/zp.png">');
		        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
		        }
			});
		} 
	}
	//删除上传的图片
	function deleteImage(obj) {
		var id =obj.id;
		
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
			var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
			$('#zfbimagetd_'+j).empty();
        	var x=fromNum[1].id.lastIndexOf("\_");
   	     var y=fromNum[1].id.substring(x+1,fromNum[1].id.length);
        	if(y!=j){
        		$('#zfbimagetd_'+j).append('<a onclick="clickUpFile(this)" id="click_'+j+'" style="font-weight: bold;" href="#">'+
        				'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)"'
        				+' onMouseOut="mouseOut(this)"></a>'
        				+'<a onclick="deleteCars(this)" style="float: right;" href="#">'
        				+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
        				+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
        	}else{
        		$('#zfbimagetd_'+j).append('<a onclick="clickUpFile(this)" id="click_'+j+'" style="font-weight: bold;" href="#">'+
        				'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)"'
        				+' onMouseOut="mouseOut(this)"></a>');
        	}
			
			
			
			
			$('#fp_'+j).val(null);
			$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
			$('#checkRepet_'+j).html("");
	}
	
	function  deleteCars(item){
		
		var fromNum = item.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children.length;
		var id = item.parentNode.parentNode.parentNode.id;
		var tId = item.parentNode.parentNode.parentNode.parentNode;
		$("#"+id).remove();
		var arr=id.split("_");
		for(var i=1;i<fromNum-1;i++){
			if('cost'==arr[0]){
				var fapiao = tId.children[i].children[0].children[0].children[2].id;
				$("#"+fapiao).html("发票"+i);
			}
		}
		addAmonut(item);
		return ;
	}
</script>
