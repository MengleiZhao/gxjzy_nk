<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<tr class="trbody">
		<td class="td1" style="width:70px;"><span class="style1">*</span> 团组名称</td>
		<td class="td2" >
			<input style="width: 265px; height: 30px;" id="fTeamName" name="fTeamName" class="easyui-textbox"
			value="${abroad.fTeamName}"  data-options="required:true,validType:'length[1,100]'"/> 
		</td>
		<td class="td1" style="width:70px;"><span class="style1">*</span> 组团单位</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" name="fAbroadPlace" class="easyui-textbox" 
			value="${abroad.fAbroadPlace}" data-options="required:true,validType:'length[1,100]'"/> 
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width:70px;"><span class="style1">*</span> 团长(级别)</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" id="fTeamLeader" name="fTeamLeader" class="easyui-textbox"
			value="${abroad.fTeamLeader}"  data-options="required:true,validType:'length[1,100]'"/> 
		</td>
		<td class="td1" style="width:70px;"><span class="style1">*</span> 团员人数</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" id="fTeamPersonNum"  name="fTeamPersonNum" class="easyui-numberbox" 
			value="${abroad.fTeamPersonNum}" data-options="required:true,validType:'length[1,100]'"/> 
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width:70px;"><span class="style1">*</span> 开始时间</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" id="abroadDateStart" name="fAbroadDateStart" class="easyui-datebox" 
			value="${abroad.fAbroadDateStart}" data-options="required:true" editable="false"/>
		</td>
		
		<td class="td1" style="width:70px;"><span class="style1">*</span> 结束时间</td>
		<td class="td2">
			<input type="hidden" name="faId" value="${abroad.faId}" />
			<input style="width: 265px; height: 30px;" id="abroadDateEnd" name="fAbroadDateEnd" class="easyui-datebox" 
			value="${abroad.fAbroadDateEnd}" data-options="onSelect:onSelectAbroad2,required:true" editable="false"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width:70px;"><span class="style1">*</span> 出国天数</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" id="abroadDay" name="fAbroadDayNum" class="easyui-textbox"
			value="${abroad.fAbroadDayNum}" readonly="readonly" data-options="required:true,validType:'length[1,2]'"/> 
		</td>
		<td class="td1" style="width:70px;"></td>
		<td class="td2">
		</td>
		<%-- <td class="td4"></td>
		<td class="td1"><span class="style1">*</span> 出国人员</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" name="fAbroadPeople" class="easyui-textbox" 
			value="${abroad.fAbroadPeople}" data-options="required:true,validType:'length[1,100]'"/> 
		</td> --%>
	</tr>
	<%-- <tr class="trbody">
		<td class="td1"><span class="style1">*</span> 任务类型</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" name="fTasjType" class="easyui-textbox" 
			value="${abroad.fTasjType}" data-options="required:true,validType:'length[1,10]'"/> 
		</td>
		<td class="td4"></td>
		<td class="td1"><span class="style1">*</span> 出访国家(地区)</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" name="fAbroadPlace" class="easyui-textbox" 
			value="${abroad.fAbroadPlace}" data-options="required:true,validType:'length[1,10]'"/> 
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 交通工具</td>
		<td class="td2"><input style="width: 265px; height: 30px;" name="fVehicle" class="easyui-textbox" 
		value="${abroad.fVehicle}" data-options="required:true,validType:'length[1,10]'"/>
		</td>
		<td class="td4"></td>
		<td class="td1"><span class="style1">*</span> 交通工具等级</td>
		<td class="td2">
			<input style="width: 265px; height: 30px;" name="fVehicleLevel" class="easyui-textbox"
			value="${abroad.fVehicleLevel}" data-options="required:true,validType:'length[1,10]'"/> 
		</td>
	</tr> --%>
<%-- <table class="window-table" cellspacing="0" cellpadding="0">
<tr class="trbody">
		<td colspan="3" class="" style=""><span class="style1"></span>出访路线及计划（含经停）</td>
		
		<jsp:include page="abroad_way.jsp" />		
	</tr> 
</table> --%>



<script type="text/javascript">
//日期设置
function onSelectAbroad2(date) {
	endday5 = date;
	startday5 =new Date(startday5);
	if(startday5 !=undefined){
		var d = (endday5 - startday5) / 86400000 + 1;
		if (d > 0) {
			$('#abroadDay').textbox("setValue", d);
		} else {
			$('#abroadDay').textbox("setValue", "");
		}
	}
	
}
//自动获得费用明细
function calcTravelCost(){
	
	var aboard_num = $("#abroadDay").textbox('getValue');//出国天数
	
	if(aboard_num==''){
		return;
	}
	
	$('#appli-detail-dg-travel').datagrid({
		url: base+'/hotelStandard/calcCost?outType=aboard',
		queryParams:{
			aboard_num: aboard_num
		}
	});
}
	
$(function(){
	$("#fTeamPersonNum").numberbox({
	    onChange : function(newValue,oldValue){
	    	if(newValue==undefined || oldValue==undefined){
				return false;
			}
	    	$("#travelPerson").numberbox('setValue',newValue);
			$("#hotelPerson").numberbox('setValue',newValue);
			$("#foodPerson").numberbox('setValue',newValue);
			$("#pocketPerson").numberbox('setValue',newValue);
	    	//动态添加列表行和删除行
	    	var newRowNum =parseInt(newValue);
	    	var oldRowNum =parseInt(oldValue);
	    	if(!isNaN(newRowNum) && isNaN(oldRowNum)){
	    	for(var i=0;i<=newRowNum-1;i++){
	    		if (endEditingR()){
	        	$('#abroad-people-dg').datagrid('appendRow', {});
	    			}
	    		}
	    	}
	    	if(!isNaN(newRowNum) &&!isNaN(oldRowNum)){
	    		if(newRowNum<oldRowNum){
	    			for(var j=oldRowNum;j>newRowNum;j--){
	    				$('#abroad-people-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
	    						j-1);
	    				editIndex = undefined;
			        }
			    }else if(newRowNum>oldRowNum){
			    	for(var i=0;i<=newRowNum-oldRowNum-1;i++){
			    		if (endEditingR()){
			        	$('#abroad-people-dg').datagrid('appendRow', {});
			    		}
			    	}
			    }
	    	}
	    	
	    	
	    	
	    }
	});
});


$("#abroadDateStart").datebox({
    onSelect : function(beginDate){
    	startday5 = beginDate;
    	endday5= new Date(endday5);
    	if(endday5 !=undefined){
    		var d = (endday5 - startday5) / 86400000 + 1;
    		if (d > 0) {
    			$('#abroadDay').textbox("setValue", d);
    		} else {
    			$('#abroadDay').textbox("setValue", "");
    		}
    	}
    	
        $('#abroadDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});

$('#abroadDay').numberbox({
	onChange: function(newValue, oldValue){
		
		if(newValue==undefined || oldValue==undefined){
			return false;
		}
		
		$("#hotelDay").numberbox('setValue',newValue);
		$("#foodDay").numberbox('setValue',newValue);
		$("#pocketDay").numberbox('setValue',newValue);
	}
	 });
</script>
