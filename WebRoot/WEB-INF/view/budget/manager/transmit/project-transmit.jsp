<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="win-div">
<form id="index_release_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" id="release-plan-easyAcc" style="width:662px;margin-left: 20px;">
					<div title="基本信息" id="sqsqjbxx" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1">申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" readonly="readonly" value="${bean.deptName}" style="width: 200px"/>
								</td>
								
								<td class="td3">
									<input type="hidden" value="${bean.bId}" name="bId"/>
									<input type="hidden" id="releaseJson" name="releaseJson"/>
									
								</td>
								
								<td class="td1">指标编码</td>
								<td class="td2">
									<input class="easyui-textbox" readonly="readonly" id="release-plan-indexCode" value="${bean.indexCode}" style="width: 200px"/>
								</td>
							</tr>
						
							<tr class="trbody">
								<td class="td1">指标名称</td>
								<td class="td2">
									<input class="easyui-textbox" readonly="readonly" value="${bean.indexName}" style="width: 200px"/>
								</td>
								
								<td class="td3"></td>
								
								<td class="td1">指标总额</td>
								<td class="td2">
									<input id="zbze1" class="easyui-numberbox" readonly="readonly" value="${bean.pfAmount}" style="width: 200px" precision="2"
									data-options="icons: [{iconCls:'icon-wanyuan'}]"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">累计下达金额</td>
								<td class="td2">
									<input id="ljxd21" class="easyui-numberbox" value="${bean.xdAmount}" style="width: 200px" precision="2" readonly="readonly"
									data-options="icons: [{iconCls:'icon-wanyuan'}]"/>
								</td>
								
								<td class="td3"></td>
								
								<td class="td1">累计下达次数</td>
								<td class="td2">
									<input  class="easyui-numberbox" value="${num}" style="width: 130px" readonly="readonly">
									<a href="javascript:void(0)" onclick="openXdmx('${bean.bId}')" style="height: 20px">
										<img style="vertical-align: middle;" src="${base}/resource-modality/${themenurl}/button/xdmx1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
									</a>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">下达方式</td>
								<td class="td2">
									<c:if test="${empty bean.releaseType}">
										<input id="project-transmit-xdfs" style="width: 200px;" name="releaseType" value="0"
										data-options="valueField: 'releaseType',textField: 'value',
										data: [{releaseType: '0',value: '--请选择--'},{releaseType: '1',value: '一次性全部下达'},{releaseType: '2',value: '分批次下达'},{releaseType: '3',value: '定时自动下达'}]"/>
									</c:if>
									<c:if test="${!empty bean.releaseType}">
										<input id="project-transmit-xdfs" style="width: 200px;" name="releaseType" value="${bean.releaseType}" readonly="readonly"
										data-options="valueField: 'releaseType',textField: 'value',
										data: [{releaseType: '0',value: '--请选择--'},{releaseType: '1',value: '一次性全部下达'},{releaseType: '2',value: '分批次下达'},{releaseType: '3',value: '定时自动下达'}]"/>
									</c:if>
								</td>
								
								<td class="td3"></td>
								
								<td class="td1">本次下达金额</td>
								<td>
									<input id="bcxd11" class="easyui-numberbox" value="${bean.pfAmount-bean.xdAmount}" style="width: 200px" precision="2"
									data-options="icons: [{iconCls:'icon-wanyuan'}]" name="bcReleaseAmount"/>
									<a id="bcxdjetx" style="color:#ff6800;display: none;">下达金额超过指标总额</a>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">指标下达进度</td>
								<td colspan="4">
									<div id="zbxdp1" class="easyui-progressbar" data-options="value:0"  style="width:550px;height: 14px;"></div>
								</td>
							</tr>
						</table>
						
						<%-- <div>
							<div id="release-plan-tab-tb" style="height:30px">
								<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
								<a style="float: right;">&nbsp;&nbsp;</a>
								<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
							</div>
							
						</div> --%>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveTransmit()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeIndexReleaseWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	</div>
