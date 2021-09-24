<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>

	<style type="text/css">
body {
	margin: 0;
	padding: 0;
	width: 100%;
}

.tableContent {
	width: 98%;
	overflow: auto;
	height: 85%;
	margin: 10px auto;
}

#anaTable {
	word-wrap: break-word;
	word-break: break-all;
	color: #333333;
	border-collapse: collapse;
	font-size: 12px;
	font-family: '微软雅黑';
	border-spacing: 0;
    border-collapse: separate;
    background-color: #fff;
}

.dataTd1 {
	word-break: keep-all;
	white-space: nowrap;
	text-align: center;
	border-bottom: 1px dashed #ccc;
    border-right: 1px dashed #ccc;
	heigth:90px;
	text-align:right
}
.dataTd2 {
	word-break: keep-all;
	white-space: nowrap;
	text-align: center;
	border-bottom: 1px dashed #ccc;
    border-right: 1px dashed #ccc;
	heigth:90px;
}

#anaTable tr th {
	word-break: keep-all;
	white-space: nowrap;
	text-align: center;
	border-bottom: 1px solid #ffffff;
    border-right: 1px solid #ffffff;
	font-weight: normal;
}

#anaTable tr {
	height: 30px;
	line-height: 30px;
}

#anaTable tr:nth-child(even) {
	background-color: #eaf2ff;
}

.list-top {
	margin-top: 10px;
}

.dataDetailInfos {
	background-color: #E3E9EC;
}

