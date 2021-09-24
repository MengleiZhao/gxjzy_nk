<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="drfpdg" class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
toolbar: '#drfptb',
<c:if test="${!empty bean.rId}">
url: '${base}/reimburse/invoice?id=${bean.rId}',
</c:if>
<c:if test="${empty bean.rId}">
url: '',
</c:if>
method: 'post',
<c:if test="${empty detail2}">
onClickRow: onClickRow2,
</c:if>
striped : true,
nowrap : false,
rownumbers:true,
scrollbarSize:0,
singleSelect: true,
">
	<thead>
		<tr>
			<th data-options="field:'iId',hidden:true"></th>
			<th data-options="field:'invoiceCode',align:'center',width:150">发票代码</th>
			<th data-options="field:'invoiceNum',align:'center',width:150">发票号码</th>
			<th data-options="field:'checkCode',hidden:true"></th>
			<th data-options="field:'invoiceTime',align:'center',width:110,formatter:getTimeFormat">开票时间</th>
			<th data-options="field:'zjzt',align:'center',width:70,formatter:zjzt">验真</th>
			<th data-options="field:'cfzt',align:'center',width:70,formatter:cfzt">验重</th>
			<th data-options="field:'buyerName',hidden:true"></th>
			<th data-options="field:'buyerCode',hidden:true"></th>
			<th data-options="field:'buyerAddressTel',hidden:true"></th>
			<th data-options="field:'buyerBankAccount',hidden:true"></th>
			<th data-options="field:'priceCapitals',hidden:true"></th>
			<th data-options="field:'priceLowerCase',hidden:true"></th>
			<th data-options="field:'sellerName',hidden:true"></th>
			<th data-options="field:'sellerCode',hidden:true"></th>
			<th data-options="field:'sellerAddressTel',hidden:true"></th>
			<th data-options="field:'sellerBankAccount',hidden:true"></th>
			<th data-options="field:'invoiceRemark',hidden:true"></th>
			<th data-options="field:'payee',hidden:true"></th>
			<th data-options="field:'checker',hidden:true"></th>
			<th data-options="field:'drawer',hidden:true"></th>
			<th data-options="field:'couponList',hidden:true"></th>
			<th data-options="field:'invoiceCZ',align:'left',width:85,formatter:invoiceCZ">操作</th>
		</tr>
	</thead>
</table>
<c:if test="${empty detail2}">
<div id="drfptb" style="height:30px">
	<a href="javascript:void(0)" onclick="removeit2()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="openInvoiceKind(${bean.rId})" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<input type="hidden" id="rfpJson" name="fapiao"/>

<script type="text/javascript">
/* $('#drfpdg').datagrid({
	columns: [[
		{field: 'naId', hidden:true},
		{field: 'invoiceCode', title: '发票代码', width: 150, editor: {type: 'textbox'}},
		{field: 'invoiceNum', title: '发票号码', width: 150, editor: {type: 'textbox'}},
		{field: 'openTime', title: '开票时间', width: 150, editor: {type: 'datetimebox'}},
		{field: 'fileId', hidden:true},
		{field: 'fileName', hidden:true},
		{field: 'fpFileUpload', title: '发票附件上传', width: 185, 
			formatter:function (value, row, index) {
				if(row.fileId != "" && row.fileId != null) {
					var id='"'+row.fileId+'"';
					var str1 = "<a href='${base}/attachment/download/"+row.fileId+"'>"+row.fileName+"</a>";
					var str2 = "<a href='#' onclick='deleteFpAttac("+id+")' style='color:red'>删除</a>";
					var str="";
					if(${empty detail2}){
						str = str1 +"&nbsp;&nbsp;"+ str2;
					} else {
						str = str1;
					}
					
                    return str;
                }else{
                	if(${empty detail2}){
	                    var str = "<a href='#' style='color:blue' onclick='this.parentNode.childNodes[1].click()'>上传文件</a>"+
	                    		  "<input type='file' onchange='uploadfile(this)' hidden='hidden'>";
	                    return str;
                	} else {
                		return null;
                	}
                }
			} 
		},
	]]
}); */


