<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="white_EXP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">专家编号&nbsp;
					<input id="expert_white_fexpertCode" name="fexpertCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;专家名称
					<input id="expert_white_fexpertName" name="fexpertName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;擅长领域
					<input id="expert_white_ffield" name="ffield" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;专家状态
					<select class="easyui-combobox" id="expert_fcheckType" name="fcheckType"  style="width: 120px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="in" >在库</option>
						<option value="out">已出库</option>
						<option value="black" >黑名单</option>
					 </select>	
					&nbsp;&nbsp;性别&nbsp;
					 <select class="easyui-combobox" id="expert_white_fexpertSex" name="fexpertSex"  style="width: 120px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="0" >男</option>
						<option value="1" >女</option>
					 </select>
					&nbsp;&nbsp;<a href="#" onclick="queryWhiteExpert();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearWhiteExpertTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>	
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="white_expert_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/expertgl/whiteexpPage',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'feId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fexpertCode',align:'center'" width="14%">专家编号</th>
						<th data-options="field:'fexpertName',align:'center'" width="7%">专家名称</th>
						<th data-options="field:'feducation',align:'center'" width="7%">最高学历</th>
						<th data-options="field:'fstudyMajor',align:'center'" width="10%">所学专业</th>
						<th data-options="field:'fnowWork',align:'center'" width="10%">现从事专业</th>
						<th data-options="field:'fmTel',align:'center'" width="9%">联系手机</th>
						<th data-options="field:'ffield',align:'center',formatter:formatCellTooltip" width="10%">业务领域</th>
						<th data-options="field:'fbirthday',align:'center',resizable:false,sortable:true,formatter:formatAge" width="6%">年龄</th>
						<th data-options="field:'fexpertSex',align:'center',resizable:false,sortable:true,formatter:formatSex" width="6%">性别</th>
						<th data-options="field:'fcheckType',align:'center',resizable:false,sortable:true,formatter:formatStauts" style="width: 8%">专家状态</th>
						<th data-options="field:'operation',align:'left',formatter:method_operation" width="8%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
</div>
<script type="text/javascript">
	//点击查询
	function queryWhiteExpert() {
		$('#white_expert_tab').datagrid('load', {
			fexpertCode:$('#expert_white_fexpertCode').val(),
			fexpertName:$('#expert_white_fexpertName').val(),
			fcheckType:$('#expert_fcheckType').val(),
			ffield:$('#expert_white_ffield').val(),
			fexpertSex:$('#expert_white_fexpertSex').val()
		});
	}
	//清除查询条件
	function clearWhiteExpertTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#expert_white_fexpertCode").textbox('setValue','');
		$("#expert_white_fexpertName").textbox('setValue','');
		$("#expert_fcheckType").combobox('setValue','');
		$("#expert_white_ffield").textbox('setValue','');
		$("#expert_white_fexpertSex").combobox('setValue','');
		$('#white_expert_tab').datagrid('load',{//清空以后，重新查一次
		});
	}
	//设置专家状态
	function formatStauts(val, row) {
		if (val == "out") {
			if(row.fisOutStatus==9 || row.fisOutStatus==-2){
				return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 已出库" + '</a>';
			}
		} else if (val == "black") {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 黑名单" + '</a>';
		}
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 在库" + '</a>';
	}
	
	//操作栏创建
	function method_operation(val,row) {
		var checkType=row.fcheckType;
		if(row.fcheckType=="in" && row.fcheckStauts==9 && row.fisOutStatus!=9 && row.fisOutStatus!=0 && row.fisOutStatus!=-1){
			checkType="out";
		}
		var str='<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="expert_detail_lend(' + row.feId + ',\''+checkType+'\')" class="easyui-linkbutton">'+
   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
   		'</a></td>';
		//alert(row.fcheckType+"---"+row.fisOutStatus+"---"+row.fisBlackStatus+"---"+row.fcheckStauts);
		 //显示查看和黑名单按钮 
		if(row.fcheckType=="black" && row.fisBlackStatus==9){
			return str+'<td style="width: 25px"><a href="#" onclick="OUT_BLACK(' + row.feId + ')" class="easyui-linkbutton">'+
		       '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/outblack1.png">'+
		       '</a></td></tr></table>';
		}else if(row.fcheckType=="out" && (row.fisOutStatus==-2||row.fisOutStatus==9 )){
			return  str+'<td style="width: 25px"><a href="#" onclick="inOut_suppliers(' + row.feId + ','+"2"+')" class="easyui-linkbutton">'+
			'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/ruku1.png">'+
			'</a></td></tr></table>';
		}
		//在库
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
	//移出黑名单
	function OUT_BLACK(id) {
		var win =parent.creatWin(' ', 540, 300, 'icon-search',"/blackexpertgl/moveoutblack?id=" + id);
		win.window('open'); 
  	}
	//专家出入库
	function inOut_suppliers(id,type) {
		var win =parent.creatWin(' ',750, 480, 'icon-search',"/expertOutIn/outJsp?id=" + id+"&type="+type);
		win.window('open'); 
  	}	
	</script>
</body>