#anaTable tr:nth-child(4){
	background-color: rgb(239, 239, 239);
}
</style>

	<!----------------------------- 报表一 报表界面 ------------------------------>
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr id="data_index_top">
				<td class="top-table-search-pro">&nbsp;&nbsp;预算年度 <select
					class="easyui-combobox" id="select_year" name="year"
					style="width: 120px; height: 25px;"
					data-options="editable:false, panelHeight:'auto'">
						<c:forEach items="${yearList}" var="ye">
							<option value="${ye}"
								<c:if test="${ye == year }">selected="selected"</c:if>>&nbsp;${ye }</option>
						</c:forEach>
				</select> &nbsp;&nbsp;校内项目 <input id="school_project" name="secondLevelCode"
					type="checkbox" value="4003"></input> &nbsp;&nbsp;&nbsp;财政项目 <input
					id="finance_project" name="secondLevelCode" type="checkbox"
					value="4001"></input> &nbsp;&nbsp;&nbsp;横向项目 <input
					id="crosswise_project" name="secondLevelCode" type="checkbox"
					value="4002"></input> &nbsp;&nbsp;&nbsp;基本支出 <input
					id="basic_expend" name="secondLevelCode" type="checkbox"
					value="XD-01"></input> &nbsp;&nbsp;<a href="#"
					onclick="data_analy_query();"> <img
						style="vertical-align: bottom"
						src="${base}/resource-modality/${themenurl}/button/detail1.png"
						onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> <a href="#" onclick="clear_data_analy();"> <img
						style="vertical-align: bottom"
						src="${base}/resource-modality/${themenurl}/button/clear1.png"
						onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				</td>
				<td align="right" style="padding-right: 10px; width: 70px;"><a
					href="#" onclick="exportDataAnalysis();"> <img
						src="${base}/resource-modality/${themenurl}/button/daochu1.png"
						onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a></td>
			</tr>
		</table>
	</div>

	<div class="tableContent">
		<table id="anaTable">
			<tr style="background-color: #E3E9EC;">
				<th>序号</th>
				<th>部门代码</th>
				<th>部门名称</th>
				<th colspan="4">合计</th>
				<th colspan="4">301</th>
				<th colspan="4">302</th>
				<th colspan="4">303</th>
				<th colspan="4" class="firstTr">310</th>

			</tr>
			<tr style="background-color: #E3E9EC;">
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th colspan="4">工资福利支出</th>
				<th colspan="4">商品与服务支出</th>
				<th colspan="4">对个人与家庭的补助</th>
				<th colspan="4" class='nameTd'>资本性支出</th>


			</tr>
			<tr class="dataDetailInfos">
				<th></th>
				<th></th>
				<th></th>
				<th>一上</th>
				<th>一下</th>
				<th>二上</th>
				<th>二下</th>
				<th>一上</th>
				<th>一下</th>
				<th>二上</th>
				<th>二下</th>
				<th>一上</th>
				<th>一下</th>
				<th>二上</th>
				<th>二下</th>
				<th>一上</th>
				<th>一下</th>
				<th>二上</th>
				<th>二下</th>
				<th>一上</th>
				<th>一下</th>
				<th>二上</th>
				<th class="typeTd">二下</th>

			</tr>
		</table>
	</div>
	
	<script src="${base}/resource-modality/js/jquery.table2excel.min.js"></script>
	<script>
	(function(){
		sjfxlist('${year}');
	})();
	
	function sjfxlist(year, secondLevelCode) {
		$.messager.progress();
		$.ajax({
	        type : "POST",
	        url : base+'/bData/sjfxlistAll',
	        async : 'false',
	        data : {
	        	year : year,
	        	secondLevelCode : secondLevelCode
	        },
	        success : function(data) {
	        	data = JSON.parse(data);
	        	var colStr = '';
	        	var rowStr = '';
	        	var nameStr = '';
	        	
	        	data.header.forEach(function(item) {
	        		colStr +="<th colspan='4' class='codeClass'>" + item.code + "</th>";
	        		nameStr += "<th colspan='4' class='nameClass'>" + item.name + "</th>";
	        		rowStr +="<th>一上</th><th>一下</th><th>二上</th><th>二下</th>";
	        	})
	        	$('.codeClass').html('');
	        	$('.nameClass').html('');
	        	$('.firstTr').nextAll().remove();
	        	$('.nameTd').nextAll().remove();
	        	$('.typeTd').nextAll().remove();
	        	$('.firstTr').after(colStr);
	        	$('.nameTd').after(nameStr);
	        	$('.typeTd').after(rowStr);
	        	
	        	var dateTr = '';
	        	
	        	data.list.forEach(function(item) {
	        		var data7 = item[7]==null?0:item[7];
	        		var data8 = item[8]==null?0:item[8];
	        		var data9 = item[9]==null?0:item[9];
	        		var data10 = item[10]==null?0:item[10];
	        		var data11 = item[11]==null?0:item[11];
	        		var data12 = item[12]==null?0:item[12];
	        		var data13 = item[13]==null?0:item[13];
	        		var data14 = item[14]==null?0:item[14];
	        		var data15 = item[15]==null?0:item[15];
	        		var data16 = item[16]==null?0:item[16];
	        		var data17 = item[17]==null?0:item[17];
	        		var data18 = item[18]==null?0:item[18];
	        		var data19 = item[19]==null?0:item[19];
	        		var data20 = item[20]==null?0:item[20];
	        		var data21 = item[21]==null?0:item[21];
	        		var data22 = item[22]==null?0:item[22];
	    			
	    			var amount1 = data7 + data11 + data15 + data19;
	    			var amount2 = data8 + data12 + data16 + data20;
	    			var amount3 = data9 + data13 + data17 + data21;
	    			var amount4 = data10 + data14 + data18 + data22;
	    			dateTr += "<tr class='headClass' >";
	        		for (var i = 0; i < item.length; i++) {
	        			var dateResult = item[i]==null?'':item[i];
	        			if (i != 0 && i != 1 && i != 2) {
	        				dateResult = item[i]==null?'':listToFixed(parseFloat(item[i]));
	        			}
	        			if (i == 3) {
	        				dateResult = listToFixed(amount1);
	        			}
	        			if (i == 4) {
	        				dateResult = listToFixed(amount2);
	        			}
	        			if (i == 5) {
	        				dateResult = listToFixed(amount3);
	        			}
	        			if (i == 6) {
	        				dateResult = listToFixed(amount4);
	        			}
	        			if(i != 0 && i != 1 && i != 2){
	        				
		        			dateTr += "<td class='dataTd1'>"+ dateResult +"</td>"
	        			}else{
	        				dateTr += "<td class='dataTd2'>"+ dateResult +"</td>"
	        			}
	        		}
	        		
	        		dateTr += "</tr>";
	        		
	        	});
	        	$('.dataDetailInfos').after(dateTr);
	        	
	        	//合计
	        	/* var ysAmount = 0;
	        	var yxAmount = 0;
	        	var esAmount = 0;
	        	var exAmount = 0;
	        	var tableId = document.getElementById("anaTable"); 
				for (var i = 4; i < tableId.rows.length; i++) {
					ysAmount += Number(tableId.rows[i].cells[3].innerHTML);
					yxAmount += Number(tableId.rows[i].cells[4].innerHTML);
					esAmount += Number(tableId.rows[i].cells[5].innerHTML);
					exAmount += Number(tableId.rows[i].cells[6].innerHTML);
	      　　　　　　	}
	      　　　　　　	tableId.rows[1].cells[3].innerText = ysAmount;
	      　　　　　　	tableId.rows[1].cells[4].innerText = yxAmount;
	      　　　　　　	tableId.rows[1].cells[5].innerText = esAmount;
	      　　　　　　	tableId.rows[1].cells[6].innerText = exAmount; */
	      		$.messager.progress('close');
	        },
	        error : function(data) {
	        	$.messager.progress('close');
	        }
		});
	}	
		$(".tableContent").scroll(function() { //给table外面的div滚动事件绑定一个函数
			var left = $(".tableContent").scrollLeft(); //获取滚动的距离
			var trs = $(".tableContent table tr"); //获取表格的所有tr
			trs.each(function(index, element) {
				//对每一个tr（每一行）进行处理
				//获得每一行下面的所有的td，然后选中下标为0的，即第一列，设置position为相对定位
				//相对于父div左边的距离为滑动的距离，然后设置个背景颜色，覆盖住后面几列数据滑动到第一列下面的情况
				//如果有必要也可以设置一个z-index属性
				$(this).children().eq(0).css({
					"position" : "relative",
					"top" : "0px",
					"left" : left,
					"background-color" : "#E3E9EC",
					"z-index" : "5000"
				});

				$(this).children().eq(1).css({
					"position" : "relative",
					"top" : "0px",
					"left" : left,
					"background-color" : "#E3E9EC",
					"z-index" : "5000"
				});

				$(this).children().eq(2).css({
					"position" : "relative",
					"top" : "0px",
					"left" : left,
					"background-color" : "#E3E9EC",
					"z-index" : "5000"
				});

			});
		});
		
		//查询
		function data_analy_query() {
			var year=$('#select_year').combobox('getValue');
			var obj = document.getElementsByName("secondLevelCode");
			var secondLevelCode=new Array();
			for(var i in obj){
				if(obj[i].checked){
					secondLevelCode.push(obj[i].value);
				}
			}
			
			sjfxlist(year, secondLevelCode);
		}
		
		//清除查询条件
		function clear_data_analy() {
			addTabs('比较表','${base}/bData/sjfxJsp');
		}
		
		//导出
		function exportDataAnalysis() {     
			$("#anaTable").table2excel({
				exclude : ".noExl", //过滤位置的 css 类名
				filename : "对比表.xls", //文件名称
				name: "Excel Document Name.xlsx",
				exclude_img: false,//是否导出图片 false导出
				exclude_links: true,//是否导出链接 false导出
				exclude_inputs: true//是否导出输入框的值 true导出
			});            
    }
	</script>

</body>

