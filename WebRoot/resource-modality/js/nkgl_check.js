/** 李安达 2019-1-7 **/


//校验不通过，就打开第一个校验失败的手风琴
function openAccordion(){
		alert("红线边框输入内容有误，请检验后重新提交");
		//获取当前有多少个手风琴
		var panels=$(".easyui-accordion").accordion('panels'); 
		//循环每个手风琴
		for(var i=0;i<panels.length;i++){
			var forflag=true;
			//得到每个手风琴的id
			var id=panels[i].get(0).id;
			$("#"+id+" input").each(function() {
				//判断当前手风琴下是否有校验不通过的，因为校验不通过，会给当前input增加class名validatebox-invalid
				if($(this).hasClass("validatebox-invalid")){
					//获取手风琴title
					var title = $("#"+id).prev().get(0).textContent;
					//根据title打开手风琴
					$(".easyui-accordion").accordion('select',title); 
					forflag=false;
					return false;
				}
			});
			$("#"+id+" select").each(function() {
				//判断当前手风琴下是否有校验不通过的，因为校验不通过，会给当前input增加class名validatebox-invalid
				if($(this).hasClass("validatebox-invalid")){
					//获取手风琴title
					var title = $("#"+id).prev().get(0).textContent;
					//根据title打开手风琴
					$(".easyui-accordion").accordion('select',title); 
					forflag=false;
					return false;
				}
			});
			
			$("#"+id+" textarea").each(function() {
				//判断当前手风琴下是否有校验不通过的，因为校验不通过，会给当前input增加class名validatebox-invalid
				if($(this).hasClass("validatebox-invalid")){
					//获取手风琴title
					var title = $("#"+id).prev().get(0).textContent;
					//根据title打开手风琴
					$(".easyui-accordion").accordion('select',title); 
					forflag=false;
					return false;
				}
			});
			
			//只要第一次出现红色框得css样式，就跳出循环
			if(forflag==false){
				return forflag;
			}
		}
}

//校验不通过，就打开第一个校验失败的标签页
function openInvalidTab(tabid){
	//获取所有标签页
	var $wrapper = $('#'+tabid),
		$allTabs = $wrapper.find('.tab-content > div'),
		$tabMenu = $wrapper.find('.tab-menu li');
		
	for(var i=0;i<$allTabs.length;i++){
		var forflag = true;
		//获取标签页标记
		var datab = $allTabs[i].getAttribute('data-tab');
		var inputs = $('div[data-tab="'+datab+'"] input');
		
		$('div[data-tab="'+datab+'"] input').each(function() {
			//打开校验不通过的标签
			if($(this).hasClass("validatebox-invalid")){
				
				$('li[data-tab="'+datab+'"]').click();
				//打开该标签页
				$getWrapper = $(this).closest($wrapper);
				$getWrapper.find($allTabs).css('display','none');
				$getWrapper.find($allTabs).filter('[data-tab='+datab+']').css('display','block');
				//更改标签头
				var lili= $('li[data-tab="'+datab+'"]');
				$getWrapper.find($tabMenu).removeClass('active');
				$('li[data-tab="'+datab+'"]').addClass('active');
				
				forflag=false;
				return false;
			}
		});
		
		if(forflag==false){
			return forflag;
		}
		
	}
	//循环每个标签页
}

//easuyi的textarea在内容改变时触发，在jquery.easyui.min.js 6878行	叶添加
function textareaNum(textarea){
	var textareanum1=1;
	var textareanum2=1;
	var idclass1="_easyui_textbox_input";//easyui的textarea的id前缀
	$("textarea").each(function(){
		if(!$(this).prop("readonly")){//只有可以编辑的才算
			var idclass2 = this.id.substring(0,21);//获取当前textarea的id前21位
			if(idclass2==idclass1) {//判断当前循环到的textarea是否是easyui生成的（easyui生成的话id前缀应该相同）
				if(textarea.id==this.id){//当两个值相等的时候可以确定这个textarea是当前页面中由easyui生成的第几个控件
					textareanum2 = textareanum1;
				}
				textareanum1++;
			}
		}
	});
	//根据控件的名次将数据剩余数写入span
	var span = $('#textareaNum'+textareanum2);//获得显示剩余字数的span的标签（span标签id为texteareNum开头后面跟的数字一定要通过textarea在页面中的先后顺序确定）
	var num1 = span.attr('class');//获得可以输入的字数（由span的class决定可输入数）
	var num2 = textarea.value.length;//获取当前的输入数
	span.text(num1-num2);//设置剩余数
	if(num1-num2<=0){//设置颜色
		span.css('color','red');
	} else {
		span.css('color','#666666');
	}
}

