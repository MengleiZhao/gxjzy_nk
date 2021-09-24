<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
  <style type="text/css">
    .stars{
      white-space: nowrap;
      text-align: left;
/*       margin-top: 20px;
      margin-bottom: 20px; */
    }
    .stars li{
      display: inline-block;
      color: #b1b1b1;
      font-size: 20px;
    }
    .stars5{
      white-space: nowrap;
      text-align: left;
/*       margin-top: 20px;
      margin-bottom: 20px; */
    }
    .stars5 li{
      display: inline-block;
      color: #b1b1b1;
      font-size: 25px;
    }
  </style>
<div class="win-div">
<form id="supplier_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 479px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div" style="height: 410px;">
				<div class="easyui-accordion" data-options="" id="" style="width:662px;margin-left: 20px">
									<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td colspan="6" style="text-align: center">
												<a style="color: #0170a4;font-size: 15px;font-weight: bold;">评价服务</a>
											</td>
										</tr>
										<tr>
											<td class="tdstar"></td>
											<td class="tdstar" colspan="2" style="text-align: center;">
												<a style="color: #b1b1b1;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													采购名称:&nbsp;&nbsp;${hisbean.fpName}</a>
												<input type="hidden" name="fpId" id="F_fpId" value="${hisbean.fpId}"/><!--隐藏域  采购信息的主键id  -->
												<input type="hidden" name="fpCode" id="F_fpCode" value="${hisbean.fpCode}"/><!--隐藏域  采购信息的采购单编号  -->
												<input type="hidden" name="fpName" id="F_fpName" value="${hisbean.fpName}"/><!--隐藏域  供应商的主键id -->
												<input type="hidden" name="fwId" id="F_fwId" value="${fwbean.fwId}"/><!--隐藏域  供应商的主键id -->
											</td>
											<td class="tdstar" style="color: color: #b1b1b1;" colspan="2">
												<a style="color: #b1b1b1;">采购时间:&nbsp;&nbsp;${dealTime.substring(0,10)}</a>
											</td>
											<td class="tdstar" ></td>
										</tr>
										<tr class="trbody">
											<td class="tdstar5" style="text-align: left;font-size: 14px;font-weight: bold;">综合评价</td>
											<td class="tdstar5" style="text-align: center;" >
													<ul class="stars5" id="star5">
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												    </ul>
											</td>
											<td id="pingfen5" class="tdstar5" colspan="2"></td>
										</tr>
										<tr style="height: 30px">
											<td colspan="6">
												<hr style="color: #b1b1b1;height:1px;border:none;border-top:1px solid #b1b1b1;"/>
											</td>
										</tr>
										<tr class="trbody">
											<td class="tdstar" style="text-align: left;font-size: 14px;font-weight: bold;">分项评价</td>
										</tr>
										<!-- <tr>
											<td class="tdstar">&nbsp;&nbsp;&nbsp;&nbsp;价格</td>
											<td class="tdstar">
													<ul class="stars" id="star1">
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												    </ul>
											</td>
											<td id="pingfen1" class="tdstar"></td>
											<td class="tdstar">性价比</td>
											<td class="tdstar">
													<ul class="stars" id="star2">
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												    </ul>										
											</td>
											<td id="pingfen2" class="tdstar"></td>
										</tr> -->
										<tr>
											<td class="tdstar">&nbsp;&nbsp;&nbsp;&nbsp;质量</td>
											<td class="tdstar">
													<ul class="stars" id="star3">
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												    </ul>											
											</td>
											<td id="pingfen3" class="tdstar"></td>
											<td class="tdstar">服务</td>
											<td class="tdstar">
													<ul class="stars" id="star4">
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												      <li>★</li>
												    </ul>											
											</td>
											<td id="pingfen4" class="tdstar"></td>
										</tr>
										<tr>
											<td class="tdstar"></td>
											<td class="tdstar" colspan="5"><span id="pingfen6" style="display: none;" class="style4" >不满意？请留下您的宝贵意见</span></td>
										</tr>
										<tr style="height: 70px;">
											<td class="tdstar" valign="top"><p style="margin-top: 8px">个人意见</td>
											<td colspan="5">
												<input class="easyui-textbox" type="text" id="F_fremark"  name="fremark"  data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" />
											</td>
										</tr>
									</table>
									
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveEvalSupplier()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<!-- <a href="javascript:void(0)">
					<input type="button" id="ok" value="打分">
				</a>&nbsp;&nbsp; -->
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
					<input type="checkbox" name="hobby" value="1"/>
					<label>匿名评价</label>
			</div>
		</div>
	
		
	</div>
