<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
 <head>
		<meta charset="UTF-8">
		<title>查看</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="${base}/resource-modality/css/qrcode/mui.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/qrcode/common.css" />
		<!-- <link rel="stylesheet" type="text/css" href="../../../css/expendManage/beforehandApply/meetingApply.css" />
		<link href="../../../css/loading.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="../css/expendManage/beforehandApply/indexSelect.css" /> -->
		<link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/qrcode/flow.css" />
	</head>
	<body style="background: #FFFFFF;">
		<header class="mui-bar mui-bar-nav">
			<!-- <a href="javascript:;" class="mui-pull-left meetingBack">
				<img class="backIcon"  />
			</a> -->
			<h1 class="mui-title">查看</h1>
		</header>
		<div class="mui-content">
			<!--通用事项-->
			<div class="mui-content-padded">
				<p>
					<span>基本信息</span>
				</p>
			</div>
			<div class="mui-card" style="border: none;">
				<form class="mui-input-group">
					<div class="mui-input-row">
						<label><font style="color: red;">*</font>摘要</label>
						<input type="text" placeholder="" required="required" readonly="readonly" name="gName" id="gName" value="${name }" title="摘要">
					</div>
					<div class="mui-input-row">
						<label><span style="color: red;">*</span>单据名称</label>
						<textarea rows="5" type="text" style="height: 40px;" readonly="readonly" name="reason" required="required" id="reason" title="申请事由">${reason }</textarea>
					</div>
					<div class="mui-input-row">
						<label><span style="color: red;">*</span>单号</label>
						<input type="text" placeholder="" required="required" readonly="readonly" name="gCode" id="gCode" value="${code }" title="单号">
					</div>
					<div class="mui-input-row">
						<label><span style="color: red;">*</span>总金额</label>
						<input type="text" name="amount" id="amount" value="${amount }" readonly="readonly" required="required" title="总金额">
					</div>
					<div class="mui-input-row">
						<label><span style="color: red;">*</span>申请人</label>
						<input type="text" id="userNames" required="required" value="${userName }" readonly="readonly" title="申请人">
					</div>
					<div class="mui-input-row">
						<label><span style="color: red;">*</span>申请部门</label>
						<input type="text" id="deptName" required="required" value="${deptName }" readonly="readonly" title="申请部门">
					</div>
				</form>
			</div>

			<!--审批记录-->
			<div class="mui-content-padded" id="choose">
				<p>
					<span>审批记录</span>
				</p>
			</div>
			
			<c:forEach items="${checkHistoryList }" var="i" varStatus="n">
				<div class="mui-card" style="border: none;" id="cost" >
					<form class="mui-input-group">
						<%-- <div class="mui-input-row">
							<label style="color: #007AFF;" id="costDetail">第${n.count}审批人</label>
						</div> --%>
						<div class="mui-input-row unit">
							<label>审批人</label>
							<input type="text" id="fuserName" disabled="disabled" class="hotelStd" value="${i.fuserName }" >
						</div>
						<div class="mui-input-row unit">
							<label>审批结果</label>
							<input type="text" id="standard" style="<c:if test="${i.fcheckResult==0 }">color: red</c:if><c:if test="${i.fcheckResult==1 }">color: green</c:if>" disabled="disabled" class="hotelStd" value="<c:if test="${i.fcheckResult==1 }">通过</c:if><c:if test="${i.fcheckResult==0 }">不通过</c:if>" >
						</div>
						<div class="mui-input-row unit">
							<label>审批时间</label>
							<input type="text" id="totalStandard" disabled="disabled" class="hotelMoney" value="<fmt:formatDate value="${i.fcheckTime}" pattern="yyyy-MM-dd HH:mm"/>" >
						</div>
						<div class="mui-input-row unit">
							<label>审批意见</label>
							<input type="text" id="applySum" class="capital" disabled="disabled" value="${i.fcheckRemake }" >
						</div>
					</form>
				</div>
				<div style="border:1px #000;margin-bottom: 7.5px;margin-top: 7.5px;width: 60%;text-align: center;margin-left: 10%;margin-right: 10%;">
				</div>
			</c:forEach>

			<input type="hidden" name="indexId" id="indexId" />
			<input type="hidden" name="pid" id="pid" />
			<input type="hidden" name="indexType" id="indexType" />
		</div>
		<!-- <div class="operationBtnContent">
			<span class="operationMoneryText">申请金额 ￥<span id="logbox">0.00</span></span>
			<button class="commitInfos" onclick="tjform(1)">
				提交
			</button>
		</div> -->

		<script type="text/javascript" src="${base}/resource-modality/js/qrcode/mui.js"></script>
		<script type="text/javascript" src="${base}/resource-modality/js/qrcode/adjust.js"></script>
		<%-- <script type="text/javascript" src="${base}/resource-modality/js/qrcode/jquery-1.11.3.min.js"></script> --%>
		<!-- <script type="text/javascript" src="../../../js/common.js"></script> -->
		<!-- <script src="../../../js/exif.js"></script>
		<script type="text/javascript" src="../../../js/loading.js"></script>
		<script type="text/javascript" src="../../../js/expendManage/beforehandApply/meetingApply.js"></script>
		<script src="../../../js/expendManage/beforehandApply/indexSelect.js"></script>
		<script src="../../../js/cupload.js" type="text/javascript" charset="utf-8"></script> -->
		<script src="${base}/resource-modality/js/qrcode/flow.js" type="text/javascript" charset="utf-8"></script>
		<!-- jquery.js  -->
		<script type="text/javascript" src="${base}/resource/js/jquery.js"></script>
		<!-- jquery.min.js   -->
		<script type="text/javascript" src="${base}/resource/ui/jquery.min.js"></script>
	</body>
	<script type="text/javascript">
		/* var cuploadCreate = new Cupload({
			ele: '#cupload-create',
			num: 4,
		}); */
		/* var userid= ${userid};
		var type= 2;
		flowNode(userid,type); */
	</script>
</html>