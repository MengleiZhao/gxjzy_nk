<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<!-- 参考文档：https://blog.csdn.net/weixin_34405557/article/details/86362651 -->

<body>
	<!--  取消滚动条显示-->
	<div class="window-div" style="overflow: hidden;">
		<div class="window-left-div" id="sample">
			<div class="win-left-top-div" style="overflow-x: hidden;white-space: nowrap;">
				<input type="hidden" id='flowId' name='flowId' value='${flowId}'>
	        	
	        	<textarea id="mySavedModel" style="display: none;">${flowJson}</textarea>
	            
	           	<!--  控件 -->
	            <span class="controls"  style="display: inline-block; vertical-align: top; width:100px">
	                <div id="myPaletteDiv"></div>
	            </span>
	            <!--  设计面板 -->
	            <span class="design_panel">
	                <div id="myFlowDesignerDiv" style=" width: 950px;height: 560px;"></div>
	            </span>
			</div>
			
			<div class="win-left-bottom-div">
	        	<a href="javascript:void(0)" onclick="saveDesigner(0)">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>
	
	<%-- <div class="window-div"> 
	    	<div class="window-left-div" id="sample">
		        <div class="win-left-top-div" style="width:100%; white-space:nowrap;">
		        
		        	<input type="hidden" id='flowId' name='flowId' value='${flowId}'>
		        	
		        	<textarea id="mySavedModel" style="display: none;">${flowJson}</textarea>
		            
		           	<!--  控件 -->
		            <span class="controls"  style="display: inline-block; vertical-align: top; width:100px">
		                <div id="myPaletteDiv"></div>
		            </span>
		            <!--  设计面板 -->
		            <span class="design_panel">
		                <div id="myFlowDesignerDiv" style=" width: 950px;height: 550"></div>
		            </span> 
		        </div>
		        <div class="win-left-bottom-div">
		        	<a href="javascript:void(0)" onclick="saveDesigner(0)">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="closeWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</div>
			</div>
		</div> --%>
		
	    <!-- <div>
	            设置当前处理节点：<input type="text" id="txtFlowPath" placeholder="" value="-4" style="width: 300px;" />
	            <button class="layui-btn" onclick="showFlowPath()">查看流程状态</button>
	            <input type="checkbox" value="已完成流程" id="chkIsCompleted" />流程已结束
	        </div> -->
	        <!-- 图例 -->
	       <!--  <div style="padding:8px 5px 0 10px;">
	            <span style="display:inline-block; height:12px; width:12px; background:#4fba4f; margin-left:6px; vertical-align:middle;"></span>
	            <label style="vertical-align:middle;">已完成步骤</label>
	            <span style="display:inline-block; height:12px; width:12px; background:#ff9001; margin-left:6px; vertical-align:middle;"></span>
	            <label style="vertical-align:middle;">待处理步骤</label>
	            <span style="display:inline-block; height:12px; width:12px; background:#7e7e7f; margin-left:6px; vertical-align:middle;"></span>
	            <label style="vertical-align:middle;">未经过步骤</label>
	        </div> -->
	        <!-- <div class="view_panel">
	             显示面板
	            <span class="view_panel_box">
	                <div id="myDisplayDiv"></div>
	            </span>
	        </div> -->
    <link rel="stylesheet"  type="text/css" href="${base}/resource/workflow/samples/css/style.css">
   	<%-- <script type="text/javascript" src="${base}/resource/workflow/samples/js/jquery-1.12.1.min.js"></script>  --%>
    <script type="text/javascript" src="${base}/resource/workflow/samples/js/layer/layer.js"></script>
    <script type="text/javascript" src="${base}/resource/workflow/samples/go.js"></script>
    <script type="text/javascript" src="${base}/resource/workflow/samples/js/flow-desinger.js"></script>
    <script type="text/javascript" src="${base}/resource/workflow/samples/js/flow-display.js"></script>
	<script type="text/javascript">
    var areaFlow = document.getElementById('mySavedModel');
    // 流程图设计器
    var content = areaFlow.value;
    //if (localStorage.myDesigner != "") {
     //   content = JSON.parse(localStorage.myDesigner);
    //    $('#mySavedModel').val(content)
   // }
    if (typeof content == "object") {
        var myDesigner = new FlowDesigner('myFlowDesignerDiv', content.nodeDataArray.length,${flowId});
    } else {
        var data = JSON.parse(content);
        var myDesigner = new FlowDesigner('myFlowDesignerDiv', data.nodeDataArray.length,${flowId});
    }

    myDesigner.initToolbar('myPaletteDiv'); // 初始化控件面板
    myDesigner.displayFlow(content); // 在设计面板中显示流程图

    // 流程图显示器
    var myDisplay = new FlowDisplay('myDisplayDiv');
   // showFlowPath();

    function showFlowPath() {
    	var content = areaFlow.value;
        var flowPath = $.trim($('#txtFlowPath').val());
        var isCompleted = $('#chkIsCompleted').is(':checked');
        myDisplay.loadFlow(content);
        myDisplay.animateFlowPath(flowPath, isCompleted);
    }


    /**
     * 保存设计图中的数据
     */
    function saveDesigner() {
    	var flowId=${flowId};
       // areaFlow.value = myDesigner.getFlowData();
       // localStorage.myDesigner = "";
       // localStorage.myDesigner = JSON.stringify(areaFlow.value);
       // var text = areaFlow.value;
       // var flowPath = $.trim($('#txtFlowPath').val());
       // var isCompleted = $('#chkIsCompleted').is(':checked');
       // myDisplay.loadFlow(text);
       // myDisplay.animateFlowPath(flowPath, isCompleted);
        var flowJson= myDesigner.getFlowData();
        $.ajax({
			async:false,
			type:"POST",
	        url:base+"/wflow/saveNode?flowId="+flowId,
	        data:{"flowJson":flowJson},
	        success:function(data){
	        	alert('保存成功');
	        	closeWindow();
	        }
	    });
    };

    function redraw() {
        var ctx1 = document.querySelector("#myFlowDesignerDiv canvas").getContext("2d");
        var ctx2 = document.querySelector("#myDisplayDiv canvas").getContext("2d")
        ctx1.clearRect(0, 0, 999999, 999999)
        ctx2.clearRect(0, 0, 99999, 99999)
    }
  
</script>
</body>