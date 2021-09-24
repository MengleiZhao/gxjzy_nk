<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
  <body>
	<style type="text/css">
	.textbox-text{color:#666666;height: 25px; line-height: 25px;}
	.style1{color: red;height: 40px;}
	.numberbox .textbox-text {text-align: left;}
	.tabDiv{padding:10px;}
	.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑";}
	.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑";}
	.ourtable3{font-size: 12px;width: 720px;color: #666666;font-family: "微软雅黑";} 
	 .td1{width: 100px;}
	.td2{height: 30px;width: 150px;}
	.trtop{height: 10px;}
	.trbody{height: 30px;} 
	</style>

	<div class="easyui-layout" fit="true">
		<form id="self_eval_temp_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
						<!--  左侧div基本信息-->
			<div data-options="region:'west',split:true" style="width:798px;border-color: #dce5e9" id="westDiv">
				<table>					
					<tr>
						<td>
							<div class="easyui-accordion" data-options="" id="easyAcc" style="width:750px;margin-left: 20px;">
												<!-- 第一个div -->
								<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>模版编码</td>
											<td colspan="4">
												<input id="F_ftempCode" class="easyui-textbox" type="text" readonly="readonly" required="required" name="ftempCode" data-options="validType:'length[1,30]'" style="height: 30px;width: 450px" value="${bean.ftempCode}"/>
												<!-- 隐藏域 --> 
											    <input type="hidden" name="ftId" id="F_ftId" value="${bean.ftId}"/><!-- 模版表的id -->
											    <input type="hidden" name="fcId" id="F_fcId" value="${fevalbean.fcId}"/><!--自评配置表的id  -->
											    <input type="hidden" id="proids" name="proids"/><!-- 规避项目的id合集 -->
											    <input type="hidden" id="finalproids" name="finalproids"/><!-- 最终生成自评项目的id合集 -->
											    <input type="hidden" id="nowturnon" name="nowturnon"/><!-- 是否现在启用-->
											    
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>模版名称</td>
											<td class="td2" colspan="4">
												<input id="F_ftempName" name="ftempName"  required="required"  class="easyui-textbox" style="height: 30px;width: 450px" value="${bean.ftempName}" />
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>应用年度</td>
											<td class="td2" colspan="4">
												<input id="F_fyear" name="fyear"  required="required"  class="easyui-textbox" style="height: 30px;width: 150px" value="${bean.fyear}" />
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>是否启用</td>
											<td class="td2">
           										<c:if test="${empty bean.ftId}">
													<span>
               											<input type="radio"  name="fisOn" checked="checked" value="0">否</input>
                										<input type="radio"  name="fisOn" value="1">是</input>
           											</span>
												</c:if>
												<c:if test="${!empty bean.ftId}">
													<span>
                										<input type="radio"  name="fisOn" <c:if test="${bean.fisOn=='0'}">checked="checked"</c:if> value="0">否</input>
                										<input type="radio"  name="fisOn" <c:if test="${bean.fisOn=='1'}">checked="checked"</c:if> value="1">是</input>
           											</span>
												</c:if>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>是否已配置规则</td>
											<td class="td2">
           										<c:if test="${empty bean.ftId}">
													<span>
               											<input type="radio"  name="fisCo"  checked="checked" value="0">否</input>
                										<input type="radio"  name="fisCo"   value="1">是</input>
           											</span>
												</c:if>
												<c:if test="${!empty bean.ftId}">
													<span>
               											<input type="radio"  name="fisCo" <c:if test="${bean.fisCo=='0'}">checked="checked"</c:if> value="0">否</input>
                										<input type="radio"  name="fisCo" <c:if test="${bean.fisCo=='1'}">checked="checked"</c:if> value="1">是</input>
           											</span>
												</c:if>
											</td>
										</tr>
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>模版说明</td>
											<td class="td2" colspan="4">
												<%-- <input class="easyui-textbox" type="text" id="F_ftempDesc" 
												 name="ftempDesc" data-options="validType:'length[1,50]',multiline:true" 
												   style="width:450px;height:70px;" value="${bean.ftempDesc}"/> --%>
												
												<textarea name="ftempDesc"  id="F_ftempDesc"
												  class="textbox-text" oninput="textareaNum(this,'textareaNum1')"
												  autocomplete="off"  style="width:450px;height:70px;">${bean.ftempDesc }</textarea>
											</td>
										</tr>
										<tr>
											<td align="right" colspan="5" style="padding-right: 0px;">
											可输入剩余数：<span id="textareaNum1" class="200">
												<c:if test="${empty bean.ftempDesc}">200</c:if>
												<c:if test="${!empty bean.ftempDesc}">${200-bean.ftempDesc.length()}</c:if>
											</span>
											</td>
										</tr>
									</table>
								</div>
								
																<!--第二个div  -->
								<div title="筛选规则配置"  data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;height: 400px;">
										<!--规则的table  -->
									<table cellpadding="0" cellspacing="0" class="ourtable3" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>自评开始时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_fevalDateStart"  name="fevalDateStart" required="required" data-options="validType:'length[1,20]'" style="height: 30px;width: 150px;" value="${fevalbean.fevalDateStart}"/>
											</td>
											<td class="td1"><span class="style1">*</span>自评结束时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_fevalDateEnd"  name="fevalDateEnd" required="required" data-options="validType:'length[1,20]'" style="height: 30px;width: 150px;" value="${fevalbean.fevalDateEnd}"/>
											</td>
										</tr>	
										<tr>
											<td class="td1"><span class="style1">*</span>是否规避</td>
											<td class="td2" colspan="3">
												<span>
               										<input type="radio"  name="fisAvoid" onclick="clearIds(this)" checked="checked" value="0">否</input>
                									<input type="radio"  name="fisAvoid" onclick="alertQingdan(this)"  value="1">是</input>
           										</span>
											</td>
										</tr>
										<tr id="guibidiv" style="height:200px">
											<td colspan="4">&nbsp;
												<table id="guibi_tab" class="easyui-datagrid" 
													data-options="collapsible:true,url:'',
													method:'post',fit:true,pagination:false,singleSelect: false,
													selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
													<thead>
													<tr>
														<th data-options="field:'fproId',hidden:true"></th>
														<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
														<th data-options="field:'fproCode',align:'center'" width="30%">项目编号</th>
														<th data-options="field:'fproName',align:'center'" width="30%">项目名称</th>
														<th data-options="field:'fproAppliPeople',align:'center'" width="20%">申报人</th>
														<th data-options="field:'fproBudgetAmount',align:'left'" width="10%">预算(元)</th>
														<th data-options="field:'operation',align:'left',formatter:format_oper" width="5%">操作</th>
													</tr>
													</thead>
												</table>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>规则类型</td>
											<td class="td2" colspan="3">
												<input id="F_fevalType" name="fevalType.code"  class="easyui-combobox" style="width:150px;height:25px; font-size: 12px;"
													data-options="url:'${base}/lookup/lookupsJson?parentCode=EVAL_TYPE',method:'get',valueField:'code',textField:'text',editable:false"/>
											<span class="style1">以下符合条件的项目，将参与本次自评</span>
											</td>
											
											<%-- <td class="td2">
												<a href="#" onclick="showList();">
													<img src="${base}/resource-modality/${themenurl}/button/yulan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
												</a>
											</td> --%>
										</tr>
										<tr id="amountTr">
											<td class="td1"><span class="style1">*</span>项目金额</td>
											<td class="td2" colspan="3">
												<input id="F_famountMin" name="famountMin"  style="width: 150px;height:25px;" class="easyui-textbox" value="${fevalbean.famountMin}"></input>
												<span style="text-align: center;">——</span>
													<input id="F_famountMax" name="famountMax"  style="width: 150px;height:25px;" class="easyui-textbox" value="${fevalbean.famountMax}"></input>
											
											</td>
										</tr>
										<tr id="rateTr">
											<td class="td1"><span class="style1">*</span>比例(%)&nbsp;&nbsp; <span id="tip" ></span></td>
											<td style="height: 75px" colspan="3">
												<div id="F_frate" style="height:250px;width:150px;"></div>
											</td>
										</tr>
										<tr id="randomTr">
											<td class="td1"><span class="style1">*</span>随机筛选项目个数</td>
											<td class="td2" colspan="3">
												<input id="F_frandomMount" name="frandomMount"  style="width: 150px;height:25px;" class="easyui-textbox" value="${fevalbean.frandomMount}"></input>
											</td>
										</tr>
										<tr id="fixedTr">
											<td class="td1"><span class="style1">*</span>固定数量</td>
											<td class="td2" colspan="2">
               										<input type="radio"  name="ffixedMount" onclick="hideFixed(this)" <c:if test="${fevalbean.ffixedMount=='1'}">checked="checked"</c:if> value="1">全部</input>&nbsp;&nbsp;&nbsp;&nbsp;
                									<input type="radio"  name="ffixedMount" onclick="hideFixed(this)" <c:if test="${fevalbean.ffixedMount=='2'}">checked="checked"</c:if> value="2">一半</input>&nbsp;&nbsp;&nbsp;&nbsp;
                									<input type="radio"  name="ffixedMount" onclick="changFixed(this)" <c:if test="${fevalbean.ffixedMount=='3'}">checked="checked"</c:if> value="3">其他数量</input>
											</td>
											<td id="fixed_mount" class="td2">
												<input id="F_fotherMount" name="fotherMount" style="width: 150px; height:25px;" class="easyui-textbox" value="${fevalbean.fotherMount}"></input>
											</td>
										</tr>
										<tr >
											<td class="td2" style="text-align: left" colspan="4">
					  							<a href="#" onclick="showList();">
													<img src="${base}/resource-modality/${themenurl}/button/sceval1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
												</a>
											</td>
										</tr> 
									</table>
									<!-- 预览的表格 -->
									<div id="yulandiv" style="width:720px;height:250px;">
										<table id="show_pro_tab" class="easyui-datagrid" 
											data-options="collapsible:true,url:'',
											method:'post',fit:true,pagination:false,singleSelect: false,
											selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
											<thead>
												<tr>
													<th data-options="field:'fproId',hidden:true"></th>
													<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
													<th data-options="field:'fproCode',align:'center'" width="23%">项目编号</th>
													<th data-options="field:'fproName',align:'center'" width="24%">项目名称</th>
													<th data-options="field:'fproAppliPeople',align:'center'" width="10%">申报人</th>
													<th data-options="field:'fproClass',align:'center',formatter: attformatter" width="22%">项目类别</th>
													<th data-options="field:'fproBudgetAmount',align:'left'" width="9%">预算(元)</th>
													<th data-options="field:'operation',align:'center',formatter:format_oper" width="9%">操作</th>
												</tr>
											</thead>
										</table>
									</div>
									
									</div>	
								</div>
					</td>
				</tr>
		</table>
	</div>
					
		
		
			<div data-options="region:'south'">
				<div class="win-left-bottom-div">
					<a href="javascript:void(0)" onclick="finalSaveEval()">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="closeSecondWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=预算管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				</div>
			</div>
		</form>


	</div>
	<script type="text/javascript">
	
	$("#F_fevalDateStart").datebox({
	    onSelect : function(beginDate){
	        $('#F_fevalDateEnd').datebox().datebox('calendar').calendar({
	            validator: function(date){
	                return beginDate <= date;
	            }
	        });
	    }
	});
		//隐藏预览的table
		$("#yulandiv").hide();
		//规避项目 点否清空所有的id合集
		function clearIds() {
			$('#proids').val('');
		}
		//规避项目  点是弹出页面
		function alertQingdan() {
			var win = creatFirstWin('请选择要规避的项目', 840, 450, 'icon-search',
					'/selfevaluationrule/guibipro');
			win.window('open');
			//页面加载项目数据   已结项的
			/* $.ajax({
		        //类型为get，是要从数据库获取数据，
		        type: "GET",
		        //获取数据的地址，此地址为对应的controller,去执行对应的controller,MVC里的controller相当于三层中的U层
				url : '${base}/selfevaluationrule/getjiexiangjson',
		       	//返回的数据类型为json类型
		        dataType: "json",
		        //当controller 请求服务器成功时执行,参数data为返回的数据
		        success: function (data) {
		            //在表格中加载数据，show_pro_tab是datagrid 的ID
		            $('#guibi_pro_tab').datagrid("loadData", data);
		        }
		    }); */	 
			
		}
		//固定数量筛选   显示其他数量
		function changFixed() {
			$('#fixed_mount').show();
		}
		//选择全部  一半时  隐藏其他数量的列表并且清空已存在的其他数量 
		function hideFixed() {
			$("#F_fotherMount").textbox('setValue','');
			$('#fixed_mount').hide();
		}

		
		//滑动条
		$("#F_frate").slider({
			mode : "h",
			min : 0,
			max : 100,
			rule : [ 0, '|', 25, '|', 50, '|', 75, '|', 100 ],
			showTip : true
		});
		 $("#F_frate").slider({
			onChange : function(newValue) {
				$("#tip").text(newValue).css("color", "red");
			}
		}); 
		//隐藏tr
		$('#amountTr').hide();
		$('#rateTr').hide();
		$('#randomTr').hide();
		$('#fixedTr').hide();
		//隐藏td
		$('#fixed_mount').hide();

		//根据下拉列表展示不同的tr
		$('#F_fevalType').combobox({
			onChange : function(newValue, oldValue) {
				if ($(this).val() == "EVAL_TYPE_1") {
					//隐藏 
					$("#amountTr").show();
					$("#rateTr").hide();
					$("#randomTr").hide();
					$("#fixedTr").hide();
					//清空其他
					$("#F_frate").slider('setValue',0);
					$("#F_frandomMount").textbox('setValue','');
					$('input[type=radio][name="ffixedMount"]:checked').prop("checked", false);
					$("#F_fotherMount").textbox('setValue','');
				} else if ($(this).val() == "EVAL_TYPE_2") {
					//隐藏
					$("#amountTr").hide();
					$("#rateTr").show();
					$("#randomTr").hide();
					$("#fixedTr").hide();
					//清空其他
					$("#F_famountMin").textbox('setValue','');
					$("#F_famountMax").textbox('setValue','');
					$("#F_frandomMount").textbox('setValue','');
					$('input[type=radio][name="ffixedMount"]:checked').prop("checked", false);
					$("#F_fotherMount").textbox('setValue','');
				} else if ($(this).val() == "EVAL_TYPE_3") {
					//隐藏
					$("#amountTr").hide();
					$("#rateTr").hide();
					$("#randomTr").show();
					$("#fixedTr").hide();
					//清空其他
					$("#F_famountMin").textbox('setValue','');
					$("#F_famountMax").textbox('setValue','');
					$("#F_frate").slider('setValue',0);
					$('input[type=radio][name="ffixedMount"]:checked').prop("checked", false);
					$("#F_fotherMount").textbox('setValue','');
				} else if ($(this).val() == "EVAL_TYPE_4") {
					//隐藏
					$("#amountTr").hide();
					$("#rateTr").hide();
					$("#randomTr").hide();
					$("#fixedTr").show();
					//清空其他
					$("#F_famountMin").textbox('setValue','');
					$("#F_famountMax").textbox('setValue','');
					$("#F_frate").slider('setValue',0);
					$("#F_frandomMount").textbox('setValue','');
				}
			}
		});
		
		function showList(){
			//判断有没有筛选规则  没有不允许预览
			var bili=$("#F_frate").slider('getValue');//比例
			var minv=$("#F_famountMin").textbox('getValue');//最小值
			var maxv=$("#F_famountMax").textbox('getValue');//最大值
			var randmv=$("#F_frandomMount").textbox('getValue');		//随机数量
			var othermv=$("#F_fotherMount").textbox('getValue');//其他数量 
			
			//获取固定数筛选单选按钮的值 
			var fixed='';
			var radio = document.getElementsByName("ffixedMount");
			for(var i = 0;i<radio.length;i++){
				if(radio[i].checked==true){
					fixed = radio[i].value;
					break;
				}
			}
			//获取是否规避项目的单选按钮的值
			var avoid='';
			var danxuan = document.getElementsByName("fisAvoid");
			for(var i = 0;i<danxuan.length;i++){
				if(danxuan[i].checked==true){
					avoid = danxuan[i].value;
					break;
				}
			}
			//获取规避项目的id
			var proids=$("#proids").val();
			//alert(bili=="0"&&minv==""&&maxv==""&&randmv==""&&othermv==""&&fixed=="");
			 if(bili=="0"&&minv==""&&maxv==""&&randmv==""&&othermv==""&&fixed==""){
				$.messager.alert('系统提示', '请配置筛选规则后再进行操作！');
				return false;
			}
			 else{
				//var win = creatFirstWin('项目预览', 840, 450, 'icon-search','/selfevaluationrule/showlist');
				//win.window('open');
				//请求后台  获取预览项目的列表
				$.ajax({
			        //类型为get，是要从数据库获取数据，
			        type: "POST",
			        //获取数据的地址，此地址为对应的controller,去执行对应的controller,MVC里的controller相当于三层中的U层
					url : '${base}/selfevaluationrule/getlistjson',
					// 连同请求发送到服务器的数据，请求参数
			        data:{'rate':$("#F_frate").slider('getValue'),'min':$("#F_famountMin").textbox('getValue'),'max':$("#F_famountMax").textbox('getValue'),'randM':$("#F_frandomMount").textbox('getValue'),'fixed':fixed,'isavoid':avoid,'othM':$("#F_fotherMount").textbox('getValue'),'proids':proids},
			       	//返回的数据类型为json类型
			        dataType: "json",
			        //当controller 请求服务器成功时执行,参数data为返回的数据
			        success: function (data) {
			            //在表格中加载数据，show_pro_tab是datagrid 的ID
			            $('#show_pro_tab').datagrid("loadData", data);
			        }
			    });	
				
				$("#yulandiv").show();
			}  
		}
		
		
		//保存
		function finalSaveEval() {
			//获取最终的数据
			var bili=$("#F_frate").slider('getValue');//比例
			var minv=$("#F_famountMin").textbox('getValue');//最小值
			var maxv=$("#F_famountMax").textbox('getValue');//最大值
			var randmv=$("#F_frandomMount").textbox('getValue');//随机数量
			var othermv=$("#F_fotherMount").textbox('getValue');//其他数量 
			//获取固定数筛选单选按钮的值 
			var fixed='';
			var radio = document.getElementsByName("ffixedMount");
			for(var i = 0;i<radio.length;i++){
				if(radio[i].checked==true){
					fixed = radio[i].value;
					break;
				}
			}
			//获取是否规避项目的单选按钮的值
			var avoid='';
			var danxuan = document.getElementsByName("fisAvoid");
			for(var i = 0;i<danxuan.length;i++){
				if(danxuan[i].checked==true){
					avoid = danxuan[i].value;
					break;
				}
			}
			//获取规避项目的id合集
			var proids=$("#proids").val();
			//获取最终自评项目的id
			var datas = $('#show_pro_tab').datagrid('getData');
			var finalproids = '';
	    	for(var i=0;i<datas.rows.length;i++){
	    		finalproids +=datas.rows[i].fproId + ',';
	    	}
			$('#finalproids').val(finalproids);
			//最终生成的自评项目的id合集
			var finalproids=$("#finalproids").val();
			//启用状态
			var qiyong='';
					/* alert(avoid);
					alert($('#F_fevalType').val());
					alert(minv);
					alert(maxv);
					alert(bili);
					alert(randmv);
					alert(fixed);
					alert(othermv);
					alert(proids);
					alert(finalproids);  */
			//保存
			 if (confirm("现在启用该模版吗")) {
					//提交
					$('#self_eval_temp_form').form('submit', {
						onSubmit : function(param) {//携带额外参数
							param.rate = bili;
							param.proid = proids;//此处不要有相同name的值  会出现两次
							param.finalproid = finalproids;//此处不要有相同name的值  会出现两次
							param.qiyong = '1';//设置启用状态和规避项目的显示状态
							
							flag = $(this).form('enableValidation').form('validate');
							if (flag) {
								$.messager.progress();
							}
							return flag;
						},
						url : base + '/selfevaluationrule/save',
						success : function(data) {
							if (flag) {
								$.messager.progress('close');
							}
							data = eval("(" + data + ")");
							if (data.success) {
								$.messager.alert('系统提示', data.info, 'info');
								closeSecondWindow();
								//$("#self_eval_temp_form").form("clear");  
								//$('#registerTab').datagrid('reload');
								$("#self_rule_Tab").datagrid("reload");
							} else {
								$.messager.alert('系统提示', data.info, 'error');
								closeSecondWindow();
								$('#self_eval_temp_form').form('clear');
							}
						}
					});
				}else{
						$('#self_eval_temp_form').form('submit', {
							onSubmit : function(param) {//携带额外参数
								param.rate = bili;
								param.proid = proids;//此处不要有相同name的值  会出现两次
								param.finalproid = finalproids;//此处不要有相同name的值  会出现两次
								param.qiyong = '0';
								
								flag = $(this).form('enableValidation').form('validate');
								if (flag) {
									$.messager.progress();
								}
								return flag;
							},
							url : base + '/selfevaluationrule/save',
							success : function(data) {
								if (flag) {
									$.messager.progress('close');
								}
								data = eval("(" + data + ")");
								if (data.success) {
									$.messager.alert('系统提示', data.info, 'info');
									closeSecondWindow();
									//$("#self_eval_temp_form").form("clear");  
									//$('#registerTab').datagrid('reload');
									$("#self_rule_Tab").datagrid("reload");
								} else {
									$.messager.alert('系统提示', data.info, 'error');
									closeSecondWindow();
									$('#self_eval_temp_form').form('clear');
								}
							}
						});
					 
					 
				} 
		}

		function attformatter(val, row) {
			if (val == 1) {
				return '常规性项目';
			} else if (val == 2) {
				return '一次性跨年项目';
			}else  if(val == 3){
				return '一次性非跨年项目';
			}
			return '';
		}
		function protyeformatter(val, row) {
			if (val == "PRO-TYPE-1") {
				return '纪检监察工作经费';
			} 
			else if (val == "PRO-TYPE-2") {
				return '机关建设与日常保障费用';
			}
			else  if(val == "PRO-TYPE-3"){
				return '宣传文化工作专项经费';
			}
			else  if(val == "PRO-TYPE-4"){
				return '互联网信息管理专项经费';
			}
			else  if(val == "PRO-TYPE-5"){
				return '文明办工作专项经费';
			}
			else  if(val == "PRO-TYPE-6"){
				return '文化发展专项经费';
			}
			else  if(val == "PRO-TYPE-99"){
				return '其他';
			}
			return '';
		}
		//操作栏创建
		function format_oper(val, row) {
				return '<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="see_detail(' + row.fproId + ')" class="easyui-linkbutton">'+
		   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		   		'</a>'+ '</td><td style="width: 25px">'+
				'<a href="#" onclick="see_delete(' + row.fproId + ')" class="easyui-linkbutton">'+
				'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
				'</a>' + '</td><td style="width: 25px">'+
				'</a></td></tr></table>';
		}
		function showA(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
		}
		function showB(obj){
			obj.src=base+'/resource-modality/${themenurl}/select2.png';
		}
		function showE(obj){
			obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
		}
		function showF(obj){
			obj.src=base+'/resource-modality/${themenurl}/delete2.png';
		}
		 //删除  只是页面删除
		function see_delete(fproId) {
			 var datas = $('#show_pro_tab').datagrid('getData');
		    	for(var i=0;i<datas.rows.length;i++){
		    	    if(datas.rows[i].fproId==fproId){//数据中的id和渲染时的id相等
		    	    	//通过传入的id值查询到对应的记录，在获取实际的Index,这样去删除,（直接传入渲染好的索引值会出现错误）
				  		var rowIndex = $('#show_pro_tab').datagrid('getRowIndex',datas.rows[i]);
				  		 $('#show_pro_tab').datagrid('deleteRow', rowIndex);
				  		 return;
		    		} 
		  		 } 
		}
		 
		//查看
		function see_detail(proId){
			var win=creatFirstWin('查看-项目信息',1240,600,'icon-search','/project/detail/'+proId);
			win.window('open');
		}
		function format_oper(value, row, index){
			var btn = "";
			btn = btn + "<table><tr style='width: 105px; height:20px'>";
			var btn1 = "<td style='width:25px'><a href='javascript:void(0)' style='color:blue' onclick='detailPro("+row.fproId+")'>" 
						+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
						+ "</a></td>";
			btn = btn +  btn1  ;
			btn = btn + "</td></tr></table>";
			return btn;
		}
	</script>
</body>
<script type="text/javascript">
//显示详情tab
</script>
</html>

