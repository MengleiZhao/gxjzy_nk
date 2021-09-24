<%@ page language="java" pageEncoding="UTF-8"%>

<ol class="ui-step ui-step-5" style="margin-top: 15px;width:430px;">
	<li class="step-active" id="pro_add_step1">
	<!-- <li class="step-start step-done"> -->
		<div class="ui-step-line"></div>
		<div class="ui-step-cont">
			<span class="ui-step-cont-number">1</span>
			<span class="ui-step-cont-text">项目信息</span><br/>
		</div>
	</li>
	<li class="step-start" id="pro_add_step2">
		<div class="ui-step-line"></div>
		<div class="ui-step-cont">
			<span class="ui-step-cont-number">2</span>
			<span class="ui-step-cont-text">项目支出明细</span>
		</div>
	</li>
	<li class="step-start" id="pro_add_step3">
		<div class="ui-step-line"></div>
		<div class="ui-step-cont">
			<span class="ui-step-cont-number">3</span>
			<span class="ui-step-cont-text">项目支出计划</span>
		</div>
	</li>
	<li class="step-end" id="pro_add_step4" >
		<div class="ui-step-line"></div>
		<div class="ui-step-cont">
			<span class="ui-step-cont-number">4</span>
			<span class="ui-step-cont-text">项目支出绩效目标</span>
		</div>
	</li>
	<!-- <li class="step-end" id="pro_add_step5" style="margin-top: 16px; width:125px;">
		<div class="ui-step-line"></div>
		<div class="ui-step-cont">
			<span class="ui-step-cont-number">5</span>
			<span class="ui-step-cont-text">年度目标</span>
		</div>
	</li>  -->
</ol>
<script type="text/javascript">
//当前步骤
var currentStepNum=0;
var currentStepName='项目基本信息';
//初始化accordion点击事件
$(function(){
	/* $('#div-project-add').accordion({
		onSelect:function(title,index){
			if(index!=currentStepNum){
				//验证数据是否完整
				if(validateProjectAdd(currentStepName)==false){
					$('#div-project-add').accordion('select',currentStepNum);
					return;
				}
				//验证是否越级
				if (index > currentStepNum + 1) {
					alert('请按指定顺序进行填写！');
					$('#div-project-add').accordion('select',currentStepNum);
					return;
				}
				//成功进入下一步，并变更步骤条样式
				currentStepNum = index;
				currentStepName = title;
				refreshStepLine(currentStepNum);
			}
		}
	}); */
});
//刷新步骤条样式
function refreshStepLine(stepNum){
	var stepNum1 = stepNum + 1;
	var sid = 'pro_add_step' + stepNum;
	var sid1 = 'pro_add_step' + stepNum1;
	//变更当前步骤样式
	$('#'+sid).removeClass();
	$('#'+sid).addClass('step-done');
	//变更下一步骤样式
	if(stepNum1!=4){
		$('#'+sid1).removeClass();
		$('#'+sid1).addClass('step-active');
	}else{
		$('#'+sid1).addClass('step-active');
	}
}	
</script>