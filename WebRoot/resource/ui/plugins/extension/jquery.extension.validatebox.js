/**
 * 继承easyui的验证
 */
$.extend($.fn.validatebox.defaults.rules, {
    minLength : { // 判断最小长度
        validator : function(value, param) {
            return value.length >= param[0];
        },
        message : "最少输入 {0} 个字符。"
    },
    length:{validator:function(value,param){
        var len=$.trim(value).length;
            return len>=param[0]&&len<=param[1];
        },
            message:"输入内容长度必须介于{0}和{1}之间."
        },
    phone : {// 验证电话号码
        validator : function(value) {
            return /^1\d{10}$|^(0\d{2,3}-?|\(0\d{2,3}\))?[1-9]\d{4,7}(-\d{1,8})?$/i.test(value);
        },
        message : "请输入有效的电话格式"
    },
    mobile : {// 验证手机号码
        validator : function(value) {
            return /^\d{11}$/i.test(value);
        },
        message : "请输入有效的手机号码格式"
    },
    idcard : {// 验证身份证
        validator : function(value) {
            return /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/i.test(value);
        },
        message : "请输入有效的身份证号码格式"
    },
    intOrFloat : {// 验证整数或小数
        validator : function(value) {
            return /^(([1-9]\d{0,9})|0)(\.\d{1,2})?$/i.test(value);
        },
        message : "请输入数字，并确保格式正确"
    },
    currency : {// 验证货币
        validator : function(value) {
            return /^(([1-9]\d{0,9})|0)(\.\d{1,2})?$/i.test(value);
        },
        message : "货币格式不正确"
    },
    integer : {// 验证整数
        validator : function(value) {
            return /^[\-\+]?\d+$/i.test(value);
        },
        message : "请输入整数"
    },
    chinese : {// 验证中文
        validator : function(value) {
            return /^[u0391-uFFE5]+$/i.test(value);
        },
        message : "请输入中文"
    },
    english : {// 验证英语
        validator : function(value) {
            return /^[A-Za-z]+$/i.test(value);
        },
        message : "请输入英文"
    },
    unnormal : {// 验证是否包含空格和非法字符
        validator : function(value) {
            return /.+/i.test(value);
        },
        message : "输入值不能为空和包含其他非法字符"
    },
    username : {// 验证用户名
        validator : function(value) {
            return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
        },
        message : "用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）"
    },
    faxno : {// 验证传真
        validator : function(value) {
//            return /^[+]{0,1}(d){1,3}[ ]?([-]?((d)|[ ]){1,12})+$/i.test(value);
            return /^(((d{2,3}))|(d{3}-))?((0d{2,3})|0d{2,3}-)?[1-9]d{6,7}(-d{1,4})?$/i.test(value);
        },
        message : "传真号码不正确"
    },
    zip : {// 验证邮政编码
        validator : function(value) {
            return /^[1-9]d{5}$/i.test(value);
        },
        message : "邮政编码格式不正确"
    },
    ip : {// 验证IP地址
        validator : function(value) {
            return /^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/i.test(value);
        },
        message : "IP地址格式不正确"
    },
    name : {// 验证姓名，可以是中文或英文
            validator : function(value) {
                return /^[u0391-uFFE5]+$/i.test(value)|/^w+[ws]+w+$/i.test(value);
            },
            message : "请输入姓名"
    },
    same:{
        validator : function(value, param){
            if($("#"+param[0]).val() != "" && value != ""){
                return $("#"+param[0]).val() == value;
            }else{
                return true;
            }
        },
        message : "两次输入的密码不一致！"   
    }
});