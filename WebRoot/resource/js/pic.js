$(function() {
	init("a1");
	function init(cls){
		var $cls = $('.'+cls);
		var sWidth = $cls.width(); 
		var len = $cls.find("ul li").length; 
		var index = 0;
		var picTimer;	
		
		var banbtn = "<div class='banbtnBg'></div><div class='banbtn'>";
		for(var i=0; i < len; i++) {
			banbtn += "<span></span>";
		}
		$cls.append(banbtn);	

		
		$cls.find(".banbtn span").mouseover(function() {
			index = $cls.find(".banbtn span").index(this);
			showPics(index);
		}).eq(0).trigger("mouseover");
		$cls.hover(function() {
			clearInterval(picTimer);
		},function() {
			picTimer = setInterval(function() {
				showPics(index);
				index++;
				if(index == len) {index = 0;}
			},4000); //此4000代表自动播放的间隔，单位：毫秒
		}).trigger("mouseleave");
		//显示图片函数，根据接收的index值显示相应的内容
		function showPics(index) { //普通切换
			var nowLeft = -index*sWidth; //根据index值计算ul元素的left值
			$cls.find("ul").stop(true,false).animate({"left":nowLeft},500); //通过animate()调整ul元素滚动到计算出的position
			$cls.find(".banbtn span").removeClass("on").eq(index).addClass("on"); //为当前的按钮切换到选中的		
		}
	}
});
document.execCommand("BackgroundImageCache", false, true);  