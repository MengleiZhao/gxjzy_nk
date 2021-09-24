
//禁用网页本身右键
// $(document).ready(function(){  
//    $(document).bind("contextmenu",function(e){  
//        return false;  
//    });  
//}); 

//在layout的panle全局配置中,增加一个onCollapse处理title
var buttonDir = {north:'down',south:'up',east:'left',west:'right'};
$.extend($.fn.layout.paneldefaults,{
    onBeforeCollapse:function(){
        /**/
        var popts = $(this).panel('options');
            var dir = popts.region;
            var btnDir = buttonDir[dir];
            if(!btnDir) return false;
 
            setTimeout(function(){
                var pDiv = $('.layout-button-'+btnDir).closest('.layout-expand').css({
                textAlign:'center',lineHeight:'18px',fontWeight:'bold'
                });
 
                if(popts.title){
                    var vTitle = popts.title;
                    if(dir == "east" || dir == "west"){
                    var vTitle = popts.title.split('').join('<br/>');
                    pDiv.find('.panel-body').html(vTitle);
                }else{
                    $('.layout-button-'+btnDir).closest('.layout-expand').find('.panel-title')
                    .css({textAlign:'left'})
                    .html(vTitle)
                }
            }   
        },100);
    }
});

//让window居中
var easyuiPanelOnOpen = function (left, top) {
	var iframeWidth = $(this).parent().parent().width();
	var iframeHeight = $(this).parent().parent().height();
	var windowWidth = $(this).parent().width();
	var windowHeight = $(this).parent().height();
	var setWidth = (iframeWidth - windowWidth) / 2;
	var setHeight = (iframeHeight - windowHeight) / 2;
	$(this).parent().css({
		/* 修正面板位置 */
		left: setWidth,
		top: setHeight    
	});    
	if (iframeHeight < windowHeight){
		$(this).parent().css({
			/* 修正面板位置 */
			left: setWidth,
			top: 0       
		});    
	}    
	$(".window-shadow").hide();
};
$.fn.window.defaults.onOpen = easyuiPanelOnOpen;


/**
 * easyui 实现动态创建datagrid onHeaderContextMenu 功能
 * @param {} e
 * @param {} field
 */
