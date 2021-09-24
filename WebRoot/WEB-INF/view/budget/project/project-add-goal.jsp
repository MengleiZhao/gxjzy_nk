<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
.pro_goal_th {
	/* border-left:1px solid black;
	border-top:1px solid black;
	border-bottom:1px solid black;
	margin: 0;
	padding: 0 */
	
	background: #c1e3f2;
	font-weight: bold;
	color: #333333;
}
.pro_goal_th2 {
	/* border-left:1px solid black;
	border-top:1px solid black;
	border-bottom:1px solid black;
	margin: 0;
	padding: 0 */
	
	background: #c1e3f2;
	font-weight: bold;
	color: #333333;
}
.ourtable{
	width:650px
}
</style>


<div id="acco_pro_add_jx" class="easyui-accordion" style="width:922px;margin-left: 20px">
	<div title="年度绩效信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<input type="hidden" value="${bean.goal.pid}" name="goal.pid">
		<table cellpadding="0" cellspacing="0" class="ourtable" style="width: 645px">
			<tr class="trbody">
				<td>年度资金总额（元）</td>
				<td>其中：</td>
				<td>财政拨款（元）</td>
				<td>其他资金（元）</td>
			</tr>
			<tr class="trbody">
				<td>
					<input id="pro_goal_nkzjze" class="easyui-numberbox" precision="2" name="goal.longTotal" style="height:30px;width: 200px" value="${bean.goal.longTotal}" readonly="readonly"/>
				</td>
				<td colspan="2">
					<input id="pro_goal_czbk" class="easyui-numberbox" precision="2" name="goal.longAmount1" style="height:30px;width: 200px" value="${bean.goal.longAmount1}"  readonly="readonly"/>
				</td>
				<td>
					<input id="pro_goal_qtzj" class="easyui-numberbox" precision="2" name="goal.longAmount2" style="height:30px;width: 200px" value="${bean.goal.longAmount2}"  readonly="readonly"/>
				</td>
			</tr>
			<tr class="trbody">
				<td colspan="4" class="td1" valign="top"><p style="margin-top: 8px">年度目标</p></td>
			</tr>
			<tr class="trbody">
				<td colspan="4">
					<%-- <input class="easyui-textbox" style="width:645px;height:70px"
					data-options="multiline:true,required:false,validType:'length[0,100]'"
					name="goal.longGoal" value="${bean.goal.longGoal}"/> --%>
					
					<textarea class="textbox-text" name="goal.longGoal"
					 oninput="textareaNum(this,'textareaNum3')" autocomplete="off" 
					  style="width:645px;height:70px">${bean.goal.longGoal}</textarea>
				</td>
			</tr>
			<c:if test="${operation=='add' || operation=='edit'}">
			<tr class="trbody">
				<td colspan="5" align="right">
					可输入剩余数：<span id="textareaNum3" class="100">
						<c:if test="${empty bean.goal.longGoal}">100</c:if>
						<c:if test="${!empty bean.goal.longGoal}">${100-bean.goal.longGoal.length()}</c:if>
					</span>
				</td>
			</tr>
			</c:if>
		</table>
		
	</div>
	
	<div title="中期绩效信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
		<table cellpadding="0" cellspacing="0" class="ourtable">
			<tr class="trbody">
				<td>中期资金总额（元）</td>
				<td>其中：</td>
				<td>财政拨款（元）</td>
				<td>其他资金（元）</td>
			</tr>
			<tr class="trbody">
				<td>
					<input class="easyui-numberbox" precision="2" name="goal.midTotal" style="height:30px;width: 200px" value="${bean.goal.midTotal}"/>
				</td>
				<td  colspan="2">
					<input class="easyui-numberbox" precision="2" name="goal.midAmount1" style="height:30px;width: 200px" value="${bean.goal.midAmount1}"/>
				</td>
				<td>
					<input class="easyui-numberbox" precision="2"name="goal.midAmount2" style="height:30px;width: 200px" value="${bean.goal.midAmount2}"/>
				</td>
			</tr>
		
			<tr class="trbody">
				<td colspan="4" class="td1" valign="top"><p style="margin-top: 8px">中期目标</p></td>
			</tr>
			<tr class="trbody">
				<td colspan="4">
					<input class="easyui-textbox" style="width:645px;height:70px" 
					data-options="multiline:true,required:false,
					validType:'length[0,100]'"
					name="goal.midGoal" value="${bean.goal.midGoal}"/>
				</td>
			</tr>
			<c:if test="${operation=='add' || operation=='edit'}">
			<tr class="trbody">
				<td colspan="5" align="right">
					可输入剩余数：<span id="textareaNum4" class="100">
						<c:if test="${empty bean.goal.midGoal}">100</c:if>
						<c:if test="${!empty bean.goal.midGoal}">${100-bean.goal.midGoal.length()}</c:if>
					</span>
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	
	<div title="绩效指标" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px; ">
		<table id="index-jx-dg" class="easyui-datagrid"  style="width:775px;height:auto"
			data-options="striped:true,nowrap:false,rownumbers:true,scrollbarSize:0,singleSelect:true,method:'post',
			toolbar:'#index-jx-tb',
			<c:if test="${!empty bean.FProId}">url:'${base}/project/jxIndex?id=${bean.FProId}',</c:if>
			<c:if test="${empty bean.FProId}">url:'',</c:if>
			<c:if test="${operation=='add' || operation=='edit'}">onClickRow: onClickRow,</c:if>
			">
		</table>
		<c:if test="${operation=='add' || operation=='edit'}">
			<div id="index-jx-tb" style="height:30px">
			<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		</div>
		</c:if>
		<input type="hidden" id="jxmingxiJson" name="jxmingxi"/>
	</div>
