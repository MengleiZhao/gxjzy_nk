<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>


<div style="border: 1px #dce5e9 solid;width: 476px;height: 407px">
	<div style="width: 436px;height: 350px;border: 0px;margin-left: 20px">
		<table style="width: 100%;" border="0" cellpadding="0" cellspacing="0">
			<tr style="height: 40px">
				<td style="width: 100px">使用部门</td>
				<td>
					<input class="easyui-textbox" readonly="readonly" value="办公室" style="width: 200px"/>
				</td>
			</tr>
			
			<tr style="height: 40px">
				<td style="width: 100px">指标编码</td>
				<td>
					<input class="easyui-textbox" readonly="readonly" value="${bean.indexCode}" style="width: 200px"/>
				</td>
			</tr>
			
		
			<tr style="height: 40px">
				<td style="width: 100px">指标名称</td>
				<td>
					<input class="easyui-textbox" readonly="readonly" value="${bean.indexName}" style="width: 200px"/>
				</td>
			</tr>
			
			<tr style="height: 40px" >
				<td style="width: 100px">指标总额</td>
				<td>
					<input class="easyui-numberbox" readonly="readonly" value="${bean.ysAmount}" style="width: 200px" precision="2"
					data-options="icons: [{iconCls:'icon-wanyuan'}]"/>
				</td>
			</tr>
			
			<tr style="height: 40px">
				<td style="width: 100px">下达方式</td>
				<td>
					<select class="easyui-combobox" style="width: 200px" id="xdfs">
						<option value="1">一次性全部下达</option>
						<option value="2">定额下达</option>
					</select>
					
				</td>
			</tr>
			
			<tr id="bcxdje1" style="height: 40px">
				<td style="width: 100px">本次下达金额</td>
				<td>
					<input class="easyui-numberbox" value="" style="width: 200px" precision="2"
					data-options="icons: [{iconCls:'icon-wanyuan'}]"/>
				</td>
			</tr>
			
			<tr id="bcxdje2" style="height: 40px">
				<td style="width: 100px">累计下达金额</td>
				<td>
					<input class="easyui-numberbox" value="${bean.ysAmount-bean.syAmount}" style="width: 200px" precision="2" readonly="readonly"
					data-options="icons: [{iconCls:'icon-wanyuan'}]"/>
				</td>
			</tr>
			
			<tr id="bcxdje2" style="height: 40px">
				<td style="width: 100px">指标下达进度</td>
				<td>
					<div id="zbxdp1" class="easyui-progressbar" data-options="value:0"  style="width:200px;height: 14px;"></div>
				</td>
			</tr>
			
			<tr id="bcxdje3" style="height: 40px">
				<td style="width: 100px">累计下达次数</td>
				<td>
					<input class="easyui-numberbox" value="0" style="width: 200px" readonly="readonly"/>
					<input type="button" value="下达明细"/>
				</td>
			</tr>
			
			
		
		</table>
	</div>
	
	<div style="width: 436px;height: 56px;border: 0px;margin-left: 20px;text-align: center;line-height: 56px">
		<a href="javascript:void(0)" onclick="saveTransmit()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
	
</div>

<script type="text/javascript">
var v = 100-parseFloat(${bean.syAmount}/${bean.ysAmount})*100;

function start2() {
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
             
           setTimeout(arguments.callee, 30);  
       }  
}

$(document).ready(function(){
	start2();
});

//下达保存
function saveTransmit() {
	
}
</script>
