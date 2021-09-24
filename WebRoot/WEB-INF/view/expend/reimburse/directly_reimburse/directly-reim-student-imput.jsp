<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<form id="directly-reim-imput-form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div style="width: 436px;height: 127px;border:1px #d9e3e7 solid;">
	<table style="width: 436px;height: 127px;" cellpadding="0" cellspacing="0" border="0" >
		<tr>
			<td style="padding-left: 20px;width: 60px">导入文件</td>
			<td>
				<input style="width: 260px;" value="" readonly="readonly" id="filDirReim" name="" class="easyui-textbox"/>
				<input type="file" id="fDirReim" name="xlsx" onchange="upFile()" hidden="hidden" >
			</td>
			<td style="padding-right: 20px">
				<a onclick="$('#fDirReim').click()" style="font-weight: bold;" href="#">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
				</a>
			</td>
		</tr>
		<tr style="text-align: center;visibility: hidden; " id="mingxiprogid" >
			<td colspan="3">
				<div style="background:#EFF5F7;width:400px;height:10px;margin-top:5px;" >
		       <div id="DirReimprogressNumber" style="background:#3AF960;width:0px;height:10px" >
		       </div>文件导入中...&nbsp;&nbsp;<font id="DirReimpercent">0%</font> 
				</div>
			</td>
		</tr>
		<tr style="text-align: center;" id="buttonid">
			<td colspan="3">
				<a href="javascript:void(0)" onclick="save()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</td>
		</tr>
	</table>
	
</div>
</form>

<script type="text/javascript">
function progressFunction(index,total) {
		  //index：文件加载的大小   total：文件总的大小                    
	      var percentComplete = Math.round(index * 100 / total);    
	      //加载进度条，同时显示信息          
	      $("#DirReimpercent").html(percentComplete + '%');
	      //percentComplete*2  这个2是根据总像素大小来改变的，如果是300px就 *3
	      $("#DirReimprogressNumber").css("width",""+percentComplete*4+"px");   
	} 
function upFile(){
	
	var url = $("#fDirReim").val();
	$('#filDirReim').textbox('setValue',url);
}

function save() {
	$("#mingxiprogid").css("visibility","visible");
	$("#buttonid").css("visibility","hidden");
	//保存导入的xml文件
	var url = $('#filDirReim').textbox('getValue');
	
	var index1=url.lastIndexOf(".");
    var index2=url.length;
	var arr = url.substring(index1+1,index2);
	var formData = new FormData($('#directly-reim-imput-form')[0]);
	var type = '${type}';
	if(arr != "xlsx") {
		alert("请上传xlsx文件！");
		$("#mingxiprogid").css("visibility","hidden");
		$("#buttonid").css("visibility","visible");
	} else {
		$.ajax({
        	type: 'post',
            url: base+'/directlyReimburse/directlyReimCollect?type='+type,
			data: formData,
			cache: false,
			processData: false,
			contentType: false,
			dataType: 'json',
		}).success(function (data) {
			ajaxAppendOutCome(data);
			closeFirstWindow();
		}).error(function () {
			alert('上传失败！');
			$("#mingxiprogid").css("visibility","hidden");
			$("#buttonid").css("visibility","visible");
			closeFirstWindow();
		});
		
	} 
}

//删除支出金额为零的项，与行删除方法不同
function deleteOutRows(row,index){
	row.parentNode.removeChild(row);
	arr.push(index);					//往数组末尾添加值 值为删除行序号
	arr.sort();							//按数字顺序排序
	var delNum=arr.join(",");			//用逗号分隔数组元素	
	$("#delIndex").val(delNum);			//将数据存到隐藏域中
	
	//重新计算支出金额
	autoCalTotal(null);
	
}
function ajaxAppendOutCome(data){
	
	var type = '${type}';
	if(type=='student'){
		for (var i = 0; i < data.length; i++) {
			$('#payer_info_student_tab').datagrid('appendRow', {
				sclass :data[i].sclass,
				payeeName :data[i].payeeName,
				proName :data[i].proName,
				numberDays :data[i].numberDays,
				everyoneAmount :data[i].everyoneAmount,
				bankAccount :data[i].bankAccount,
				payeeAmount :data[i].payeeAmount,
				tel :data[i].tel,
				remark :data[i].remark
			});
		}
		exportStudentDetailMoney();
	}
	if(type=='ccb'){
		for (var i = 0; i < data.length; i++) {
			$('#payer_info_ccb_tab').datagrid('appendRow', {
				payeeName :data[i].payeeName,
				company :data[i].company,
				duty :data[i].duty,
				tel :data[i].tel,
				idCard :data[i].idCard,
				bankAccount :data[i].bankAccount,
				planAmount :data[i].planAmount,
				deductionAmount :data[i].deductionAmount,
				payeeAmount :data[i].payeeAmount,
				remark :data[i].remark
			});
		}
		exportCCBDetailMoney();
	}
	if(type=='noCCB'){
		for (var i = 0; i < data.length; i++) {
			$('#payer_info_no_ccb_tab').datagrid('appendRow', {
				payeeName :data[i].payeeName,
				company :data[i].company,
				duty :data[i].duty,
				tel :data[i].tel,
				idCard :data[i].idCard,
				bank :data[i].bank,
				bankAccount :data[i].bankAccount,
				planAmount :data[i].planAmount,
				deductionAmount :data[i].deductionAmount,
				payeeAmount :data[i].payeeAmount,
				remark :data[i].remark
			});
		}
		exportNoCCBDetailMoney();
	}

}
</script>