</form>
</div>

<script type="text/javascript">
//进度条加载
var timeout=null;
function start2() {
	 var xdAmount=0;
	 if(${bean.releaseStauts ==1}){
		 xdAmount=${bean.xdAmount}+"";
	 }
	 var v = parseFloat(xdAmount/${bean.pfAmount})*100;
	 var value1 = $('#zbxdp1').progressbar().progressbar('getValue');
     if (value1 < v){
        value1 += Math.floor(Math.random() * 2);  
         $('#zbxdp1').progressbar('setValue', value1);  
             if(value1<=30){  
                 $(".progressbar-value .progressbar-text").css("background-color","#DF4134");
             }else if (value1<=70){
                 $(".progressbar-value .progressbar-text").css("background-color","#EABA0A");
             }else if (value1>70){
                 $(".progressbar-value .progressbar-text").css("background-color","#53CA22");
             }
         timeout=setTimeout(arguments.callee, 10);
     } 
     
}

$(document).ready(function(){
	start2();//页面加载完成时加载进度条
	var type=$('#project-transmit-xdfs').combobox().combobox('getValue');
	if(type=='1'){//当下达方式为一次性全部下达和定时自动下达时，将本次下达金额空格改为不可修改状态
		$("#bcxd11").numberbox().numberbox({readonly:true});
	}
	if(type=='3'){
		$("#bcxd11").numberbox().numberbox({readonly:true});
		
		$("#release-plan-easyAcc").accordion().accordion('add', {//创建计划下达明细手风琴页面
			title: '计划下达明细',
			content:"<table id='release-plan-tab' style='width:660px;height:auto'></table>",//手风琴内写入空的表格
			iconCls:"icon-xxlb",//手风琴标题左侧所用的图标
			selected : false,
		});
		
		var code=$("#release-plan-indexCode").textbox().textbox('getValue');//获得指标编码
		
		$("#release-plan-tab").datagrid({//创建计划表格的内容
			url:base+'/transmit/releasePlanList?code='+code,
			columns:[[ 
	            {field:'pId',hidden:true},  
	            {field:'releaseTime',title:'计划下达时间',width:200,align:'left',formatter: ChangeDate},
	            {field:'releaseAmount',title:'下达金额[万元]',width:200,align:'left'},
	            /* {field:'xdhsyje',title:'下达后剩余金额[万元]',width:140,align:'left'}, */
	            {field:'sysj',title:'剩余时间',width:230,align:'left',formatter: sysj},
	        ]],
	        rownumbers:true,//显示行号
	        striped : true,
	        nowrap : false,
	        rownumbers:true,
	        scrollbarSize:0,
	        singleSelect: true,
	        onLoadSuccess:loadSuccess,//加载完成后执行
		});
	}
});

//剩余时间计算
function sysj(val, row) {
	if(row.type==1){
		return "已下达";
	} else if(row.releaseTime!=null && row.releaseTime!="undefined") {
		var releaseTime = new Date(row.releaseTime);//计划下达时间
		var now = new Date();
		var time = releaseTime.getTime()-now.getTime();
		
		var d = parseInt(time / (1000 * 60 * 60 * 24));
		var h = parseInt((time % (1000 * 60 * 60 * 24))/(1000 * 60 * 60));
		var m = parseInt(((time % (1000 * 60 * 60 * 24))%(1000 * 60 * 60))/(1000*60));
		var s = parseInt((((time % (1000 * 60 * 60 * 24))%(1000 * 60 * 60))%(1000*60))/1000);
		
		var t = d + h + m + s;//t=0说明已经到了定时任务的执行时间
		
		if(row.pId!=null && row.pId!="undefined" && t==0) {//当下达时间=当前时间时刷新计划下达明细列表和预算指标列表（定时任务执行时刷新列表将立即下达按钮隐藏防止误操作）
			$("#release-plan-tab").datagrid('reload');
			$("#transmitBasicIndex").datagrid('reload');
			$("#transmitProIndex").datagrid('reload');
		}
		
		var ljxd = "<a href='#' style='color:red' onclick='ljxd("+row.pId+")'>立即下达</a>";
		
		
		if(row.pId!=null && row.pId!="undefined") {
			return d+"天"+h+"小时"+m+"分"+s+"秒     "+ljxd;
		} else {
			return d+"天"+h+"小时"+m+"分"+s+"秒";//pid不存在说明还没有保存，所以不存在立即下达
		}
	}
}

