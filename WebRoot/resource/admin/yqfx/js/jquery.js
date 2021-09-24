$(function(){		

});

 $(document).ready(function(){
	
	$('.tabtit li').click(function(){
		$(this).addClass("tab_on").siblings().removeClass("tab_on");
		$(".tabcontent > ul").eq($(".tabtit li").index(this)).show().siblings().hide();
	});
	
});



