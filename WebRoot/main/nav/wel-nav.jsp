<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script language="javaScript">
	var char_1 = [ '寂静的深夜，除了自己的心跳，还有我在陪你。', '夜都睡了，你还不睡吗？', '晚安，月亮也一起睡了。',
			'夜深了，天上的星星都已经睡了。', '晚睡伤身体，客官早点歇息吧: )', '夜深了，常常熬夜可不好哦。' ];
	var char_2 = [ '清风送来新的一天，早晨好！', '一日之计在于晨，早安！', '请在清早给自己一个微笑^__^',
			'每个醒后的早晨都是一件礼物。', '每一天都是崭新的，早安！', '每天都是新的自己！' ];
	var char_3 = [ '生活是一面镜子，你笑它也笑。', '开启工作，开启一天的愉快！', '生活每天都是新的，加油！',
			'勤劳的小蜜蜂要开始忙碌的一天啦。', '一天之计在于晨，为了梦想努力吧！', '记得每天要喝八杯水哦！' ];
	var char_4 = [ '午饭要好好吃哇，幸福是吃到饱。', '一份可口的午餐，可以补充作战的体力哦。', '工作再忙，午餐必不可少哦。',
			'吃饭的时候最好不要盯着电脑哦。', '做个快乐的吃货吧！' ];
	var char_5 = [ '午后一杯红茶，偷得片刻惬意。', '歇一歇吧，享受午后时光。', '下午茶时间到啦   : )',
			'喝喝茶，提提神。', '抬眼硬拗三分困，不及午后一盏茶。' ];
	var char_6 = [ '晚饭有着落了吗？赶紧约起！', '华灯初上，谁在等你，你又在等谁？', '晚上好，要对自己的胃好一些哦。',
			'万家灯火中，总有一盏为你点亮。', '夜幕降落，霓红灯亮起，城市迎来另一种喧闹。' ];
	var char_7 = [ '还在忙吗，别忘了给自己一个微笑。', '在忙吗，是否该问候一下远方的TA？', '操劳了一日工作，别忘了陪陪家人。',
			'今天累不累？停下来听首歌吧。', '今天运动了没？打字不算哦: )' ];
	var char_8 = [ '深夜了，不知道有多少人和你一样还没有睡呢？', '夜深了，来日方长，早点休息。',
			'不要活得太累，不要忙得太疲惫。', '愿与您分享这夜色，早点休息   : )', '还在熬夜的您，让我为您点一盏灯。' ];

	var num = Math.floor(Math.random() * 4);


	now = new Date(), hour = now.getHours();
	if (hour < 6) {
		$('#welcomeInfo').append("凌晨好！  " + "<span style='color:#fcdd09'>${userName}</span>，  " + char_1[num]);
	} else if (hour < 9) {
		$('#welcomeInfo').append("早上好！  " + "<span style='color:#fcdd09'>${userName}</span>，  " + char_2[num]);
	} else if (hour < 12) {
		$('#welcomeInfo').append("上午好！  " + "<span style='color:#fcdd09'>${userName}</span>，  " + char_3[num]);
	} else if (hour < 14) {
		$('#welcomeInfo').append("中午好！  " + "<span style='color:#fcdd09'>${userName}</span>，  " + char_4[num]);
	} else if (hour < 17) {
		$('#welcomeInfo').append("下午好！  " + "<span style='color:#fcdd09'>${userName}</span>，  " + char_5[num]);
	} else if (hour < 19) {
		$('#welcomeInfo').append("傍晚好！  " + "<span style='color:#fcdd09'>${userName}</span>，  " + char_6[num]);
	} else if (hour < 22) {
		$('#welcomeInfo').append("晚上好！  " + "<span style='color:#fcdd09'>${userName}</span>，  " + char_7[num]);
	} else {
		$('#welcomeInfo').append("夜里好！  " + "<span style='color:#fcdd09'>${userName}</span>，  " + char_8[num]);
	}
</script>