$('#project-transmit-xdfs').combobox({
    onChange:function(newValue,oldValue){//当下达方式改变是改变表单的内容
		if(newValue=='1'){
			var l=$('#zbze1').numberbox('getValue')-$('#ljxd21').numberbox('getValue');//指标总额-累计下达金额=本次下达金额
			$("#bcxd11").numberbox('setValue',l);//设置本次下达金额
			$("#bcxd11").numberbox({readonly:true});//修改为不可修改状态
			
			var s=$("#release-plan-easyAcc").accordion('panels').length;//判断手风琴个数
			if(s==2){//手风琴个数为1时不需要删除（强行删除会报错）
				$("#release-plan-easyAcc").accordion('remove','计划下达明细');//删除计划下达手风琴
			}
		}
		if(newValue=='2'){//分批次下达时可随意填写下达金额
			$("#bcxd11").numberbox({readonly:false});//修改为可编辑状态
			
			var s=$("#release-plan-easyAcc").accordion('panels').length;//判断手风琴个数
			if(s==2){//手风琴个数为1时不需要删除（强行删除会报错）
				$("#release-plan-easyAcc").accordion('remove','计划下达明细');//删除计划下达手风琴
			}
		}
		if(newValue=='3'){
			var l=$('#zbze1').numberbox('getValue')-$('#ljxd21').numberbox('getValue');//指标总额-累计下达金额=本次下达金额
			$("#bcxd11").numberbox('setValue',l);//设置本次下达金额
			$("#bcxd11").numberbox({readonly:true});//修改为可编辑状态
			
			$("#release-plan-easyAcc").accordion('add', {//创建计划下达明细手风琴页面
				title: '计划下达明细',
				content:"<div id='release-plan-tab-tb' style='height:30px;padding-top: 10px'>"+//手风琴内添加表格的增删按钮
						"<a style='color: red;'>可下达金额：</a><input style='width: 100px;height:25px' id='planKXDJE' class='easyui-numberbox' value='${bean.pfAmount-bean.xdAmount}' readonly='readonly' data-options='precision:2,icons: [{iconCls:\"icon-wanyuan\"}]'/>"+
						"<a href='javascript:void(0)' onclick='removeit()' style='float: right;'><img src='${base}/resource-modality/${themenurl}/button/scyh1.png' onMouseOver='mouseOver(this)' onMouseOut='mouseOut(this)'></a>"+
						"<a style='float: right;'>&nbsp;&nbsp;</a>"+
						"<a href='javascript:void(0)' onclick='append()' style='float: right;'><img src='${base}/resource-modality/${themenurl}/button/tjyh1.png' onMouseOver='mouseOver(this)' onMouseOut='mouseOut(this)'></a>"+
						"</div>"+
						"<table id='release-plan-tab' style='width:660px;height:auto'></table>",//手风琴内写入空的表格
				iconCls:"icon-xxlb",//手风琴标题左侧所用的图标
			});
			
			$("#release-plan-tab").datagrid({//创建计划表格的内容
				columns:[[ 
		            {field:'pId',hidden:true},  
		            {field:'releaseTime',title:'计划下达时间',width:200,align:'left',editor: { type: 'datetimebox',required: true, } },    
		            {field:'releaseAmount',title:'下达金额[万元]',width:200,align:'left',editor:{type:'numberbox',options:{onChange:releaseAmountChange,precision:2}} },    
		            /* {field:'xdhsyje',title:'下达后剩余金额[万元]',width:140,align:'left'}, */
		            {field:'sysj',title:'剩余时间',width:230,align:'left',formatter: sysj},            
		        ]],
		        rownumbers:true,//显示行号
		        onClickRow: onClickRow,
		        striped : true,
		        nowrap : false,
		        rownumbers:true,
		        scrollbarSize:0,
		        singleSelect: true,
		        onAfterEdit:onEndEdit,//结束一行的编辑后执行
			});

		}
    }
});

