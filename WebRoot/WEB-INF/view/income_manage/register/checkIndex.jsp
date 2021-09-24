<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<style type="text/css">
.tabletop{background-color: #fff;font-family: "微软雅黑"}
</style>
<body>
	<style type="text/css">
	.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
	.textbox-readonly{background-color: #f6f6f6;color: #999999}
	.textbox-text{color:#666666;height: 25px; line-height: 25px}
	.style1{color: red;height: 40px;}
	.numberbox .textbox-text {text-align: left;}
	.tabDiv{padding:10px;}
	.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
	.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
	.td1{width: 100px;}
	.td2{height: 30px;width: 150px;}
	.trtop{height: 10px;}
	.trbody{height: 30px;}
	
	/*---滚动条默认显示样式--*/
	::-webkit-scrollbar-thumb {
		background-color: #f0f5f7;
		height: 50px;
		outline-offset: -2px;
		outline: 2px solid #fff;
		-webkit-border-radius: 4px;
		border: 2px solid #fff;
	}
	
	/*---鼠标点击滚动条显示样式--*/
	::-webkit-scrollbar-thumb:hover {
		background-color: #f0f5f7;
		height: 50px;
		-webkit-border-radius: 4px;
	}
	
	/*---滚动条大小--*/
	::-webkit-scrollbar {
		width: 8px;
		height: 8px;
	}
	
	/*---滚动框背景样式--*/
	::-webkit-scrollbar-track-piece {
		background-color: #fff;
		-webkit-border-radius: 0;
	}
	
	</style>
	
<div class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true" style="width:600px;height:450px;border-color: #dce5e9" >
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
			
			<div  style="width:95%;" id="tree">
				<table id="basic-choose-tree"  class="easyui-treegrid" style="width:100%;height: auto;"
		            data-options="
		                url: '${base}/srregister/tree',
		                method: 'post',
		                idField: 'id',
		                treeField: 'text',
						onClickRow: showIndex,
						onDblClickRow:confirmKm,
		            ">
		        	<thead>
		            	<tr>
		                <th data-options="field:'haveChild',hidden:true"></th>
		                <th data-options="field:'text'" width="40%">科目名称</th>
		                <th data-options="field:'id'" width="20%" >科目编号</th>
		                <th data-options="field:'col9',formatter:kmjb" width="20%" >科目级别</th>
		                <th data-options="field:'col8'" width="20%" >科目类型</th>
		            	</tr>
		        	</thead>
		    	</table> 
		   	</div>
	</div>
			
	<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
		<div style="width:775px;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 0px">
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton" onclick="confirmKm()">确认选择</a>  -->
			<a href="javascript:void(0)" onclick="closeFirstWindow()"> 
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
		</div>
	</div>
</div>

<script type="text/javascript">
	/* $(document).ready(function(){
		start();
	});  */

	//科目级别
	function kmjb(val, row){
		if(val=='KMJB-01'){
			return '一级科目';
		}else if(val=='KMJB-02'){
			return '二级科目';
		}else if(val=='KMJB-03'){
			return '三级科目';
		}else if(val=='KMJB-04'){
			return '四级科目';
		}
	}
	

 	function confirmKm(){
		var nodes = $('#basic-choose-tree').treegrid('getSelections');
		if(nodes[0].haveChild == 'false') {
			$('#F_indexName').textbox('setValue',nodes[0].text);//科目名称
			$('#arriveIndexId').val(nodes[0].id);//科目ID
			$('#arriveIndexType').val(nodes[0].col8);//科目类型
			closeFirstWindow();
		} else {
			alert("请选择最底层科目");
		}
	}
	

	
	function showIndex(val) {
		/* var bfb = accDiv(val.residAmount,parseFloat(val.amount));
		$('#bfb').append('<p>'+bfb+'%    之后用进度条代替</p>');  */
	}
	
	
/* 	function start() {
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
	} */
	

	
</script>
</body>

</html>
	