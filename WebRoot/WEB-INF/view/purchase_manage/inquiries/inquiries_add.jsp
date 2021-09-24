<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="qingdan_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
									<!--第1个div  -->
					<div title="供应商信息" id="gysxxdiv" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>供应商名称</td>
								<td colspan="4">
									<c:if test="${empty fwbean.fwId}">
										<a href="javascript:void(0)" onclick="checkSel()">
											<input class="easyui-textbox" id="F_fwName"  name="fwName"  readonly="readonly"  style="width:555px;" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkSel()}}]" value="${fwbean.fwName}"/>		
										</a>
									</c:if>
									<c:if test="${!empty fwbean.fwId}">
										<input class="easyui-textbox" id="F_fwName"  name="fwName"  readonly="readonly"  style="width:555px;" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkSel()}}]" value="${fwbean.fwName}"/>		
									</c:if>
									<%-- <a href="javascript:void(0)" onclick="checkSel()">
										<input class="easyui-textbox" id="F_fwName"  name="fwName"  readonly="readonly"  style="width:555px;height:30px;" data-options="prompt: '请选择' ,icons: [{iconCls:'icon-sousuo',handler: function(){checkSel()}}]" value="${fwbean.fwName}"/>		
									</a> --%>
									<!--隐藏域  -->
									<input type="hidden" name="fwId" id="F_fwId" value="${fwbean.fwId}"/>
									<input type="hidden" name="fpId" id="F_fpId" value="${fpid}"/>
									<input type="hidden" name="fmainid" id="F_fmianid" value="${mainid}"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>办公地址</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fwAddr"  name="fwAddr" readonly="readonly" required="required" data-options="validType:'length[1,200]'" style="width:555px;" value="${fwbean.fwAddr}"/>
								</td>
							</tr>
							<tr>
								<td class="td1"><span class="style1">*</span>联系人</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fwuserName"  name="fwuserName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${fwbean.fwuserName}"/>
								</td>
								<td class="td4"></td>
								<td class="td1"><span class="style1">*</span>联系人电话</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fwTel"  name="fwTel" readonly="readonly"  style="width: 200px" value="${fwbean.fwTel}"/>
								</td>
							</tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">备注</td>
								<td colspan="4">
									<textarea name="fwRemark"  id="F_fwRemark"  class="textbox-text"  oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:555px;height:70px;resize:none">${fwbean.fwRemark }</textarea>
									<%-- <input class="easyui-textbox" type="text" id="F_fwRemark"  name="fwRemark" readonly="readonly" data-options="validType:'length[0,200]',multiline:true"   style="width:555px;height:70px;" value="${fwbean.fwRemark}"/>
								 --%>
								</td>
							</tr>
							<c:if test="${operType=='add'||operType=='edit' }">
								<tr>
									<td align="right" colspan="6" style="padding-right: 00px;">
									可输入剩余数：<span id="textareaNum1" class="200">
										<c:if test="${empty fwbean.fwRemark}">200</c:if>
										<c:if test="${!empty fwbean.fwRemark}">${200-fwbean.fwRemark.length()}</c:if>
									</span>
									</td>
								</tr>
							</c:if>
						</table>
					</div>
									<!-- 第2个div -->
					<div title="供货清单" id="ghqddiv" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
 							<jsp:include page="qingdan_mingxi.jsp" />												
					</div>			
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveXunbiJia()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=采购管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
	//弹出供应商信息
	function checkSel() {   			
	    var win = parent.creatFirstWin('供应商信息', 840, 450, 'icon-search', '/cginquiries/selinfo?fpid='+$('#F_fpId').val());
		win.window('open');  			
	}

		//保存
		function saveXunbiJia() {	
			// 在后台反序列话成采购明细Json的对象集合
			accept();
			var rows = $('#dg').datagrid('getRows');
			var mingxi = "";
			for (var i = 0; i < rows.length; i++) {
				mingxi = mingxi + JSON.stringify(rows[i]) + ",";
			}
			$('#mingxiJson').val(mingxi);
			
			//提交
			$('#qingdan_form').form('submit', {
				onSubmit : function() {
					//获得校验结果
					flag = $(this).form('enableValidation').form('validate');
					if (flag) {
						//如果校验通过，则进行下一步
						$.messager.progress();
					}else{
						openAccordion();
					}
					return flag;
				},
				url : base + "/cginquiries/save?fpid="+$('#F_fpId').val()+"&fwid="+$("#F_fwId").val()+"&fmainid="+$("#F_fmianid").val(),
				success : function(data) {
					if (flag) {
						$.messager.progress('close');
					}
					data = eval("(" + data + ")");
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$("#qingdan_form").form("clear");
						$("#winner_tab").datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});	
			
		}

	
			
		 //寻找相关制度
		function findSystemFile(id) {
			$.ajax({ 
				url: base+"/cheter/systemFind?id="+id, 
				success: function(data){
					data=data.replace('\"','');
					data=data.replace('\"','');
					window.open(data);
		    }});
		} 
		



		//明细表格添加删除，保存方法
		var editIndex = undefined;
		function endEditing() {
			if (editIndex == undefined) {
				return true ;
			}
			if ($('#dg').datagrid('validateRow', editIndex)) {
				var ed = $('#dg').datagrid('getEditor', {
					index : editIndex,
					field : 'costDetail'
				});
				$('#dg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickRow(index) {
			if (editIndex != index) {
				if (endEditing()) {
					$('#dg').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					editIndex = index;
				} else {
					$('#dg').datagrid('selectRow', editIndex);
				}
			}
		}
		function append() {
			if (endEditing()) {
				$('#dg').datagrid('appendRow', {
					status : 'P'
				});
				editIndex = $('#dg').datagrid('getRows').length - 1;
				$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit',
						editIndex);
			}

			//页面随滚动条置底
			var div = document.getElementById('westDiv');
			div.scrollTop = div.scrollHeight;
		}
		function removeit() {
			if (editIndex == undefined) {
				return
			}
			$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
					editIndex);
			editIndex = undefined;
		}
		function accept() {
			if (endEditing()) {
				$('#dg').datagrid('acceptChanges');
			}
		}
		//计算供货总额
		function setFfinalPrice(newValue,oldValue) {
			var totalFfinalPrice = 0;
			var ffinalPrice = 0;
			var index=$('#dg').datagrid('getRowIndex',$('#dg').datagrid('getSelected'));
			var rows = $('#dg').datagrid('getRows');
			for(var i=0;i<rows.length;i++){
				if(i==index){
					ffinalPrice=setEditing(rows,i);
				}else{
					totalFfinalPrice+=addNum(rows,i);
				}   
			}
			totalFfinalPrice=totalFfinalPrice+ffinalPrice;
			$('#ffinalPrice').textbox('setValue',totalFfinalPrice.toFixed(2));
		}
		//未编辑或者已经编辑完毕的行，计算优惠后总价
		function addNum(rows,index){
			var ffinalPrice=0;
			var fnum=rows[index]['fnum'];
			var ffactoryPrice=rows[index]['ffactoryPrice'];
			var fdiscountPrice=rows[index]['fdiscountPrice'];
			if(fnum!="" && fnum!=null && ffactoryPrice!="" && ffactoryPrice!=null && fdiscountPrice!="" && fdiscountPrice!=null){
				ffinalPrice= parseFloat(fnum)*(parseFloat(ffactoryPrice)*(1-(parseFloat(fdiscountPrice)*0.01)));
			}
			return ffinalPrice;
		}
		//对于正在编辑的行，计算优惠后总价
	    function setEditing(rows,index){
	    	var fnum=rows[index]['fnum'];
	        var editors = $('#dg').datagrid('getEditors', index);  
	        var ffactoryPrice = editors[2];   
	        var fdiscountPrice = editors[3];
	        var ffinalPrice = fnum*(ffactoryPrice.target.val())*(1-(fdiscountPrice.target.val()*0.01));		
	        var costEditor = editors[4];    
	        costEditor.target.numberbox("setValue",ffinalPrice);    
	        return ffinalPrice;
	    }
	    $('#dg').datagrid({onLoadSuccess : function(data){
	    	setFfinalPrice("","");
	    }});
	    /**是否进口*/
    	var pipingLevel = [{id:'是',projectName:'是'},{id:'否',projectName:'否'}];//json格式
		//填写报价单信息    设置列固定  左右滚动
		$('#dg').datagrid({
	         frozenColumns: [[
                         	  { field: 'finqId', title: '主ID', width: 100,hidden:true },
                         	  { field: 'pmainId', title: '外键ID', width: 100 ,hidden:true},
                         	  { field: 'fplId', title: '采购清单id', width: 100 ,hidden:true},
                         	  { field:'fpurName',title:'商品名称',width:100}
                         	 
       					 ]],
       					columns:[[
       					        {field:'fpurBrand',title:'商品品牌',width:100},
							    {field:'fspecifModel',title:'规格型号',width:100},
							    {field:'fnum',title:'采购数量',width:90, editor:{}},
								{field:'fproVendor', title: '生厂商名称', width: 130, editor:{type:'textbox'}},
       					        {field:'fproArea',title:'商品产地',width:130,  editor:{type:'textbox'}},
       					        {field:'ffactoryPrice',title:'单价',width:100, editor:{type:'numberbox',options:{precision:2,onChange:setFfinalPrice}}},
       					        {field:'fdiscountPrice',title:'优惠幅度%',width:90, editor:{type:'numberbox',options:{precision:2,onChange:setFfinalPrice}}},
       					        {field:'ffinalPrice',title:'优惠后总价', width:100, editor:{ type:'numberbox',options:{precision:2,readonly:true}}},
       					        {field:'fisImpe',title:'是否进口',width:100, value:'否', editor:{
												                                    type: 'combobox',
												                                    options: {    
												                                    	 valueField: 'id', 
												                                    	 textField: 'projectName',
												                                    	 data: pipingLevel,
												                                         editable: false,
												                                        /*  onLoadSuccess : function(){
												                             			    this.combobox('setValue','否');
												                             			} */
												                                              }
                                  }}]]

	});
		
	</script>
</body>