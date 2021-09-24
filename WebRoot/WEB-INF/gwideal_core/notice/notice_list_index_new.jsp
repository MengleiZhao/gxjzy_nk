<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/cockpit/cockpit.css">
<div class="list-div">
	<div style="background-color:#ffffff "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
					<tr>
				
						<td class="top-table-td1">公告标题:</td>
						<td	class="top-table-td2">
							<input type="text" style="width: 150px;height:25px;" size="15" class="easyui-textbox" maxlength="10" id="notice_noticeTitle"/>
						</td>
						
						<td class="top-table-td1">副标题:</td>
						<td	class="top-table-td2">
							<input type="text" style="width: 150px;height:25px;" size="15" class="easyui-textbox" maxlength="10" id="notice_subTitle"/>
						</td>
						
						<td class="top-table-td1">发布日期：</td>
						<td	class="top-table-td2" style="width:400px;">
							<input type="text" style="width: 150px;height:25px;" size="20" class="easyui-datebox" maxlength="15" id="notice_releaseDates"/>
							-
							<input type="text" style="width: 150px;height:25px;" size="20" class=easyui-datebox maxlength="15" id="notice_releaseDatee"/>
						</td>
						
						<td style="width: 30px;"></td>				
						<td style="width: 26px;">
							<a href="#" onclick="queryNotice();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>				
						<td style="width: 8px;"></td>			
						<td style="width: 26px;">
							<a href="#" onclick="clearNotice();">
								<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
						</td>								
						<td align="right" style="padding-right: 10px">
						</td>
						
					    <%-- <gwideal:perm url="/notice/edit/{id}">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit32',size:'large',iconAlign:'left'" onclick="editNotice()">修改</a>&nbsp;
						</gwideal:perm>
						<gwideal:perm url="/notice/delete/{id}">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut32',size:'large',iconAlign:'left'" onclick="deleteNotice()">删除</a>&nbsp;
						</gwideal:perm> --%>
					</tr>
				</table>
			</div>
			
			<div class="list-table">
				<table id="noticeTab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/notice/noticePage',
				method:'post',fit:true,toolbar:'#noticeHelpTab',singleSelect: true,pagination:true,
				selectOnCheck: true,remoteSort:true,nowrap:false,pageSize:10,pageList:[10]">
					<thead>
						<tr>
							<th data-options="field:'noticeId',hidden:true"></th>
							<th data-options="field:'num',align:'center',resizable:false,sortable:true" style="width: 5%">序号</th>
							<th data-options="field:'noticeTitle',align:'left',resizable:false,sortable:true,formatter:format_reviewNotice" style="width:35%">公告标题</th>
							<th data-options="field:'noticeSubtitle',align:'left',resizable:false,sortable:true" style="width: 20%">副标题</th>
							<th data-options="field:'releaseUser',align:'center',resizable:false,sortable:true" style="width: 10%">发布人</th>
							<th data-options="field:'releaseTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 30%">发布日期</th>
						</tr>
					</thead>
				</table>	
			</div>
			 <!-- 导航区 -->
  <div data-options="region:'south'" style="height:40px; ">
  		<div style="text-align: center;">
			<%-- <a href="javascript:void(0)" onclick="goback()">
				<img src="${base}/resource-modality/${themenurl}/button/fanhui1.png"
					onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui2.png')"
					onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/fanhui1.png')"
				/>
			</a> --%>
			&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
  </div>
    	</div>
    
    
<script type="text/javascript">

$("#notice_releaseDates").datebox({
    onSelect : function(beginDate){
        $('#notice_releaseDatee').datebox().datebox('calendar').calendar({
            validator: function(date){
            	return beginDate <= date;
            }
        });
    }
});
//点击名称查看详情
function format_reviewNotice(value, row, index){
	return "<a href='javascript:void(0)' style='color:blue' onclick='openNotice("+row.noticeId+")'>"+value+"</a>";
}
//打开详情页
function openNotice(noticeId){
	var win=parent.creatWin('通知公告-查看',1300,630,'icon-search',"/notice/detail/"+noticeId);
	win.window('open');
}
//操作
function oper_notice(value, row, index){
	var btn = "<table><tr style='width: 105px; height:20px'>";
	//修改
	var btn1 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='editNotice("+row.noticeId+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
	+"</a></td>"
	//删除
	var btn2 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='deleteNotice("+row.noticeId+")'>"
	+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/delete1.png'>"
	+"</a></td>";
	btn = btn + btn1 + btn2;
	btn = btn + "</tr></table>";
	return btn;
}
//时间格式化
function ChangeDateFormat(val) {
    var t, y, m, d, h, i, s;
    if(val==null){
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' ;
}

//新增窗口弹出
function addNotice(){
	window.open("/nkgl/notice/add","新增公告","width=900,height=700");
}

//删除
function deleteNotice(id){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: '${base}/notice/delete/'+id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$('#noticeTab').datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
}

//修改页面跳转
function editNotice(id){
	window.open("/nkgl/notice/edit/"+id,"新增公告","width=900,height=700");
}

//查询
function queryNotice(){ 
	$('#noticeTab').datagrid('load',{ 
		noticeTitle:$('#notice_noticeTitle').textbox('getValue'),
		noticeSubtitle:$('#notice_subTitle').textbox('getValue'),
		releaseDates:$('#notice_releaseDates').datebox('getValue'),
		releaseDatee:$('#notice_releaseDatee').datebox('getValue')
	} ); 
}
//清除
function clearNotice(){
	$('#notice_noticeTitle').textbox('setValue','');
	$('#notice_subTitle').textbox('setValue','');
	$('#notice_releaseDates').datebox('setValue','');
	$('#notice_releaseDatee').datebox('setValue','');
	queryNotice();
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
</script>
  </body>
</html>