//textarea在内容改变时触发
function textareaNum(textarea,spanid){
	//根据控件的名次将数据剩余数写入span
	var span = $('#'+spanid);//获得显示剩余字数的span的标签（span标签id为texteareNum开头后面跟的数字一定要通过textarea在页面中的先后顺序确定）
	var num1 = span.attr('class');//获得可以输入的字数（由span的class决定可输入数）
	var num2 = textarea.value.length;//获取当前的输入数
	if((num1-num2)<0){
		$('#'+textarea.id).val(textarea.value.substr(0,num1));
		span.text(0);//设置剩余数
		span.css('color','red');
		return false;
	}
	span.text(num1-num2);//设置剩余数
	if(num1-num2<=0){//设置颜色
		span.css('color','red');
	} else {
		span.css('color','#666666');
	}
}

//判断输入是否是有效的长日期格式 - "YYYY-MM-DD HH:MM:SS" || "YYYY/MM/DD HH:MM:SS"
function isdatetime(str)
{
	var result=str.match(/^(\d{4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/);
	if(result==null) {
		return false;
	}
	var d= new Date(result[1], result[3]-1, result[4], result[5], result[6], result[7]);
	return (d.getFullYear()==result[1]&&(d.getMonth()+1)==result[3]&&d.getDate()==result[4]&&d.getHours()==result[5]&&d.getMinutes()==result[6]&&d.getSeconds()==result[7]);
}


//检查是否为 YYYY-MM-DD || YYYY/MM/DD 的日期格式
function isdate(str){
	var result=str.match(/^(\d{4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
	if(result==null) {
		alert("日期格式不正确");
		return false;
	}
	var d=new Date(result[1], result[3]-1, result[4]);
	return (d.getFullYear()==result[1] && d.getMonth()+1==result[3] && d.getDate()==result[4]);
}


//判断输入是否是有效的电子邮件
function isemail(str)
{
	var result=str.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/);
	if(result==null) {
		return false;
	}
	 return true;
}


//去除字符串的首尾的空格
function trim(str){
	return str.replace(/(^\s*)|(\s*$)/g, "");
}


//返回字符串的实际长度, 一个汉字算2个长度
function strlen(str){
	return str.replace(/[^\x00-\xff]/g, "**").length;
}


//匹配中国邮政编码(6位)
function ispostcode(str)
{
	var result=str.match(/[1-9]\d{5}(?!\d)/);
	if(result==null) {
		return false;
	}
	 return true;
}
//用一个正则来验证(支持手机号码、含区号固定电话、不含区号固定电话)
function istell(tel) {
       var pattern = /(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/;
       if (!pattern.test(tel)) {
           return false;
       }
       return true;
   }
//验证手机号只验证，是否正确，调用那边自定义提示
function ismobile(tel) {
	tel=trim(tel);
	if(tel==""){
		 return false;
	}
    var mobile = /^1[0-9]{10}$/;
    if (!mobile.test(tel)) {
        return false;
    }
    return true;
}
//固定电话(包含区号)
function isTelPhone(tel) {
	tel=trim(tel);
	if(tel==""){
		return false;
	}
    var  phone = /^0\d{2,3}-?\d{7,8}$/;
    if (!phone.test(tel)) {
       return false;
     }
    return true;
}
//匹配身份证(15位或18位)
function checkidcard(str){
	str=trim(str);
	if(str==""){
		return false;
	}
	var regIdNo = /(^\d{15}$)|(^[1-9][0-9]{5}([1][9][0-9]{2}|[2][0][0|1][0-9])([0][1-9]|[1][0|1|2])([0][1-9]|[1|2][0-9]|[3][0|1])[0-9]{3}([0-9]|[X])$)/; 
	if(!regIdNo.test(str)){ 
	  return false; 
	}
	 return true;
}

//银行卡号校验
function CheckBankNo(t_bankno) {
     var bankno = $.trim(t_bankno.val());
     if(bankno == "") {
       alert("请填写银行卡号");
       return false;
   }
   if(bankno.length < 16 || bankno.length > 19) {
	   alert("银行卡号长度必须在16到19之间");
     return false;
   }
   var num = /^\d*$/; //全数字
   if(!num.exec(bankno)) {
	   alert("银行卡号必须全为数字");
     return false;
   }
   //开头6位
   var strBin = "10,18,30,35,37,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,58,60,62,65,68,69,84,87,88,94,95,98,99";
   if(strBin.indexOf(bankno.substring(0, 2)) == -1) {
	   alert("银行卡号开头6位不符合规范");
     return false;
   }
     return true;
   }

//自定义校验内容，在下方自助添加需要的正则即可     例子：data-options="validType:'CHS'" message是提示信息           ——crc添加
$(function(){ 
$.extend($.fn.validatebox.defaults.rules, {
    CHS: {
      validator: function (value, param) {
        return /^[\u0391-\uFFE5]+$/.test(value);
      },
      message: '请输入汉字'
    },
    english : {// 验证英语
    	validator : function(value) {
          return /^[A-Za-z]+$/i.test(value);
      },
      message : '请输入英文'
    },
    BankCardID : {// 验证银行卡号
    	validator : function(value) {
    		return  /^(\d{16}|\d{19})$/.test(value);
    	},
    	message : '银行卡号不正确'
    },
    ip : {// 验证IP地址
    	validator : function(value) {
            return /\d+\.\d+\.\d+\.\d+/.test(value);
        },
        message : 'IP地址格式不正确'
    },
    ZIP: {
      validator: function (value, param) {
    	  return /^[0-9]\d{5}$/.test(value);
      },
      message: '邮政编码不存在'
    },
    QQ: {
      validator: function (value, param) {
        return /^[1-9]\d{4,10}$/.test(value);
      },
      message: 'QQ号码不正确'
    },
    mobile: {//验证是否为11位
      validator: function (value, param) {
       // return /^1[3-8]{10}$/.test(value);
        //var mobile = /^1[0-9]{10}$/;
        var mobile = /^1[3,4,5,7,8][0-9]{9}$/;
        return mobile.test(value);
      },
      message: '手机号码不正确'
    },
    tel:{//支持手机号码、含区号固定电话、不含区号固定电话
      validator:function(value,param){
    	return /(^((0\d{2,3}-\d{7,8}$)|(^1[3,4,5,7,8]\d{9})$))/.test(value);
        //return /(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/.test(value);
      },
      message:'请输入11位手机号或者7-8位带区号如：022- 开头的座机号'
    },
    fax:{//传真号码
        validator:function(value,param){
    	 var  fax = /^0\d{2,3}-?\d{7,8}$/;
    	 return fax.test(value);
        },
        message:'传真不正确'
      },
    Email:{//电子邮箱
    	validator:function(value,param){
    		return /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(value);
    	},
    	message:'邮箱格式不正确'
    },
    mobileAndTel: {
      validator: function (value, param) {
        return /(^([0\+]\d{2,3})\d{3,4}\-\d{3,8}$)|(^([0\+]\d{2,3})\d{3,4}\d{3,8}$)|(^([0\+]\d{2,3}){0,1}13\d{9}$)|(^\d{3,4}\d{3,8}$)|(^\d{3,4}\-\d{3,8}$)/.test(value);
      },
      message: '请正确输入电话号码'
    },
    number: {
      validator: function (value, param) {
        return /^[0-9]+.?[0-9]*$/.test(value);
      },
      message: '请输入数字'
    },
    money:{
      validator: function (value, param) {
       	return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(value);
       },
       message:'请输入正确的金额'

    },
    mone:{
      validator: function (value, param) {
       	return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(value);
       },
       message:'请输入整数或小数'

    },
    integer:{
      validator:function(value,param){
        return /^[+]?[1-9]\d*$/.test(value);
      },
      message: '请输入最小为1的整数'
    },
    integ:{
      validator:function(value,param){
        return /^[+]?[0-9]\d*$/.test(value);
      },
      message: '请输入整数'
    },
    range:{
      validator:function(value,param){
        if(/^[1-9]\d*$/.test(value)){
          return value >= param[0] && value <= param[1]
        }else{
          return false;
        }
      },
      message:'输入的数字在{0}到{1}之间'
    },
    minLength:{
      validator:function(value,param){
        return value.length >=param[0]
      },
      message:'至少输入{0}个字'
    },
    maxLength:{
      validator:function(value,param){
        return value.length<=param[0]
      },
      message:'最多{0}个字'
    },
    fpdm:{//发票代码验证
        validator:function(value,param){
    	 var  fpdm = /^[0-9]{10}$|[0-9]{12}/;
    	 return fpdm.test(value);
        },
        message:'请输入十或者十二位有效数字'
     },
    fphm:{//发票号码验证
        validator:function(value,param){
    	 var  fphm = /^[0-9]{8}$/;
    	 return fphm.test(value);
        },
        message:'请输入八位有效数字'
     },
    yzmhlw:{//验证码后六位
        validator:function(value,param){
    	 var  yzmhlw = /^[0-9]{6}$/;
    	 return yzmhlw.test(value);
        },
        message:'请输入六位数字'
     },
    //select即选择框的验证
    selectValid:{//非空校验
      validator:function(value){
        if(value == '--请选择--'){
        	return false;
        }else{
          return true ;
        }
      },
      message:'请选择'
    },
    idCode:{//验证身份证号
      validator:function(value,param){
        //return /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value);
        return /(^\d{15}$)|(^[1-9][0-9]{5}([1][9][0-9]{2}|[2][0][0|1][0-9])([0][1-9]|[1][0|1|2])([0][1-9]|[1|2][0-9]|[3][0|1])[0-9]{3}([0-9]|[X])$)/.test(value);
      },
      message: '请输入正确的身份证号'
    },
    loginName: {
      validator: function (value, param) {
        return /^[\u0391-\uFFE5\w]+$/.test(value);
      },
      message: '登录名称只允许汉字、英文字母、数字及下划线。'
    },
    equalTo: {
      validator: function (value, param) {
        return value == $(param[0]).val();
      },
      message: '两次输入的字符不一至'
    },
    englishOrNum : {// 只能输入英文和数字
          validator : function(value) {
              return /^[a-zA-Z0-9_ ]{1,}$/.test(value);
          },
          message : '请输入英文、数字、下划线或者空格'
      },
     xiaoshu:{ 
        validator : function(value){ 
        return /^(([1-9]+)|([0-9]+\.[0-9]{1,2}))$/.test(value);
        }, 
        message : '最多保留两位小数！'    
    	},
    ddPrice:{
    validator:function(value,param){
      if(/^[1-9]\d*$/.test(value)){
        return value >= param[0] && value <= param[1];
      }else{
        return false;
      }
    },
    message:'请输入1到100之间正整数'
  },
  jretailUpperLimit:{
    validator:function(value,param){
      if(/^[0-9]+([.]{1}[0-9]{1,2})?$/.test(value)){
        return parseFloat(value) > parseFloat(param[0]) && parseFloat(value) <= parseFloat(param[1]);
      }else{
        return false;
      }
    },
    message:'请输入0到100之间的最多俩位小数的数字'
  },
  rateCheck:{
    validator:function(value,param){
      if(/^[0-9]+([.]{1}[0-9]{1,2})?$/.test(value)){
        return parseFloat(value) > parseFloat(param[0]) && parseFloat(value) <= parseFloat(param[1]);
      }else{
        return false;
      }
    },
    message:'请输入0到1000之间的最多俩位小数的数字'
  }
  });
});

//查询区域时间先后的判断
$.extend($.fn.validatebox.defaults.rules, {
	dateEnd: {
		validator: function (value, param) {
		var startDate = $("#"+param[0].id).datebox('getValue');
		if(startDate==""||startDate==null){
			return true;
	  	} else {
	   		var startTmp = new Date(startDate.replace(/-/g, "/"));
	   		var endTmp = new Date(value.replace(/-/g, "/"));
	   		
	   		/* $("#"+param[0].id).next().removeClass('textbox-invalid'); */
	   		
	   		return startTmp <= endTmp;
	  	}
	},
	message: '结束时间要大于开始时间！'
	}
});
$.extend($.fn.validatebox.defaults.rules, {
	dateBegin: {
		validator: function (value, param) {
   		var endDate = $("#"+param[0].id).datebox('getValue');
   		if(endDate==""||endDate==null){
			return true;
	  	} else {
			var startTmp = new Date(value.replace(/-/g, "/"));
	   		var endTmp = new Date(endDate.replace(/-/g, "/"));
	   		
	   		/* $("#"+param[0].id).next().removeClass('textbox-invalid'); */
	   		
	   		return startTmp <= endTmp;
	  	}
	},
	message: '结束时间要大于开始时间！'
	}
});
//金额转换大写：
function convertCurrency(money) {
	var stringValue=money.toString();
   if (stringValue.indexOf('.') >0) {//如果有小数点
	   if(stringValue.split('.')[1].length>6){ //如果小数点位数大于6，说明出现了数字失真问题
		   money = money.toFixed(2);  //保留两位小数
	   }
   }
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
  if (money == '') { return '零元整'; }
  money = parseFloat(money);
  if (money >= maxNum) {
    //超出最大处理数字
    return '超出最大处理数字，请调整数字';
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
}