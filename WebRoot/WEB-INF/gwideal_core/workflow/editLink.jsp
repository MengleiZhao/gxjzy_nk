
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
<style type="text/css">
.tabletop{margin: 0 10px 10px 10px;background-color: #fff;font-family: "微软雅黑"}
.queryth{text-align: right;}
</style>
</head>
<!-- 配置连线跳转条件页面 -->
<body>
	<div style="width:100%; white-space:nowrap;">
	<div  style="height:30px">
	<input type="hidden" id="ruleJson" name="ruleJson"/>
	<input type="hidden" id="customs" name="customs"/>
	<input type="hidden" id="resultText" name="resultText"/>
	<input type="hidden" id="editLink_FPId" name="FPId"  value="${flowId}" />
	<input type="hidden" id="editLink_fromKey" name="fromKey"  value="${fromKey}" />
	<input type="hidden" id="editLink_toKey" name="toKey"  value="${toKey}" />
	<a href="javascript:void(0)" onclick="editLinkremoveit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="editLinkappend()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>	      
	<table id="editLink_table" class="easyui-datagrid" style="width:100%;height:auto"
	data-options="
	singleSelect: true,
	rownumbers : true,
	url: '${base}/wflow/findByFlowIdAndKey?flowId=${flowId}&fromKey=${fromKey}&toKey=${toKey}',
	method: 'post',
	onClickRow: onClickRow,
	onLoadSuccess:setCombotree  
	">
		<thead>
			<tr>
			<th data-options="field:'fieldNameText' ,align:'center',width:'33%',editor:{type: 'combotree',options: {valueField:'id',textField:'text',data:[
                	{id:'F_AMOUNT',text:'金额'},
                	{id:'F_IF_CFO',text:'主管校长是否财务校长'},
                	{id:'F_IF_DEPUTY',text:'申请人是否副处长'},
                	{id:'F_INDEX_TYPE',text:'预算指标类型'},
                	{id:'F_IF_DEPT_INDEX',text:'是否本部门预算指标'},
                	{id:'F_EXPENDITURE_TYPE',text:'经费类型'},
                	{id:'F_RESEARCH_TYPE',text:'科研经费类型'},
                	{id:'F_PAYMENT_TYPE',text:'收款方式'},
                	{id:'F_LEV_CODE_1',text:'项目一级名称'},
                	{id:'F_PROCUREMENT_STATUS',text:'是否政府采购'},
                	{id:'F_DEPT',text:'党务部门'},
                	{id:'F_CHANGE_TYPE',text:'调整类型'},
                	{id:'F_IS_ACROSS_DEPT',text:'是否跨部门调整'},
                	{id:'T_PRO_USE_TYPE',text:'是否包含基建，维修，设备购置'}
                	<c:if test="${bean.FBusiArea=='HTND'}">,
                		{id:'F_ASSIS_DEPT_NAME',text:'协调部门'},
                		{id:'F_STANDARD',text:'制式合同'},
                		{id:'F_IF_FJJHT',text:'是否非经济合同'}
                	</c:if>
                	],
                	prompt:'--请选择--',panelHeight:'atuo',editable: false,
                	onSelect:getFieldName
                	}}">条件字段</th>
			<th data-options="field:'customText' ,align:'center',width:'33%',editor:{type: 'combotree',options: {valueField:'id',textField:'text',
                	prompt:'--请选择--',panelHeight:'atuo',editable: false,
                	onSelect:getcustom
                	}}">条件</th>
             <th data-options="field:'custom',width:0,editor:'textbox',hidden:true" ></th>
             <th data-options="field:'fieldName',width:0,editor:'textbox',hidden:true" ></th>
			<th data-options="field:'fieldValue',width:'33%',align:'center',editor:{type:'combotree',options:{precision:2,groupSeparator:',',editable: true}}" >值</th>
			</tr>
		</thead>
	</table>
	
