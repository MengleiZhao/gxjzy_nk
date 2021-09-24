<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<style type="text/css">
.datagrid .datagrid-pager {
   
    margin-right: 25px;

}
</style>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
	
	 <div class="list-table-tab">
		<div style="height: 440px">
			<table id="project-review-table" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/projectReview/reviewDetailList?id=${id}',
				method:'post',fit:true,pagination:false,singleSelect: false,scrollbarSize:0,onLoadSuccess:projectPsTotal,
				selectOnCheck: true,remoteSort:true,nowrap:false,striped: true,fitColumns:true">
				<thead>
					<tr>
						<th data-options="field:'fproId',hidden:true"></th>
						<th data-options="align:'center',field:'pageOrder'" style="width: 5%">序号</th>
						<th data-options="align:'center',field:'fproCode'" style="width: 12%">项目编号</th>
						<th data-options="align:'center',field:'fproName'" style="width: 13%">项目名称</th>
						<th data-options="align:'center',field:'fproAppliPeople'" style="width: 10%">项目负责人</th>
						<th data-options="align:'center',field:'fproAppliDepart'" style="width: 10%">申报部门</th>
						<th data-options="align:'center',field:'planStartYear'" style="width: 10%">开始执行年份</th>
						<th data-options="align:'center',field:'fproAppliTime',formatter: ChangeDateFormat" style="width: 10%">申报时间</th>
						<th data-options="align:'right',field:'fproBudgetAmount',formatter:listToFixed" style="width: 10%">项目预算[元]</th>
						<!-- <th data-options="align:'left',field:'fext6',formatter: projectReviewStauts" style="width: 10%">评审状态</th> -->
						<th data-options="align:'center',field:'fext6',formatter: projectReviewStauts" style="width: 10%">是否上报</th>
						<th data-options="align:'center',field:'operation',formatter: CZ" style="width: 10%">查看明细</th>
					</tr>
				</thead>
			</table>
		</div>
	</div> 
	<div class="list-top" id="project-review-bottom" style="background-color: #f1fcf1;height: 30px">
		<table cellpadding="0" cellspacing="0" style="width: 100%">
			<tr style="height: 30px">
				<td>
					<table border="0">
						<tr>
							<td colspan="3" id="tdf">
								<div >
									<c:forEach items="${attaList}" var="att">
										<c:if test="${att.serviceType=='hyjy' }">
											<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
										</c:if>
									</c:forEach>
								</div>
							</td>
						</tr>
					</table>
				</td>	
			</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
//评审状态变化
function projectReviewStauts(val, row) {
	if(val == 2){
		return '<a  class="easyui-linkbutton">'+
			   '<img   src="'+base+'/resource-modality/${themenurl}/list/yes2.png">'+
			   '</a>'+
			   '&nbsp;&nbsp;<a  class="easyui-linkbutton">'+
			   '<img   src="'+base+'/resource-modality/${themenurl}/list/no1.png">'+
			   '</a>';
	}else {
		return '<a  class="easyui-linkbutton">'+
			   '<img   src="'+base+'/resource-modality/${themenurl}/list/yes1.png">'+
			   '</a>'+
			   '&nbsp;&nbsp;<a  class="easyui-linkbutton">'+
			   '<img   src="'+base+'/resource-modality/${themenurl}/list/no2.png">'+
			   '</a>';
	}
		
}

//项目评审操作
function CZ(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="selectProject(' + row.fproId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a>'+
		   '</td></tr></table>';
}

//查看项目信息
function selectProject(id) {
	var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+id+'?logType=2');
	win.window('open');
}

/* //项目评审结果
function projectReviewResult(val, row) {
	if(val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 未通过" + '</a>';
	} else if (val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已通过" + '</a>';
	}
}      */

/* //评审记录操作
function projectReviewOperation2(val, row) {
	return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
		   '<a href="#" onclick="selectReview(' + row.rId + ')" class="easyui-linkbutton">'+
		   '<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   '</a></td></tr></table>';
}
 */

</script>
</body>
