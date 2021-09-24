<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div >
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="tr_supplier_count_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<td align="right" style="padding-right: 10px">
				<%-- <a href="#" onclick="output()">
					<img src="${base}/resource-modality/${themenurl}/button/troutput1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> --%>
				<input type="hidden" name="" id="F_fwid" value=""/><!--供应商的id-->
				<input type="hidden" name="" id="F_fmonth" value=""/><!--成交记录表的月份信息  -->
			</td>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 250px;">	
			<table id="monthtr_supplier_tab">			
				
			</table>
		</div>
		
		<div class="win-left-bottom-div" style="text-align: center;">
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
	<form id="form1" method="post">	</form>
		

</div>

	<script type="text/javascript">
	

	//分页样式调整
	$(document).ready(function() {
		var pager = $('#monthtr_supplier_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	//时间格式化
	function ChangeDateFormat(val) {
		//alert(val)
		var t, y, m, d, h, i, s;
		if (val == null) {
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
		return y + '-' + (m < 10 ? '0' + m : m) + '-'
				+ (d < 10 ? '0' + d : d);
	}
	
	varFields = [ [
                   {field:'fhId', hidden : true, sortable : false, align:'left',title : "id"},
                   {field:'fwId', hidden : true, sortable : false, align:'left',title : "供应商id"},
                   {field:'ftrMonth', hidden : true, sortable : false, align:'left',title : "成交月份"},
                   {field:'num', hidden : false, sortable : false, align:'center',width:15,title : "序号"},
                   {field:'fsupCode', hidden : false, sortable : false, align:'left',width:37,title : "供应商编码"},
                   {field:'fsupName', hidden : false, sortable : false, align:'left',width:38,title : "供应商名称"},
                   {field:'fproName', hidden : false, sortable : false, align:'left',width:30,title : "成交项目名称"},
                   {field:'ftrTime', hidden : false, sortable : false, align:'left',width:30,title : "成交时间",formatter:ChangeDateFormat},
                   {field:'ftrAmount', hidden : false, sortable : false, align:'left',width:30,title : "成交金额[元]"},
                 ]];
	
		$("#monthtr_supplier_tab").datagrid({
			pagination:false,//不分页
			sortName : '',
			sortOrder : 'asc',
			collapsible:true,
			fit : true,
			scrollbarSize:0,
			selectOnCheck: true,
			checkOnSelect:true,
			remoteSort:true,
			nowrap:false,//允许换行
			fitColumns:true,//宽度自适应
			striped : true,
			rownumbers : false,//是否自带序号
			singleSelect : true,// 选择一行
			columns : varFields
		});
		
		/* function output() {
			var rows = $('#monthtr_supplier_tab').datagrid('getRows');
			
			//var len=rows.length;
			alert(rows[0].fwId);
			alert(rows[0].ftrMonth);
			//获取当前页面第一行的供应商id和月份     每一行的id和month都一样  随便取   并且页面一定是有数据的
			var fwid=rows[0].fwId;
			var month=rows[0].ftrMonth;
			
			var varFiledsValue2 = JSON.stringify(varFields);//datagrid列的配置对象
		 	var colvalue = $("#monthtr_supplier_tab").datagrid('getColumnFields');
			var varcolvalue = JSON.stringify(colvalue);
			$('#form1').form({    
				url : base + '/suppliercount/getOutput',
			    queryParams:{
			    	sort :'fhId',
			    	order:'asc',
					colvalue : varcolvalue,
					fwid:fwid,
					month:month,
					name :'trhis',
					varFields:varFiledsValue2
				},
			    onSubmit: function(){    
			    },    
			    success:function(data){    
			        alert(data)  ;  
			    }
			});
			$('#form1').submit();  
		} */
	</script>
</body>

