<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-td1">制度名称</td>
				<td	class="top-table-td2">
					<input id="cheter_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
				</td>

				<td style="width: 30px;"></td>				
				<td style="width: 26px;">
					<a href="#" onclick="queryCheter();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>				
				<td style="width: 8px;"></td>			
				<td style="width: 26px;">
					<a href="#" onclick="clearCheterTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>								
				<td align="right" style="padding-right: 10px">
				  		<a href="#" onclick="addCheter()">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
				</td>
			</tr>
		</table>
	</div>
		
		
		
		<div class="list-table">
			<table id="cheter_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/systemcentergl/systemcenterPageData',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'systemId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fileName',align:'center',formatter:format_reviewCheter" width="21%">制度名称</th>
						<th data-options="field:'belong',align:'center'" width="10%">归属类型</th>
						<th data-options="field:'releseUser',align:'center'" width="10%">上传人</th>
						<th data-options="field:'releseTime',align:'center',formatter: ChangeDateFormat" width="15%">上传日期</th>
						<th data-options="field:'updateTime',align:'center',formatter: ChangeDateFormat" width="15%">更新日期</th>
						<th data-options="field:'clickNum',align:'center',formatter:getClicks" width="10%">浏览量</th>
						<th data-options="field:'operation',align:'center',formatter:format_supplier" width="15%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	
	</div>
	

</div>

	<script type="text/javascript">
	function openPDF(fileName,attId,isflag){
		if(isflag==0){
			alert("没有相关附件！");
			return;
		}
		//window.open(base+'/systemcentergl/viewPDF/'+fileName,'open');
		window.open(base+'/systemcentergl/viewPDF?systemId='+attId,'open');
	}
	
	function getClicks(num){
		if(num==null){
			return 0;
		}
		return num;
	}
	function format_reviewCheter(value, row, index){
		return "<a href='javascript:void(0)' style='color:blue' onclick='openCheter("+row.systemId+")'>"+value+"</a>";
	}
	
	function openCheter(cheterId){
		var win=parent.creatWin('制度中心-查看',650,500,'icon-search',"/systemcentergl/detail?id="+cheterId+"&fromSy=true");
		win.window('open');
	}
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#cheter_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	
	//点击查询
	 function queryCheter() {
		$('#cheter_tab').datagrid('load',{
			fileName : $('#cheter_name').textbox('getValue')
		});
	}
		//清除查询条件
		function clearCheterTable() {
			/* $(".topTable :input[type='text']").each(function(){
				$(this).val("a");
			}); */
			$("#cheter_name").textbox('setValue','');
			queryCheter();
		}
	
	//显示搜索
	function spread() {
		$('#helpTr').css("display", "");
		$('#retract').css("display", "");
		$('#spread').css("display", "none");
	}
	//隐藏搜索
	function retract() {
		$('#helpTr').css("display", "none");
		$('#retract').css("display", "none");
		$('#spread').css("display", "");
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
	
	//操作栏创建
	function format_supplier(val,row) {		
			return 	'<table style="margin:0 auto"><tr style="width: 75px;height:20px;"><td style="width: 25px">'+
					'<a href="#" onclick="cheter_detail(' + row.systemId + ')" class="easyui-linkbutton">'+
			   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   		'</a>'+ '</td><td style="width: 25px">'+
					'<a href="#" onclick="cheter_update(' + row.systemId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="chtere_delete(' + row.systemId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="openPDF(\''+row.fileName+'\',\'' + row.systemId + '\',\'' + row.attachment.flag + '\')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/yulan1.png">'+
					'</a></td></tr></table>';
		
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/update2.png';
	}
	function showE(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
	}
	function showF(obj){
		obj.src=base+'/resource-modality/${themenurl}/delete2.png';
	}
	
	
	//新增页面
	function addCheter() {
		var win = creatWin('新增-制度文件', 690, 350, 'icon-search', '/systemcentergl/add');
		win.window('open');
	}
	
	 //查看
	 function cheter_detail(id) {
		var win = creatWin('查看', 690, 350, 'icon-search',"/systemcentergl/detail?id=" + id);
		win.window('open'); 
	} 
	//修改
	function cheter_update(id) {
		var win = creatWin('修改', 690, 350, 'icon-search',"/systemcentergl/edit?id=" + id);
		win.window('open'); 
  }
	
	 
	
	 //删除
	function chtere_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/systemcentergl/delete?id='+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#cheter_tab').datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	
	

		//鼠标移入图片替换
		function mouseOver(img) {
			var src = $(img).attr("src");
			src = src.replace(/1/, "2");
			$(img).attr("src", src);
		}

		function mouseOut(img) {
			var src = $(img).attr("src");
			src = src.replace(/2/, "1");
			$(img).attr("src", src);
		}
	</script>
</body>
</html>

