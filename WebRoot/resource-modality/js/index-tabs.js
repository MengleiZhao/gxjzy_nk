function flashtab(tabid) {
	var $wrapper = $('#'+tabid),
		//获得所有标签页
		$allTabs = $wrapper.find('.tab-content > div'),
		//获得所有标签头
		$tabMenu = $wrapper.find('.tab-menu li');
		$line = $('<div class="line"></div>').appendTo($tabMenu);
	
	//关闭所有非第一标签页
	$allTabs.not(':first-of-type').css('display','none');
	//展示第一标签页
	$tabMenu.filter(':first-of-type').find(':first').width('100%');
	
	//标签头赋予id和属性
	$tabMenu.each(function(i) {
	  $(this).attr('data-tab', 'tab'+i);
	  $(this).attr('id', 'tab'+i);
	});
	
	//标签页赋予id和属性
	$allTabs.each(function(i) {
	  $(this).attr('data-tab', 'tab'+i);
	  $(this).attr('id', 'tab'+i);
	});
	
	//标签头 设置点击事件
	$tabMenu.on('click', function() {
		  
	  var dataTab = $(this).data('tab');
	  $getWrapper = $(this).closest($wrapper);
	  
	  $getWrapper.find($tabMenu).removeClass('active');
	  $(this).addClass('active');
	  
	  $getWrapper.find('.line').width(0);
	  $(this).find($line).animate({'width':'100%'}, 'fast');
	  //关闭所有标签页，打开当前点击的
	  $getWrapper.find($allTabs).css('display','none');
	  $getWrapper.find($allTabs).filter('[data-tab='+dataTab+']').css('display','block');
	  
	  $getWrapper.find(".easyui-panel").panel('close');//用于被隐藏的表格显示出来
	  $(this).find(".easyui-panel").panel('open');//用于被隐藏的表格显示出来
	});
}