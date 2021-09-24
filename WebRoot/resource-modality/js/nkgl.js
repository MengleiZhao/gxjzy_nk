/** 叶崇晖 2018-9-12 **/
/*//分页样式调整
$(function(){
	$(".easyui-datagrid").each(function(){
		var pager = $(this).datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last' ,'refresh']
		});
	});
});*/

//鼠标悬浮单元格提示信息  
function formatCellTooltip(value){  
    return "<span title='" + value + "'>" + value + "</span>";  
}  

//分页样式调整
function paginationChange(tableId) {
	var pager = $('#'+tableId).datagrid().datagrid('getPager');
	pager.pagination({layout:['sep','first','prev','links','next','last']});	
}

//获取一个时间的年份
function getYear(val) {
	var t, y;
	if (val == null || val == "") {
		return "";
	}
	t = new Date(val);
	y = t.getFullYear();
	return y;
}

//时间格式化
function ChangeDateFormat(val) {
	var t, y, m, d, h, i, s;
	if (val == null || val == "") {
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

//时间格式化
function ChangeDateFormatIndex(val) {
	var t, y, m, d, h, i, s;
	if (val == null || val == "") {
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
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d)+ ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}

/* EasyUI--datebox设置默认时间 */
function myformatter(date){  
    var y = date.getFullYear();  
    var m = date.getMonth()+1;  
    var d = date.getDate();  
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);  
}  

//列表页面级子页面图片替换
function mouseOver(img){
	var src = $(img).attr("src");
	src = src.replace(/1/, "2");
	$(img).attr("src",src);
}
	
function mouseOut(img) {
	var src = $(img).attr("src");
	src = src.replace(/2/, "1");
	$(img).attr("src",src);
}

//列表操作图片鼠标移入事件
function listMouseOver(obj) {
	var src = $(obj).attr("src");
	src = src.replace(/1/, "2");
	$(obj).attr("src",src);
}
//列表操作图片鼠标移出事件
function listMouseOut(obj) {
	var src = $(obj).attr("src");
	src = src.replace(/2/, "1");
	$(obj).attr("src",src);
}

//项目审批状态
function projectCheckStauts(val, row){
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/zc.png">' + " 未发起" + '</a>';
	} else if(val=='11' || val=='21' || val=='31') {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/dsp.png">' + " 待审批" + '</a>';
	} else if(val=='29' || val=='39') {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/ytg.png">' + " 已审批" + '</a>';
	} else if (val=='-11' || val=='-21' || val=='-31') {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/yth.png">' + " 已退回" + '</a>';
	} else if(val=='19'||val=='20') {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/zc.png">' + " 未发起" + '</a>';
	} else if(val=='-14'||val=='-34') {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/zc.png">' + " 已撤回" + '</a>';
	} else if(val=='30') {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/zc.png">' + " 暂存" + '</a>';
	}
}

//项目上报状态
function declareStauts(val, row) {
	if(val=='10' || val=='20'){
		return '<a style="color:#666666;line-height: 16px"><img style="vertical-align:middle;height:12px" src="'+base+'/resource-modality/img/list/bxdd.png">' + " 备选待定" + '</a>';
	}
	if(val=='11' || val=='21'){
		return '<a style="color:#4fba7a;line-height: 16px;font-weight: bold;"><img style="vertical-align:middle;height:12px;width:12px" src="'+base+'/resource-modality/img/sbcg.png">' + " 上报成功" + '</a>';
	}
}

//查看项目信息
function selectProject(id) {
	var win=creatWin('查看-项目信息',1230,630,'icon-search','/project/detail/'+id);
	win.window('open');
}

//上报库审批结果转换
function ysCheckResult(val, row) {
	if(val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/ytg.png">' + " 同意" + '</a>';
	} else if(val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/yth.png">' + " 不同意" + '</a>';
	}
}
//上报库加载时差额计算
function projectCE(val, row) {
	if(row.provideAmount1 != null && row.provideAmount1 != ""){
		return parseFloat(row.provideAmount1-row.fproBudgetAmount).toFixed(2);
	} else if(row.provideAmount1==null||row.provideAmount1==0||row.provideAmount1=='undefined'||row.provideAmount1=='') {
		return parseFloat(0-row.fproBudgetAmount).toFixed(2);
	} else {
		return null;
	}
}

