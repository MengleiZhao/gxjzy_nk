<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-table" >
			<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:597px;">
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span>省</td>
					<td class="td2" colspan="3">
					<input class="easyui-combobox" id="shengId" name="shengId" style="width: 535px;height: 30px;margin-left: 10px " data-options="editable:false,
					url:'${base}/apply/getRegion?id=0&selected=${shengId}',
					method:'POST',
					valueField:'id',
					textField:'text',
					onSelect: function(rec){
					    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${shiId}';
					    $('#shiId').combobox('reload', url);
						$('#shiId').combobox('setValue', '');
					    }"/>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span>市</td>
					<td class="td2" colspan="3">
					<input class="easyui-combobox" id="shiId" name="shiId" style="width: 535px;height: 30px;margin-left: 10px " data-options="editable:false,
					method:'POST',
					valueField:'id',
					textField:'text',
					onSelect: function(rec){
					    var url = '${base}/apply/getRegion?id='+rec.id+'&selected=${quId}';
					    $('#quId').combobox('reload', url);
						$('#quId').combobox('setValue', '');
					    }"/>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span>区/县</td>
					<td class="td2" colspan="3">
					<input class="easyui-combobox" id="quId" name="quId" style="width: 535px;height: 30px;margin-left: 10px " data-options="editable:false,
					method:'POST',valueField:'id',textField:'text'"/>
					</td>
				</tr>
			</table>
			<div class="window-left-bottom-div" style="margin-top: 255px;">
				<a href="javascript:void(0)" onclick="saveRegion()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
			</div>
		</div>
</div>	
<script type="text/javascript">
	var areaId = '${areaId}';

function saveRegion(){
	var shengId =  $("#shengId").combobox('getValue');
	var shiId =  $("#shiId").combobox('getValue');
	var quId =  $("#quId").combobox('getValue');
	var shengName =  $("#shengId").combobox('getText');
	var shiName =  $("#shiId").combobox('getText');
	var quName =  $("#quId").combobox('getText');
	var regionAll = "";
	if(shengId==''){
		alert('请选择省份！')
		return false;
	}

	if(shiId==''){
		alert('请选择城市！')
		return false;
	}
	regionAll = shengName+"("+shiName+")";
	if(shengId=='2260'){
		if(quId==''){
			alert('请选择区域')
			return false;
		}else{
			regionAll = shengName+"("+shiName+quName+")";
		}
	}else{
		if(quId==''){
			regionAll = shengName+"("+shiName+")";
		}else{
			regionAll = shengName+"("+shiName+quName+")";
		}
	}
	var indexRow = '${index}';
	var editors = $('#'+tabId).datagrid('getEditors', indexRow);  
    editors[3].target.textbox('setValue', regionAll);
    if(shengId=='2260'){
	    editors[4].target.textbox('setValue', quId);
    }else{
    	if(quId==''){
	    	editors[4].target.textbox('setValue', shiId);
		}else{
	    	editors[4].target.textbox('setValue', quId);
		}
    }
	closeFirstWindow();
}
var tabId = '${tabId}';
//初始化datagrid点击事件
	$('#hotestd_choose_dg_s').datagrid({
		onDblClickRow:function(index,row){
			var indexRow = '${index}';
			if(tabId=='tracel_itinerary_trip_tab_id' || tabId=='tracel_itinerary_trip_reim_tab_id'){
				var editors = $('#'+tabId).datagrid('getEditors', indexRow);  
			    editors[3].target.textbox('setValue', row.area);
			    editors[4].target.textbox('setValue', row.id);
			}else{
				
			}
			
			closeFirstWindow();
		}
	});

//清除查询条件
function clearTable_hstd() {
	$('#htsd_area').textbox('setValue',null);
	query_hstd();
}


function query_hstd() {
	var area = $('#htsd_area').textbox('getValue');
	console.log(area);
	$('#hotestd_choose_dg_s').datagrid('load', {
		area : area,
	});
}


function format_strToDate(value){
	if (value != null) {
		var date = new Date(value);
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		return (m<10?('0'+m):m)+'-'+(d<10?('0'+d):d); 
		//return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d); 
	} else {
		return '无';
	}
}

function format_wjsfbl(value){
	if (value=='' || value==null) {
		return '无';
	} else {
		return value;
	}
}
function onShowPanelSHI(){
	var shengId =  $("#shengId").combobox('getValue');
	if(shengId==""){
		alert('请先选择省级地区！');
		return false;
	}
	var url = base+'/apply/getRegion?id='+shengId;
    $('#shiId').combobox('reload', url);
}
function onShowPanelQU(){
	var shiId =  $("#shiId").combobox('getValue');
	if(shiId==""){
		return false;
	}
	var url = base+'/apply/getRegion?id='+shiId;
    $('#quId').combobox('reload', url);
}

</script>
</body>