//打开发票种类选择页面
function openInvoiceKind(id) {
	var win = creatFirstWin('发票类型', 500, 500, 'icon-search', '/invoice/invoiceKind');
	win.window('open');
}

var invoicejson=null;
//发票操作
function invoiceCZ(val, row, index) {
	if(${empty detail2}){
		return "<table><tr style='width: 75px;height:20px'><td style='width: 25px'>"+
		   "<a href='#' onclick='openInvoiceEdit("+JSON.stringify(row)+","+row.iId+")' class='easyui-linkbutton'>"+
		   "<img style='vertical-align:middle' onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"+
		   "</a></td></tr></table>";
	} else {
		return "<table><tr style='width: 75px;height:20px'><td style='width: 25px'>"+
		   "<a href='#' onclick='openInvoiceCheck("+JSON.stringify(row)+","+row.iId+")' class='easyui-linkbutton'>"+
		   "<img style='vertical-align:middle' onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"+
		   "</a></td></tr></table>";
	}
	
}


//修改发票页面打开
function openInvoiceEdit(row,id) {
	invoicejson=row;//将发票信息放入全局变量之中
	if(id=="undefined"||id==null){
		//打开发票编辑页面
		var win = creatFirstWin('发票信息', 1006, 580, 'icon-search', '/invoice/invoiceAdd?type=edit&kind='+row.invoiceType);
		win.window('open');
	} else {
		//打开发票编辑页面
		var win = creatFirstWin('发票信息', 1006, 580, 'icon-search', '/invoice/invoiceAdd?type=edit&id='+id+'&kind='+row.invoiceType);
		win.window('open');
	}
}

//查看发票信息
function openInvoiceCheck(row,id) {
	invoicejson=row;//将发票信息放入全局变量之中
	
	//打开发票编辑页面
	var win = creatFirstWin('发票信息', 1006, 580, 'icon-search', '/invoice/invoiceCheck?type=edit&id='+id+'&kind='+row.invoiceType);
	win.window('open');
}

function zjzt() {
	return "<img style='vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/list/zp.png'>";
}

function cfzt() {
	return "<img style='vertical-align:middle' src='"+base+"/resource-modality/${themenurl}/list/tg.png'>";
}


//明细表格添加删除，保存方法
var editIndex2 = undefined;
function endEditing2() {
	if (editIndex2 == undefined) {
		return true
	}
	if ($('#drfpdg').datagrid('validateRow', editIndex2)) {
		var ed = $('#drfpdg').datagrid('getEditor', {
			index : editIndex2,
			field : 'costDetail'
		});
		$('#drfpdg').datagrid('endEdit', editIndex2);
		editIndex2 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow2(index) {
	if (editIndex2 != index) {
		if (endEditing2()) {
			$('#drfpdg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex2 = index;
		} else {
			$('#drfpdg').datagrid('selectRow', editIndex2);
		}
	}

}
function append2() {
	if (endEditing2()) {
		$('#drfpdg').datagrid('appendRow', {});
		editIndex2 = $('#drfpdg').datagrid('getRows').length - 1;
		$('#drfpdg').datagrid('selectRow', editIndex2).datagrid('beginEdit',
				editIndex2);
	}

	/* //页面随滚动条置底
	var div = document.getElementById('westDiv');
	div.scrollTop = div.scrollHeight; */
}
function removeit2() {
	if (editIndex2 == undefined) {
		return
	}
	$('#drfpdg').datagrid('cancelEdit', editIndex2).datagrid('deleteRow',
			editIndex2);
	editIndex2 = undefined;
}
function accept2() {
	if (endEditing2()) {
		$('#drfpdg').datagrid('acceptChanges');
	}
}

//时间格式化
function getTimeFormat(val) {
	//alert(val)
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "未填写";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
}

</script>

