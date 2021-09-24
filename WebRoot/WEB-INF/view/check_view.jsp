<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<body>
    <div id="sample">
        <div style="display: none;">
            <textarea id="mySavedModel" >
            ${flowJson}
            </textarea>
        </div>

        <br/>
        <div>
            <input type="hidden" id="txtFlowPath" placeholder="" value="${nextKey }" style="width: 300px;" />
        </div>
        <div class="view_panel">
            <!--  显示面板 -->
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
    // 流程图显示器
    var myDisplay = new FlowDisplay('myDisplayDiv');
    showFlowPath();
    function showFlowPath() {
    	 var areaFlow = document.getElementById('mySavedModel');
    	var content = areaFlow.value;
        var flowPath = $.trim($('#txtFlowPath').val());
        var isCompleted = $('#chkIsCompleted').is(':checked');
        myDisplay.loadFlow(content);
        myDisplay.animateFlowPath(flowPath, isCompleted);
    }
  
</script>
</body>