</form>
</div>
	<script type="text/javascript">
	
   // $(function() {
    	//判断是否展示提示信息
        var isshow=false;
        var isshow2=false;
        var isshow3=false;
        var isshow4=false;
        var isshow5=false;
     	//第一个ul
        //为星星设置hover效果
        var isClicked = false;
        var beforeClickedIndex = -1;
        var clickNum = 0; //点击同一颗星次数
        $('#star1 li').hover(
          function() {
            if(!isClicked) {
              $(this).css('color', '#fed80b');
              var index = $(this).index();
              for(var i = 0; i <= index; i++) {
                $('#star1 li:nth-child(' + i + ')').css('color', '#fed80b');
              }
            }
          },
          function() {
            if(!isClicked) {
              $('#star1 li').css('color', '#b1b1b1');
            }
          }
        );
        //星星点击事件
        $('#star1 li').click(function() {
          $('#star1 li').css('color', '#b1b1b1');
          isClicked = true;
          var index = $(this).index();
          for(var i = 1; i <= index+1; i++) {
            $('#star1 li:nth-child(' + i + ')').css('color', '#fed80b');
          }
          if(index == beforeClickedIndex) { //两次点击同一颗星星 该星星颜色变化
            clickNum++;
            if(clickNum % 2 == 1) {
              $('#star1 li:nth-child(' + (index + 1) + ')').css('color', '#b1b1b1');
            } else {
              $('#star1 li:nth-child(' + (index + 1) + ')').css('color', '#fed80b');
            }
          } else {
	         	clickNum = 0;
	            beforeClickedIndex = index;
	            $('#pingfen1').empty();
	            if(beforeClickedIndex==4){//根据点击的星星数量显示满意度
	            	$('#pingfen1').append('<span class="style2">非常满意</span>');
	            /* 	document.getElementById("pingfen1").innerHTML = "非常满意"; */
	            	isshow=false;
	            	showSuggest();
	            }else if(beforeClickedIndex==3){
	            	$('#pingfen1').append('<span class="style2">满意</span>');
	            	/* document.getElementById("pingfen1").innerHTML = "满意"; */
	            	isshow=true;
	            	$('#pingfen6').show();//不满意展示提示信息
	            }else if(beforeClickedIndex==2){
	            	$('#pingfen1').append('<span class="style2">一般</span>');
	           /*  	document.getElementById("pingfen1").innerHTML = "一般"; */
	           	    isshow=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex==1){
	            	$('#pingfen1').append('<span class="style2">不满意</span>');
	            /* 	document.getElementById("pingfen1").innerHTML = "不满意"; */
	            	isshow=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex==0){
	            	$('#pingfen1').append('<span class="style2">非常不满意</span>');
	            	/* document.getElementById("pingfen1").innerHTML = "非常不满意"; */
	            	isshow=true;
	            	$('#pingfen6').show();
	            }
          }
        });
     	//第二个ul
        var isClicked2 = false;
        var beforeClickedIndex2 = -1;
        var clickNum2 = 0; //点击同一颗星次数
        $('#star2 li').hover(
          function() {
            if(!isClicked2) {
              $(this).css('color', '#fed80b');
              var index = $(this).index();
              for(var i = 0; i <= index; i++) {
                $('#star2 li:nth-child(' + i + ')').css('color', '#fed80b');
              }
            }
          },
          function() {
            if(!isClicked2) {
              $('#star2 li').css('color', '#b1b1b1');
            }
          }
        );
        //星星点击事件
        $('#star2 li').click(function() {
          $('#star2 li').css('color', '#b1b1b1');
          isClicked2 = true;
          var index = $(this).index();
          for(var i = 1; i <= index+1; i++) {
            $('#star2 li:nth-child(' + i + ')').css('color', '#fed80b');
          }
          if(index == beforeClickedIndex2) { //两次点击同一颗星星 该星星颜色变化
            clickNum2++;
            if(clickNum2 % 2 == 1) {
              $('#star2 li:nth-child(' + (index + 1) + ')').css('color', '#b1b1b1');
            } else {
              $('#star2 li:nth-child(' + (index + 1) + ')').css('color', '#fed80b');
            }
          } else {
	            clickNum2 = 0;
	            beforeClickedIndex2 = index;
	            $('#pingfen2').empty();
	            if(beforeClickedIndex2==4){//根据点击的星星数量显示满意度
	            	$('#pingfen2').append('<span class="style2">非常满意</span>');
	            	isshow2=false;
	            	showSuggest();
	            }else if(beforeClickedIndex2==3){
	            	$('#pingfen2').append('<span class="style2">满意</span>');
	            	isshow2=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex2==2){
	            	$('#pingfen2').append('<span class="style2">一般</span>');
	            	isshow2=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex2==1){
	            	$('#pingfen2').append('<span class="style2">不满意</span>');
	            	isshow2=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex2==0){
	            	$('#pingfen2').append('<span class="style2">非常不满意</span>');
	            	isshow2=true;
	            	$('#pingfen6').show();
	            }
          }
        });
        //第三个ul
        var isClicked3 = false;
        var beforeClickedIndex3 = -1;
        var clickNum3 = 0; //点击同一颗星次数
        $('#star3 li').hover(
          function() {
            if(!isClicked3) {
              $(this).css('color', '#fed80b');
              var index = $(this).index();
              for(var i = 0; i <= index; i++) {
                $('#star3 li:nth-child(' + i + ')').css('color', '#fed80b');
              }
            }
          },
          function() {
            if(!isClicked3) {
              $('#star3 li').css('color', '#b1b1b1');
            }
          }
        );
        //星星点击事件
        $('#star3 li').click(function() {
          $('#star3 li').css('color', '#b1b1b1');
          isClicked3 = true;
          var index = $(this).index();
          for(var i = 1; i <= index+1; i++) {
            $('#star3 li:nth-child(' + i + ')').css('color', '#fed80b');
          }
          if(index == beforeClickedIndex3) { //两次点击同一颗星星 该星星颜色变化
            clickNum3++;
            if(clickNum3 % 2 == 1) {
              $('#star3 li:nth-child(' + (index + 1) + ')').css('color', '#b1b1b1');
            } else {
              $('#star3 li:nth-child(' + (index + 1) + ')').css('color', '#fed80b');
            }
          } else {
	            clickNum3 = 0;
	            beforeClickedIndex3 = index;
	            $('#pingfen3').empty();
	            if(beforeClickedIndex3==4){//根据点击的星星数量显示满意度
	            	$('#pingfen3').append('<span class="style2">非常满意</span>');
	            	isshow3=false;
	            	showSuggest();
	            }else if(beforeClickedIndex3==3){
	            	$('#pingfen3').append('<span class="style2">满意</span>');
	            	isshow3=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex3==2){
	            	$('#pingfen3').append('<span class="style2">一般</span>');
	            	isshow3=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex3==1){
	            	$('#pingfen3').append('<span class="style2">不满意</span>');
	            	isshow3=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex3==0){
	            	$('#pingfen3').append('<span class="style2">非常不满意</span>');
	            	isshow3=true;
	            	$('#pingfen6').show();
	            }          
          }
        });
        //第四个ul
        var isClicked4 = false;
        var beforeClickedIndex4 = -1;
        var clickNum4 = 0; //点击同一颗星次数
        $('#star4 li').hover(
          function() {
            if(!isClicked4) {
              $(this).css('color', '#fed80b');
              var index = $(this).index();
              for(var i = 0; i <= index; i++) {
                $('#star4 li:nth-child(' + i + ')').css('color', '#fed80b');
              }
            }
          },
          function() {
            if(!isClicked4) {
              $('#star4 li').css('color', '#b1b1b1');
            }
          }
        );
        //星星点击事件
        $('#star4 li').click(function() {
          $('#star4 li').css('color', '#b1b1b1');
          isClicked4 = true;
          var index = $(this).index();
          for(var i = 1; i <= index+1; i++) {
            $('#star4 li:nth-child(' + i + ')').css('color', '#fed80b');
          }
          if(index == beforeClickedIndex4) { //两次点击同一颗星星 该星星颜色变化
            clickNum4++;
            if(clickNum4 % 2 == 1) {
              $('#star4 li:nth-child(' + (index + 1) + ')').css('color', '#b1b1b1');
            } else {
              $('#star4 li:nth-child(' + (index + 1) + ')').css('color', '#fed80b');
            }
          } else {
	            clickNum4 = 0;
	            beforeClickedIndex4 = index;
	            $('#pingfen4').empty();
	            if(beforeClickedIndex4==4){//根据点击的星星数量显示满意度
	            	$('#pingfen4').append('<span class="style2">非常满意</span>');
	            	isshow4=false;
	            	showSuggest();
	            }else if(beforeClickedIndex4==3){
	            	$('#pingfen4').append('<span class="style2">满意</span>');
	            	isshow4=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex4==2){
	            	$('#pingfen4').append('<span class="style2">一般</span>');
	            	isshow4=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex4==1){
	            	$('#pingfen4').append('<span class="style2">不满意</span>');
	            	isshow4=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex4==0){
	            	$('#pingfen4').append('<span class="style2">非常不满意</span>');
	            	isshow4=true;
	            	$('#pingfen6').show();
	            }  
          }
        });
      //第五个个ul
        var isClicked5 = false;
        var beforeClickedIndex5 = -1;
        var clickNum5 = 0; //点击同一颗星次数
        $('#star5 li').hover(
          function() {
            if(!isClicked5) {
              $(this).css('color', '#fed80b');
              var index = $(this).index();
              for(var i = 0; i <= index; i++) {
                $('#star5 li:nth-child(' + i + ')').css('color', '#fed80b');
              }
            }
          },
          function() {
            if(!isClicked5) {
              $('#star5 li').css('color', '#b1b1b1');
            }
          }
        );
        //星星点击事件
        $('#star5 li').click(function() {
          $('#star5 li').css('color', '#b1b1b1');
          isClicked5 = true;
          var index = $(this).index();
          for(var i = 1; i <= index+1; i++) {
            $('#star5 li:nth-child(' + i + ')').css('color', '#fed80b');
          }
          if(index == beforeClickedIndex5) { //两次点击同一颗星星 该星星颜色变化
            clickNum5++;
            if(clickNum5 % 2 == 1) {
              $('#star5 li:nth-child(' + (index + 1) + ')').css('color', '#b1b1b1');
            } else {
              $('#star5 li:nth-child(' + (index + 1) + ')').css('color', '#fed80b');
            }
          } else {
	            clickNum5 = 0;
	            beforeClickedIndex5 = index;
	            $('#pingfen5').empty();
	            if(beforeClickedIndex5==4){//根据点击的星星数量显示满意度
	            	$('#pingfen5').append('<span class="style3">非常满意</span>');
	            	isshow5=false;
	            	showSuggest();
	            }else if(beforeClickedIndex5==3){
	            	$('#pingfen5').append('<span class="style3">满意</span>');
	            	isshow5=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex5==2){
	            	$('#pingfen5').append('<span class="style3">一般</span>');
	            	isshow5=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex5==1){
	            	$('#pingfen5').append('<span class="style3">不满意</span>');
	            	isshow5=true;
	            	$('#pingfen6').show();
	            }else if(beforeClickedIndex5==0){
	            	$('#pingfen5').append('<span class="style3">非常不满意</span>');
	            	isshow5=true;
	            	$('#pingfen6').show();
	            }
          }
        });
   // });
   
	//循环遍历   只要有一个不是五星    就展示提示信息
   function showSuggest(){
	  if(!isshow && !isshow2 && !isshow3 && !isshow4 && !isshow5) {
		  $('#pingfen6').hide();
	  } else {
		  $('#pingfen6').show();
	  }
   }
   
   
	//保存评价信息
    function saveEvalSupplier(){        
        var zonghe=beforeClickedIndex5+1;//综合评价
        var price=beforeClickedIndex+1;//价格
        var rate=beforeClickedIndex2+1;//性价比
        var quality=beforeClickedIndex3+1;//质量
        var service=beforeClickedIndex4+1;//服务
        
        var val=$("input[type='checkbox']").is(':checked');//判斷是否匿名评价
        var isniming;
        if(val ==false){//非匿名
        	isniming=1;
        }else{//匿名
        	isniming=0;
        } 
        
        
        /* alert("综合评分："+zonghe+"分");
        alert("价格："+price+"分");
        alert("性价比："+rate+"分");
        alert("质量："+quality+"分");
        alert("服务："+service+"分");
        alert($("#F_fpId").val());
        alert($("#F_fwId").val());
        alert($("#F_fpCode").val());
        alert($("#F_fpName").val());
        alert($("#F_fremark").val()); */
        //保存评价的信息
         $.ajax({
	        //类型为get，是要从数据库获取数据，
	        type: "POST",
	        //获取数据的地址，此地址为对应的controller,去执行对应的controller,MVC里的controller相当于三层中的U层
			url : '${base}/evalsupplier/saveEvalSupplier',
			// 连同请求发送到服务器的数据，请求参数
	        data:{'fremark':$("#F_fremark").val(),'fpid':$("#F_fpId").val(),'fwid':$("#F_fwId").val(),'fpcode':$("#F_fpCode").val(),'fpname':$("#F_fpName").val(),'zonghe':zonghe,'price':price,'rate':rate,'quality':quality,'service':service,'isniming':isniming},
	       	//返回的数据类型为json类型
	        dataType: "json",
	        //当controller 请求服务器成功时执行,参数data为返回的数据
	        success: function (data) {
	        	if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#receive_approved').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
	        }
	    });	   
        
    }
    
    
    
    
	</script>
</body>