//金额数据保留两位
function listToFixed(val) {
	if(val != null && val != ""){
		var	num = parseFloat(val).toFixed(2);
	    return num.toString().replace(/\d+/, function (n) { // 先提取整数部分
	        return n.replace(/(\d)(?=(\d{3})+$)/g, function ($1) { // 对整数部分添加分隔符
	            return $1 + ",";
	        });
	    });
	} else {
		val=0;
		return val.toFixed(2);
	}
}

//审批页面跳转
function indexCheck(id,url) {
	url = url.toString();
	var lasttype = url.substring(url.length-1,url.length);
	var lastfourtype = url.substring(url.length-4,url.length);
	var type = url.substring(1,8);
	var types = url.substring(1,12);
	if(types=='projectknot') {
			var win = parent.creatWin('审批', 970, 580,'icon-search',url);
			win.window('open');
		}else if(type=='project'){
			var win = parent.creatWin('审批', 1330, 630, 'icon-search',url);
			win.window('open');
	}else if(type=='applyCh'){
		var win;
		/*if(lasttype=='1') {
			//通用事项申请查看
			win = parent.creatWin('审批',765, 580,'icon-search',url);
//			win.window('open');
		}else {
			win = parent.creatWin('审批', 985, 580, 'icon-search',url);
		}*/
		win = parent.creatWin('审批', 1125, 580, 'icon-search',url);
		win.window('open');
	}else if(type=='reimbur'&&lastfourtype=='tysx') {
		var win = parent.creatWin('审批', 1115, 600,'icon-search',url);
		win.window('open');
	}else if(type=='reimbur'&&lasttype==0) {
		var win = parent.creatWin('审批', 1115, 600,'icon-search',url);
		win.window('open');
	}else if(type=='reimbur'){
		var win = parent.creatWin('审批', 1115, 580, 'icon-search',url);
		win.window('open');
	} else if(type=='insideC') {
		var win = parent.creatWin('审批', 970, 580,'icon-search',url);
		win.window('open');
	}  else if(type=='declare') {
		var win = parent.creatWin('审批', 1330, 630,'icon-search',url);
		win.window('open');
	}  else  if(type=='Approva') {
		var win = parent.creatWin('审批', 1115, 580,'icon-search',url);
		win.window('open');
	}  else if(type=='payment') {
		var win = parent.creatFirstWin('审批', 1115, 580,'icon-search',url);
		win.window('open');
	}else if(type=='busines'){
		var win = parent.creatWin('审批', 1105, 580, 'icon-search',url);
		win.window('open');
	}else if(type=='srregis'){
		var win = parent.creatWin('审批', 1105, 580, 'icon-search',url);
		win.window('open');
	} else if(type=='account') {
		var win = parent.creatWin('审批', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='appropr') {
		var win = parent.creatWin('审批', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='directl') {
		var win = parent.creatWin('审批', 1115, 600,'icon-search',url);
		win.window('open');
	}else if(type=='loanChe') {
		var win = parent.creatWin('审批', 1115, 600,'icon-search',url);
		win.window('open');
	}else {
		var win = parent.creatWin('审批', 1115, 600, 'icon-search',url);
		win.window('open');
	}
	
}

/*else if(type=='reimbur'&&lasttype=='1') {
	var win = parent.creatWin('审批', 780, 580,'icon-search',url);
win.window('open');
}  */
//查看页面跳转
function indexDetail(id,url){
	var type = url.substring(1,8);
	//用来判断是不是通用事项
	url = url.toString();
	var lastfourtype = url.substring(url.length-4,url.length);
	var lasttype = url.substring(url.length-1,url.length);
	var types = url.substring(1,12);
	 if(types=='projectknot') {
			var win = parent.creatWin('查看', 980, 580,'icon-search',url);
			win.window('open');
		}else if(type=='project'){
		var win = parent.creatWin('查看', 1330,630, 'icon-search',url);
		win.window('open');
	}  else if(type=='Enforci') {
		var win = parent.creatFirstWin('查看', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='apply/e') {
		/*if(lasttype=='1') {
			//通用事项申请查看
			var win = parent.creatWin('查看',795, 580,'icon-search',url);
//			win.window('open');
		}else {
			var win = parent.creatWin('查看', 1095, 580,'icon-search',url);
		}*/
		var win = parent.creatWin('查看', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='Formula') {
		var win = parent.creatWin('查看', 1115, 580,'icon-search',url);
		win.window('open');
	} else if(type=='insideA') {
		var win = parent.creatWin('查看', 970, 580,'icon-search',url);
		win.window('open');
	}  else if(type=='Storage') {
		var win = parent.creatWin('查看', 970, 580,'icon-search',url);
		win.window('open');
	}  else if(type=='reimbur') {
		var win = null;
		if(type=='reimbur'&&lastfourtype=='tysx'){
			win = parent.creatWin('查看', 1115, 600,'icon-search',url);
		}else{
			win = parent.creatWin('查看', 1080, 580,'icon-search',url);
		}
		win.window('open');
	}  else if(type=='payment') {
		var win = parent.creatFirstWin('查看', 1115, 580,'icon-search',url);
		win.window('open');
	}	else if(type=='busines'){
		var win = parent.creatWin('查看', 1105, 580, 'icon-search',url);
		win.window('open');
	}else if(type=='srregis'){
		var win = parent.creatWin('查看', 1105, 580, 'icon-search',url);
		win.window('open');
	} else if(type=='appropr') {
		var win = parent.creatWin('查看', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='account') {
		var win = parent.creatWin('查看', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='directl') {
		var win = parent.creatWin('查看', 1115, 600,'icon-search',url);
	win.window('open');
	} else if(type=='loan/ed') {
		var win = parent.creatWin('查看', 1115, 600,'icon-search',url);
		win.window('open');
	} else {
		var win = parent.creatWin('查看', 1115, 600, 'icon-search',url);
		win.window('open');
	}
}
//修改页面跳转
function indexEdit(id,url){
	var type = url.substring(1,8);
	//用来判断是不是通用事项
	url = url.toString();
	var lastfourtype = url.substring(url.length-4,url.length);
	var lasttype = url.substring(url.length-1,url.length);
	var types = url.substring(1,12);
	 if(types=='projectknot') {
			var win = parent.creatWin('审批', 970, 580,'icon-search',url);
			win.window('open');
		}else if(type=='project'){
		var win = parent.creatWin('修改', 1330,630, 'icon-search',url);
		win.window('open');
	} else if(type=='Enforci') {
		var win = parent.creatFirstWin('修改', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='apply/e') {
		/*if(lasttype=='1') {
			//通用事项申请查看
			var win = parent.creatWin('修改',795, 580,'icon-search',url);
			win.window('open');
		}else {
			var win = parent.creatWin('修改', 1100, 580,'icon-search',url);
		}*/
		var win = parent.creatWin('修改', 1115, 580,'icon-search',url);
		win.window('open');
	} else if(type=='insideA') {
		var win = parent.creatWin('修改', 970, 580,'icon-search',url);
		win.window('open');
	}  else if(type=='reimbur'&&lastfourtype=='tysx') {
		var win = parent.creatWin('修改', 1115, 600,'icon-search',url);
		win.window('open');
	}  else if(type=='Formula') {
		var win = parent.creatWin('修改', 1115, 580,'icon-search',url);
		win.window('open');
	}  else if(type=='payment') {
		var win = parent.creatWin('修改', 1115, 580,'icon-search',url);
		win.window('open');
	}   else if(type=='reimbur') {
		var win = parent.creatWin('修改', 1080, 580, 'icon-search',url);
		win.window('open');
	}  else if(type=='account') {
		var win = parent.creatWin('修改', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='busines'){
		var win = parent.creatWin('修改', 1105, 580, 'icon-search',url);
		win.window('open');
	}else if(type=='srregis'){
		var win = parent.creatWin('修改', 1105, 580, 'icon-search',url);
		win.window('open');
	} else if(type=='appropr') {
		var win = parent.creatWin('修改', 1115, 600,'icon-search',url);
		win.window('open');
	} else if(type=='directl') {
		var win = parent.creatWin('修改', 1115, 600,'icon-search',url);
		win.window('open');
	}else if(type=='loan/ed') {
		var win = parent.creatWin('修改', 1115, 600,'icon-search',url);
		win.window('open');
	}    else {
		var win = parent.creatWin('修改', 1115, 600, 'icon-search',url);
		win.window('open');
	}
}

//首页待办事项删除方法
function indexDelete(id,url) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : url,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					indexDelete1(id);
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}
//待办个人任务删除

function indexDelete1(id){
		$.ajax({
		url: base+ "/psersonalWork/delete?id="+id+"",
		type : 'post',
		dataType:'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(data) {
			alert("删除成功！");
			$('#indexdb').datagrid('reload');
			}
		});
}
/*//待办已办办结耗时计算
function haoshi(val, row) {
	var sdate = new Date(row.referTime);//上环节处理人提交时间
	var fdate = new Date(row.finishTime);//任务完成时间
	if(row.taskStauts==0) {//待办
		if(row.type==3) {//退回
			return "-";
		} else {//审批耗时
			var now = new Date();
			var days = now.getTime() - sdate.getTime();
			var d = parseInt(days / (1000 * 60 * 60 * 24));
			var h = parseInt((days % (1000 * 60 * 60 * 24))/(1000 * 60 * 60));
			return d+"天"+h+"小时"; 
		}
	} else if(row.taskStauts==2 || row.taskStauts==4) {//已办、办结
		var days = fdate.getTime() - sdate.getTime();
		var d = parseInt(days / (1000 * 60 * 60 * 24));
		var h = parseInt((days % (1000 * 60 * 60 * 24))/(1000 * 60 * 60));
		return d+"天"+h+"小时";
	} else {
		return "";
	}
}*/

/*//小写数字换成大写数字
function convertCurrency(money) {  
	//汉字的数字  
	var cnNums = new Array('零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖');  

	//基本单位  
	var cnIntRadice = new Array('', '拾', '佰', '仟');  

	//对应整数部分扩展单位  
	var cnIntUnits = new Array('', '万', '亿', '兆');  

	//对应小数部分单位  
	var cnDecUnits = new Array('角', '分', '毫', '厘');  

	//整数金额时后面跟的字符  
	var cnInteger = '整';  

	//整型完以后的单位  
	var cnIntLast = '元';  

	//最大处理的数字  
	var maxNum = 999999999999999.9999;  

	//金额整数部分  
	var integerNum;  
	
	//金额小数部分  
	var decimalNum;  

	//输出的中文金额字符串  
	var chineseStr = '';  

	//分离金额后用的数组，预定义  
	var parts;  
	if (money == '') { 
		return ''; 
	}  
	money = parseFloat(money);  
	if (money >= maxNum) {  
		//超出最大处理数字  
		return '';  
	}  

	if (money == 0) {  
		chineseStr = cnNums[0] + cnIntLast + cnInteger;  
	    return chineseStr;  
	}  

	//转换为字符串  
	money = money.toString();  
	if (money.indexOf('.') == -1) {  
	  integerNum = money;  
	  decimalNum = '';  
	} else {  
	  parts = money.split('.');  
	  integerNum = parts[0];  
	  decimalNum = parts[1].substr(0, 4);  
	}  

	//获取整型部分转换  
	if (parseInt(integerNum, 10) > 0) {  
	  var zeroCount = 0;  
	  var IntLen = integerNum.length;  
	  for (var i = 0; i < IntLen; i++) {  
	    var n = integerNum.substr(i, 1);  
	    var p = IntLen - i - 1;  
	    var q = p / 4;  
	    var m = p % 4;  
	    if (n == '0') {  
	    	zeroCount++;  
	    } else {  
	    	if (zeroCount > 0) {  
	    		chineseStr += cnNums[0];  
	    	}  
	        //归零  
	        zeroCount = 0;  
	        chineseStr += cnNums[parseInt(n)] + cnIntRadice[m];  
	    }  
	    if (m == 0 && zeroCount < 4) {  
	    	chineseStr += cnIntUnits[q];  
	    }  

	  }  
	  chineseStr += cnIntLast;  
	}  
	//小数部分  
	if (decimalNum != '') {  
		var decLen = decimalNum.length;  
	    for (var i = 0; i < decLen; i++) {  
	    	var n = decimalNum.substr(i, 1);  
	    	if (n != '0') {  
	        chineseStr += cnNums[Number(n)] + cnDecUnits[i];  
	    	}  
	    }  
	}  

	if (chineseStr == '') {  
		chineseStr += cnNums[0] + cnIntLast + cnInteger;  
	} else if (decimalNum == '') {  
		chineseStr += cnInteger;  
	}  
		return chineseStr;  
}  */

var dynamicLoading = {
	css: function(path){
	if(!path || path.length === 0){
	throw new Error('argument "path" is required !');
	}
	var head = document.getElementsByTagName('head')[0];
	var link = document.createElement('link');
	link.href = path;
	link.rel = 'stylesheet';
	link.type = 'text/css';
	head.appendChild(link);
	},
	js: function(path){
	if(!path || path.length === 0){
	throw new Error('argument "path" is required !');
	}
	var head = document.getElementsByTagName('head')[0];
	var script = document.createElement('script');
	script.src = path;
	script.type = 'text/javascript';
	head.appendChild(script);
	}
}

//将时间转化为X天X小时X分X秒
function timeChange(time){
	var d = parseInt(time / (1000 * 60 * 60 * 24));
	var h = parseInt((time % (1000 * 60 * 60 * 24))/(1000 * 60 * 60));
	var m = parseInt(((time % (1000 * 60 * 60 * 24))%(1000 * 60 * 60))/(1000*60));
	var s = parseInt((((time % (1000 * 60 * 60 * 24))%(1000 * 60 * 60))%(1000*60))/1000);
	return d+" 天 "+h+" 小时 "+m+" 分 "+s+" 秒 ";
}

//easyui tree全选
function treeAllChecked(id) {  
	var tree = $('#'+id);//获取当前的树
	
	
    var roots = tree.tree('getSelected').children;//返回tree中所选择节点的所有子节点  
    for ( var i = 0; i < roots.length; i++) {//将所有子节点的选中状态改为选择
        var node = tree.tree('find', roots[i].id);  
        tree.tree('check', node.target);  
    }  
}

//easyui tree反选
function treeAntiChecked(id) {	
	var tree = $('#'+id);//获取当前的树
	
	var roots = tree.tree('getSelected').children;//返回tree中所选择节点的所有子节点  
    for ( var i = 0; i < roots.length; i++) {  
        var node = tree.tree('find', roots[i].id);
        if(node.checked){//判断子节点的选择状态
        	tree.tree('uncheck', node.target);
        } else {
        	tree.tree('check', node.target);
        }
    }  
}


//指标执行进度
function zbzxjd(val, row) {
	var percent = val;
	//进度条
	if (percent <= 40) {
					
		var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
				+ percent
				+ '" text="'
				+ percent
				+ '%">'
				+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
				+ percent
				+ '%</div>'
				+ '<div class="progressbar-value" style="width: '
				+ percent
				+ '%; height: 20px; line-height: 20px;">'
				+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#53CA22">'
				+ percent + '%</div>' + '</div>' + '</div>';
		
				}
		else if (percent <= 60) {
		var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
			+ percent
			+ '" text="'
			+ percent
			+ '%">'
			+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
			+ percent
			+ '%</div>'
			+ '<div class="progressbar-value" style="width: '
			+ percent
			+ '%; height: 20px; line-height: 20px;">'
			+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#FFFF00">'
			+ percent + '%</div>' + '</div>' + '</div>';
		
		}		
		else if (percent <= 80) {
					var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
						+ percent
						+ '" text="'
						+ percent
						+ '%">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
						+ percent
						+ '%</div>'
						+ '<div class="progressbar-value" style="width: '
						+ percent
						+ '%; height: 20px; line-height: 20px;">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#FF8C00">'
						+ percent + '%</div>' + '</div>' + '</div>';
					
				}			
				else if (percent <= 100) {
					var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
						+ percent
						+ '" text="'
						+ percent
						+ '%">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
						+ percent
						+ '%</div>'
						+ '<div class="progressbar-value" style="width: '
						+ percent
						+ '%; height: 20px; line-height: 20px;">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#FF0000">'
						+ percent + '%</div>' + '</div>' + '</div>';
					
				}
				else if (percent > 100) {
					var htmlstr = '<div class="easyui-progressbar progressbar" style="margin: 0 auto;width: 60px; height: 20px;background-color:#F0F5F7" value="'
						+ percent
						+ '" text="'
						+ percent
						+ '%">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;">'
						+ percent
						+ '%</div>'
						+ '<div class="progressbar-value" style="width: '
						+ percent
						+ '%; height: 20px; line-height: 20px;">'
						+ '<div class="progressbar-text" style="width: 60px; height: 20px; line-height: 20px;background-color:#A52A2A">'
						+ percent + '%</div>' + '</div>' + '</div>';
					
				}
	return htmlstr;

	}
/**
 * 金额使用逗号分隔
 * @param s   金额
 * @param n   小数点位数
 * @returns {String}
 */
function fomatMoney(s, n) {  
	if(s=="" || s==null){
		s=0.00;
	}else{
		s=parseFloat(s);
	}
    n = n > 0 && n <= 20 ? n : 2;  

    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  

    var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];  

    t = "";  

    for (i = 0; i < l.length; i++) {  

        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  

    }  

    var mone = t.split("").reverse().join("") + "." + r;

    return t.split("").reverse().join("") + "." + r;  

}
function showFlowDesinger(){
	var flowId=$("#flowId").val();
	var nextKey=$("#nextKey").val();
	var win = creatFirstWin("流程进度", 1075, 580, 'icon-search', "/wflow/showFlowDesinger?flowId="+ flowId +"&nextKey="+ nextKey);
	win.window('open');	
}

/*//撤回方法  1.dgID重新加载列表名称 2.id主键id 3.类名全路径
function reCall(dgID,id,beanPath){
	if (confirm("确认撤回吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/public/reCall?id='+id+'&beanPath='+beanPath,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$("#"+dgID).datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
	
}*/

//撤回方法   1.dgID重新加载列表名称  3.url
function reCall(dgID,id,url){
	if (confirm("确认撤回吗？")) {
		$.messager.progress();
		$.ajax({
			type : 'POST',
			url : base+url+'?id='+id,
			dataType : 'json',
			async : false,
			success : function(data) {
				$.messager.progress('close');
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$("#"+dgID).datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
	
}

function HFLX(val){
	if(val=='HTFL-01'){
		return '采购类合同';
	}else if(val=='HTFL-02'){
		return '收入类合同';
	}else if(val=='HTFL-03'){
		return '非经济类合同';
	}
	
}
/**
 * 合同变更列表显示返回值
 * @param val
 * @returns {有/无变更}
 */
function HTupdateStatus(val){
	if(val=='1'){
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/yth.png">' + " 有变更" + '</span>';
	}else if(val=='0'){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/img/ytg.png">' + " 无变更" + '</span>';
	}
}
/**
 * 合同纠纷列表显示返回值
 * @param val
 * @returns {有/无纠纷}
 */
function HTdisputeStatus(val){
	if(val=='1'){
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/img/yth.png">' + " 有纠纷" + '</span>';
	}else if(val=='0'){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/img/ytg.png">' + " 无纠纷" + '</span>';
	}
}

/**
 * 预算模块的查询方法
 * @param datagridID 表的id
 * @author 陈睿超
 */
function queryProList(datagridID){
	$("#"+datagridID).datagrid('load',{
		FProCode:$('#pro_list_query_FProCode').textbox('getValue').trim(),
		FProName:$('#pro_list_query_FProName').textbox('getValue').trim(),
		FProAppliDepart:$('#pro_list_query_FProAppliDepart').textbox('getValue').trim(),
		FProAppliPeople:$('#pro_list_query_FProAppliPeople').textbox('getValue').trim(),
		planStartYear:$('#pro_list_query_planStartYear').numberbox('getValue'),
		FProOrBasic:$('#pro_list_query_FProOrBasic').combobox('getValue').trim()=='--请选择--'?'':$('#pro_list_query_FProOrBasic').combobox('getValue').trim()
	});
}


/**
 * 子项目模块的查询方法
 * @param datagridID 表的id
 * @author 陈睿超
 */
function queryProList1(datagridID){
	$("#"+datagridID).datagrid('load',{
		FProCode:$('#pro_list_query_FProCode').textbox('getValue').trim(),
		FProName:$('#pro_list_query_FProName').textbox('getValue').trim(),
		FProAppliDepart:$('#pro_list_query_FProAppliDepart').textbox('getValue').trim(),
		FProAppliPeople:$('#pro_list_query_FProAppliPeople').textbox('getValue').trim(),
		planStartYear:$('#pro_list_query_planStartYear').numberbox('getValue'),
	});
}
/**
 * 子项目模块的清除方法 没有多余标签页时使用
 * @param datagridID 表的id
 * @author 陈睿超
 */
function clearProList1(datagridID){
	$('#pro_list_query_FProCode').textbox('setValue','');
	$('#pro_list_query_FProName').textbox('setValue','');
	$('#pro_list_query_FProAppliDepart').textbox('setValue','');
	$('#pro_list_query_FProAppliPeople').textbox('setValue','');
	$('#pro_list_query_planStartYear').numberbox('setValue','');
	$("#"+datagridID).datagrid('load',{});
}

/**
 * 预算模块的清除方法 没有多余标签页时使用
 * @param datagridID 表的id
 * @author 陈睿超
 */
function clearProList(datagridID){
	$('#pro_list_query_FProCode').textbox('setValue','');
	$('#pro_list_query_FProName').textbox('setValue','');
	$('#pro_list_query_FProAppliDepart').textbox('setValue','');
	$('#pro_list_query_FProAppliPeople').textbox('setValue','');
	$('#pro_list_query_planStartYear').numberbox('setValue','');
	$('#pro_list_query_FProOrBasic').combobox('setValue','--请选择--');
	$("#"+datagridID).datagrid('load',{});
}
function zk(){//展开
	$('#zk').hide();
	$('#sq').show();
	//搜索栏框变大
	$('#top-table').css('height', '80px');
	$('#othersearchtd').css('margin-top:', '0px');
	$('#othersearchtd').show();
}
function sq(){//收起
	$('#sq').hide();
	$('#zk').show();
	//搜索栏框变小
	$('#top-table').css('height', '40px');
	$('#othersearchtd').hide();
}
/**
 * 预算模块的查询方法 有多个标签页时使用以下方法
 * @param datagridID 表的id
 * @author 陈睿超
 */
function queryProList2(datagridID){
	$("#"+datagridID).datagrid('load',{
		FProCode:$('#pro_list_query_FProCode2').textbox('getValue').trim(),
		FProName:$('#pro_list_query_FProName2').textbox('getValue').trim(),
		FProAppliDepart:$('#pro_list_query_FProAppliDepart2').textbox('getValue').trim(),
		FProAppliPeople:$('#pro_list_query_FProAppliPeople2').textbox('getValue').trim(),
		planStartYear:$('#pro_list_query_planStartYear2').numberbox('getValue'),
		FProOrBasic:$('#pro_list_query_FProOrBasic2').combobox('getValue').trim()=='--请选择--'?'':$('#pro_list_query_FProOrBasic2').combobox('getValue').trim(),
	});
}
function clearProList2(datagridID){
	$('#pro_list_query_FProCode2').textbox('setValue','');
	$('#pro_list_query_FProName2').textbox('setValue','');
	$('#pro_list_query_FProAppliDepart2').textbox('setValue','');
	$('#pro_list_query_FProAppliPeople2').textbox('setValue','');
	$('#pro_list_query_planStartYear2').numberbox('setValue','');
	$('#pro_list_query_FProOrBasic2').combobox('setValue','--请选择--');
	$("#"+datagridID).datagrid('load',{});
}
function zk2(){//展开
	$('#zk2').hide();
	$('#sq2').show();
	//搜索栏框变大
	$('#top-table').css('height', '80px');
	$('#othersearchtd2').css('margin-top:', '0px');
	$('#othersearchtd2').show();
}
function sq2(){//收起
	$('#sq2').hide();
	$('#zk2').show();
	//搜索栏框变小
	$('#top-table').css('height', '40px');
	$('#othersearchtd2').hide();
}
//预览图片
function yl(e){
    var large='<img width="780px" height="480px" src=' +e+ '></img>';
    $("#divlarge").html(large).animate({
        height:'30%',
        width:'60%'
    },1);
    $("#dlgdiv").dialog("open").dialog("setTitle", "预览");
}

function isBig(val){
	if(val==null||val==''){
		return "——";
	}else {
		return val;
	}
}


//判断数据是否为Null或者undefined或者为空字符串
function CheckIsNullOrEmpty(value) {
     //正则表达式用于判斷字符串是否全部由空格或换行符组成
    var reg = /^\s*$/
    //返回值为true表示不是空字符串
    return (value != null && value != undefined && !reg.test(value))
}
//校验文本是否为空
function isNotEmpty(val) {
	if(val == '' || val == null || val == 'null' || val == undefined || val == 'undefined'){
		return false;
	}
	return true;
}