//计划下达明细列表中下达金额发生改变时触发
function releaseAmountChange(newValue,oldValue) {
	var row = $("#release-plan-tab").datagrid('getSelected');//获得选择行
	var index=$("#release-plan-tab").datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $("#release-plan-tab").datagrid('getEditors', index);//获得选中行
	
	var num = 0;
	var rows = $("#release-plan-tab").datagrid('getRows');//获得表格的所有行
	for(var i=0;i<rows.length;i++){
		if(i!=index){	//统计--- 除当前编辑行外--- 所有行的计划下达金额
			if(rows[i].releaseAmount!=""&&rows[i].releaseAmount!=null){
				num += parseFloat(rows[i].releaseAmount);
			}
		}
	}
	
	if(newValue!=""&&newValue!=null) {
		num += parseFloat(newValue);//总的下达金额加上发生改变的newValue
	}
	
	var kxdje = $("#bcxd11").numberbox('getValue');//获得可下大金额数（因为计划下达需要一次性将--指标可以下达的金额--全部列入计划，因此数值上可以等于页面中的-本次下达金额-框（计算公式相同），但是概念是不同的这里为了方便所以取了-本次下达金额-框中的值）
	
	var amount = parseFloat(num-kxdje).toFixed(2);
	if(amount>0){//下达金额超出可下大金额
		alert('下达金额超出可下达金额，请核对！');
		tr[1].target.textbox('setValue','0');
		newValue=0;
	} else {
		$("#planKXDJE").numberbox('setValue',parseFloat(kxdje-num).toFixed(2));//给可下大金额框赋值
	}
}

//这个方法是保存完成之后查看时加载
var timechange1=null;
function loadSuccess() {//表格结束编辑开始计算剩余时间
	timechange1=setInterval("timeChange1()",1000);//设置循环的触发器100毫秒执行一次 
}

function timeChange1() {
	var len=$("#release-plan-tab").datagrid('getRows').length;
	for(var i=0;i<len;i++){
		$("#release-plan-tab").datagrid('refreshRow', i);//刷新所有的行，以此不断触发sysj方法，改变剩余时间
	}
}

//这个方法是没有保存，在编辑时加载
var timechange2=null;
function onEndEdit() {//结束一行的编辑后执行
	timechange2=setInterval("timeChange2()",1000);//设置循环的触发器1000毫秒执行一次 
}

function timeChange2() {
	var len=$("#release-plan-tab").datagrid('getRows').length;
	for(var i=0;i<len;i++){
		if(i!=editIndex) {
			$("#release-plan-tab").datagrid('refreshRow', i);//刷新除了---当前编辑行---之外的所有行，以此不断触发sysj方法，改变剩余时间
		}
	}
}

