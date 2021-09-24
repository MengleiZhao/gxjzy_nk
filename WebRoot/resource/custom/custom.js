
//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
var base='${base}';
var themenurl='${themenurl}';
Date.prototype.Format = function(fmt)   
{ //author: meizz   
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}  

/**
 * yyyy-MM-dd HH:mm
 * @param {} date
 * @return {}
 * 以下两个方法必须同时使用，如：data-option='formatter:nyrsfFormatter,parser:nyrsfParser'
 */
function nyrsfFormatter(date){  
    var y = date.getFullYear();  
    var m = date.getMonth()+1;  
    var d = date.getDate();  
    var h = date.getHours();  
    var min = date.getMinutes();
    var str = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d)+' '+(h<10?('0'+h):h)+':'+(min<10?('0'+min):min);  
    return str;  
}  
function nyrsfParser(s){  
	if (!s) return new Date();  
    var y = s.substring(0,4);  
    var m =s.substring(5,7);  
    var d = s.substring(8,10);  
    var h = s.substring(11,13);  
    var min = s.substring(14,16);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(min)){  
        return new Date(y,m-1,d,h,min);  
    } else {  
        var time1 = new Date().format("yyyy-MM-dd HH:mm");
        return new Date(time1);  
    }  
}   
/**
 * yyyy年MM月dd日
 * @param {} date
 * @return {}
 */
function nyrCNFormatter(date){  
    var y = date.getFullYear();  
    var m = date.getMonth()+1;  
    var d = date.getDate();  
    var str = y+'年'+(m<10?('0'+m):m)+'月'+(d<10?('0'+d):d)+'日';  
    return str;  
}  
function nyrCNParser(s){  
	if (!s) return new Date();  
    var y = s.substring(0,4);  
    var m =s.substring(5,7);  
    var d = s.substring(8,10);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d) && !isNaN(h) && !isNaN(min)){  
        return new Date(y,m-1,d);  
    } else {  
        var time1 = new Date().format("yyyy年MM月dd日");
        return new Date(time1);  
    }  
}   

/**
 * 创建窗口
 * @param title		窗口标题
 * @param width		宽度
 * @param height	高度
 * @param icon		图标
 * @param href		地址
 * @returns
 */
function creatWin(title,width,height,icon,href){
	sessionValidate();//session过期则返回登录页
	var win=$("#custom_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: width,
	    height: height,
	    left: ($(window).width() - width)/2,
	    top:$(window).scrollTop()+50,
	    top:30,
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closed: true,
	    closable:true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:false,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+href,
	    onBeforeClose: function() {$('#custom_window').empty();}
    });
    return win;
}

function closeWindow(){
	$('#custom_window').empty();
	$("#custom_window").window('close');
}
function creatStreetWin(title,width,height,icon,href){
	var win=$("#custom_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: width,
	    height: height,
	    left: ($(window).width() - width)/2,
	    top:$(document).scrollTop()+50,  
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:false,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:href,
	    onBeforeClose: function() {$('#custom_window').empty();}
    });
    return win;
}


function creatFirstWin(title,width,height,icon,href){
	var win=$("#first_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: width,
	    height: height,
	    left: ($(window).width() - width)/2,
	    top:$(document).scrollTop()+50,
	    top:30,
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:false,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+href,
	    onBeforeClose: function() {$('#first_window').empty();}
	    
    });
    return win;
}

function closeFirstWindow(){
	$('#first_window').empty();
	$("#first_window").window('close');
}

function creatSecondWin(title,width,height,icon,href){
	var win=$("#second_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: width,
	    height: height,
	    left: ($(window).width() - width)/2,
	    top:$(document).scrollTop()+50,
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:false,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+href,
	    onBeforeClose: function() {$('#second_window').empty();}
	    
    });
    return win;
}

function closeSecondWindow(){
	$('#second_window').empty();
	$("#second_window").window('close');
}
//填写表单时可能需要弹出的表单
function creatSearchDataWin(title,width,height,icon,href){
	var win=$("#search_data_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: width,
	    height: height,
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:false,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+href,
	    onBeforeClose: function() {$('#search_data_window').empty();}
    });
    return win;
}

function closeSearchDateWindow(){
	$('#search_data_window').empty();
	$("#search_data_window").window('close');
}




