<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
	.input_amonut{
		width: 140px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.fp_span{
		width:100px;
		margin-bottom:5px;
		display: inline-block;
	}
	.input_amonut1{
		width: 150px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.fp_span1{
		width:85px;
		margin-bottom:5px;
		margin-left:15px;
		display: inline-block;
	}
</style>
<div id="dlgdiv" class="easyui-dialog"
     style="width: 650px; height: 550px; padding: 10px 20px" closed="true"
     buttons="#dlgdiv-buttons">
        <div id="divlarge"></div>
</div>
<div style="margin-top: 5px;margin-bottom: 5px;height: 15px;">
	<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">发票明细</a>
	<a style="float: left;">&nbsp;&nbsp;</a>
</div>
<form id="form1">
	<table id="meetingfapiao" class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style=" height: 100px;width:695px;">
		<c:forEach items="${Invoicelist }" varStatus="i" var="invoice">
			<tbody id="meeting_${i.index}" >
				<tr>
					<td class="td1" style="width: 100px;">
						&nbsp;&nbsp;<span id="meetingFp_${i.index}">发票${i.index+1}</span>
						<input type="text" id="meetingfp_${i.index}" value="${invoice.fileId}" name="fileId" hidden="hidden">
						<input type="file" id="meetingImage_${i.index}" onchange="upImageFile(this)" hidden="hidden">
					</td>
					<td class="td2" colspan="3" id="meetingZfbimagetd_${i.index}" style="width: 150px;">
						<c:if test="${invoice.fileId!=null&&!empty invoice.fileId}">
							<img style="vertical-align:bottom;width: 100px; height: 73px;margin-left:0px" onclick="yl(this.src)" src="${base}/attachment/download/${invoice.fileId}"/>
						</c:if>
					</td>
					<td class="td2" colspan="3" id="">
						<div style="width: auto; height:auto; height:auto;margin-top:5px;margin-left:49px;width: 300px;">
							<p style="margin-bottom:10px;">
								<span class="fp_span" >金额(元)：</span>
								<input class="input_amonut1 a easyui-numberbox" readonly="readonly" name="amount" id="meetingAmount_${i.index}" value="${invoice.amount}" onchange="addAmonut(this)"data-options="precision:2"/>
								<!-- oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value=""  -->
							</p>
							<p style="margin-bottom:5px;" >
								<span class="fp_span">备注：</span>
								<input  class="input_amonut1 easyui-textbox" readonly="readonly" name="remark" id="meetingRemark_${i.index}" value="${invoice.remark}" />
							</p>
						</div>
					</td>
					<td style="vertical-align:top">
					</td>
				</tr>
			</tbody>
		</c:forEach>
	</table>
</form>	
<div style="height:10px"></div>
<script type="text/javascript">
var index =1;
var a =1;
var b =0;
var c =0;
var d =0;
var f =0;
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
      countDays(obj);
      cx();
}

function countDays(obj){
	var id=obj.id;
	var j=id.lastIndexOf("\_");
	var i=id.substring(j+1,id.length);
	var time1 =new Date($('#startTime_' + i).val());
	var time2 =new Date($('#endTime_' + i).val());
	var d = (time2 - time1) / 86400000 ;
	if (d > 0) {
		var amount =parseFloat($('#meetingAmount_' + i).val());
		if(!isNaN(amount)){
			var average =(amount/d).toFixed(2);
			$('#average_' + i).val(average);
		}
		$('#days_' + i).val(d);
	}else {
		$('#days_' + i).val(0);
		$('#average_' + i).val(0);
	}
}

function countTravel(obj){
	var id=obj.id;
	var j=id.lastIndexOf("\_");
	var i=id.substring(j+1,id.length);
	var num =0;
	var num1 =parseFloat($('#meetingAmount_' + i).val());
	var num2 =parseFloat($('#amount1_' + i).val());
	if (!isNaN(num1)) {
		num=num+num1;
		}
	if (!isNaN(num2)) {
		num=num+num2;
		}
	$('#amount2_' + i).val(num);
	addAmonut(obj);
	}

	function append(obj) {
		index = index + 1;
		var fromNum = parseInt(obj.parentNode.parentNode.children[5].children[0].children.length);
		$('#meetingfapiao').append('<tbody id="meeting_'+a+'" >'+
		'<tr><td class="td1" style="width: 100px;">&nbsp;&nbsp;<span id="meetingFp_'+a+'">发票'+(fromNum+1)+'</span>'+
		'<input type="text" id="meetingfp_'+a+'" name="fileId" hidden="hidden">'+
		'<input type="file" id="meetingImage_'+a+'" onchange="upImageFile(this)" hidden="hidden"></td>'+
		'<td class="td2" colspan="3" id="meetingZfbimagetd_'+a+'" style="width: 150px;">'+
		'<a onclick="clickUpFile(this)" id="click_'+a+'" style="font-weight: bold;" href="#">'+
		'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">'+
		'</a></td>'+
		'<td class="td2" colspan="3" id="">'+
		'<div style="width: auto; height:auto; height:auto;margin-top:5px;margin-left:49px;width: 300px;">'+
		'<p style="margin-bottom:10px;">'+
		'<span class="fp_span" >金额(元)：</span>'+
		'<input class="input_amonut1 a easyui-numberbox" name="amount" id="meetingAmount_'+a+'" onchange="addAmonut(this)"data-options="precision:2"/>'+
		'</p>'+
		'<p style="margin-bottom:5px;" >'+
		'<span class="fp_span">备注：</span>'+
		'<input  class="input_amonut1 easyui-textbox" name="remark" id="meetingRemark_'+a+'" value="" />'+
		'</p></div>'+
		'</td>'+
		'<td style="vertical-align:top">'+
		'<div>'+
		'<a onclick="deleteTravel(this)" style="float: right;" href="#" > '+
		'<img style="vertical-align:bottom;margin-left:0px;margin-right: 5px;margin-top: 5px;" src="${base}/resource-modality/${themenurl}/button/gb1.jpg">'+
		'</a>'+
		'</div>'+
		'</td>'+
		'</tr></tbody>');
		$.parser.parse($('#meeting_'+a).parent());
		
		a = a + 1;
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

	function clickUpFile(obj) {
		var id = obj.id;
		var i = id.lastIndexOf("\_");
		var j = id.substring(i + 1, id.length);
		$('#meetingImage_' + j).click();
	}

	//上传图片文件转化为base64在页面显示
	function upImageFile(obj) {
		var id = obj.id;
		var i = id.lastIndexOf("\_");
		var j = id.substring(i + 1, id.length);
		if (obj == null || obj == "") {
			return;
		}
		var files = obj.files;
		var formData = new FormData();
		for (var i = 0; i < files.length; i++) {
			formData.append("imageFile", files[i]);//图片文件
			$.ajax({
						url : base + '/base64/uploadImage',
						type : 'post',
						data : formData,
						cache : false,
						processData : false,
						contentType : false,
						async : false,
						dataType : 'json',
						success : function(data) {
							upladFp(obj, "meeting", "fp04");
							
				        	var num = obj.parentNode.parentNode.parentNode.id;
				        	$('#meetingZfbimagetd_'+j).empty();
				        	$('#meetingImage_'+j).val("");
				        	var x=num.lastIndexOf("\_");
				   	     	var y=num.substring(x+1,num.length);
				        	if(y!=0){
				        		$('#meetingZfbimagetd_' + j)
								.append(
										'<img style="vertical-align:bottom;margin-left:0px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="meetingsc_'
												+ j
												+ '" onclick="deleteImage(this)">    删除</a>');
					        	}else{
					        		$('#meetingZfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:0px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="meetingsc_'+j+'" onclick="deleteImage(this)">    删除</a>');
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
	     var num = obj.parentNode.parentNode.parentNode.id;
     	$('#meetingZfbimagetd_'+j).empty();
     	$('#meetingImage_'+j).val("");
     	var x=num.lastIndexOf("\_");
	     var y=num.substring(x+1,num.length);
	   	  if(y!=0){
	   		$('#meetingZfbimagetd_' + j)
			.append(
					'<a onclick="clickUpFile(this)" id="click_'
							+ j
							+ '" style="font-weight: bold;" href="#">'
							+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"'
							+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
      	}else{
      		$('#meetingZfbimagetd_'+j).append('<a onclick="clickUpFile(this)" id="click_'+j+'" style="font-weight: bold;" href="#">'+
					'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)"'
					+' onMouseOut="mouseOut(this)"></a>');
      	}
		$('#meetingfp_' + j).val(null);
		$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_'+j).html("");
	}
	//选择人员
	function chooseUser(obj){
		var id =obj.id;
		var i=id.lastIndexOf("\_");
	    var j=id.substring(i+1,id.length);
		var win=creatSecondWin('选择住宿人员',860,580,'icon-search','/user/chooseUser?index='+j+''); 
		win.window('open');
	}
	

	function  deleteTravel(item){
		
		var fromNum = item.parentNode.parentNode.parentNode.parentNode.parentNode.children.length;
		var id = item.parentNode.parentNode.parentNode.parentNode.id;
		$("#"+id).remove();
		var arr=id.split("_");
		for(var i=1;i<fromNum;i++){
			if('meeting'==arr[0]){
				var tableId = $('#meetingfapiao').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+(i+1));
			}
			
		}
		addAmonut(item);
		return ;
	}
</script>