//计划立即下达的方法
function ljxd(id) {
	$.ajax({
		url: base+"/transmit/ljxd",
		type: "POST",
		data: {id:id},
		dataType: "json",
		success: function(data){
			if (data.success) {
				$("#release-plan-tab").datagrid('reload');
				$("#transmitBasicIndex").datagrid('reload');
				$("#transmitProIndex").datagrid('reload');
				$.messager.alert('系统提示', data.info, 'info');
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	})
}

//判断本次下达金额是否为负数或者超出指标总额
var bcxdflag=true;//本次下达的结果
$("#bcxd11").numberbox({onChange: function(newValue,oldValue) {
		var bcxd=$("#bcxd11").numberbox('getValue');
		var ljxd=$("#ljxd21").numberbox('getValue');
		var zbze=$("#zbze1").numberbox('getValue');
		
		var num = parseFloat(bcxd)+parseFloat(ljxd);
		if(num>zbze){
			$("#bcxdjetx").css("display","");
			bcxdflag=false;
		} else {
			$("#bcxdjetx").css("display","none");
			bcxdflag=true;
		}
		
		if(newValue<0){
			$("#bcxd11").numberbox('setValue',oldValue);
		}
		
		if(newValue==""){
			$("#bcxd11").numberbox('setValue',0);
		}
    }
});

//下达保存
function saveTransmit() {
	if(!bcxdflag){
		alert("您本次下达金额加上累计下达金额超过指标总额，请确认");
		return;
	}
	
	if($("#bcxd11").numberbox('getValue')==0){
		alert("您本次下达金额为0，请确认");
		return;
	}
	
	
	if($('#project-transmit-xdfs').combobox('getValue')==3){//当下达方式为3（定时自动下达）时需要保存下达计划表格信息
		accept();//保存计划列表，完成编辑
		var rows = $('#release-plan-tab').datagrid('getRows');//获取下达计划表格的行
		var release = "";
		for (var i = 0; i < rows.length; i++) {
			release = release + JSON.stringify(rows[i]) + ",";
		}
		$('#releaseJson').val(release);//将下达计划写入表单中
		
		var amount = $('#planKXDJE').numberbox('getValue');
		if(amount!=0){
			alert(amount!=0);
			alert("需要一次性做完全部的金额下达计划，请确认");
			return;
		}
	}
	
	//提交
	$('#index_release_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/transmit/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#transmitBasicIndex').datagrid('reload');
				$('#transmitProIndex').datagrid('reload');
				closeIndexReleaseWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				$('#index_release_form').form('clear');
				closeIndexReleaseWindow();
			}
		}
	});
}

//下达明细查看
function openXdmx(id) {
	var win = creatFirstWin('下达明细', 970, 580, 'icon-search', "/transmit/xdmx?id="+ id);
	win.window('open');
}

//关闭页面
function closeIndexReleaseWindow() {
	$("#custom_index_release_window").window('close');
	if(timechange1!=null){//定时器任务不等于空需要删除
		clearTimeout(timechange1);	//清除未保存时计划下达的时间定时器，防止页面关闭后前台报错
	}
	if(timechange2!=null){
		clearTimeout(timechange2);	//清除已经保存后查看计划下达的时间定时器，防止页面关闭后前台报错
	}
	/* if(timeout!=null){			//不清楚为什么clearTimeout只能清除一个定时器（默认清除代码中最后执行clearTimeout的任务）所以注销了代码，这段代码用作清除进度条定时器用（在进度条加载过程中关闭页面会在前台报错，所以在关闭页面时清除定时器）
		clearTimeout(timeout);
	} */
}

//时间格式化
function ChangeDate(val) {
	var t, y, m, d, h, i, s;
	if (val == null) {
		return "";
	}
	t = new Date(val);
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d)+ ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) + ':' + (s < 10 ? '0' + s : s);
}

//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#release-plan-tab').datagrid('validateRow', editIndex)) {
		var ed = $('#release-plan-tab').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#release-plan-tab').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#release-plan-tab').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#release-plan-tab').datagrid('selectRow', editIndex);
		}
	}
}
function append() {
	if (endEditing()) {
		$('#release-plan-tab').datagrid('appendRow', {});
		editIndex = $('#release-plan-tab').datagrid('getRows').length - 1;
		$('#release-plan-tab').datagrid('selectRow', editIndex).datagrid('beginEdit',
				editIndex);
	}
}
function removeit() {
	if (editIndex == undefined) {
		return
	}
	$('#release-plan-tab').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
}
function accept() {
	if (endEditing()) {
		$('#release-plan-tab').datagrid('acceptChanges');
	}
}
</script>