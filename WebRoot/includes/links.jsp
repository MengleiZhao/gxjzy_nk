<%@ page language="java" pageEncoding="utf-8"%>

<!-- 一些用途不明的样式和js  -->
<%-- <link rel="stylesheet" type="text/css" href="${base}/resource/css/layout.css">
<link rel="stylesheet" type="text/css" href="${base}/resource/css/style.css">
<link rel="stylesheet" type="text/css" href="${base}/resource/css/screen.css">
<script type="text/javascript" src="${base}/resource-modality/js/cc.js"></script>
<link rel="stylesheet" type="text/css" href="${base}/resource/camera/demo.css"></link>
<link rel="stylesheet" type="text/css" href="${base}/resource/steps/iF.step.css"> --%>

<!-- ---------------------------css---------------------------------  -->

<!-- 时间控件（不确定）  -->
<link rel="stylesheet" type="text/css" href="${base}/resource/plugins/My97DatePicker/skin/WdatePicker.css">
<!-- 一些系统样式（重要不能删除）  -->
<link rel="stylesheet" type="text/css" href="${base}/resource/css/reset.css">
<!-- easyui样式  -->
<link rel="stylesheet" id="easyuiTheme" type="text/css" href="${base}/resource/ui/themes/default/easyui-new.css">
<!-- easyui小图标  -->
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/icon.css">



<!-- 系统样式 -->
<link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/style-new.css">
<%-- <link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/first/style-new.css"> --%>
<!-- 非easyui tab页的新tab页样式 -->
<link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/style-tabs.css">
<!-- 快速入口编辑的页面样式 -->
<link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/dsSelect.css">
<!-- 浏览器页面左上角的易图标 -->
<link rel="shortcut icon" href="${base}/resource-modality/${themenurl}/icon/favicon.ico" type="image/x-icon" />
<!-- 左侧菜单 -->
<link rel="stylesheet" href="${base}/resource-modality/css/left-style.css">

<!-- jquery 日期框 -->
<link rel="stylesheet" href="${base}/resource-modality/css/date_input.css" type="text/css">  

<!-- ---------------------------js---------------------------------  -->

<!-- jquery.min.js   -->
<script type="text/javascript" src="${base}/resource/ui/jquery.min.js"></script>
<!-- jquery.js  -->
<script type="text/javascript" src="${base}/resource/js/jquery.js"></script>
<!-- easyUi  -->
<script type="text/javascript" src="${base}/resource/ui/jquery.easyui.min.js"></script>
<!-- easyUi中文语言包  -->
<script type="text/javascript" src="${base}/resource/ui/locale/easyui-lang-zh_CN.js"></script>
<%-- <!-- echarts  -->
<script type="text/javascript" src="${base}/resource-now/js/echarts.js"></script> --%>
<!-- highcharts  -->
<script type="text/javascript" src="${base}/resource/highcharts/highcharts.js"></script> 
<!-- highcharts  -->
<script type="text/javascript" src="${base}/resource/highcharts/highcharts-3d.js"></script> 
<!-- 时间控件（不确定）  -->
<script type="text/javascript" src="${base}/resource/plugins/My97DatePicker/WdatePicker.js"></script>
<!-- easyui中虚拟滚动-延迟加载 -->
<script type="text/javascript" src="${base}/resource/ui/plugins/extension/datagrid-scrollview.js"></script>
<!-- jquery二维码  -->
<script type="text/javascript" src="${base}/resource-now/js/qrcode.js"></script>
<!-- jquery生成二维码  -->
<script type="text/javascript" src="${base}/resource-now/js/jquery.qrcode.min.js"></script>
<!-- 首页资产3D效果  -->
<script type="text/javascript" src="${base}/resource/js/tagcloud.js"></script>

<!-- 系统原来的一个js文件（包含页面打开，关闭的一些方法）   -->
<script type="text/javascript" src="${base}/resource/custom/custom.js"></script>
<!-- 非easyui tab页的js -->
<script type="text/javascript" src="${base}/resource-modality/js/index-tabs.js"></script>
<!-- 系统js -->
<script type="text/javascript" src="${base}/resource-modality/js/nkgl.js"></script>
<!-- 校验js -->
<script type="text/javascript" src="${base}/resource-modality/js/nkgl_check.js"></script>
<!-- 附件上传js -->
<script type="text/javascript" src="${base}/resource-modality/js/nkgl_upload.js"></script>

<script type="text/javascript" src="${base}/resource-modality/js/ajaxfileupload.js"></script>
<!-- easyui表格分组视图js -->
<script type="text/javascript" src="${base}/resource-modality/js/datagrid-groupview.js"></script>
<!-- 银行卡号查银行名称  -->
<script type="text/javascript" src="${base}/resource-modality/js/bank.js"></script> 


