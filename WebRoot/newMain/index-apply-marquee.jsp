<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
   <div class="list_lh" id="s2">
		<ul id="apply_ul" style="width: 100%; height: 100%;"></ul>
		<ul id="apply_ul2" style="width: 100%; height: 105%;"></ul>	
		</div>
<script type="text/javascript">
function applyMarquee(){
	$.ajax({
		url: base+ "/index/recentlyApply",
		type : 'post',
		async : true,
		dataType :'json',
	    contentType:'application/json;charset=UTF-8',
		success : function(json) {
				var html = "";
				var dName="";
				if(json!=null&&json.length>0){
				for( var i=0; i<json.length;i++){
					dName = json[i].dName;
					var id = json[i].id;
					var fAmount = json[i].fAmount;
					var type =json[i].dName;
					var fReqTime = json[i].fReqTime.toString().substring(0,10);
					var applyName = json[i].applyName;
					html += "<li class='list_li' style='float:left;'>";
					html += "<a href=\"#\" style='font-size:12px;font-family:MicrosoftYaHei;font-weight:bold; color:#666666' onclick=\"queryDetail('"+type+"',"+id+")\">";
					html += "<span style='margin-left: 4%;width: 50%;height: 40%'>"+applyName+"</span>";
					html += "<br><br><span id='apply7' class='div3'  style='float: left;height: 40%;margin-left: 4%;font-family:MicrosoftYaHei;font-weight:bold;color:#666666;'>¥"+fAmount+"</span>";
					html += "<span style='padding-top: 1.9%;font-weight:400;height: 40%;font-size:12px;font-family:MicrosoftYaHei;color:#999999;float: right;margin-right:4%'>"+fReqTime+"</span>";
					html += "</a>";
					html += "</li>";
				}
				}
				$("#apply_ul").append(html);
				//我的借款走马灯
				var speed = 50;    //数值越大滚动速度越慢			
				var demo = document.getElementById("s2");
				var demo1 = document.getElementById("apply_ul");
				var demo2 = document.getElementById("apply_ul2");
				demo2.innerHTML = demo1.innerHTML;							
				demo.scrollTop = demo.scrollHeight + 'px';
				function Marquee() {
					if(demo.scrollTop >= demo1.offsetHeight) {
					demo.scrollTop = 0;
					} else {
					demo.scrollTop = demo.scrollTop + 1;
					}
				}
				 /* function Marquee() {
					 if (demo2.offsetTop - demo.scrollTop <=0)    //当滚动至demo1与demo2交界时
			                demo.scrollTop -= demo1.offsetHeight;    //demo跳到最顶端
			            else {
			                demo.scrollTop++;
			            }
				 }; */
				 var MyMar = setInterval(Marquee, speed);
			     demo.onmouseover = function () { clearInterval(MyMar)};
			     demo.onmouseout = function () { MyMar = setInterval(Marquee, speed)};	
				
		}
	});
}

</script>
