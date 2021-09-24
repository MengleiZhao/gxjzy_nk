function ChangeDateFormat(val) {
	var t, y, m, d, h, i, s;
	if(val == null) {
		return "";
	}
	t = new Date(val)
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
function flowNode(userId, type) {
	console.log(userId)
	console.log(type)
	$.ajax({
		url: "${urlbase}/node/getApplyNodes",
		/*url: base + "/node/getApplyNodes",*/
		type: 'GET',
		data: {
			userId: userId,
			type: type
		},
		async: true, //异步
		cache: false, //清缓存
		dataType: "json",
		contentType: "application/x-www-form-urlencoded",
		//成功获取后台数据
		success: function(json) {
			console.log(json)
			//发起人 /时间
			$("#f_user").text($("#appren").text().substring(0,1));
			$("#f_user2").text($("#appren").text());
			var y = 0;
			var html = '';
			for(var i = json.length - 1; i >= 0; i--) {
				var checkUserName2 = json[i].user.name.substring(0, 1); //审批人
				var checkUserName = json[i].user.name; //审批人
				var fcheckTime = ChangeDateFormat(json[i].checkInfo.fcheckTime); //审批时间
				if(json[i].checkInfo.fcheckRemake == null || json[i].checkInfo.fcheckRemake == '') {
					var fcheckRemake = '无审批意见'; //审批意见  同意/不同意
				} else {
					var fcheckRemake = json[i].checkInfo.fcheckRemake; //审批意见  同意/不同意
				}
				if(json[i].checkInfo.fcheckResult == null) {
					var fcheckResult = '待审批'; //审批意见  同意/不同意
				} else {
					var fcheckResult = '已审批'; //审批意见  同意/不同意
				}
				y++;
				if(y < json.length) {
					if(fcheckResult == '已审批') {
						if(json[i].checkInfo.fcheckResult == '1') {
							html += '<div class="stepInfo"><ul style="background:#999999;"><li></li><li></li></ul>'
							html += '<div class="stepIco stepIco1" style="background:#008DFF;" name="info_name_1">' + checkUserName2 + '</div>'
							html += '<div class="info info_2"><span name="info_name_2">' + fcheckRemake + '</span></div>'
							//										html +='<div class="info info_2"><textarea name="" class="opinion">'+"\""+fcheckRemake+"\""+'</textarea></div>'
							html += '<div class="info info_1"><strong name="info_name_1" style="font-size: 15px;">' + checkUserName + '</strong><span name="info_name_2" style="position: fixed;right:5%;margin-top:0px;">' + fcheckTime + '</span></div>'
							html += '</div>'
						}
						if(json[i].checkInfo.fcheckResult == '0') {
							html += '<div class="stepInfo"><ul style="background:#999999;"><li></li><li></li></ul>'
							html += '<div class="stepIco stepIco1" style="background:#FB6E56;" name="info_name_1">' + checkUserName2 + '</div>'
							html += '<div class="info info_2"><span name="info_name_2">' + fcheckRemake + '</span></div>'
							html += '<div class="info info_1"><strong name="info_name_1" style="font-size: 15px;">' + checkUserName + '</strong><span name="info_name_2" style="position: fixed;right:5%;margin-top:0px;">' + fcheckTime + '</span></div>'
							html += '</div>'
						}
					} else if(fcheckResult == '待审批') {
						html += '<div class="stepInfo"><ul style="background:#999999;"><li></li><li></li></ul>'
						html += '<div class="stepIco stepIco1" style="background:#999999;" name="info_name_1">' + checkUserName2 + '</div>'
						html += '<div class="info info_2"><span name="info_name_2">' + fcheckResult + '</span></div>'
						html += '<div class="info info_1"><strong name="info_name_1" style="font-size: 15px;">' + checkUserName + '</strong><span name="info_name_2" style="position: fixed;right:5%;margin-top:0px;">' + fcheckTime + '</span></div>'
						html += '</div>'
					}
				} else if(y == json.length) {
					if(fcheckResult == '已审批') {
						if(json[i].checkInfo.fcheckResult == '1') {
							html += '<div class="stepInfo" style="height:0px"><ul style="background:#008DFF;"><li></li><li></li></ul>'
							html += '<div class="stepIco stepIco1" style="background:#008DFF;" name="info_name_1">' + checkUserName2 + '</div>'
							html += '<div class="info info_2" style="position: relative;top: 20px;"><span name="info_2">' + fcheckRemake + '</span></div>'
							html += '<div class="info info_1"><strong name="info_name_1" style="font-size: 15px;">' + checkUserName + '</strong><span name="info_name_2" style="position: fixed;right:5%;margin-top:0px;">' + fcheckTime + '</span></div>'
							html += '</div>'
						}
						if(json[i].checkInfo.fcheckResult == '0') {
							html += '<div class="stepInfo" style="height:0px"><ul style="background:#008DFF;"><li></li><li></li></ul>'
							html += '<div class="stepIco stepIco1" style="background:#FB6E56;" name="info_name_1">' + checkUserName2 + '</div>'
							html += '<div class="info info_2" style="position: relative;top: 20px;"><span name="info_name_2">' + fcheckRemake + '</span></div>'
							html += '<div class="info info_1"><strong name="info_name_1" style="font-size: 15px;">' + checkUserName + '</strong><span name="info_name_2" style="position: fixed;right:5%;margin-top:0px;">' + fcheckTime + '</span></div>'
							html += '</div>'
						}
					} else if(fcheckResult == '待审批') {
						html += '<div class="stepInfo" style="height:0px"><ul style="background:#008DFF;"><li></li><li></li></ul>'
						html += '<div class="stepIco stepIco1" style="background:#999999;" name="info_name_1">' + checkUserName2 + '</div>'
						html += '<div class="info info_2" style="position: relative;top: 20px;"><span name="info_name_2">' + fcheckResult + '</span></div>'
						html += '<div class="info info_1"><strong name="info_name_1" style="font-size: 15px;">' + checkUserName + '</strong><span name="info_name_2" style="position: fixed;right:5%;margin-top:20px;">' + fcheckTime + '</span></div>'
						html += '</div>'
					}
				}
			}
			$("#flow").append(html);
			$("#atNode").text(1);
			$("#allNode").text(y+1);
		}
	})
}
function closeNode(){
	mui('#flowPopover').popover('hide');
}
