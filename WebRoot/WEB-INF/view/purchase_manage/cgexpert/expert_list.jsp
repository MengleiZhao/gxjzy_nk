<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="EXP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search" style="width:70%;">专家编号&nbsp;
					<input id="expert_fexpertCode" name="fexpertCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;专家名称
					<input id="expert_fexpertName" name="fexpertName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					<!-- &nbsp;&nbsp;擅长领域
					<input id="expert_ffield" name="ffield" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;性别&nbsp;
					 <select class="easyui-combobox" id="expert_fexpertSex" name="fexpertSex"  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="0" >男</option>
						<option value="1" >女</option>
					 </select> -->
					&nbsp;&nbsp;<a href="#" onclick="queryExpert();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearExpertTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>			
				<td align="right">
					<a href="#" onclick="addExpert()">
						<img src="${base}/resource-modality/${themenurl}/button/rksq1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;<a href="#" onclick="expertApply('out')">
						<img src="${base}/resource-modality/${themenurl}/button/cksq1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;<a href="#" onclick="expertApply('black')">
						<img src="${base}/resource-modality/${themenurl}/button/hmdsq1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="expert_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/expertgl/expertPageData?fcheckStauts=1',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'feId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fexpertCode',align:'center'" width="13%">专家编号</th>
						<th data-options="field:'fexpertName',align:'center'" width="6%">专家名称</th>
						<th data-options="field:'feducation',align:'center'" width="6%">最高学历</th>
						<th data-options="field:'fstudyMajor',align:'center'" width="10%">所学专业</th>
						<th data-options="field:'fnowWork',align:'center',formatter:formatCellTooltip" width="10%">现从事专业</th>
						<th data-options="field:'fmTel',align:'center'" width="7%">联系手机</th>
						<th data-options="field:'ffield',align:'center',formatter:formatCellTooltip" width="10%">业务领域</th>
						<th data-options="field:'fbirthday',align:'center',resizable:false,sortable:true,formatter:formatAge" width="5%">年龄</th>
						<th data-options="field:'fexpertSex',align:'center',resizable:false,sortable:true,formatter:formatSex" width="5%">性别</th>
						<th data-options="field:'fcheckType',align:'center',resizable:false,sortable:true,formatter:formatStauts" style="width: 7%">操作类型</th>
						<th data-options="field:'fcheckStauts',align:'center',resizable:false,sortable:true,formatter:checkStatus" style="width: 8%">审批状态</th>
						<th data-options="field:'operation',align:'left',formatter:method_operation" width="9%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	
	</div>
	

	<script type="text/javascript">
	//申请
	function expertApply(checkType){
		var win=creatFirstWin('选择-专家',800,580,' ','/expertgl/expertApply?checkType='+checkType);
		win.window('open');
	}
	/* //出库申请
	function outExpert(){
		var win=creatFirstWin('选择-专家',750,550,' ','/expertgl/expertApply?checkType=out');
		win.window('open');
	}
	//黑名单申请
	function inExpert(){
		var win=creatFirstWin('选择-专家',750,550,' ','/expertgl/expertApply?checkType=black');
		win.window('open');
	} */
	
		//点击查询
		function queryExpert() {
			//alert($('#apply_time').val());
			$('#expert_tab').datagrid('load', {
				fexpertCode:$('#expert_fexpertCode').val(),
				fexpertName:$('#expert_fexpertName').val(),
				/* ffield:$('#expert_ffield').val(),
				fexpertSex:$('#expert_fexpertSex').val() */
			});
		}
		//清除查询条件
		function clearExpertTable() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#expert_fexpertCode").textbox('setValue','');
			$("#expert_fexpertName").textbox('setValue','');
			/* $("#expert_ffield").textbox('setValue',''); 
			$('#expert_fexpertSex').combobox('setValue',"");*/
			$('#expert_tab').datagrid('load',{//清空以后，重新查一次
			});
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
	//------------------------
		
	//设置操作类型
	function formatStauts(val, row) {
		//(row.fisBlackStatus== -1 && row.fisOutStatus==0)||row.fisOutStatus== -1)
		if (val == "out") {
			if(row.fisOutStatus==-2){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 入库申请" + '</a>';
			}
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 出库申请" + '</a>';
		} else if (val == "black") {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 黑名单申请" + '</a>';
		}else{
			/* if(row.fcheckStauts==0){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 暂存" + '</a>';
			}else  */
				
			if(row.fisBlackStatus== -1){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 黑名单申请" + '</a>';
			}else if(row.fisOutStatus== -1){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 出库申请" + '</a>';
			}
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 入库申请" + '</a>';
		}
	}
	function checkStatus(val,row){
		if (row.fcheckType == "out") {
			if(row.fisOutStatus==9){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
			}else if (row.fisOutStatus==-2) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
			}else if (row.fisOutStatus==-4) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
			}else{
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
			}
		}else if (row.fcheckType == "black") {
			if(row.fisBlackStatus==9){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
			}else if (row.fisBlackStatus==-4) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
			}else{
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
			}
		}else{
			if(row.fisBlackStatus== -1||row.fisOutStatus== -1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</a>';
			}else if(row.fisBlackStatus== -4 ||row.fisOutStatus== -4 || row.fcheckStauts==-4) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已撤回" + '</a>';
			}else if(row.fisOutStatus== 1||row.fcheckStauts==1) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
			}else if(row.fcheckStauts==0) {
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
			}else{
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
			}
		}
	}
	
	//操作栏创建
	function method_operation(val,row) {
		var checkType=row.fcheckType;
		if(row.fcheckType=="in" && row.fcheckStauts==9){
			if(row.fisOutStatus==-2 || row.fisOutStatus==-1){	//-1：出库被退回;-2：入库被退回
				checkType="out";
			}else if(row.fisBlackStatus==-1){
				//黑名单移入被退回
				checkType="black";
			}	
		}
		
		var str='<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="expert_detail(' + row.feId + ',\''+checkType+'\')" class="easyui-linkbutton">'+
   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
   		'</a></td>';
   	//撤回按钮
		var inRecall='<td style="width: 25px">'+
			'<a href="#" onclick="reCall(\'expert_tab\',' + row.feId + ',\'/expertcheck/inRecall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			'</a></td>';
		var outRecall='<td style="width: 25px">'+
			'<a href="#" onclick="reCall(\'expert_tab\',' + row.feId + ',\'/expertcheck/outRecall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			'</a></td>';
		var blackRecall='<td style="width: 25px">'+
			'<a href="#" onclick="reCall(\'expert_tab\',' + row.feId + ',\'/expertcheck/blackRecall\')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/reCall1.png">'+
			'</a></td>';
		//alert(row.fcheckType+"---|"+row.fisOutStatus+"---|"+row.fisBlackStatus+"---|"+row.fcheckStauts);
		//显示查看和出库按钮 
		if(row.fcheckType=="out"){
			if(row.fisOutStatus==9){
				return  str+'<td style="width: 25px"><a href="#" onclick="inOut_suppliers(' + row.feId + ','+"2"+')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ruku1.png">'+
					'</a></td></tr></table>';
			}else if(row.fisOutStatus==-2){//出库后再入库被退回
				// 查看、修改（重新申请）、删除入库记录
				return str+'<td style="width: 25px">'+
				'<a href="#" onclick="inOut_suppliers(' + row.feId + ','+"2"+')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'<a href="#" onclick="expert_delete(' + row.feId + ',\''+row.fcheckType+'\')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a></td></tr></table>';
		}
		//显示查看和黑名单按钮 
		}else if(row.fcheckType=="black" && (row.fisBlackStatus==-1||row.fisBlackStatus==9)){
			return str+'<td style="width: 25px"><a href="#" onclick="OUT_BLACK(' + row.feId + ')" class="easyui-linkbutton">'+
		       '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/outblack1.png">'+
		       '</a></td></tr></table>';
		}else if(row.fcheckType=="in" ){
			var t=""; //类型 t=checktype
				if(row.fcheckStauts==9 && (row.fisOutStatus==0||row.fisOutStatus==9) && row.fisBlackStatus==0){
					return str+'<td style="width: 25px"><a href="#" onclick="inOut_suppliers(' + row.feId + ','+"1"+')" class="easyui-linkbutton">'+
				   		'<img  onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/chuku1.png">'+
				   		'</a></td><td style="width: 25px"><a href="#" onclick="IN_BLACK_EXP(' + row.feId + ')" class="easyui-linkbutton">'+
				   		'<img  onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/inblack1.png">'+
				   		'</a></td></tr></table>';
				}else if(row.fisOutStatus==-1){
					t="out";
					//出库被退回，     查看、修改（重新申请）、删除出库记录
					return str+'<td style="width: 25px">'+
					'<a href="#" onclick="inOut_suppliers(' + row.feId + ','+"1"+')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="expert_delete(' + row.feId + ',\''+t+'\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
					'</a></td></tr></table>';
				}else if(row.fisBlackStatus==-1){
					t="black";
					//移入黑名单被退回     查看、修改（重新申请）、删除黑名单记录
					return str+'<td style="width: 25px">'+
					'<a href="#" onclick="IN_BLACK_EXP(' + row.feId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="expert_delete(' + row.feId + ',\''+t+'\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
					'</a></td></tr></table>';
				}else if(row.fcheckStauts==1){
					//待审批 只查看、撤回
					return 	str+inRecall+'</tr></table>';
				}else if(row.fisOutStatus==1){
					//待审批 只查看、撤回
					return 	str+outRecall+'</tr></table>';
				}else if(row.fisBlackStatus==1){
					//待审批 只查看、撤回
					return 	str+blackRecall+'</tr></table>';
				}else{	//暂存
					t="in";
					return str+'<td style="width: 25px">'+
					'<a href="#" onclick="expert_update(' + row.feId + ',\''+t+'\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="expert_delete(' + row.feId + ',\''+t+'\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
					'</a></td></tr></table>';
				}
		}
		//在库
		return 	str+ '</tr></table>';
	}

	//查看
	 function expert_detail(id,checkType) {
		var win = creatWin(' ', 970, 580, 'icon-search',"/expertgl/detail?checkType="+checkType+"&id=" + id);
		win.window('open'); 
	} 

	//------------------------
		
	//新增页面
	function addExpert() {
		var win = creatWin('新增', 970, 580, 'icon-search', '/expertgl/add');
		win.window('open');
	}
	
	//修改
	function expert_update(id,checkType) {
		var win = creatWin(' ', 970, 580, 'icon-search',"/expertgl/edit?id="+ id+"&checkType="+checkType);
		win.window('open'); 
  	}
	
	 
	
	 //删除
	function expert_delete(id,checkType) {
		if (confirm("确认删除吗？")) {
			var url="";
			if(checkType=="in"){
				url='${base}/expertgl/delete?id='+id;
			}else if(checkType=="out"){
				url='${base}/expertOutIn/deleteOut?feId='+id;
			}else if(checkType=="black"){
				url='${base}/blackexpertgl/deleteBlack?feId='+id;
			}
			$.ajax({
				type : 'POST',
				url : url,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#expert_tab').datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	
	
	</script>
</body>
</html>

