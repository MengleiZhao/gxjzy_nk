<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="${base}/resource-modality/js/echarts.min.js"></script>

<div class="win-div">
<form id="supplier_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div data-options="region:'west',split:true">
			<div>
				<div class="easyui-accordion" data-options="" id="" style="width:938px;margin-left: 20px">
					<div title="供应商统计信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr>
								<td class="td2" style="text-align: left">
		  							<a href="#" onclick="money_count();">
										<img src="${base}/resource-modality/${themenurl}/supMoney.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
									</a>
									
									<a href="#" onclick="amount_count();">
										<img src="${base}/resource-modality/${themenurl}/supAmount.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
									</a>
									<input type="hidden" name="fwid" id="F_fwid" value="${fwid}"/><!--隐藏域 当前查看的供应商的主键id  -->
								</td>
							</tr>
						</table>
						<div id="countsupplier" style="margin: 0 10px 0 10px;height: 300px;" >	
						</div>
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
	</div>
</form>
</div>

	<script type="text/javascript">
	var fwid=$('#F_fwid').val();
	getMoneyChart(fwid);
	
	
	//按成交额统计
	function money_count(){
		var fwid=$('#F_fwid').val();
		getMoneyChart(fwid);
	}
	//按成交量统计
	function amount_count(){
		var fwid=$('#F_fwid').val();
		getAmountChart(fwid);
	}
	//按成交额统计的图
	function getMoneyChart(fwid){
	    var myChart = echarts.init(document.getElementById('countsupplier'));
		var option = {
				title : {text: '供应商成交额统计表',left:'center' },
	            tooltip:{},
	            legend:{ data:['用户来源']},
	            xAxis:{data:[],name:'月份'},
	            yAxis:{name:'成交额/元'},
	            toolbox: { show: true,orient: 'vertical',left: 'right',top: 'center',
			        feature: {
			            //mark: {show: true},
			            //dataView: {show: true, readOnly: false},
			            magicType: {show: true, type: ['line', 'bar']},
			            //magicType: {show: true, type: [  'stack' ]},
			            restore: {show: true},
			            //saveAsImage: {show: true}
			        }
			    },
	            series:[{name:'成交额',barWidth:50,type:'bar',data:[],
	                itemStyle:{
	                	normal:{
	                		color:'#83bff6'
	                	}
	                }
	            }]
	        };
	        //初始化echarts实例
	        //使用制定的配置项和数据显示图表
	        myChart.setOption(option);
	        //获取后台数据每个月的成交总额统计信息
            $.ajax({
                type : "POST",
		        url:base+"/suppliercount/getCountMoney?fwid="+fwid,
                dataType : "json",
                async:false,
                cache:false,
                success : function(data) {
                	myChart.setOption({
                		 xAxis:{data:data.categories},//月份
                		 series:[{name:'成交额',data:data.data}]//成交额
                	});
                }
            });
            myChart.on('click', function(params){//点击事件
                // 点击柱状图不同位置打开相应的百度搜索页面
                //window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.name));
                var month=params.name;
                var win = parent.creatFirstWin('供应商成交信息 ', 840, 450, 'icon-search',"/suppliercount/trlist");//点击柱状图获取追溯信息
        		win.window('open'); 
				$.ajax({//打开页面加载数据
			        //类型为get，是要从数据库获取数据，
			        type: "POST",
			        //获取数据的地址，此地址为对应的controller,去执行对应的controller,MVC里的controller相当于三层中的U层
					url : '${base}/suppliercount/getTrHisJson',
					// 连同请求发送到服务器的数据，请求参数
			        data:{'month':month,'fwid':fwid},
			       	//返回的数据类型为json类型
			        dataType: "json",
			        //当controller 请求服务器成功时执行,参数data为返回的数据
			        success: function (data) {
			            //在表格中加载数据，monthtr_supplier_tab是datagrid 的ID
			            $('#monthtr_supplier_tab').datagrid("loadData", data);
			        }
			    });
                //myChart.on('click',eConsole);//加报错
            });
	        
        }
	//按成交次数统计的图
	function getAmountChart(fwid){
	    var myChart = echarts.init(document.getElementById('countsupplier'));
		var option = {
				title : {text: '供应商成交次数计表',left:'center' },
	            tooltip:{},
	            legend:{ data:['用户来源']},
	            xAxis:{data:[],name:'月份'},
	            yAxis:{name:'成交次数'},
	            toolbox: { show: true,orient: 'vertical',left: 'right',top: 'center',
			        feature: {
			            //mark: {show: true},
			            //dataView: {show: true, readOnly: false},
			            magicType: {show: true, type: ['line', 'bar']},
			            //magicType: {show: true, type: [  'stack' ]},
			            restore: {show: true},
			            //saveAsImage: {show: true}
			        }
			    },
	            series:[{name:'成交次数',barWidth:50,type:'bar',data:[],
	                itemStyle:{
	                	normal:{
	                		color:'#83bff6'
	                	}
	                }
	            }]
	        };
	        //初始化echarts实例
	        //使用制定的配置项和数据显示图表
	        myChart.setOption(option);
	        //获取后台数据每个月的成交次数统计信息
            $.ajax({
                type : "POST",
		        url:base+"/suppliercount/getCountAmount?fwid="+fwid,
                dataType : "json",
                async:false,
                cache:false,
                success : function(data) {
                	myChart.setOption({
                		 xAxis:{data:data.categories},//
                		 series:[{name:'成交次数',data:data.data}]
                	});
                }
            });
            myChart.on('click', function(params){//点击事件
                // 点击柱状图不同位置打开相应的百度搜索页面
                //window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.name));
                var month=params.name;
                var win = parent.creatFirstWin('供应商成交信息 ', 840, 450, 'icon-search',"/suppliercount/trlist");//点折线图获取追溯信息
        		win.window('open'); 
				$.ajax({//打开页面加载数据
			        //类型为get，是要从数据库获取数据，
			        type: "POST",
			        //获取数据的地址，此地址为对应的controller,去执行对应的controller,MVC里的controller相当于三层中的U层
					url : '${base}/suppliercount/getTrHisJson',
					// 连同请求发送到服务器的数据，请求参数
			        data:{'month':month,'fwid':fwid},
			       	//返回的数据类型为json类型
			        dataType: "json",
			        //当controller 请求服务器成功时执行,参数data为返回的数据
			        success: function (data) {
			            //在表格中加载数据，monthtr_supplier_tab是datagrid 的ID
			            $('#monthtr_supplier_tab').datagrid("loadData", data);
			        }
			    });
                //myChart.on('click',eConsole);//加报错
            });
        }
	        
	</script>
