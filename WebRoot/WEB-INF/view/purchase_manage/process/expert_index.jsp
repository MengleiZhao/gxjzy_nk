<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div >
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				 <tr>
					<td class="top-table-td1">专家名称：</td> 
					<td class="top-table-td2">
						<input id="expertName" name=""  style="width: 150px;height:25px;" class="easyui-textbox" ></input>
					</td>
					
					<td style="width: 30px;"></td>				
						<td style="width: 26px;">
							<a href="#" onclick="queryEX();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>				
						<td style="width: 8px;"></td>			
						<td style="width: 26px;">
							<a href="#" onclick="clearEXTable();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>	
						<td align="right" style="padding-right: 10px"></td>	
				</tr>
			</table> 
		</div>
	
		<div style="margin: 0 10px 0 10px;height: 250px;">	
				<table id="expert_dg"  class="easyui-datagrid" 
						data-options=" url: '${base}/expertgl/whiteexpPage',singleSelect: false, 
						method: 'post',idField: 'feId',checkbox: true">
		        	<thead>
		            	<tr>
		            	<th field="ck" checkbox="true"></th>
		                <th data-options="field:'feId',align:'center',hidden:true"></th>
						<th data-options="field:'fexpertName',align:'left'" width="8%">专家</th>
						<th data-options="field:'fidNumber',align:'left'" width="19%">身份证</th>
						<th data-options="field:'fmTel',align:'left'" width="12%">电话</th>
						<th data-options="field:'feducation',align:'left'" width="8%">学历</th>
						<th data-options="field:'fjobTime',align:'left'" width="8%">工龄</th>
						<th data-options="field:'ffield',align:'left'" width="13%">擅长领域</th>
						<th data-options="field:'fhomeAddr',align:'left'" width="15%">住址</th>
						<th data-options="field:'fremark',align:'left'" width="17%">备注</th>
		                
		            	</tr>
		        	</thead>
		    	</table> 
		    	<div class="win-left-bottom-div" style="text-align: center;">
			<a href="javascript:void(0)" onclick="confirmKm()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
		</div>

		
	</div>
<script type="text/javascript">
	 function confirmKm(){
		 var rows = $('#expert_dg').datagrid('getChecked');
		/*  var parm = []; */
 		 var s = '';
		 for (var i = 0; i < rows.length; i++) {
			 	var id = rows[i].feId; 
			 	/* parm.push(id); */
			 	s += rows[i].feId + ',';
			 }
		$('#zbtz').datagrid('reload',{
			data:s
		}); 
		closeFirstWindow();
	}
	
	
	//点击查询
	 function queryEX() {
		$('#expert_dg').datagrid('load',{
			fexpertName : $('#expertName').textbox('getValue')
		});
	}  
	//清空
	function clearEXTable(){
		$('#expertName').textbox('setValue','');
	}
</script>
</body>

	