</div>
	<div class="win-left-bottom-div">
			<a href="javascript:void(0)" onclick="save()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
	</div>
<script type="text/javascript">
var editLinkEditIndex = undefined;

function getcustom(item){
	 var tr = $('#editLink_table').datagrid('getEditors', editLinkEditIndex);
	 tr[2].target.textbox('setValue', item.id);
	 nowcustom=item.id;
}
function getFieldName(item){
	var tr = $('#editLink_table').datagrid('getEditors', editLinkEditIndex);
	$(tr[3].target).textbox('setValue',item.id); 
	var data = [];
    data.push( {id:'',text:'空'},
    	       {id:'14',text:'设备与安技处'},
               {id:'35',text:'总务处'},
               {id:'20',text:'创业就业指导中心'});
	var data3 = [];
    data3.push( {id:'0',text:'是'},
               {id:'1',text:'否'});
	var data11 = [];
    data11.push( {id:'0',text:'不跨部门'},
               {id:'1',text:'跨部门'});
	var data7 = [];
    data7.push( {id:'0',text:'基本指标'},
               {id:'1',text:'项目指标'});
	var data4 = [];
    data4.push( {id:'是',text:'是'},
               {id:'否',text:'否'});
	var data5 = [];
    data5.push({id:"('现金'.'公务卡')",text:"('现金'.'公务卡')"},
               {id:"('支票'.'电汇'.'银行代发')",text:"('支票'.'电汇'.'银行代发')"}
    );
	var data12 = [];
    data12.push({id:"('JIJIAN'.'WEIXIU'.'SHEBEI')",text:"('基建'.'维修'.'设备购置')"}
    );
	var data13 = [];
    data13.push({id:"XD-01",text:"经常性支出项目"}
    );
	var data14 = [];
    data14.push({id:"KEYAN",text:"科研"},{id:"JIAOGAI",text:"教改"}
    );
	var data9 = [];
    data9.push({id:"(6.7.8.9.12.18.31)",text:"党务部门"}
    );
	var data10 = [];
    data10.push({id:"NBYSZBTJ",text:"内部预算指标调剂"},
    		{id:"BMYSZBTZ",text:"年终追加项目"},
    		{id:"WBYSZBTZ",text:"外部预算指标调整"}
    );
	var data8 = [];
    data8.push({id:"CLKYJFSQ",text:"科研经费"},
	    		{id:"CLJGJFSQ",text:"教改经费"},
	    		{id:"CLZXJFSQ",text:"专项经费"},
	    		{id:"CLGYJFSQ",text:"公用经费"}
    );
    
    var data1=[];
    data1.push({id:'>',text:'大于'},
      	{id:'>=',text:'大于等于'},
      	{id:'<',text:'小于'},
      	{id:'<=',text:'小于等于'},
      	{id:'=',text:'等于'}
      	);
    var data2=[];
    data2.push(
      	{id:'=',text:'等于'}
      	);
    var data6=[];
    data6.push(
      	{id:'in',text:'包含'}
      	);
	if(item.id=="F_AMOUNT"){//金额
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data1);
	}
	if(item.id=="F_ASSIS_DEPT_NAME"){//协调部门
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data);
	}
	if(item.id=="F_STANDARD"){//制式合同
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data3);
	}
	if(item.id=="F_IF_CFO"){//部门主管校长是否财务校长
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data4);
	}
	if(item.id=="F_INDEX_TYPE"){//部门主管校长是否财务校长
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data7);
	}
	if(item.id=="F_EXPENDITURE_TYPE"){//经费类型   
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data8);
	}
	if(item.id=="F_PAYMENT_TYPE"){//收款方式
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data6);
		$(tr[4].target).combotree('loadData', data5);
	}
	if(item.id=="F_IF_FJJHT"){//合同分类
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data3);
	}
	if(item.id=="F_DEPT"){//党务部门
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data6);
		$(tr[4].target).combotree('loadData', data9);
	}
	if(item.id=="F_CHANGE_TYPE"){//调整类型
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data10);
	}
	if(item.id=="F_IS_ACROSS_DEPT"){//是否跨部门调整
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data11);
	}
	if(item.id=="T_PRO_USE_TYPE"){//预算使用类型
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data6);
		$(tr[4].target).combotree('loadData', data12);
	}
	if(item.id=="F_PROCUREMENT_STATUS"){//是否政府采购
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data3);
	}
	if(item.id=="F_LEV_CODE_1"){//项目一级名称
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data13);
	}
	if(item.id=="F_RESEARCH_TYPE"){//科研经费类型
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data14);
	}
	if(item.id=="F_IF_DEPUTY"){//申请人是否副处长
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data3);
	}
	if(item.id=="F_IF_DEPT_INDEX"){//是否本部门预算指标
		$(tr[1].target).combotree('clear');
		$(tr[4].target).combotree('clear');
		$(tr[1].target).combotree('loadData', data2);
		$(tr[4].target).combotree('loadData', data3);
	}
}
function setCombotree() {
	var rows = $(this).datagrid('getRows');
    for(var index=0;index<rows.length ; index++){
    	$('#editLink_table').datagrid('beginEdit', index);
        var tr = $('#editLink_table').datagrid('getEditors', index);
        var fieldtext=tr[3].target.textbox('getValue');
        tr[0].target.combotree('setValue',fieldbol(fieldtext)); 
        var text=tr[2].target.textbox('getValue');
        tr[1].target.combotree('setValue',symbol(text)); 
		$('#editLink_table').datagrid('endEdit', index);
    }
}