</div>

<script type="text/javascript">

	function deleteGoalRow1(){
		var rows = $('#pro_goal_table1').find('tr');
		rows[rows.length-1].remove();
	}
	
	function deleteGoalRow2(){
		var rows = $('#pro_goal_table2').find('tr');
		rows[rows.length-1].remove();
	}
	
	//明细表格添加删除，保存方法
	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#index-jx-dg').datagrid('validateRow', editIndex)) {
			var ed = $('#index-jx-dg').datagrid('getEditor', {
				index : editIndex,
				field : 'costDetail'
			});
			
			var tr = $('#index-jx-dg').datagrid('getEditors', editIndex);
			var longName2_=tr[0].target.combotree('getText');
			tr[0].target.combotree('setValue',longName2_);
			
			$('#index-jx-dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index) {
		if (editIndex != index) {
			if (endEditing()) {
				$('#index-jx-dg').datagrid('selectRow', index).datagrid('beginEdit',index);
				editIndex = index;
			} else {
				$('#index-jx-dg').datagrid('selectRow', editIndex);
			}
		}
	}
	function append() {
		if (endEditing()) {
			$('#index-jx-dg').datagrid('appendRow', {});
			editIndex = $('#index-jx-dg').datagrid('getRows').length - 1;
			$('#index-jx-dg').datagrid('selectRow', editIndex).datagrid('beginEdit',
					editIndex);
		}
	}
	function removeit() {
		if (editIndex == undefined) {
			return;
		}
		$('#index-jx-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		editIndex = undefined;
	}
	function accept() {
		if (endEditing()) {
			$('#index-jx-dg').datagrid('acceptChanges');
		}
	}
	
	$('#index-jx-dg').datagrid({
		columns:[[
			        {field:'longName2_',title:'指标选择',width:150,editor:{
      					editable:true,
    					type:'combotree',
    					options:{
    						valueField:'id',//编码
    						textField:'text',//名称
    						method:'post',
    						onBeforeLoad:function(node,param){//传递到后台查询列表树
    							if(node==null){//页面第一次加载
        				            param.id=null; 
								}else{//点击二级节点  展示三级节点
									param.id=node.id;
								}
    				        },
    				        /* onLoadSuccess:function(node,data){ 
			             		if(node==null){
			             			$(this).tree('setValue','0');
			             		}
			        		}, */
    						url:"${base}/PerformanceIndicator/tree",
    						onBeforeSelect:function(node){//设置只能选择底层编码
    							if (!$(this).tree('isLeaf', node.target)) {
    								alert("请选择底层目录！");
    				                return false;
    				            }
    		                },
    						onSelect:function(item){
    							if("-请选择-"==item.text){
    								return item.text;
    							}
    							var index=$('#index-jx-dg').datagrid('getRowIndex',$('#index-jx-dg').datagrid('getSelected'));
								var tr = $('#index-jx-dg').datagrid('getEditors', index);
								tr[1].target.textbox('setValue', item.col2);//一级名称
								tr[1].target.textbox('textbox').attr('readonly',true);
								tr[2].target.textbox('setValue', item.col1);//一级代码
								tr[2].target.textbox('textbox').attr('readonly',true);
								tr[3].target.textbox('setValue', item.text);//二级名称
								tr[3].target.textbox('textbox').attr('readonly',true);
								tr[4].target.textbox('setValue', item.id);//二级代码
								tr[4].target.textbox('textbox').attr('readonly',true);
								return item.code;
    						}
    					}
    				}},
			        {field:'longName1',title:'一级指标',width:110,editor:{type:'textbox',options:{readonly:true}}},
			        {field:'longCode1',title:'code1',width:50,editor:'textbox',hidden:'true'},
			        {field:'longName2',title:'二级指标',width:110, editor:{type:'textbox',options:{readonly:true}}},
			        {field:'longCode2',title:'code2',width:50,editor:'textbox',hidden:'true'},
			        {field:'longName3',title:'三级指标',width:100,editor:'textbox'},
			        {field:'midAmount3',title:'中期指标值',width:150,editor:'textbox'},
			        {field:'longAmount3',title:'长期指标值',width:150,editor:'textbox'},
			    ]]
	
	});
	</script>
