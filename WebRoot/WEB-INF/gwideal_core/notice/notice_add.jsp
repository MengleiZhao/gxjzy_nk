<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
	<script type="text/javascript" charset="utf-8" src="${base}/resource-modality/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${base}/resource-modality/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="${base}/resource-modality/ueditor/lang/zh-cn/zh-cn.js"></script>
    
<div class="win-div">
<form id="notice_add_form" method="post" data-options="novalidate:true" class="easyui-form" >
	<div class="easyui-layout" style="height: 460px;">
		<div data-options="region:'center',split:true ">
			<table  class="ourtable" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
				<tr class="trbody">
					<td class="td1"><span class="style1">*</span>&nbsp;发布人</td>
					<td class="td2">
						<input class="easyui-textbox" type="text" id="notice_add_releaseUser"  name="releaseUser" value="${bean.releaseUser }" required="required" data-options="readonly:true"  style="width:200px"/>
					</td>
					<td class="td4">
						<input class="easyui-textbox" type="hidden" id="noticeId"  name="noticeId" value="${bean.noticeId }"/>
					</td>
					<td class="td1"><span class="style1">*</span>&nbsp;发布时间</td>
					<td class="td2">
						<input class="easyui-datebox" type="text" id="notice_add_releaseTime"  name="releaseTime" value="${bean.releaseTime }" required="required" data-options="readonly:true" style="width:200px" />
					</td>
				</tr>
				<tr style="height: 10px;"></tr>
				<tr class="trbody">
					<td class="td1"><span class="style1">*</span>&nbsp;公告标题</td>
					<td colspan="4">
						<input class="easyui-textbox" id="notice_add_noticeTitle" name="noticeTitle" value="${bean.noticeTitle}"  style="width:555px;height:30px;" data-options="validType:'length[1,100]',required:true" /></br>
						<span class="kv-item-tip" style="color: red">标题字数限制在100个字符</span>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1"><span class="style1">*</span>&nbsp;副标题</td>
					<td colspan="4">
						<input class="easyui-textbox" id="notice_add_noticeSubtitle" name="noticeSubtitle" value="${bean.noticeSubtitle}"  style="width:555px;height:30px;" data-options="validType:'length[1,100]',required:true" /></br>
						<span class="kv-item-tip" style="color: red">标题字数限制在100个字符</span>
					</td>
				</tr>
				<tr class="trbody">
							<%-- <td class="td1">
								<div class="kv-item ue-clear">
			                	<label style="float: left;width: 104px;"><span style="color: red;">*</span>&nbsp;是否置顶</label>
			                	<div class="kv-item-content">
			                    	<span class="choose">
			                            <span class="checkboxouter">
			                                <input type="radio" value="1" name="stick1"  <c:if test="${bean.stick==1 }">checked="checked"</c:if>/>
			                                <span class="radio" ></span>
			                            </span>
			                            <span class="text">是</span>
			                        </span>
			                    	<span class="choose">
			                            <span class="checkboxouter">
			                                <input type="radio" value="2" name="stick1" <c:if test="${bean.stick==2 }">checked="checked"</c:if>/>
			                                <span class="radio"></span>
			                            </span>
			                            <span class="text">否</span>
			                        </span>
			                        
			                    </div>
			                    <input type="hidden" id="stick" name="stick"/>
			                    <input type="hidden" id="noticeNum" name="noticeNum" value="${bean.noticeNum}"/>
			                </div>
			                </td> --%>
			                
			  		<td class="td1"><span class="style1">*</span>&nbsp;是否置顶</td>
					<td class="td2">
						<input type="radio" value="1" name="stick1" <c:if test="${bean.stick==1 }">checked="checked"</c:if> />是
						<input type="radio" value="2" name="stick1" <c:if test="${bean.stick==2 }">checked="checked"</c:if> />否
					</td>
					<td class="td4">
						<input type="hidden" id="stick" name="stick"/>
						<input type="hidden" id="noticeNum" name="noticeNum" value="${bean.noticeNum}"/>
					</td>
			    </tr>
				<tr class="trbody">
					<td class="td1">
						&nbsp;&nbsp;附件
						<input type="file" multiple="multiple" id="notice_files_add" onchange="upladFile(this,'tzgg','notice')" hidden="hidden">
						<input type="text" id="files" name="files" hidden="hidden">
					</td>
					<td colspan="4" id="tdf">
						<a onclick="$('#notice_files_add').click()" style="font-weight: bold;" href="#">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
						</a>
						<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
					        <div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
					        </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
			    	    </div>
						<c:forEach items="${attac}" var="attac">
							<c:if test="${attac.serviceType=='tzgg' }">
								<div style="margin-top: 10px;">
									<a href='${base}/attachment/download/${attac.id}' style="color: #666666;font-weight: bold;">${attac.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${attac.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
								</div>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr></tr>
			</table>
			
	        <table class="ourtable" cellpadding="0" cellspacing="0" align="center">
				<tr class="trbody" style="height: 75px;">
					<td>
						<div class="subfild-content remarkes-info">
            				<div class="kv-item ue-clear">
                				<label style="color: red">公告内容</label>
		                		<div class="kv-item-content">
									<textarea id="contentString" name="contentString" style="width:700px;height:200px;">${bean.content}</textarea>
								</div>
	                		</div>
	            		</div>
            		</td>
				</tr>
			</table>
			
			<div class="win-left-bottom-div" style="text-align: center;">
				<a href="javascript:void(0)" onclick="saveCheter()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="publishCheter()">
				<img src="${base}/resource-modality/${themenurl}/button/fabu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button//guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">
function deleteAttacment(t){
	deleteAttac(t,'zdsy');
	/* $("#systemcenter_add_uploadbtn").css("display", "block"); */
}

function hint(t,v){
	upladFile(t,'zdsy',null,'zdsy');
}
//发布
function publishCheter() {
	/* var at=$('#attName').text();
	var an=($('#notice_files_add').val()).length;
	if(an==0 && at=="" ){
		alert('请上传附件！');
		return;
	} */
	//附件的路径地址
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);

	var files=$('#files').val();
	if(files==0 && files=="" ){
		alert('请上传附件！');
		return;
	}
	var w="";
	var w = $('input:radio:checked').val();
	$("#noticeNum").val(w);
	var a="";
	var a = $('input:radio:checked').val();
	$("#stick").val(a);
	//提交
	$('#notice_add_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + "/notice/save?fNoticeStatus=2",
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeFirstWindow();
				 $("#noticeTab").datagrid("reload");
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				if(data.info!='该文档名称已经存在，请修改！'){
					closeFirstWindow();
					$('#noticeTab').form('clear');
				}
			}
		}
	});	
}
//保存
function saveCheter() {
	/* var at=$('#attName').text();
	var an=($('#f').val()).length;
	if(an==0 && at=="" ){
		alert('请上传附件！');
		return;
	} */
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);

	//附件的路径地址
	var files=$('#files').val();
	if(files==0 && files=="" ){
		alert('请上传附件！');
		return;
	}
	var w="";
	var w = $('input:radio:checked').val();
	$("#noticeNum").val(w);
	var a="";
	var a = $('input:radio:checked').val();
	$("#stick").val(a);
	//提交
	$('#notice_add_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + "/notice/save?fNoticeStatus=1",
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeFirstWindow();
				 $("#noticeTab").datagrid("reload");
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				if(data.info!='该文档名称已经存在，请修改！'){
					closeFirstWindow();
					$('#noticeTab').form('clear');
				}
			}
		}
	});	
}
</script>
<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('contentString');

    function isFocus(e){
        alert(UE.getEditor('contentString').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('contentString').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('contentString').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('contentString');
    }
    function getAllHtml() {
        alert(UE.getEditor('contentString').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('contentString').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('contentString').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('contentString').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('contentString').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('contentString').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('contentString').selection.getRange();
        range.select();
        var txt = UE.getEditor('contentString').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('contentString').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('contentString').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('contentString').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('contentString').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('contentString').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('contentString').execCommand( "clearlocaldata" );
        alert("已清空草稿箱")
    }
</script>
</body>
