<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<style type="text/css">
.tabletop{background-color: #fff;font-family: "微软雅黑"}
</style>
<body>
	
<div class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true" style="width:600px;border-color: #dce5e9" >
		<div>
			<table style="font-size: 12px;">
				<tr>
					<td style="width: 80px;">所属部门：</td> 
					
					<td style="width: 140px">
						<!-- <input id="indexDepartName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"
						data-options="prompt: '搜索' ,icons: [{iconCls:'icon-sousuo',handler: function(){queryIndex()}}]"></input> -->
						<input style="width: 150px;height:25px;" class="easyui-textbox" value="办公室" readonly="readonly">
					</td>
				</tr>
			</table>
		</div>
	
		<div class="easyui-tabs" style="width:95%;" id="tree">
		
			<div title="基本支出指标">
				<table id="basic-choose-tree"  class="easyui-treegrid" style="width:100%;"
		            data-options="
		                url: '${base}/insideAdjust/insideTree',
		                method: 'post',
		                idField: 'id',
		                treeField: 'text',
						onClickRow: showIndex,
		            ">
		        	<thead>
		            	<tr>
		                <th data-options="field:'id',hidden:true"></th>
		                <th data-options="field:'haveChild',hidden:true"></th>
		                <th data-options="field:'text'" width="44%">支出预算事项</th>
		                <th data-options="field:'departName'" width="20%" >所属部门</th>
		                <th data-options="field:'amount'" width="20%" >预算总额</th>
		                <th data-options="field:'residAmount'" width="20%" >预算可用余额</th>
		            	</tr>
		        	</thead>
		    	</table> 
		   	</div>
		   	
		   	<div title="项目支出指标">
		   		<table id="pro-choose-tree"  class="easyui-treegrid" style="width:100%;"
		            data-options="
		                url: '${base}/insideAdjust/projectTree',
		                method: 'post',
		                idField: 'id',
		                treeField: 'text',
						onClickRow: showIndex,
						singleSelect:true,
		            ">
		        	<thead>
		            	<tr>
		                <th data-options="field:'id',hidden:true"></th>
		                <th data-options="field:'haveChild',hidden:true"></th>
		                <th data-options="field:'text'" width="44%">支出预算事项</th>
		                <th data-options="field:'departName'" width="20%" >所属部门</th>
		                <th data-options="field:'amount'" width="20%" >预算总额</th>
		                <th data-options="field:'residAmount'" width="20%" >预算可用余额</th>
		            	</tr>
		        	</thead>
		    	</table> 
		   	
		   	</div>
		</div>
	</div>
	
	<div data-options="region:'center',split:true" style="width: 8xp;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7"></div>



	<div data-options="region:'east',split:true" style="width:190px;border-color: #dce5e9">
		<table class="ourtable2" style="width: 150px;margin-left: 20px;" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 28px;"><span style="color: ff6800">指标使用情况</span></td>
			</tr>
			<tr>
				<td valign="top">
					<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
				</td>
			</tr>
			<tr>
				<td style="height: 31px;" id="bfb">
					<table>
						<tr style="height: 23px"><td><div id="p1" class="easyui-progressbar" data-options="value:0"  style="width:150px;height: 14px;"></div></td></tr>
						<tr><td>指标总额：500000 万元</td></tr>
						<tr><td>剩余金额：500000 万元</td></tr>
						<tr><td>冻结金额：0 万元</td></tr>
						<td>
							<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
						</td>
						<tr><td>预算不够啦？请调整指标预算！&nbsp;<a href="#" style="color: red">指标预算调整</a></td></tr>
					</table>
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
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="confirmKm()">确认选择</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeFirstWindow()">取消</a> 
		</div>
		<div style="width: 8px;height:50px;border: 1px solid #f0f5f7;border-left:0px;border-right:0px; border-top:0px ;background-color: #f0f5f7;float: left;"></div>
		<div style="width: 188px;height:50px;border:1px solid #dce5e9;float: left;border-top: 0px"></div>
	</div>
</div>

<script type="text/javascript">
	function confirmKm(){
		var tab = $('#tree').tabs('getSelected');
		var index = $('#tree').tabs('getTabIndex',tab);
		if(index == 0) {
			var nodes = $('#basic-choose-tree').treegrid('getSelections');
			if(nodes[0].haveChild == 'false') {
				$('#applyIndexName').textbox('setValue',nodes[0].text);
				$('#applyIndexAmount').textbox('setValue',nodes[0].residAmount);
				$('#applyIndexId').val(nodes[0].id);
				$('#applyIndexType').val(0);
				closeFirstWindow();
			} else {
				alert("请选择最底层指标");
			}
			
		} else if (index == 1) {
			var nodes = $('#pro-choose-tree').treegrid('getSelections');
			if(nodes[0].haveChild == 'false') {
				$('#applyIndexName').textbox('setValue',nodes[0].text);
				$('#applyIndexAmount').textbox('setValue',nodes[0].residAmount);
				$('#applyIndexId').val(nodes[0].id);
				$('#applyIndexType').val(1);
				closeFirstWindow();
			} else {
				alert("请选择最底层指标");
			}
		}
	}
	
	//查询
	function queryIndex() {
		var tab = $('#tree').tabs('getSelected');
		var index = $('#tree').tabs('getTabIndex',tab);
		if(index == 0) {
			$('#basic-choose-tree').treegrid('load',{ 
				depart:$('#indexDepartName').textbox('getValue'),
			}); 
		} else if (index == 1) {
			$('#pro-choose-tree').treegrid('load',{ 
				depart:$('#indexDepartName').textbox('getValue'),
			});
		}
	}
	
	function showIndex(val) {
		/* var bfb = accDiv(val.residAmount,parseFloat(val.amount));
		$('#bfb').append('<p>'+bfb+'%    之后用进度条代替</p>'); */
	}
	
	function start() {
		 var value1 = $('#p1').progressbar().progressbar('getValue');  
	        if (value1 < 100){  
	           value1 += Math.floor(Math.random() * 2);  
	            $('#p1').progressbar('setValue', value1);  
	                if(value1<=30){  
	                    $(".progressbar-value .progressbar-text").css("background-color","#DF4134");  
	                }else if (value1<=70){  
	                    $(".progressbar-value .progressbar-text").css("background-color","#EABA0A");  
	                }else if (value1>70){  
	                    $(".progressbar-value .progressbar-text").css("background-color","#53CA22");  
	                }
	              
	            setTimeout(arguments.callee, 30);  
	        }  
	}
	
	$(document).ready(function(){
		start();
	});
</script>
</body>

</html>
	