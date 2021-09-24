<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<body  style="overflow-y: hidden">
<!-- 参考文档：https://blog.csdn.net/weixin_34405557/article/details/86362651 -->
     <!--  取消滚动条显示-->
    <div id="sample" style="overflow-x: hidden;">
        <br/>
        <!-- 图例 -->
         <div style="padding:8px 5px 0 10px;">
            <span style="display:inline-block; height:12px; width:12px; background:#ff9001; margin-left:6px; vertical-align:middle;"></span>
            <label style="vertical-align:middle;">待处理步骤</label>
            <input type="hidden" id="txtFlowPath" placeholder="" value="${nextKey }"  /> <!-- 当前跳转到哪个节点 -->
            <input type="hidden" id="historyNodes" placeholder="" value="${historyNodes }"  /> <!-- 历史跳转节点 -->
        </div> 
         <div class="view_panel">
         	 <textarea id="mySavedModel" style="display: none;">
            ${flowJson}
            </textarea>
            <span class="view_panel_box">
                <div id="myDisplayDiv"></div>
            </span>
        </div> 

    </div>
    <link rel="stylesheet"  type="text/css" href="${base}/resource/workflow/samples/css/style.css">
   <%-- <script type="text/javascript" src="${base}/resource/workflow/samples/js/jquery-1.12.1.min.js"></script>  --%>
    <script type="text/javascript" src="${base}/resource/workflow/samples/js/layer/layer.js"></script>
    <script type="text/javascript" src="${base}/resource/workflow/samples/go.js"></script>
    <script type="text/javascript" src="${base}/resource/workflow/samples/js/flow-desinger.js"></script>
    <script type="text/javascript" src="${base}/resource/workflow/samples/js/flow-display.js"></script>
    <script type="text/javascript">
    //获取流程的json字符串
    var areaFlow = document.getElementById('mySavedModel');
    // 流程图显示器
    var myDisplay = new FlowDisplay('myDisplayDiv');
    //显示流程图
    showFlowPath();
    
    //显示流程图
    function showFlowPath() {
    	var content = areaFlow.value;
    	//当前跳转到哪个节点
        var flowPath = $.trim($('#txtFlowPath').val()); 
        var historyNodes = $.trim($('#historyNodes').val()); 
        
        myDisplay.loadFlow(content);
        myDisplay.animateFlowPath(historyNodes,flowPath, false);
    }

</script>
</body>