<!-- jquery日期框样式 -->
<script type="text/javascript" src="${base}/resource-modality/js/jquery.date_input.js"></script>   



<script type="text/javascript">
var base='${base}';

//老的tab页面打开方式，各个tab页的id和js会冲突
function addTabs(title, url) {
	$("#system-body").panel({
	    href:url,
	    loadingMessage:null,
	});
	//切换为驾驶舱样式
	/* if(title=='管理驾驶舱'){
        dynamicLoading.css('/nkgl/resource/ui/themes/default/easyui-new.css');
    } else{
    	dynamicLoading.css('/nkgl/resource/ui/themes/default/easyui-new.css');
    } */
	
	/* sessionValidate();
	if ($('#tt').tabs('exists', title)) {
		$('#tt').tabs('select', title);
		var tab = $('#tt').tabs('getSelected');
		tab.panel('refresh', encodeURI(url));
	} else {
		$('#tt').tabs('add', {
			title : title,
			href : encodeURI(url),
			closable : true,
			loadingMessage : '',
			border : false,
			//一下为刷新tab页使用，叶注销 
			tools : [ {
				iconCls : 'icon-mini-refresh',
				handler : function() {
					$('#tt').tabs('select', title);
					var tab = $('#tt').tabs('getSelected');
					tab.panel('refresh', url);
				}
			} ]
			//
		});
	} */
}

//新的tab页面打开方式，方法需要各自填写
function addTabs2(title, href){  
	$("#system-body").panel({
	    href:href,
	    loadingMessage:null,
	});
	
	/* if(title=='管理驾驶舱'){
        dynamicLoading.css('/nkgl/resource/ui/themes/cockpit/easyui-new.css');
    }else{
    	dynamicLoading.css('/nkgl/resource/ui/themes/default/easyui-new.css');
    } */
	
	/* sessionValidate();
    var tt = $('#tt');  
    if (tt.tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab          
        tt.tabs('select', title);  
      	refreshTab({tabTitle:title,url:href});
    } else {  
         var content="";
        if (href){  
            content = '<iframe class="ourIframe" scrolling="yes" frameborder="0" src="'+href+'" style="width:100%;height:99%;margin:0px;padding:0px; "></iframe>';
        } else {  
            content = '未实现';  
        }  
        tt.tabs('add',{  
            title:title,
            closable:true,
            border : false,
            content:content, 
        });  
    }  */
}

/* -----------------以下方法用途不明---------------------- */
/* $(function() {
	//默认展开项
	 $('#aa').accordion('select',"${selectNo}");
	//绑定tabs的右键菜单
	$("#tt").tabs({
		onContextMenu : function(e, title) {
			e.preventDefault();
			if (title != '首页') {
				$('#tabsMenu').menu('show', {
					left : e.pageX,
					top : e.pageY
				}).data("tabTitle", title);
			}
		}
	});

	//实例化menu的onClick事件
	$("#tabsMenu").menu({
		onClick : function(item) {
			CloseTab(this, item.name);
		}
	});

	//几个关闭事件的实现
	function CloseTab(menu, type) {
		var curTabTitle = $(menu).data("tabTitle");
		var tabs = $("#tt");

		if (type === "close") {
			tabs.tabs("close", curTabTitle);
			return;
		}

		var allTabs = tabs.tabs("tabs");
		var closeTabsTitle = [];

		$.each(allTabs, function() {
			var opt = $(this).panel("options");
			if (opt.closable && opt.title != curTabTitle && type === "Other") {
				closeTabsTitle.push(opt.title);
			} else if (opt.closable && type === "All") {
				closeTabsTitle.push(opt.title);
			}
		});

		for (var i = 0; i < closeTabsTitle.length; i++) {
			tabs.tabs("close", closeTabsTitle[i]);
		}
	}
	
 	$('.easyui-tree').tree({
		onClick: function(node){
			addTabs(node.attributes.title,node.attributes.url);
			//$("#right_region").panel('refresh', node.attributes.about)
		}
	});
}); */
/* $(function () {	
	$(document).ready(function(){
	  $(".cont-ul li").hover(function(){
	    $(this).children(".cont-ul li div").toggle();
	  });
	});
}); */


</script>
<!-- plugins -->
<%-- <script type="text/javascript" src="${base}/resource/plugins/jquery.cookie.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/resource/ui/plugins/extension/jquery.extension.validatebox.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/resource/ui/jquery.easyui.extension.js" charset="utf-8"></script> --%>

