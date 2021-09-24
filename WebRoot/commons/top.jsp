<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!--header start-->
<c:if test="${currentUser.hasRole('QU_ROLE')==true}">
	<div class="header auto">
	  <!--menu start-->
	  <div class="menubar">
	      <ul>
	         <li>
	              <dl>
	                 <dt><a href="${base}/index.do"><img src="${base}/resource/images/menu-1.png"  alt=""/></a></dt>
	                 <dt><a href="${base}/index.do">首页</a></dt>
	              </dl>
	         </li>
	         <li>
	               <dl>
	                  <dt><a href="${base}/stat/tjhz"><img src="${base}/resource/images/menu-2.png"  alt=""/></a></dt>
	                  <dt><a href="${base}/stat/tjhz">综合统计</a></dt>
	               </dl>
	         </li>
	         <li>
	                <dl>
	                   <dt><a href="${base}/stat/rytjhz"><img src="${base}/resource/images/menu-3.png"  alt=""/></a></dt>
	                   <dt><a href="${base}/stat/rytjhz">综合查询</a></dt>
	                </dl>
	         </li>
	         <li>
	                <dl>
	                    <dt><img src="${base}/resource/images/menu-4.png"  alt=""/></dt>
	                    <dt><a href="${base}/sqmynews/wlyq">舆情分析</a></dt>
	                </dl>
	         </li>
	         <li class="last">
	                 <dl>
	                    <dt><img src="${base}/resource/images/menu-5.png"  alt=""/></dt>
	                    <dt><a href="${base}/rkxx/rkDetail">街镇情况</a></dt>
	                 </dl>
	         </li>
	      </ul>
	  </div>
	  <!--menu end-->
	</div>
</c:if>
<c:if test="${currentUser.hasRole('QU_ROLE')==false}">
	   <c:if test="${currentUser.hasRole('JWH_ROLE')==false}">
			<div class="header-jz-${currentUser.street.streetCode}  auto">
				<div class="menu-new">
			      <ul>
			         <li>
			              <dl>
			                 <dt><img src="${base}/resource/images/menu-1.png"  alt=""/></dt>
			                 <dt><a href="${base}/streetIndex.do;">首页</a></dt>
			              </dl>
			         </li>
			       <gwideal:perm url="/stat/rytjhz">
			         <li class="last">
			                 <dl>
			                    <dt><img src="${base}/resource/images/menu-3.png"  alt=""/></dt>
			                    <dt><a href="${base}/stat/rytjhz">综合查询</a></dt>
			                 </dl>
			         </li>
			         </gwideal:perm>
			      </ul>
		       </div>
			</div>
	   </c:if>
       <c:if test="${currentUser.hasRole('JWH_ROLE')==true}">
			<div class="header-jwh-${currentUser.street.streetCode}  auto">
				<div class="menu-new">
			      <ul>
			         <li>
			              <dl>
			                 <dt><img src="${base}/resource/images/menu-1.png"  alt=""/></dt>
			                 <dt><a href="${base}/jwhIndex.do;">首页</a></dt>
			              </dl>
			         </li>
			       	<gwideal:perm url="/stat/rytjhz">
			         <li class="last">
			                 <dl>
			                    <dt><img src="${base}/resource/images/menu-3.png"  alt=""/></dt>
			                    <dt><a href="${base}/stat/rytjhz">综合查询</a></dt>
			                 </dl>
			         </li>
			         </gwideal:perm>
			      </ul>
		        </div>
			</div>
	</c:if>
</c:if>

<script type="text/javascript">
function search(){
	document.getElementById("pageForm").submit();
}
</script>
<!--header end-->