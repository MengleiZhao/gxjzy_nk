<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
  <body>
	<style type="text/css">
/* 	.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
	.textbox-readonly{background-color: #f6f6f6;color: #999999} */
	.textbox-text{color:#666666;height: 25px; line-height: 25px}
	.style1{color: red;height: 40px;}
	.numberbox .textbox-text {text-align: left;}
	.tabDiv{padding:10px;}
	.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
	.ourtable3{font-size: 12px;width: 530px;color: #666666;font-family: "微软雅黑"}
	.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
	.td1{width: 100px;}
	.td2{height: 30px;width: 150px;}
	.td3{height: 30px;width: 100px;background-color: #cce2ed}
	.trtop{height: 10px;}
	.trbody{height: 30px;}
	</style>

	<div class="easyui-layout" fit="true">
		<form id="self_eval_temp_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
						<!--  左侧div基本信息-->
			<div data-options="region:'west',split:true" style="width:600px;border-color: #dce5e9" id="westDiv">
				<table>					
					<tr>
						<td>
							<div class="easyui-accordion" data-options="" id="easyAcc" style="width:555px;margin-left: 20px;">
												<!-- 第一个div -->
								<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>模版编码</td>
											<td colspan="4">
												<input id="F_ftempCode" class="easyui-textbox" type="text" readonly="readonly"   name="ftempCode" data-options="validType:'length[1,30]'" style="height: 30px;width: 450px" value="${bean.ftempCode}"/>
												<!-- 隐藏域 --> 
											    <input type="hidden" name="ftId" id="F_ftId" value="${bean.ftId}"/><!-- 模版表的id -->
											    <input type="hidden" name="fcId" id="F_fcId" value="${fevalbean.fcId}"/><!--自评配置表的id  -->
											    <input type="hidden" id="proids" name="proids"/><!-- 规避项目的id合集 -->
											    <input type="hidden" id="H_frate" name="hfrate"  value="${fevalbean.frate}"/><!-- 滑动条的值 -->
											    <input type="hidden" id="H_ffixedMount" name="hffixedMount"  value="${fevalbean.ffixedMount}"/><!-- 是否固定数量筛选 -->
											    <input type="hidden" id="H_fisAvoid" name="hfisAvoid"  value="${fevalbean.fisAvoid}"/><!-- 是否规避 -->
											    
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>模版名称</td>
											<td class="td2">
												<input id="F_ftempName" name="ftempName" readonly="readonly"    class="easyui-textbox" style="height: 30px;width: 150px" value="${bean.ftempName}" />
											</td>
											
											<td class="td4"></td>
											
											<td class="td1"><span class="style1">*</span>应用年度</td>
											<td class="td2">
												<input id="F_fyear" name="fyear"  readonly="readonly"     class="easyui-textbox" style="height: 30px;width: 150px" value="${bean.fyear}" />
											</td>
										</tr>
										<tr style="height: 70px;">
											<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>模版说明</td>
											<td colspan="4">
												<input class="easyui-textbox" type="text" id="F_ftempDesc"  name="ftempDesc"  readonly="readonly"  data-options="validType:'length[1,50]',multiline:true"   style="width:450px;height:70px;" value="${bean.ftempDesc}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>是否启用</td>
											<td class="td2">
												<span>
                									<input type="radio"  name="fisOn" disabled="disabled" <c:if test="${bean.fisOn=='0'}">checked="checked"</c:if> value="0">否</input>
                									<input type="radio"  name="fisOn" disabled="disabled" <c:if test="${bean.fisOn=='1'}">checked="checked"</c:if> value="1">是</input>
           										</span>
											</td>
											
											<td style="width: 0px"></td>
											
											<td class="td1"><span class="style1">*</span>是否已配置规则</td>
											<td class="td2">
												<span>
               										<input type="radio"  name="fisCo" disabled="disabled" <c:if test="${bean.fisCo=='0'}">checked="checked"</c:if> value="0">否</input>
                									<input type="radio"  name="fisCo" disabled="disabled" <c:if test="${bean.fisCo=='1'}">checked="checked"</c:if> value="1">是</input>
           										</span>
											</td>
										</tr>
									</table>
								</div>
								
																<!--第二个div  -->
								<div title="筛选规则配置" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;height: 300px;">
										<!--规则的table  -->
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>自评开始时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_fevalDateStart" readonly="readonly"  name="fevalDateStart"  data-options="validType:'length[1,20]'" style="height: 30px;width: 150px;" value="${fevalbean.fevalDateStart}"/>
											</td>
											<td class="td1"><span class="style1">*</span>自评结束时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_fevalDateEnd" readonly="readonly"  name="fevalDateEnd"  data-options="validType:'length[1,20]'" style="height: 30px;width: 150px;" value="${fevalbean.fevalDateEnd}"/>
											</td>
										</tr>
										<tr>
											<td class="td1"><span class="style1">*</span>是否规避</td>
											<td class="td2" colspan="3">
												<span>
												   <input type="radio"  name="fisAvoid" disabled="disabled" <c:if test="${fevalbean.fisAvoid=='0'}">checked="checked"</c:if> value="0">否</input>
												   <input type="radio"  name="fisAvoid" disabled="disabled" <c:if test="${fevalbean.fisAvoid=='1'}">checked="checked"</c:if> value="1">是</input>
           										</span>
											</td>
										</tr>	
										<tr>
											<td class="td1"><span class="style1">*</span>规则类型</td>
											<td class="td2" colspan="3">
												<input id="F_fevalType" name="fevalType.code" readonly="readonly"  class="easyui-combobox" style="height: 30px;width: 150px"
													data-options="url:'${base}/lookup/lookupsJson?parentCode=EVAL_TYPE&selected=${fevalbean.fevalType.code}',method:'get',valueField:'code',textField:'text',editable:false"  />
											</td>
										</tr>
										<tr id="amountTr">
											<td class="td1"><span class="style1">*</span>项目金额</td>
											<td class="td2">
												<input id="F_famountMin" name="famountMin"  style="width: 150px;height:30px;" readonly="readonly"  class="easyui-textbox" value="${fevalbean.famountMin}"></input>
											</td>
											<td class="td1" style="text-align: center;">——</td>
											<td class="td2">
												<input id="F_famountMax" name="famountMax"  style="width: 150px;height:30px;" readonly="readonly"  class="easyui-textbox" value="${fevalbean.famountMax}"></input>
											</td>
										</tr>
										<tr id="rateTr">
											<td class="td1"><span class="style1">*</span>比例(%)&nbsp;&nbsp; <span id="tip" ></span></td>
											<td style="height: 70px" colspan="3">
												<div id="F_frate" style="height:250px;width:150px;"></div>
											</td>
										</tr>
										<tr id="randomTr">
											<td class="td1"><span class="style1">*</span>项目个数</td>
											<td class="td2" colspan="3">
												<input id="F_frandomMount" name="frandomMount" readonly="readonly"   style="width: 150px;height:30px;" class="easyui-textbox" value="${fevalbean.frandomMount}"></input>
											</td>
										</tr>
										<tr id="fixedTr">
											<td class="td1"><span class="style1">*</span>固定数量</td>
											<td class="td2" colspan="2">
               										<input type="radio"  name="ffixedMount" disabled="disabled" <c:if test="${fevalbean.ffixedMount=='1'}">checked="checked"</c:if> value="1">全部</input>&nbsp;&nbsp;&nbsp;&nbsp;
                									<input type="radio"  name="ffixedMount" disabled="disabled" <c:if test="${fevalbean.ffixedMount=='2'}">checked="checked"</c:if> value="2">一半</input>&nbsp;&nbsp;&nbsp;&nbsp;
                									<input type="radio"  name="ffixedMount" disabled="disabled" <c:if test="${fevalbean.ffixedMount=='3'}">checked="checked"</c:if> value="3">其他数量</input>
											</td>
											<td id="fixed_mount" class="td2">
												<input id="F_fotherMount" name="fotherMount" readonly="readonly"  style="width: 150px; height:30px;" class="easyui-textbox" value="${fevalbean.fotherMount}"></input>
											</td>
										</tr>
									</table>
									</div>
																									<!--第3个div  -->
								<div  title="项目规避清单" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;height: 300px;">
										<!--规则的table  -->
									<table id="guibi_tab" class="easyui-datagrid" 
													data-options="collapsible:true,url:'${base}/selfevaluationrule/getoldgb?id=${fevalbean.fcId}',
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
								</div>		
																									<!--第4个div  -->
								<div  title="自评清单" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;height: 300px;">
										<!--规则的table  -->
									<table id="show_pro_tab" class="easyui-datagrid" 
											data-options="collapsible:true,url:'${base}/selfevaluationrule/getoldeval?id=${fevalbean.fcId}',
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
					</td>
				</tr>
		</table>
	</div>
	
	<div data-options="region:'center',split:true" style="width: 8xp;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7">
			</div>
					<!--右侧div  相关制度  -->
			<div data-options="region:'east',split:true" style="width:190px;border-color: #dce5e9">
				<table class="ourtable2" style="width: 150px;margin-left: 20px;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="height: 28px;"><span style="color: ff6800">相关制度</span></td>
					</tr>
					<tr>
					<td valign="top">
						<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
					</td>
					</tr>
					<tr>
						<td style="height: 31px;">
							<input class="easyui-textbox" style="height: 30px;width:150px;"
							data-options="prompt: '搜索' ,icons: [{iconCls:'icon-sousuo',handler: function(){}}]">
						</td>
					</tr>
					<c:forEach items="${cheterInfo}" var="li">
						<tr style="height: 30px;">
							<td>
								<a style="color: #666666" id="file${li.systemId}" href="#" onclick="findSystemFile(${li.systemId})">${li.fileName}</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div> 
		
		
			
			<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
					<div style="width:598px;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 0px">
						<a href="javascript:void(0)" onclick="closeFirstWindow()">
							<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</div>
					<div style="width: 8px;height:50px;border: 1px solid #f0f5f7;border-left:0px;border-right:0px; border-top:0px ;background-color: #f0f5f7;float: left;"></div>
					<div style="width: 188px;height:50px;border:1px solid #dce5e9;float: left;border-top: 0px"></div>
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
	//按比例筛选 以及  按固定数按钮筛选的
		formaterDetail();
		function formaterDetail(){
			//隐藏tr
			$('#amountTr').hide();
			$('#rateTr').hide();
			$('#randomTr').hide();
			$('#fixedTr').hide();
			//隐藏td
			$('#fixed_mount').hide();

			var ratevalue=$('#H_frate').val();
			var fixed=$('#H_ffixedMount').val();
			var avoid=$('#H_fisAvoid').val();
			
			if(ratevalue!=null){//根据比例筛选的  设置滑动条的值同时 设置滑动条不可以滑动   
				 $("#F_frate").slider({
						mode : "h",
						min : 0,
						max : 100,
						rule : [ 0, '|', 25, '|', 50, '|', 75, '|', 100 ],
						showTip : true,
						disabled:true
					});
					$('#F_frate').slider('setValue',ratevalue*100);
			} 
			
			if(fixed=="3"){//根据固定数按钮筛选的如果选得是其他数量   展示文本框
				$('#fixed_mount').show();
			 }
			
			if(avoid=="0"){//没有规避项目  不显示规避项目的手风琴
				$("#easyAcc").accordion().accordion('remove','项目规避清单');
			}
			
			 
		}
			
	

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


		//寻找相关制度
		function findSystemFile(id) {
			var win=parent.creatWin('制度中心-查看',650,500,'icon-search',"/systemcentergl/detail?id="+id+"&fromSy=true");
			win.window('open');
			
			/* $.ajax({
				url : base + "/systemcentergl/detail?id="+id+"&fromSy=true",
				success : function(data) {
					data = data.replace('\"', '');
					data = data.replace('\"', '');
					window.open(data);
				}
			}); */
		}
	</script>
</body>
<script type="text/javascript">
//显示详情tab
</script>
</html>

