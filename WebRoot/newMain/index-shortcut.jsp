<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<!-- 快速入口编辑的页面需要的js -->
<script type="text/javascript" src="${base}/resource-modality/js/dsSelect.js"></script>


   <!--  <button onclick="leftValues()">获取左侧数据</button>
    <button onclick="rightValues()">获取右侧数据</button>
    <button onclick="disableButtons()">禁用按钮</button>
    <button onclick="start()">启用按钮</button> -->

<!--正文-->
<div style="width: 776px;height: 402px;border:1px #d9e3e7 solid;">
	<div>
		<div style="width: 100%;height: 40px;">
			<table style="width: 100%;font-weight: bold;">
				<tr style="height: 40px;line-height: 40px">
					<td><span style="margin-left: 130px">请选择快捷菜单</span></td>
					<td><span>已选择快捷菜单</span></td>
				</tr>
			</table>
		</div>
	
	
		<div class="dsSelect" id="dsSelectTemp" style="">

		</div>
		
		<div style="clear:both;"></div>
		
		<div style="text-align: left;height: 20px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：快捷菜单最多显示8项</span>
		</div>
		
		<div style="width: 100%;height: 25px;text-align: center;">
			<a href="javascript:void(0)" onclick="saveKsrk()">
				<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
	</div>
	
</div>

    
<script type="text/javascript">


    let dsSelectObj = new dsSelect("dsSelectTemp");
    dsSelectObj.multiSelect =true;
    dsSelectObj.init();
    //可以选择的入口
    let datas = ${dsDatas};
  	//已经拥有的入口
    let datasR= ${dsDatasR};
    
    dsSelectObj.setLeftData(datas,"name");
    dsSelectObj.setRightData(datasR,"name");

    function leftValues(){
        alert(JSON.stringify(dsSelectObj.getSelectLeftValus()));
    }
    function rightValues(){
       /* alert(JSON.stringify(dsSelectObj.getSelectRightValus())); */
       return JSON.stringify(dsSelectObj.getSelectRightValus());
    }
    function disableButtons(){
        dsSelectObj.disableButtons();
    }

    function start(){
        dsSelectObj.restartButtons();
    };
    
    function saveKsrk() {
    	//保存快速入口
    	var ksrk="";
    	var data = dsSelectObj.getSelectRightValus();
    	if(data.length>8) {
    		alert("您选择的快捷菜单已超过系统最大支持数（最多选择八项）");
    	} else {
	    	$.each(data, function(i){
	    		ksrk += data[i].id + ',';
	        }); 
	    	$.ajax({ 
				type: 'POST', 
				url: '${base}/index/saveKsrk',
				data: {ksrk:ksrk},
				dataType: 'json',  
				success: function(data){ 
					if(data){
						$("#syIframe").contents().find("#ksrk").empty();
						/* $("#ksrk").empty(); */
						/* var s1 = "<div class='ksrk0' style='background: url("+base+"/resource-modality/${themenurl}/index/ksrk0.png');'></div>";
						var s3 = '<div class="ksrkjj"><a href="#" onclick="ksrkadd()"><img src="${base}/resource-modality/${themenurl}/index/ksrk9.png"></a></div>'; */
						
						var s2 = "";
						$.each(data, function(n, value){
							var n1 = n+1;
							/* s2 += '<a href="#" onclick="parent.addTabs('+"'"+value.menuName+"','"+base+value.menuUrl+"'"+')">'+
							"<div class='ksrk' style='background: url("+base+"/resource-modality/${themenurl}/index/ksrk"+n1+".png');'>"+
							'<p class="ksrkf">'+value.menuName+'</p></div></a>'; */
							s2 += '<h2 onclick="parent.addTabs('+"'"+value.menuName+"','"+base+value.menuUrl+"'"+')">'+
							value.menuName+'</h2><div></div>';
						}); 
						/* var elem = document.getElementsById("ksrk");
						//console.log(elem);
						elem.parentNode.remove(elem); */
						$('#ksrk').empty();
						$("#ksrk").append(s2);
						//$("#syIframe").contents().find("#ksrk").append(s1+s2+s3);
						//$(".opened-for-codepen").trigger("create");
						//$("#syIframe").contents().find("#ksrk").trigger("create");
						//$("#syIframe").contents().find("#ksrk").flash()
						closeWindow();
					}else{
						alert("操作失败");
					}
				}
			});
    	}
    };
    
</script>
</body>