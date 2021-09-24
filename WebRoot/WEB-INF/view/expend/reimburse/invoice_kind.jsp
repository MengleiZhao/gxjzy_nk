<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<style>
.invoice{width: 124px;height: 34px;border:0;margin-top: 18px}
.invoice p{color: #666666;text-align: center;height: 34px;line-height: 34px}
</style>

<div style="border: 1px solid #d9e3e7;text-align: center;height: 327px;">
	<div style="width: 450px;height: 100%;border: 0;float: left;display: table">
		<div style="display: table-cell;vertical-align: middle;">
			<img src="${base}/resource-modality/${themenurl}/invoice/fp1.png" id="invoice-png"/>
		</div>
	</div>
	<div style="width: 124px;float: left;">
		<a href="#" onclick="openInvoiceAdd('1')" onMouseOver="invoiceMouseOver('1')">
			<div class="invoice" style="background: url('${base}/resource-modality/${themenurl}/invoice/fpdt1.png');" onMouseOver="divMouseOver(this)" onMouseOut="divMouseOut(this)">
				<p>普通发票</p>
			</div>
		</a>
		
		<a href="#" onclick="openInvoiceAdd('2')" onMouseOver="invoiceMouseOver('2')">
			<div class="invoice" style="background: url('${base}/resource-modality/${themenurl}/invoice/fpdt1.png');" onMouseOver="divMouseOver(this)" onMouseOut="divMouseOut(this)">
				<p>增值税专用发票</p>
			</div>
		</a>
		
		<a href="#" onclick="openInvoiceAdd('3')" onMouseOver="invoiceMouseOver('3')">
			<div class="invoice" style="background: url('${base}/resource-modality/${themenurl}/invoice/fpdt1.png');" onMouseOver="divMouseOver(this)" onMouseOut="divMouseOut(this)">
				<p>机打发票</p>
			</div>
		</a>
		
		<a href="#" onclick="openInvoiceAdd('4')" onMouseOver="invoiceMouseOver('4')">
			<div class="invoice" style="background: url('${base}/resource-modality/${themenurl}/invoice/fpdt1.png');" onMouseOver="divMouseOver(this)" onMouseOut="divMouseOut(this)">
				<p>定额发票</p>
			</div>
		</a>
		
		<a href="#" onclick="openInvoiceAdd('5')" onMouseOver="invoiceMouseOver('5')">
			<div class="invoice" style="background: url('${base}/resource-modality/${themenurl}/invoice/fpdt1.png');" onMouseOver="divMouseOver(this)" onMouseOut="divMouseOut(this)">
				<p>剪开式发票</p>
			</div>
		</a>
		
		<a href="#" onclick="openInvoiceAdd('6')" onMouseOver="invoiceMouseOver('6')">
			<div class="invoice" style="background: url('${base}/resource-modality/${themenurl}/invoice/fpdt1.png');" onMouseOver="divMouseOver(this)" onMouseOut="divMouseOut(this)">
				<p>机动车专用发票</p>
			</div>
		</a>
	</div>
</div>

<script type="text/javascript">
//打开发票信息添加页面
function openInvoiceAdd(kind){
	var win = creatFirstWin('发票信息', 1006, 580, 'icon-search', '/invoice/invoiceAdd?type=add&kind='+kind);
	win.window('open');
}
//发票样式转化
function invoiceMouseOver(kind){
	$("#invoice-png").attr("src","${base}/resource-modality/${themenurl}/invoice/fp"+kind+".png");
}
//div图片鼠标移入事件
function divMouseOver(obj) {
	$(obj).css("background-image","url(${base}/resource-modality/${themenurl}/invoice/fpdt2.png)");
	$(obj).find("p").css("color","#ffffff");
}
//div图片鼠标移出事件
function divMouseOut(obj) {
	$(obj).css("background-image","url(${base}/resource-modality/${themenurl}/invoice/fpdt1.png)");
	$(obj).find("p").css("color","#666666");
}
</script>