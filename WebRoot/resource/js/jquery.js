$(document).ready(function(){
	
	$('.tabtit li').click(function(){
		$(this).addClass("tab_on").siblings().removeClass("tab_on");
		$(".tabcontent > ul").eq($(".tabtit li").index(this)).show().siblings().hide();
	});

	$(".nav_in li:last").css("background","none");
	
	$(".nav_in li").hover(function(){
		$(this).find("ul:first").show();
		$(this).addClass("sel");
	},function(){
		$(this).find("ul:first").hide();
		$(this).removeClass("sel");
	});
	
	
	$('.sidebar li ul').hide(); 
	$('.sidebar li span.sid_on').next().show();
	$(".sidebar li span").click(function(event){
		var that = $(this).next(".sidebar li ul")
		//alert("1")
		//if(that[0])
			$(".sidebar li ul").slideUp();
			that.slideToggle().siblings(".sidebar li ul").slideUp();
		//else
			
	});
	
	
	
	
	$(".expert:even dd, .monthly:even dd").addClass("e_pr");
	$(".expert:odd dt, .expert:odd dt").addClass("e_pl");	
	$(".link ul a:last").css("margin-right","0");
	$(".homeInterview dl:last, .homeKnowledge ul li:last").css("border-bottom", "none");
	$(".four_f dl:last").css("border-right", "none");
	
	$(".j_jl_table tr:even td").css("background","#fafafa");
	
	$(".tips_txt").hide();
		//alert("1");
		$(".tips:first .tips_txt").show();
		//$(".tips:first .fold").attr("src","images/arrow_1.jpg");
		$(".fold").click(function(){
			var index=$(".fold").index(this);
			if($($(".fold_none").get(index)).css("display")=='none'){
				$($(".fold_none").get(index)).slideToggle();
				$($(".fold img").get(index)).attr("src","images/icon_9.jpg");
			}else{
				$($(".fold_none").get(index)).slideUp();
				$($(".fold img").get(index)).attr("src","images/icon_8.jpg");
			}
		});
		
	$(".tablelist tbody tr:odd").addClass("odd");
	$(".tablelist tbody tr").hover(
		function(){
		$(this).addClass("highlight");
		},
		function(){
		$(this).removeClass("highlight");
	});
	
	
	$(".green_menu li").hover(function(){
		$(this).find("ul:first").show();
		$(this).addClass("sel");
	},function(){
		$(this).find("ul:first").hide();
		$(this).removeClass("sel");
	});
	
});



$(document).ready(function(){
	   var index;
	//var index1;
	$(".tablelist_1_imgtit").click(function(event){		  
			event.stopPropagation();  
				index = $(".tablelist_1_imgtit").index(this); 
			$(".tablelist_1_img_txt:eq("+index+")").toggle(""); 
				$(".tablelist_1_img_txt").each(function(i){
			if(i != index){
				$(".tablelist_1_img_txt:eq("+i+")").hide(); 			
			}
		});
	});
 
	$(".tablelist_1_img_txt").click(function (event) { 
			   event.stopPropagation();  
	    $(this).show();
	});  
    $(document).click(function (event) {
		$('.tablelist_1_img_txt').hide();
	}); 
	
	
});


$(function(){	
	$(".login ul li input").focus(
		function(){
			$(this).parent().addClass("focus");
		}
		).blur(
			function(){
			$(this).parent().removeClass("focus");
		}
	);
});			
$(function(){
	$(".sbubar span").click(function(event){
		var that = $(this).next(".subMenu").find("ul.subMenu-1")
		if(that[0]){
			that.slideToggle().parent().siblings(".subMenu").find("ul.subMenu-1").slideUp();
		}
		else{
			$(".subMenu").find("ul.subMenu-1").slideUp();
		}
	   });
});	

function subClose(){
	try{	
		window.opener.document.getElementById("pageForm").submit();
		window.close();
	}catch(e){
		window.close();
	}
}

$(function(){
	$("#t1").mouseover(function(){
 		 $(".zayj").css("display","none");
	});
	$("#t2").mouseover(function(){
 		 $(".zayj").css("display","block");
	});		
});

$(function(){		

});

 $(document).ready(function(){
	
	$('.tabtit li').click(function(){
		$(this).addClass("tab_on").siblings().removeClass("tab_on");
		$(".tabcontent > ul").eq($(".tabtit li").index(this)).show().siblings().hide();
	});
	
});