function editLinkappend() {//
	 var row= {
			 fieldNameText:'',
			fieldName:'',
			customText:'',
			custom:'',
			fieldValue:null
		}; 
	 if (editLinkEndEditing()) {
			$('#editLink_table').datagrid('appendRow', row);
			editLinkEditIndex = $('#editLink_table').datagrid('getRows').length - 1;
			$('#editLink_table').datagrid('selectRow', editLinkEditIndex).datagrid('beginEdit',
					editLinkEditIndex);
		}
}
//删除一行
function editLinkremoveit() {
	if (editLinkEditIndex == undefined) {
		return
	}
	$('#editLink_table').datagrid('cancelEdit', editLinkEditIndex).datagrid('deleteRow',
			editLinkEditIndex);
	editLinkEditIndex = undefined;
}
//设计规则
function setRule() {
	var resultcustoms = '';
	var resultText='';
	//获取所有行
	var rows = $('#editLink_table').datagrid('getRows');
	var customArr = new Array(rows.length);//条件符号数组
	var fieldValueArr = new Array(rows.length);//值数组
	for(var index=0;index<rows.length;index++){
		//把 条件字段、条件、值组装起来
		var fieldName=rows[index]['fieldName'];//条件
		var custom=rows[index]['custom'];//条件
		var fieldValue=rows[index]['fieldValue'];//值
		customArr[index]=custom;
		fieldValueArr[index]=fieldValue;
		// 项目申报和合同拟定合同金额是元
		// 得到结果 例如  F_AMOUNT>10000
		var text = null;
		var customs = null;
		var fBusiArea ='${bean.FBusiArea}';
		if(fieldName=='F_AMOUNT'){ //如果条件字段是金额
			if(fBusiArea=='XMSB'){
				text=fieldbol(fieldName)+symbol(custom)+fieldValue+'元';
				customs=fieldName+custom+fieldValue; 
			}else{
				text=fieldbol(fieldName)+symbol(custom)+fieldValue+'元';
				customs=fieldName+custom+fieldValue; 
			}
		}else if(fieldName=='F_ASSIS_DEPT_NAME'){// //如果条件字段是协调部门
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+custom+valuebol(fieldValue);
		}else if(fieldName=='F_STANDARD'){// //如果条件字段是制式合同
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+custom+valuebol(fieldValue);
		}else if(fieldName=='F_IF_CFO'){// //如果条件字段是主管校长是否财务校长
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+custom+valuebol(fieldValue);
		}else if(fieldName=='F_PAYMENT_TYPE'){// //如果条件字段是付讫人
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_IF_FJJHT'){// //如果条件字段是合同分类
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_INDEX_TYPE'){// //预算指标类型
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_EXPENDITURE_TYPE'){//经费类型
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_DEPT'){//党务部门
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_CHANGE_TYPE'){//调整类型
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_IS_ACROSS_DEPT'){//调整类型
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='T_PRO_USE_TYPE'){//预算使用类型
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_PROCUREMENT_STATUS'){//是否政府采购
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_LEV_CODE_1'){//项目一级名称
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_RESEARCH_TYPE'){//科研经费类型
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_IF_DEPUTY'){//是否副职
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}else if(fieldName=='F_IF_DEPT_INDEX'){//是否本部门预算指标
			text=fieldbol(fieldName)+symbol(custom)+fieldValue;
			customs=fieldName+" "+custom+valuebol(fieldValue);
		}
		
		if(resultcustoms==''){
	 		resultcustoms=customs;
	 		resultText=text;
	 	}else{
	 		resultcustoms=resultcustoms+' and '+customs; 
	 		resultText=resultText+' 且 '+text;
	 	}
	}
	
	$('#customs').val(resultcustoms);
	$('#resultText').val(resultText);
	return true;
}


