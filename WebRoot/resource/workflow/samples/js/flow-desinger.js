function FlowDesigner(diagramDiv, i,flowId) {
    var G = go.GraphObject.make;
    var _this = {};
    var myDiagram = {};
    /** --------public method----------------------------------------**/
    /**
     * 初始化图例面板
     * @returns {*}
     */
    this.initToolbar = function(div) {
        var myPalette =
            G(go.Palette, div, // 必须是DIV元素
                {
                    maxSelectionCount: 4,
                    nodeTemplateMap: myDiagram.nodeTemplateMap, // 跟设计图共同一套样式模板
                    model: new go.GraphLinksModel([
                        { key: guid(i),category: "Start", text: "开始", figure: "Circle", fill: "#4fba4f", stepType: 1 },
                        { key: guid(i),category: "Role",text: "审批节点" ,fill: "#1E9FFF", stepType: 2},
        	            /*{ key: guid(i),category: "Judge",text: "判断", figure: "Diamond" , stepType: 3},*/
                        { key: guid(i),category: "End", text: "结束", figure: "Circle", fill: "#CE0620", stepType: 4 }
                    ])
                });

        return myPalette;
    };

    /**
     * 在设计面板中显示流程图
     * @param flowData  流程图json数据
     */
    this.displayFlow = function(flowData) {
        if (!flowData) return;

        myDiagram.model = go.Model.fromJson(flowData);

        var pos = myDiagram.model.modelData.position;
        if (pos) myDiagram.initialPosition = go.Point.parse(pos);

        // 更改所有连线中间的文本背景色
        setLinkTextBg();
    };


    /**
     * 获取流程图数据
     * @returns {*}
     */
    this.getFlowData = function() {

        myDiagram.model.modelData.position = go.Point.stringify(myDiagram.position);
        return myDiagram.model.toJson();
    };
    

    /**
     * 检验流程图是否规范
     */
    this.checkData = function() {
        var errMsg = "";

        // 检查：每个步骤必须包含角色
        if (!myDiagram.model.nodeDataArray) return '请绘制流程图';

        $.each(myDiagram.model.nodeDataArray, function(i, item) {
            if (!item.hasOwnProperty("remark") || item.remark === "") {
                errMsg = "请为步骤【" + item.text + "】设置备注~";
                return false;
            }
        });

        return errMsg;
    };
    
    /**
     * 根据key更新节点信息
     * @param key
     * @param nodeJson
     */
    this.updateNodeDataByKey = function(key,nodeJson) {
    	 myDiagram.startTransaction("vacate");
    	 
    	 var nodeData=myDiagram.model.findNodeDataForKey(key);//首先拿到这个节点的对象
    	 myDiagram.model.removeNodeData(nodeData); //删除原来节点对象
    	 myDiagram.model.addNodeData(nodeJson);//新增修改过的节点对象
         myDiagram.commitTransaction("vacate");
    };
    /**
     * 根据key更新连线信息
     * @param key
     * @param nodeJson
     */
    this.updateLinkDataByKey = function(fromKey,toKey,text,custom) {
    	
    	 var nodeData=myDiagram.model.findNodeDataForKey(fromKey);//首先拿到这个节点的对象
    	 myDiagram.model.updateTargetBindings(nodeData);
    	 var node=myDiagram.findNodeForKey(fromKey);//获得连线后面的判断节点对象
     	 var links=findLinksOutNode(node);
     	 for(var i =0 ;i<links.length;i++){
     		//得到连线的文字，除了 同意、不同意以外， 其他的都是跳转条件，存到节点里
     		if(links[i].to==toKey){
     			myDiagram.model.setDataProperty(links[i],"custom",custom);//先设置字段的条件，下一步让节点获取到字段条件去拼接
     			myDiagram.model.setDataProperty(links[i],"text",text);//设置判断连线的文字
     			updateNodeData(links[i]);//修改节点的跳转条件属性
     		}
     	}
    };
    /** --------public method-------------end---------------------------**/

    init(diagramDiv);

    /** --------private method----------------------------------------**/

    /**
     * 初始化流程设计器
     * @param divId 设计器Div
     */
    function init(divId) {
        myDiagram = G(go.Diagram, divId, // 必须命名或引用DIV HTML元素
            {
	            grid: G(go.Panel, "Grid",
	                G(go.Shape, "LineH", { stroke: "lightgray", strokeWidth: 0.5 }),
	                G(go.Shape, "LineH", { stroke: "gray", strokeWidth: 0.5, interval: 10 }),
	                G(go.Shape, "LineV", { stroke: "lightgray", strokeWidth: 0.5 }),
	                G(go.Shape, "LineV", { stroke: "gray", strokeWidth: 0.5, interval: 10 })
	            ),
	            initialContentAlignment: go.Spot.Center,
	            allowHorizontalScroll: false,
	            allowVerticalScroll: false,
  	          allowDrop: true,  // 必须为true才能接受来自Palette
  	          "LinkDrawn": showLinkLabel,  // 这个DiagramEvent监听器定
  	          "LinkRelinked": showLinkLabel,
  	          "animationManager.duration": 800, // 略长于默认（600毫秒）动画
  	          "undoManager.isEnabled": true  // 启用撤消和恢复
            });

        // “有条件”节点。
	    // 这个监听器由“LinkDrawn”和“LinkRelinked”图表事件调用。
	    function showLinkLabel(e) {
	      astrictLinks(e);//限制连线个数  开始和审批节点节点，只能连接一条， 判断节点，只能连接两条
	      checkLinks(e);//检查连接目标是否正确
	      var label = e.subject.findObject("LABEL");
	      if (label !== null) label.visible = (e.subject.fromNode.data.figure === "Diamond");
	    }
        // 双击事件
        myDiagram.addDiagramListener("ObjectDoubleClicked", onObjectDoubleClicked);

        // 流程连接线的样式模板
        myDiagram.linkTemplate = makeLinkTemplate();
        
        // 流程步骤的样式模板
       // myDiagram.nodeTemplate = makeNodeTemplate();
        myDiagram.nodeTemplateMap.add("Role",  // 默认类别
      	      G(go.Node, "Spot", { locationSpot: go.Spot.Center },
      	            new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify), { selectable: true, selectionAdornmentTemplate: makeNodeSelectionAdornmentTemplate() },
      	            new go.Binding("angle").makeTwoWay(),
      	            // 主对象是一个面板，它用一个形状包围一个文本块。
      	            G(go.Panel, "Auto", { name: "PANEL" },
      	                new go.Binding("desiredSize", "size", go.Size.parse).makeTwoWay(go.Size.stringify),
      	                G(go.Shape, "RoundedRectangle", // 默认图形
      	                    {
      	                        portId: "", // 默认端口：如果链路数据上没有点，则使用最近的一端。
      	                        fromLinkable: true,
      	                        toLinkable: true,
      	                        cursor: "pointer",
      	                        fill: "#7e7e7f", // 默认背景色
      	                        strokeWidth: 1,
      	                        stroke: "#DDDDDD"
      	                    },
      	                    new go.Binding("figure"),
      	                    new go.Binding("fill")),
      	                G(go.TextBlock, {
      	                        font: "bold 11pt Helvetica, Arial, sans-serif",
      	                        margin: 8,
      	                        maxSize: new go.Size(160, NaN),
      	                        wrap: go.TextBlock.WrapFit,
      	                        editable: false,
      	                        stroke: "white"
      	                    },
      	                    new go.Binding("text").makeTwoWay()), // 标签显示节点数据的文本
      	                {
      	                    toolTip: // 此工具提示修饰由所有节点共享
      	                        G(go.Adornment, "Auto",
      	                        G(go.Shape, { fill: "#FFFFCC" }),
      	                        G(go.TextBlock, { margin: 4 }, // 工具提示显示调用nodeinfo（data）的结果。
      	                            new go.Binding("text", "", nodeInfo))
      	                    ),
      	                    // 绑定上下文菜单  绑定角色
      	                    contextMenu: makePartContextMenu()
      	                }
      	            ),
      	            // 4个连接点
      	            makeNodePort("T", go.Spot.Top, true, true),
      	            makeNodePort("L", go.Spot.Left, true, true),
      	            makeNodePort("R", go.Spot.Right, true, true),
      	            makeNodePort("B", go.Spot.Bottom, true, true), {
      	                mouseEnter: function(e, node) { showNodePort(node, true); },
      	                mouseLeave: function(e, node) { showNodePort(node, false); }
      	            }
      	        ));
              myDiagram.nodeTemplateMap.add("Judge",  // 默认类别
        	      G(go.Node, "Spot", { locationSpot: go.Spot.Center },
        	            new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify), { selectable: true, selectionAdornmentTemplate: makeNodeSelectionAdornmentTemplate() },
        	            new go.Binding("angle").makeTwoWay(),
        	            // 主对象是一个面板，它用一个形状包围一个文本块。
        	            G(go.Panel, "Auto", { name: "PANEL" },
        	                new go.Binding("desiredSize", "size", go.Size.parse).makeTwoWay(go.Size.stringify),
        	                G(go.Shape, "RoundedRectangle", // 默认图形
        	                    {
        	                        portId: "", // 默认端口：如果链路数据上没有点，则使用最近的一端。
        	                        fromLinkable: true,
        	                        toLinkable: true,
        	                        cursor: "pointer",
        	                        fill: "#7e7e7f", // 默认背景色
        	                        strokeWidth: 1,
        	                        stroke: "#DDDDDD"
        	                    },
        	                    new go.Binding("figure"),
        	                    new go.Binding("fill")),
        	                G(go.TextBlock, {
        	                        font: "bold 11pt Helvetica, Arial, sans-serif",
        	                        margin: 8,
        	                        maxSize: new go.Size(160, NaN),
        	                        wrap: go.TextBlock.WrapFit,
        	                        editable: false,
        	                        stroke: "white"
        	                    },
        	                    new go.Binding("text").makeTwoWay()), // 标签显示节点数据的文本
        	                {
        	                    toolTip: // 此工具提示修饰由所有节点共享
        	                        G(go.Adornment, "Auto",
        	                        G(go.Shape, { fill: "#FFFFCC" }),
        	                        G(go.TextBlock, { margin: 4 }, // 工具提示显示调用nodeinfo（data）的结果。
        	                            new go.Binding("text", "", nodeInfo))
        	                    ),
        	                    // 绑定上下文菜单
        	                    //contextMenu: makePartContextMenu()
        	                }
        	            ),
        	            // 4个连接点
        	            makeNodePort("T", go.Spot.Top, true, true),
        	            makeNodePort("L", go.Spot.Left, true, true),
        	            makeNodePort("R", go.Spot.Right, true, true),
        	            makeNodePort("B", go.Spot.Bottom, true, true), {
        	                mouseEnter: function(e, node) { showNodePort(node, true); },
        	                mouseLeave: function(e, node) { showNodePort(node, false); }
        	            }
        	        ));
      	    myDiagram.nodeTemplateMap.add("Start",
      	      G(go.Node, "Spot", { locationSpot: go.Spot.Center },
      	            new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify), { selectable: true, selectionAdornmentTemplate: makeNodeSelectionAdornmentTemplate() },
      	            new go.Binding("angle").makeTwoWay(),
      	            // 主对象是一个面板，它用一个形状包围一个文本块。
      	            G(go.Panel, "Auto", { name: "PANEL" },
      	                new go.Binding("desiredSize", "size", go.Size.parse).makeTwoWay(go.Size.stringify),
      	                G(go.Shape, "RoundedRectangle", // 默认图形
      	                    {
      	                        portId: "", // 默认端口：如果链路数据上没有点，则使用最近的一端。
      	                        fromLinkable: true,
      	                        toLinkable: true,
      	                        cursor: "pointer",
      	                        fill: "#7e7e7f", // 默认背景色
      	                        strokeWidth: 1,
      	                        stroke: "#DDDDDD"
      	                    },
      	                    new go.Binding("figure"),
      	                    new go.Binding("fill")),
      	                G(go.TextBlock, {
      	                        font: "bold 11pt Helvetica, Arial, sans-serif",
      	                        margin: 8,
      	                        maxSize: new go.Size(160, NaN),
      	                        wrap: go.TextBlock.WrapFit,
      	                        editable: false,
      	                        stroke: "white"
      	                    },
      	                    new go.Binding("text").makeTwoWay()), // 标签显示节点数据的文本
      	                {
      	                    toolTip: // 此工具提示修饰由所有节点共享
      	                        G(go.Adornment, "Auto",
      	                        G(go.Shape, { fill: "#FFFFCC" }),
      	                        G(go.TextBlock, { margin: 4 }, // 工具提示显示调用nodeinfo（data）的结果。
      	                            new go.Binding("text", "", nodeInfo))
      	                    ),
      	                    // 绑定上下文菜单
      	                }
      	            ),
      	            // 4个连接点
      	            makeNodePort("T", go.Spot.Top, true, true),
      	            makeNodePort("L", go.Spot.Left, true, true),
      	            makeNodePort("R", go.Spot.Right, true, true),
      	            makeNodePort("B", go.Spot.Bottom, true, true), {
  	                mouseEnter: function(e, node) { showNodePort(node, true); },
  	                mouseLeave: function(e, node) { showNodePort(node, false); }
      	            }
      	        ));

      	    myDiagram.nodeTemplateMap.add("End",
      	      G(go.Node, "Spot", { locationSpot: go.Spot.Center },
      	            new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify), { selectable: true, selectionAdornmentTemplate: makeNodeSelectionAdornmentTemplate() },
      	            new go.Binding("angle").makeTwoWay(),
      	            // 主对象是一个面板，它用一个形状包围一个文本块。
      	            G(go.Panel, "Auto", { name: "PANEL" },
      	                new go.Binding("desiredSize", "size", go.Size.parse).makeTwoWay(go.Size.stringify),
      	                G(go.Shape, "RoundedRectangle", // 默认图形
      	                    {
      	                        portId: "", // 默认端口：如果链路数据上没有点，则使用最近的一端。
      	                        fromLinkable: true,
      	                        toLinkable: true,
      	                        cursor: "pointer",
      	                        fill: "#7e7e7f", // 默认背景色
      	                        strokeWidth: 1,
      	                        stroke: "#DDDDDD"
      	                    },
      	                    new go.Binding("figure"),
      	                    new go.Binding("fill")),
      	                G(go.TextBlock, {
      	                        font: "bold 11pt Helvetica, Arial, sans-serif",
      	                        margin: 8,
      	                        maxSize: new go.Size(160, NaN),
      	                        wrap: go.TextBlock.WrapFit,
      	                        editable: false,
      	                        stroke: "white"
      	                    },
      	                    new go.Binding("text").makeTwoWay()), // 标签显示节点数据的文本
      	                {
      	                    toolTip: // 此工具提示修饰由所有节点共享
      	                        G(go.Adornment, "Auto",
      	                        G(go.Shape, { fill: "#FFFFCC" }),
      	                        G(go.TextBlock, { margin: 4 }, // 工具提示显示调用nodeinfo（data）的结果。
      	                            new go.Binding("text", "", nodeInfo))
      	                    ),
      	                }
      	            ),
      	            // 4个连接点
      	            makeNodePort("T", go.Spot.Top, true, true),
      	            makeNodePort("L", go.Spot.Left, true, true),
      	            makeNodePort("R", go.Spot.Right, true, true),
      	            makeNodePort("B", go.Spot.Bottom, true, true), {
  	                mouseEnter: function(e, node) { showNodePort(node, true); },
  	                mouseLeave: function(e, node) { showNodePort(node, false); }
      	            }
      	        ));
    };
    
    /**
     * 步骤图的样式模板(目前被注释掉了，因为这个是一个统一的模板，所有节点都调用这个，不方便区分处理事件)
     * @returns {*}
     */
    function makeNodeTemplate() {
        return G(go.Node, "Spot", { locationSpot: go.Spot.Center },
            new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify), { selectable: true, selectionAdornmentTemplate: makeNodeSelectionAdornmentTemplate() },
            new go.Binding("angle").makeTwoWay(),
            // 主对象是一个面板，它用一个形状包围一个文本块。
            G(go.Panel, "Auto", { name: "PANEL" },
                new go.Binding("desiredSize", "size", go.Size.parse).makeTwoWay(go.Size.stringify),
                G(go.Shape, "RoundedRectangle", // 默认图形
                    {
                        portId: "", // 默认端口：如果链路数据上没有点，则使用最近的一端。
                        fromLinkable: true,
                        toLinkable: true,
                        cursor: "pointer",
                        fill: "#7e7e7f", // 默认背景色
                        strokeWidth: 1,
                        stroke: "#DDDDDD"
                    },
                    new go.Binding("figure"),
                    new go.Binding("fill")),
                G(go.TextBlock, {
                        font: "bold 11pt Helvetica, Arial, sans-serif",
                        margin: 8,
                        maxSize: new go.Size(160, NaN),
                        wrap: go.TextBlock.WrapFit,
                        editable: false,
                        stroke: "white"
                    },
                    new go.Binding("text").makeTwoWay()), // 标签显示节点数据的文本
                {
                    toolTip: // 此工具提示修饰由所有节点共享
                        G(go.Adornment, "Auto",
                        G(go.Shape, { fill: "#FFFFCC" }),
                        G(go.TextBlock, { margin: 4 }, // 工具提示显示调用nodeinfo（data）的结果。
                            new go.Binding("text", "", nodeInfo))
                    ),
                    // 绑定上下文菜单(目前是右键菜单)
                    contextMenu: makePartContextMenu()
                }
            ),
            // 4个连接点
            makeNodePort("T", go.Spot.Top, true, true),
            makeNodePort("L", go.Spot.Left, true, true),
            makeNodePort("R", go.Spot.Right, true, true),
            makeNodePort("B", go.Spot.Bottom, true, true), {
                mouseEnter: function(e, node) { showNodePort(node, true); },
                mouseLeave: function(e, node) { showNodePort(node, false); }
            }
        );
    }
    /**
     * 根据节点，获取从该节点发出去的线集合
     * @returns {string}
     */
    function findLinksOutNode(node) {
    	var links=[];  //定义连线容器
	   	node.findLinksOutOf().each(function(link) {
	   		links.push(link.data);//把从该节点出发的所有线都装入容器里
	   	});
       return links;
    }
    /**
     * 根据节点，获取进入该节点的线集合
     * @returns {string}
     */
    /*function findLinksIntoNode(node) {
    	var links=[];  //定义连线容器
	   	node.findLinksInto().each(function(link) {
	   		links.push(link.data);//把获取进入节点的线都装入容器里
	   	});
       return links;
    }*/
    /**
     * 限制连线个数
     * @returns {string}
     */
    function astrictLinks(e) {
    	var stepType=e.subject.fromNode.data.stepType;//得到节点类型
	      var node=e.subject.fromNode; //获取节点
	      var removeLinks=findLinksOutNode(node);
	      if("1"==stepType ){ //如果是开始
//	    	  removeLinks.pop();//留下最后一条不删除
//	    	  myDiagram.model.removeLinkDataCollection(removeLinks);//删除容器里的线
	      }else if("2"==stepType){ //如果是审批节点节点，允许有多条线
//	    	  removeLinks.pop();//留下最后一条不删除
//	    	  removeLinks.pop();//留下最后倒数第二条不删除
//	    	  myDiagram.model.removeLinkDataCollection(removeLinks);//删除容器里的线
	    	  setJudgeLinkText(e);//设置连接线属性
	      }else if("4"==stepType){ //如果是结束节点，不允许有箭头发出去
	    	  myDiagram.model.removeLinkDataCollection(removeLinks);//删除容器里的线
	      }
    }
    /**
     * 检查连线是否正确
     * @returns {string}
     */
    function checkLinks(e) {
    	var stepType=e.subject.fromNode.data.stepType;//得到节点类型
	      var node=e.subject.fromNode; //获取节点
	      var removeLinks=findLinksOutNode(node);
	      var lastLink=removeLinks[removeLinks.length-1];//得到最后一次连接的线
	      if(lastLink !=undefined){
		      if("1"==stepType){ //如果是开始只能审批节点节点
		    	  checkBeginLinks(lastLink);
		    	  node.data.agree = lastLink.to;//设置agree属性为 同意的判断连线到达的节点
		 		  myDiagram.model.updateTargetBindings(node.data);
		      }else if("2"==stepType){ //如果是审批节点节点，允许有两条线
		    	  checkRoleLinks(lastLink);
		    	  setJudgeLinkText(e);//设置最后一条判断连线的文字
		      }
	      }
    }
    
    /**
     * 如果是开始只能审批节点节点
     */
    function checkBeginLinks(lastLink){
    	 var tokey=lastLink.to;//得到这条线到达的节点key
    	 var tonodeData=myDiagram.model.findNodeDataForKey(tokey);//得到这条线到达的节点
    	 if("2" !=tonodeData.stepType){
    		 alert("只能连接到审批节点");
    		 myDiagram.model.removeLinkDataCollection(lastLink);//删除最后一次拉的线
    		 return;
    	 }
    }
    
    /**
     * 如果是审批节点节点，只能连接到判断
     */
    function checkRoleLinks(removeLinks){
    	 //如果是判断节点，允许有两条线
	   	 var removelink=[];//定义一个准备被删除的容器
	   	 var tokeys=[];
	   	 for(var i=0;i<removeLinks.length;i++){
	   		 var link=removeLinks[i];//从集合里获取连线
	   		 var tokey=link.to;//得到这条线到达的节点key
	   		 tokeys.push[tokey];//把所有连线的目标key都装起来，下面需要循环调用对比
	   	 }
	   	 
	   	 myDiagram.model.removeLinkDataCollection(removelink);//删除容器里的线
	   	 if(tokeys.length>1 ){
	   		 if(tokeys[0]==tokeys[1]){
	    		 alert("不允许两条线连接同一个目标");
	    		 myDiagram.model.removeLinkDataCollection(removeLinks[0]);//删除容器里的线
	    		 return;
		      }
	   	 }
	   	 if(tokeys.length>2){
	   		 if(tokeys[0]==tokeys[2] || tokeys[1]==tokeys[2] ){
	    		 alert("不允许两条线连接同一个目标");
	    		 myDiagram.model.removeLinkDataCollection(removeLinks[2]);//删除容器里的线
	    		 return;
		      } 
	   	 }
    }
    
    /**
     * 设置判断连线的文字
     */
	  function setJudgeLinkText(e){
		  var node=e.subject.fromNode; //获取节点
	      var links=findLinksOutNode(node);//得到判断节点所有出发的线
	      if(links.length==1){//只有一条，第一条默认是同意
	    	  var agreelink=links[0];
	    	  setAgreeProperty(agreelink,node);//设置同意连线和审批节点的同意属性
	      }
	      if(links.length>1){//有多条
	    	  var laskLink=links[links.length-1];
	    	  setCustomProperty(laskLink,node);//设置自定义连线和审批节点的同意属性
	      }
	      
	  }
	 /**
	  * 设置同意连线和审批节点的同意属性
	  */ 
    function setAgreeProperty(agreelink,node){
	  	 myDiagram.model.setDataProperty(agreelink,"text","同意");//设置判断连线的文字
  		 var nodeData1 = myDiagram.model.findNodeDataForKey(node.data.key);
  		 nodeData1.agree = agreelink.to;//设置agree属性为 同意的判断连线到达的节点
  		 myDiagram.model.updateTargetBindings(nodeData1);
    }
    /**
	  * 设置自定义连线和审批节点的同意属性
	  */ 
	 function setCustomProperty(customlink,node){
		   myDiagram.model.setDataProperty(customlink,"text","请配置流程跳转条件");//设置判断连线的文字
	 }
  
    /**
     * 生成GUID
     * @returns {string}
     */
    function guid(i) {
        return Math.abs(i++);
    }

   

    /**
     * 选中节点的样式
     * @returns {*}
     */
    function makeNodeSelectionAdornmentTemplate() {
        return G(go.Adornment, "Auto",
            G(go.Shape, { fill: null, stroke: "deepskyblue", strokeWidth: 1.5, strokeDashArray: [4, 2] }),
            G(go.Placeholder)
        );
    }

    /**
     * 创建连接点
     * @param name
     * @param spot
     * @param output
     * @param input
     * @returns {*}
     */
    function makeNodePort(name, spot, output, input) {
        // 端口基本上只是一个透明的小广场
        return G(go.Shape, "Circle", {
            fill: null, // 默认情况下看不到；通过ShowSmallPorts设置为半透明灰色，定义如下
            stroke: null,
            desiredSize: new go.Size(7, 7),
            alignment: spot, // 将端口与主形状对齐
            alignmentFocus: spot, // 在内部
            portId: name, // 将此对象声明为“端口”
            fromSpot: spot,
            toSpot: spot, // 声明链接在此端口的连接位置
            fromLinkable: output,
            toLinkable: input, // 声明用户是否可以从此处绘制链接
            cursor: "pointer" // show a different cursor to indicate potential link point
        });
        
    };

    /**
     * tooltip上显示的信息
     * @param d
     * @returns {string}
     */
    function nodeInfo(d) {
    	if(d.stepType=="2"){
    		return '单击右键可绑定审批节点';
    	}
    	if(d.from !=undefined){
    		return '单击右键可编辑条件';
    	}
    }

    /**
     * 右键菜单
     * @returns {*}
     */
    function makePartContextMenu() {
        return G(go.Adornment, "Vertical",
            makeMenuItem("绑定审批节点",
                function(e, obj) { // OBJ is this Button
                    var contextmenu = obj.part; // 该按钮位于上下文菜单装饰中
                    var part = contextmenu.adornedPart; // 修饰部分是上下文菜单修饰的部分
                    // 现在可以对部件、数据或装饰（上下文菜单）执行某些操作。
                    showEditNode(part);
                })
            /*makeMenuItem("剪切",
                function(e, obj) { e.diagram.commandHandler.cutSelection(); },
                function(o) { return o.diagram.commandHandler.canCutSelection(); }),
            makeMenuItem("复制",
                function(e, obj) { e.diagram.commandHandler.copySelection(); },
                function(o) { return o.diagram.commandHandler.canCopySelection(); }),
            makeMenuItem("删除",
                function(e, obj) { e.diagram.commandHandler.deleteSelection(); },
                function(o) { return o.diagram.commandHandler.canDeleteSelection(); })*/
        );
    };
    /**
     * 生成右键菜单项
     * @param text
     * @param action
     * @param visiblePredicate
     * @returns {*}
     */
    function makeMenuItem(text, action, visiblePredicate) {
        return G("ContextMenuButton",
            G(go.TextBlock, text, {
                margin: 5,
                textAlign: "left",
                stroke: "#555555"
            }), { click: action },
            // don't bother with binding GraphObject.visible if there's no predicate
            visiblePredicate ? new go.Binding("visible", "", visiblePredicate).ofObject() : {});
    };

    /**
     * 是否显示步骤的连接点
     * @param node
     * @param show
     */
    function showNodePort(node, show) {
        node.ports.each(function(port) {
            if (port.portId !== "") { // don't change the default port, which is the big shape
                port.fill = show ? "rgba(255,0,0,.5)" : null;
            }
        });
    };

    /**
     * 连接线的选中样式
     * @returns {*}
     */
    function makeLinkSelectionAdornmentTemplate() {
        return G(go.Adornment, "Link",
            G(go.Shape,
                // isPanelMain declares that this Shape shares the Link.geometry
                { isPanelMain: true, fill: null, stroke: "deepskyblue", strokeWidth: 0 })// use selection object's strokeWidth
        );
    };

    /**
     * 定义连接线的样式模板
     * @returns {*}
     */
    function makeLinkTemplate() {
    	 return G(go.Link, { selectable: true }, { relinkableFrom: true, relinkableTo: true, reshapable: true }, {
             routing: go.Link.AvoidsNodes,
             curve: go.Link.JumpOver,
             corner: 5,
             toShortLength: 4
         },
         new go.Binding("layerName", "color"),
         new go.Binding("zOrder"),
         G(go.Shape, { isPanelMain: true, stroke: "black", strokeWidth: 3 }, new go.Binding("stroke"), new go.Binding("zOrder")),
         G(go.Shape, { isPanelMain: true, stroke: "gray", strokeWidth: 2 }),
         G(go.Shape, { isPanelMain: true, stroke: "white", strokeWidth: 1, name: "PIPE", strokeDashArray: [10, 10] }),
         G(go.Shape, { toArrow: "standard", stroke: null }, new go.Binding("stroke"), new go.Binding("fill"), new go.Binding("zOrder")),
         G(go.Panel, "Auto",
             G(go.Shape, {
                 fill: null,
                 stroke: null
             }, new go.Binding("fill", "pFill"), new go.Binding("zOrder")),
             G(go.TextBlock, {
                     textAlign: "center",
                     font: "10pt helvetica, arial, sans-serif",
                     stroke: "#555555",
                     margin: 4
                 },
                 new go.Binding("text", "text"), new go.Binding("zOrder"))
         )
     );
       /* return G(go.Link, // the whole link panel
            { selectable: true, selectionAdornmentTemplate: makeLinkSelectionAdornmentTemplate() }, 
            { relinkableFrom: true, relinkableTo: true, reshapable: true }, {
                routing: go.Link.AvoidsNodes,
                curve: go.Link.JumpOver,
                corner: 5,
                toShortLength: 4
            },
            G(go.Shape, // 线条
                { stroke: "blue" }),
            G(go.Shape, // 箭头
                { toArrow: "standard", stroke: null }),
            G(go.Panel, "Auto",
                G(go.Shape, // 标签背景色
                    {
                        fill: null,
                        stroke: null
                    }, new go.Binding("fill", "pFill")),
                G(go.TextBlock, // 标签文本
                    {
                        textAlign: "center",
                        font: "10pt helvetica, arial, sans-serif",
                        stroke: "#555555",
                        margin: 4
                    },
                    new go.Binding("text", "text")), // the label shows the node data's text
                {
                    toolTip: // this tooltip Adornment is shared by all nodes
                        G(go.Adornment, "Auto",
                        G(go.Shape, { fill: "#FFFFCC" }),
                        G(go.TextBlock, { margin: 4 }, // the tooltip shows the result of calling nodeInfo(data)
                            new go.Binding("text", "", nodeInfo))
                    ),
                    // 绑定上下文菜单
                   // contextMenu: makeCustomMenu()
                    // this context menu Adornment is shared by all nodes
                }
                
            )
        );*/
    };

    /**
     * 流程图元素的双击事件
     * @param ev
     */
    function onObjectDoubleClicked(ev) {
        var part = ev.subject.part;
        showEditNode(part);
    };


    /**
     * 编辑
     */
    function showEditNode(node) {
        if ((node instanceof go.Node) && node.data.figure === 'Circle') {
            alert("开始和结束步骤不可编辑~");
            return;
        }else if((node instanceof go.Node) && (node.data.stepType == '2' || node.data.stepType == '3')){
        	editNode(node.data);//编辑节点信息
        }else if(node.data.from !=undefined){
        	editLink(node.data);//编辑连线信息
        	
        	/*$.messager.prompt('温馨提示', '请输入流转条件:', 
        		function(value){
	        		if (value){
	        			updateNodeData(node, value);
	        		}
        		}
        	);*/
        }
    }
    
    /**
     * 编辑节点信息
     */
	function editNode(node){
	  	var nodeJson=encodeURI(JSON.stringify(node));
	  	nodeJson=nodeJson.replace("#", "");//替换掉 # 号，因为 传过去的url不能包含 # 等特殊符号 
		var win=creatFirstWin('绑定审批节点',700,500,'icon-search','/wflow/bindingRole?nodeJson='+nodeJson);
		win.window('open');
	}
	
	 /**
     * 编辑连线信息
     */
	function editLink(link){
		var win=creatFirstWin('配置条件',400,300,'icon-search','/wflow/editLink?fromKey='+link.from+'&toKey='+link.to+'&flowId='+flowId);
		win.window('open');
	}
    /**
     * 更新节点信息  目前是更新连线的流转条件
     * @param oldData
     * @param newData
     */
    function updateNodeData(link) {
        myDiagram.startTransaction("vacate");
        //获取连线出发的节点
        var nodeData1 = myDiagram.model.findNodeDataForKey(link.from);
    	var newcustom='';
    	//得到从该节点出发的所有连线
    	var node1=myDiagram.findNodeForKey(link.from);//获得连线后面的判断节点对象
    	var links=findLinksOutNode(node1);
    	for(var i =0 ;i<links.length;i++){
    		//得到连线的文字，除了 同意、不同意以外， 其他的都是跳转条件，存到节点里
    		if(links[i].text!='同意' && links[i].text!='不同意'){
    			if(newcustom==''){
    				newcustom=links[i].custom+","+links[i].to;
    			}else{
    				newcustom = newcustom+";"+links[i].custom+","+links[i].to;
    			}
    		}
    	}
    	nodeData1.custom=newcustom;
        //nodeData1.custom=newcustom+";"+text+","+ node.data.to;
 		myDiagram.model.updateTargetBindings(nodeData1);
        myDiagram.commitTransaction("vacate");
    };

    /**
     * 更改所有连线中间的文本背景色
     */
    function setLinkTextBg() {
        myDiagram.links.each(function(link) {
            myDiagram.startTransaction("vacate");
            if (link.data.text) {
                myDiagram.model.setDataProperty(link.data, "pFill", window.go.GraphObject.make(go.Brush, "Radial", {
                    0: "rgb(240, 240, 240)",
                    //0.3: "rgb(240, 240, 240)",
                    1: "rgba(240, 240, 240, 0)"
                }));
            }
            myDiagram.commitTransaction("vacate");
        });
    };

    /** --------private method------------------end----------------------**/

    return this;
};