var createGridHeaderContextMenu = function(e, field) {
    e.preventDefault();
    var grid = $(this);/* grid本身 */
    var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
    if (!headerContextMenu) {
        var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
        var asc = $('<div iconCls="icon-asc" field="asc">升序</div>').appendTo(tmenu);
        var desc = $('<div iconCls="icon-desc" field="desc">降序</div>').appendTo(tmenu);
        var filedHTML = $('<div iconCls="icon-columns"></div>');
        var span = $('<span>显示/隐藏</span>');
        var spdiv = $('<div></div>');
        var fields = grid.datagrid('getColumnFields');
        for ( var i = 0; i < fields.length; i++) {
                var fildOption = grid.datagrid('getColumnOption', fields[i]);
                if (!fildOption.hidden&&!fildOption.checkbox) {
                        $('<div iconCls="icon-checked" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(spdiv);
                } //else {
                  //      $('<div iconCls="icon-unchecked" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(spdiv);
                //}
        }
        span.appendTo(filedHTML);
        spdiv.appendTo(filedHTML);
        filedHTML.appendTo(tmenu);
        headerContextMenu = this.headerContextMenu = tmenu.menu({
            onClick : function(item) {
                var f = $(this).attr('field')
                var fieldProperty = $(item.target).attr('field');
                if (item.iconCls == 'icon-checked') {
                    grid.datagrid('hideColumn', fieldProperty);
                    $(this).menu('setIcon', {
                        target : item.target,
                        iconCls : 'icon-unchecked'
                    });
                }
                if (item.iconCls == 'icon-unchecked') {
                    grid.datagrid('showColumn', fieldProperty);
                    $(this).menu('setIcon', {
                        target : item.target,
                        iconCls : 'icon-checked'
                    });
                }
                if (item.iconCls == 'icon-asc') {
                    var options = grid.datagrid('options');
                    options.sortName = f;
                    options.sortOrder =fieldProperty;
                    grid.datagrid('reload');
                }
                if (item.iconCls == 'icon-desc') {
                    var options = grid.datagrid('options');
                    options.sortName = f;
                    options.sortOrder =fieldProperty;
                    grid.datagrid('reload');
                }
            }
        });
    }
    headerContextMenu.attr('field',field);
    headerContextMenu.menu('show', {
        left : e.pageX,
        top : e.pageY
    });
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;

//又来兼容IE低版本
var ie = (function(){
    var undef, v = 3, div = document.createElement('div'), all = div.getElementsByTagName('i');
    while (div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->', all[0]);
    return v > 4 ? v : undef;
}());

/** 
 * add by cgh 
 * 针对panel window dialog三个组件拖动时会超出父级元素的修正 
 * 如果父级元素的overflow属性为hidden，则修复上下左右个方向 
 * 如果父级元素的overflow属性为非hidden，则只修复上左两个方向 
 * @param left 
 * @param top 
 * @returns 
 */  
//var easyuiPanelOnMove = function(left, top) {  
//    var parentObj = $(this).panel('panel').parent();  
//    if (left < 0) {  
//        $(this).window('move', {  
//            left : 1  
//        });  
//    }  
//    if (top < 0) {  
//        $(this).window('move', {  
//            top : 1  
//        });  
//    }  
//    var width = $(this).panel('options').width;  
//    var height = $(this).panel('options').height;  
//    var right = left + width;  
//    var buttom = top + height;  
//    var parentWidth = parentObj.width();  
//    var parentHeight = parentObj.height();  
//    if(parentObj.css("overflow")=="hidden"){  
//        if(left > parentWidth-width){  
//            $(this).window('move', {  
//                "left":parentWidth-width  
//            });  
//        }  
//        if(top > parentHeight-height){  
//            $(this).window('move', {  
//                "top":parentHeight-height  
//            });  
//        }  
//    }  
//};  
//$.fn.panel.defaults.onMove = easyuiPanelOnMove;  
//$.fn.window.defaults.onMove = easyuiPanelOnMove;  
//$.fn.dialog.defaults.onMove = easyuiPanelOnMove;  

//设置datagrid的PageSize和PageList
if ($.fn.datagrid){
	$.fn.datagrid.defaults.pageSize=25;
	$.fn.datagrid.defaults.pageList=[25,50,100];
}

/**
 * datagrid绑定键盘事件，up|down:上下行；left|right:上下行
 */
$.extend($.fn.datagrid.methods, {
    keyCtr : function (jq) {
        return jq.each(function () {
            var grid = $(this);
            grid.datagrid('getPanel').panel('panel').attr('tabindex', 1).bind('keydown', function (e) {
                switch (e.keyCode) {
                 case 37: // up
                    var selected = grid.datagrid('getSelected');
                    if (selected) {
                        var index = grid.datagrid('getRowIndex', selected);
                        grid.datagrid('selectRow', index - 1);
                    } else {
                        var rows = grid.datagrid('getRows');
                        grid.datagrid('selectRow', rows.length - 1);
                    }
                    break;
                case 38: // up
                    var selected = grid.datagrid('getSelected');
                    if (selected) {
                        var index = grid.datagrid('getRowIndex', selected);
                        grid.datagrid('selectRow', index - 1);
                    } else {
                        var rows = grid.datagrid('getRows');
                        grid.datagrid('selectRow', rows.length - 1);
                    }
                    break;
                case 39: // down
                    var selected = grid.datagrid('getSelected');
                    if (selected) {
                        var index = grid.datagrid('getRowIndex', selected);
                        grid.datagrid('selectRow', index + 1);
                    } else {
                        grid.datagrid('selectRow', 0);
                    }
                    break;
                case 40: // down
                    var selected = grid.datagrid('getSelected');
                    if (selected) {
                        var index = grid.datagrid('getRowIndex', selected);
                        grid.datagrid('selectRow', index + 1);
                    } else {
                        grid.datagrid('selectRow', 0);
                    }
                    break;
                }
            });
        });
    }
});


var myview = $.extend({},$.fn.datagrid.defaults.view,{
    onAfterRender:function(target){
        $.fn.datagrid.defaults.view.onAfterRender.call(this,target);
        var opts = $(target).datagrid('options');
        var vc = $(target).datagrid('getPanel').children('div.datagrid-view');
        vc.children('div.datagrid-empty').remove();
        if (!$(target).datagrid('getRows').length){
            var d = $('<div class="datagrid-empty"></div>').html(opts.emptyMsg || 'no records').appendTo(vc);
            d.css({
                position:'absolute',
                left:0,
                top:25,
                width:'100%',
                textAlign:'center'
            });
        }
    }
});