//自由创建窗口
function creatFreeWindow(id,title,width,height,icon,href){
	var win=$("#"+id).window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: width,
	    height: height,
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:false,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+href,
	    onBeforeClose: function() {$("#"+id).empty();}
    });
    return win;
}

function closeFreeWindow(id){
	$("#"+id).empty();
	$("#"+id).window('close');
}
//时间格式化
function changeDateFormat(val) {
    var t, y, m, d, h, i, s;
    if(val==null){
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) + ':' + (s < 10 ? '0' + s : s);
}
//时间格式化yyyy-MM-dd HH:mm
function ChangeDateFormat2(val) {
	//alert(val)
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}
//时间格式化yyyy-MM-dd
function ChangeDateFormat3(val) {
	//alert(val)
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
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
//判断session是否过期
function sessionValidate(){
	$.ajax({ 
		type: 'POST', 
		url: base+"/timeout.do",
		dataType: 'text',  
		success: function(data){ 
			if(data=='true'){
				alert('系统会话超时，请重新登录系统！');
				parent.location.href=base + '/login.do';
			}
		} 
	}); 
}

//弹出审批意见页面(叶添加)
function openCheckWin(title,result) {
	var win=$("#check_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: 560,
	    height: 450,
	    shadow: false,
	    modal: true,
	    iconCls: 'icon-search',
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:false,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+"/checkWin/open?result="+result,
	    onBeforeClose: function() {$("#check_window").empty();}
    });
	win.window('open');
}
//关闭审批意见页面
function closeCheckWindow() {
	$("#check_window").empty();
	$("#check_window").window('close');
}

//创建指标下达页面专用的方法（因为指标下达中有可能会是计划下达，计划下达的情况下页面中有定时触发器刷新列表时间，如果单纯点击关闭按钮则无法删除定时器，所以新建的页面不显示关闭按钮，有手动方法触发关闭，以此删除定时器）
function creatIndexReleaseWin(title,width,height,icon,href){
	sessionValidate();//session过期则返回登录页
	var win=$("#custom_index_release_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: width,
	    height: height,
	    top:30,
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closable:false,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:false,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+href,
	    onBeforeClose: function() {
	    	$('#custom_index_release_window').empty();
	    }
    });
    return win;
}
function creatCockFirstWin(title,width,height,icon,href){
	var win=$("#first_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: width,
	    height: height,
	    top:$(document).scrollTop()+50,
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:true,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+href,
	    onBeforeClose: function() {$('#first_window').empty();}
	    
    });
    return win;
}
//驾驶舱列表窗口打开
function creatDetailFirstWin(title,icon,href){
	var win=$("#first_window").window({
		constrain: true,//关键代码 使窗口不可被拖动到浏览器之外
        title: title,
	    width: 780,
	    height: 510 ,
	    top:$(document).scrollTop()+50,
	    shadow: false,
	    modal: true,
	    iconCls: icon,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    resizable:true,
	    draggable:true,
	    cache : false,
	    loadingMessage:'正在加载，请稍等...',
	    href:base+href,
	    onBeforeClose: function() {$('#first_window').empty();}
	    
    });
    return win;
}

//二维码页面打开窗口
function opeanQRecode(code){
	
	$("#QRcode_window").window({
		title: " ",
	    width: 800,
	    height: 500,
	    modal: true,
	    closed: true,
	    minimizable: false,
	    maximizable: false,
	    collapsible: false,
	    shadow:false,
	});
	$("#QRcode_window").window('open');
	$("#QRcode_window").html(" <div><div style='height:30px;width:100%;margin-top:30px;text-align: center;font-size:16px'><span style='color:#fba917'>报销太麻烦？</span><span style='color:#333333'> 用手机</span><span style='color:#008dff'>扫描</span><span style='color:#333333'>下方二维码，可以轻松实现报销</span></div> <div style='width:430px;height:377px;position:absolute;float: left;bottom: 0px;'><img style='float: right;margin-right:30px' src='"+base+"/resource-modality/img/skin_/sys.png'></div>  <div id='qrcode' style='width:360px;height:160px;margin-top:70px;float: right;position: relative'></div></div>");
	
	var qrcode = new QRCode("qrcode");
	var elText = document.getElementById("gCode");
    qrcode.makeCode(elText.value);
}
