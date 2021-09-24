<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
 <html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="background-color: #f0f5f7;text-align: center;">	
 <link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/square-jelly-box.css" />
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top">
		<table id="white_EXP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td style="width: 80px;text-align:right;font-size: 12px; color: #666; ">业务领域：</td>
				<td style="width: 150px;padding-top: 4px;">
					<input class="easyui-combobox" id="select_fField" style="width: 150px;height: 25px;"  data-options="url:'${base}/lookup/lookupsJson?parentCode=YWLY',
					method:'get',valueField:'code',textField:'text',editable:false,multiple:true, panelHeight:'auto'">
				</td>
				<td>
					<span style="padding:6px 0 6px 0;line-height:28px; ">&nbsp;&nbsp;&nbsp;&nbsp;个数：
					<input id="expert_num" name="fNum" style="width: 150px; height:25px;"  class="easyui-numberbox"></input>&nbsp;&nbsp;
					<a href="#" onclick="method_extract();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/cq1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clear_extract();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					</span>
				</td>
			</tr>
		</table>
	</div>
		<div id="cartoon" style="display: none;position:absolute;margin-top:34px;height:410px;width:794px; background: rgba(255,255,255,1);z-index: 1000;">
			<div style="margin-top:150px;margin-left:360px;">
				<div class="la-square-jelly-box la-2x" style="">
			        <div></div>
			        <div></div>
				</div>
			<div class="item-title" style="margin-top:6px;color:#666;font-size:12px;"><span>正在抽取中...</span></div>
			</div>
		</div>
		<div style="height: 445px;">	
			<table id="expert_extract" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/expertgl/expertExtractList',
			method:'post',fit:true,pagination:false,singleSelect: true,scrollbarSize:0,loadMsg:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'feId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fexpertCode',align:'center',formatter:formatCellTooltip" width="20%">专家编号</th>
						<th data-options="field:'fexpertName',align:'center',formatter:formatCellTooltip" width="10%">专家名称</th>
						<th data-options="field:'fnowWork',align:'center',formatter:formatCellTooltip" width="12%">现从事专业</th>
						<th data-options="field:'fmTel',align:'center',formatter:formatCellTooltip" width="12%">联系手机</th>
						<th data-options="field:'ffield',align:'center',formatter:formatCellTooltip" width="18%">业务领域</th>
						<th data-options="field:'fbirthday',align:'center',resizable:false,sortable:true,formatter:formatAge" width="6%">年龄</th>
						<th data-options="field:'fexpertSex',align:'center',resizable:false,sortable:true,formatter:formatSex" width="6%">性别</th>
						<th data-options="field:'operation',align:'left',formatter:method_operation" width="9%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
			
		<div class="win-left-bottom-div">
			<a href="javascript:void(0)" onclick="saveRecord(1)" style="display: none" class="record_btn">
			<img src="${base}/resource-modality/${themenurl}/button/qrsx1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="saveRecord(2)" style="display: none" class="record_btn">
			<img src="${base}/resource-modality/${themenurl}/button/qx1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeFirstWindow()"  class="close_btn">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
<form id="record_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<input type="hidden" id="record_feId" name="fResult">
	<input type="hidden" id="record_num" name="fNum">
	<input type="hidden" id="record_fField" name="fField">
	<input type="hidden" id="record_fPersonNum" name="fPersonNum">
	<input type="hidden" id="record_fFlag" name=fFlag>
</form>
</div>


<script type="text/javascript">
$(function() {
    $('#select_fField').combobox({
        onClick: function () {
        	$('#select_fField').combobox('unselect','');
        }
    });
});

var num=0;	//抽取次数
//点击抽取
function method_extract() {
	   // alert("---"+$('#select_fField').combobox('getValues'));
	if($('#select_fField').combobox('getValues')==''){
	  alert("请选择业务领域！");
	  return;
	}
	if($('#expert_num').val()==""){
	  alert("请填写个数！");
	  return;
	} 
	var data=$('#select_fField').combobox('getValues');
	/* $('#expert_extract').datagrid({
		onBeforeLoad:function(){
			$('#cartoon').show();
			//alert("加载");
		},
		loaded : function(){},
		onLoadSuccess:function(data){
			
			//alert(data);
		},
	}); */
	$('#cartoon').show();
	//定时器
	setTimeout(function(){
		$('#cartoon').hide();
		}, 2000);
	 //清除动画
	
	$('#expert_extract').datagrid('load', {
		label:data.toString(),
		num:$('#expert_num').val(),
	});
	 $('.record_btn').show();
	 $('.close_btn').hide();
	 num+=1;
}


//清除查询条件
function clear_extract() {
	$('#expert_num').textbox('setValue','');
  $('#select_fField').combobox('clear');
  $('#select_fField').combobox('select','');
	$('#expert_extract').datagrid('load',{//清空以后，重新查一次
	});
}

function saveRecord(type){
	$('#record_num').val(num);	//抽取的次数
    var data=$('#select_fField').combobox('getValues');
    $('#record_fField').val(data.toString());	//抽取的领域
    var fPersonNum= $('#expert_num').val();	//抽取的个数
    $('#record_fPersonNum').val(fPersonNum);
    $('#record_fFlag').val(type);
	var rows=$('#expert_extract').datagrid("getRows");
    if (rows.length > 0) {
        $('#expert_extract').datagrid('selectRow',0);//grid加载完成后自动选中第一行
        var row=$('#expert_extract').datagrid("getSelections");//获取选中的数据
        var rowData = row[0].fremark;
        $('#record_feId').val(rowData);	//抽取的专家结果ID
    }else {
    	//没有抽到数据 失败
    	$('#record_fFlag').val(2);
    }
	 //提交保存记录
	$('#record_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/expertgl/saveRecord',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeFirstWindow();
				$('#extract_record').datagrid("reload");
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

function method_operation(val,row) {
	var checkType=row.fcheckType;
	if(row.fcheckType=="in" && row.fcheckStauts==9 && row.fisOutStatus!=9 && row.fisOutStatus!=0 && row.fisOutStatus!=-1){
		checkType="out";
	}
	var str='<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="expert_detail_lend(' + row.feId + ',\''+checkType+'\')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td>';
	return 	str+ '</tr></table>';
}
//查看
function expert_detail_lend(id,checkType) {
	var win = creatWin(' ', 970, 580, 'icon-search',"/expertgl/detail?checkType="+checkType+"&id=" + id);
	win.window('open'); 
} 
//性别
function formatSex(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;">' + " 男" + '</a>';
	} else if (val ==1) {
		return '<a style="color:#666666;">' + "女" + '</a>';
	} 
}
//年龄
function formatAge(val, row) {
	 //出生时间 毫秒
    var birthDayTime = new Date(val).getTime();
    //当前时间 毫秒
    var nowTime = new Date().getTime();
    //一年毫秒数(365 * 86400000 = 31536000000)
    return Math.ceil((nowTime-birthDayTime)/31536000000);
}
</script>

</body>

</html>