//使列表结束编辑状态
function editLinkaccept() {
	if (editLinkEndEditing()) {
		$('#editLink_table').datagrid('acceptChanges');
	}
}

//表格结束编辑状态
function editLinkEndEditing() {
	if (editLinkEditIndex == undefined) {
		return true;
	}
	if ($('#editLink_table').datagrid('validateRow', editLinkEditIndex)) {
		
		 //下面5行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#editLink_table').datagrid('getEditors', editLinkEditIndex);
		var fieldText=tr[0].target.combotree('getText');
		tr[0].target.combotree('setValue',fieldText); 
		var text=tr[1].target.combotree('getText');
		tr[1].target.combotree('setValue',text); 
		var text=tr[4].target.combotree('getText');
		tr[4].target.combotree('setValue',text); 
		
		$('#editLink_table').datagrid('endEdit', editLinkEditIndex);
		editLinkEditIndex = undefined;
		return true;
	} else {
		return false;
	}
}
//行被点击事件
function onClickRow(index) {
	if (editLinkEditIndex != index) {
		if (editLinkEndEditing()) {
			$('#editLink_table').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editLinkEditIndex = index;
		} else {
			$('#editLink_table').datagrid('selectRow', editLinkEditIndex);
		}
	}
}
function symbol(value){
	if(value=='>'){
		return '大于';
	}else if(value=='>='){
		return '大于等于';
	}else if(value=='<'){
		return '小于';
	}else if(value=='<='){
		return '小于等于';
	}else if(value=='='){
		return '等于';
	}else if(value=='in'){
		return '包含';
	}
}
function fieldbol(value){
	if(value=='F_AMOUNT'){
		return '金额';
	}
	if(value=='F_ASSIS_DEPT_NAME'){
		return '协调部门';
	}
	if(value=='F_STANDARD'){
		return '制式合同';
	}
	if(value=='F_IF_CFO'){
		return '主管校长是否财务校长';
	}
	if(value=='F_PAYMENT_TYPE'){
		return '收款方式';
	}
	if(value=='F_IF_FJJHT'){
		return '是否非经济合同';
	}
	if(value=='F_INDEX_TYPE'){
		return '预算指标类型';
	}
	if(value=='F_EXPENDITURE_TYPE'){
		return '经费类型';
	}
	if(value=='F_DEPT'){
		return '党务部门';
	}
	if(value=='F_RESEARCH_TYPE'){
		return '科研经费类型';
	}
	if(value=='F_LEV_CODE_1'){
		return '项目一级名称';
	}
	if(value=='F_PROCUREMENT_STATUS'){
		return '是否政府采购';
	}
	if(value=='F_CHANGE_TYPE'){
		return '调整类型';
	}
	if(value=='F_IS_ACROSS_DEPT'){
		return '是否跨部门调整';
	}
	if(value=='T_PRO_USE_TYPE'){
		return '是否包含基建，维修，设备购置';
	}
	if(value=='F_IF_DEPUTY'){
		return '申请人是否副处长';
	}
	if(value=='F_IF_DEPT_INDEX'){
		return '是否本部门预算指标';
	}
}
function valuebol(value){
	if(value=='设备与安技处'){
		return '14';
	}
	if(value=='空'){
		return '';
	}
	if(value=='总务处'){
		return '35';
	}
	if(value=='创业就业指导中心'){
		return '20';
	}
	if(value=='否'){
		return '0';
	}
	if(value=='是'){
		return '1';
	}
	if(value=='基本指标'){
		return '0';
	}
	if(value=='项目指标'){
		return '1';
	}
	if(value=="('支票'.'电汇'.'银行代发')"){
		return "('支票'.'电汇'.'银行代发')";
	}
	if(value=="('现金'.'公务卡')"){
		return "('现金'.'公务卡')";
	}
	if(value=="经济类合同"){
		return "('HTFL-01'.'HTFL-02')";
	}
	if(value=="非经济类合同"){
		return "('HTFL-03'.'HTFL-04')";
	}
	if(value=="科研经费"){
		return "'CLKYJFSQ'";
	}
	if(value=="教改经费"){
		return "'CLJGJFSQ'";
	}
	if(value=="专项经费"){
		return "'CLZXJFSQ'";
	}
	if(value=="公用经费"){
		return "'CLGYJFSQ'";
	}
	if(value=="党务部门"){
		return "(6.7.8.9.12.18.31)";
	}
	if(value=="内部预算指标调剂"){
		return "'NBYSZBTJ'";
	}
	if(value=="年终追加项目"){
		return "'BMYSZBTZ'";
	}
	if(value=="外部预算指标调整"){
		return "'WBYSZBTZ'";
	}
	if(value=="不跨部门"){
		return "0";
	}
	if(value=="跨部门"){
		return "1";
	}
	if(value=="经常性支出项目"){
		return "'XD-01'";
	}
	if(value=="科研"){
		return "'KEYAN'";
	}
	if(value=="教改"){
		return "'JIAOGAI'";
	}
}
function save(){
	editLinkaccept();
	var editLinkrows = $('#editLink_table').datagrid('getRows');
	var ruleJson = "";
	for (var j = 0; j < editLinkrows.length; j++) {
		ruleJson = ruleJson + JSON.stringify(editLinkrows[j]) + ",";
	}
	$('#ruleJson').val(ruleJson);
	if(!setRule()){ //如果配置条件不正确，无法提交
		return false;
	}
	var custom=$('#customs').val();
	var text=$('#resultText').val();
	var fromKey=$('#editLink_fromKey').val();
	var toKey=$('#editLink_toKey').val();
	var flowId=$('#editLink_FPId').val();
	
	if (custom !='') {
		myDesigner.updateLinkDataByKey(fromKey,toKey,text,custom);
		$.ajax({
			async:false,
			type:"POST",
	        url:base+"/wflow/saveRule",
	        data:{flowId:flowId,fromKey:fromKey,toKey:toKey,ruleJson:ruleJson},
	        success:function(data){
	        	closeFirstWindow();
	        }
	    });
	} else {
		$.messager.alert('系统提示', '请填写跳转条件！', 'info');
	}
}

</script>
</body>
</html>

