<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="black_EXP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">专家编号&nbsp;
					<input id="expert_black_fexpertCode" name="fexpertCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;专家名称
					<input id="expert_black_fexpertName" name="fexpertName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;擅长领域
					<input id="expert_black_ffield" name="ffield" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;性别&nbsp;
					 <select class="easyui-combobox" id="expert_black_fexpertSex" name="fexpertSex"  style="width: 150px; height:25px;" data-options="editable:false,panelHeight:'auto'">
						<option value="">--请选择--</option>
						<option value="0" >男</option>
						<option value="1" >女</option>
					 </select>
					&nbsp;&nbsp;<a href="#" onclick="queryBlackExp();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clearBlackExpTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>			
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="black_expert_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/expertgl/blackexpPage',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'feId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fexpertCode',align:'center'" width="14%">专家编号</th>
						<th data-options="field:'fexpertName',align:'center'" width="7%">专家名称</th>
						<th data-options="field:'fbirthday',align:'center',resizable:false,sortable:true,formatter:formatAge" width="6%">年龄</th>
						<th data-options="field:'fexpertSex',align:'center',resizable:false,sortable:true,formatter:formatSex" width="6%">性别</th>
						<th data-options="field:'feducation',align:'center'" width="8%">最高学历</th>
						<th data-options="field:'fblackTime',align:'center',formatter: ChangeDateFormat" width="10%">移入黑名单时间</th>
						<th data-options="field:'faccFreq',align:'right'" width="10%">累计移入黑名单次数</th>
						<th data-options="field:'fopName',align:'center'" width="8%">操作人</th>
						<th data-options="field:'fblackDesc',align:'left'" width="16%">移入黑名单原因</th>
						<!-- <th data-options="field:'fisBlack',align:'left',resizable:false,sortable:true,formatter:formatExpStautsa" width="5%">是否黑名单</th> -->
						<th data-options="field:'operation',align:'center',formatter:format_black_expa" width="10%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	

</div>

	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#black_expert_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	

	//点击查询
	function queryBlackExp() {
		//alert($('#apply_time').val());
		$('#black_expert_tab').datagrid('load', {
			fexpertCode:$('#expert_black_fexpertCode').val(),
			fexpertName:$('#expert_black_fexpertName').val(),
			ffield:$('#expert_black_ffield').val(),
			fexpertSex:$('#expert_black_fexpertSex').val()
		});
	}
	//清除查询条件
	function clearBlackExpTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#expert_black_fexpertCode").textbox('setValue','');
		$("#expert_black_fexpertName").textbox('setValue','');
		$("#expert_black_ffield").textbox('setValue','');
		$('#expert_black_fexpertSex').combobox('setValue',"");
		$('#black_expert_tab').datagrid('load',{//清空以后，重新查一次
		});
	}
		//时间格式化
		function ChangeDateFormat(val) {
			//alert(val)
			var t, y, m, d, h, i, s;
			if (val == null) {
				return "";
			}
			t = new Date(val)
			y = t.getFullYear();
			m = t.getMonth() + 1;
			d = t.getDate();
			h = t.getHours();
			i = t.getMinutes();
			s = t.getSeconds();
			// 可根据需要在这里定义时间格式  
			return y + '-' + (m < 10 ? '0' + m : m) + '-'
					+ (d < 10 ? '0' + d : d);
		}
	//设置审批状态
	var c;
	function formatExpStautsa(val, row) {
		c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 否" + '</a>';
		} else if (val == 1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 是" + '</a>';
		}
	}
	
	//操作栏创建
	function format_black_expa(val,row) {		
		return '<table style="margin:0 auto;"><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		  	   '<a href="#" onclick="OUT_BLACK_EXP(' + row.feId + ')" class="easyui-linkbutton">'+
		       '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/outblack1.png">'+
		       '</a></td></tr></table>';		
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/outblack1.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/outblack2.png';
	}
	//移入黑名单
	function OUT_BLACK_EXP(id) {
		var win =parent.creatWin(' ', 540, 300, 'icon-search',"/blackexpertgl/moveoutblack?id=" + id);
		win.window('open'); 
  	}
/* 	 //移出黑名单
	function OUT_BLACK_EXP(id) {
		if (confirm("确认移出黑名单吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/blackexpertgl/moveoutblack?id='+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#black_expert_tab').datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	} */
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

