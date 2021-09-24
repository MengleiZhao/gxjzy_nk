<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">

	<h1>经济科目管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/YearsBsaic/mainList"> 
		<h2 onclick="addTabs('年度科目模板管理','${base}/YearsBsaic/mainList');">年度科目模板管理</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/yearsUnionBasic/list">
		<h2 onclick="addTabs('年度科目树管理','${base}/yearsUnionBasic/list');">年度科目树管理</h2>
		<div></div>
		</gwideal:perm>
		<gwideal:perm url="/yearsUnionBasic/ecBasicOrDepart">
		<h2 onclick="addTabs('部门科目配置管理','${base}/yearsUnionBasic/ecBasicOrDepart');">部门科目配置管理</h2>
		<div></div>
		</gwideal:perm>
	</div>

	<h1>会计科目管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/accoYear/mainList"> 
		<h2 onclick="addTabs('年度科目模板管理','${base}/accoYear/mainList');">年度科目模板管理</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/accoTree/list">
		<h2 onclick="addTabs('年度科目树管理','${base}/accoTree/list');">年度科目树管理</h2>
		<div></div>
		</gwideal:perm> 
	</div>

	<%-- <gwideal:perm url="/jcsjgl/finctionclassmgrgl"> 
	<h1>功能科目管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/finctionclassmgrgl/list"> 
		<h2 onclick="addTabs('功能分类科目管理','${base}/finctionclassmgrgl/list');">功能分类科目管理</h2>
		<div></div>
		</gwideal:perm>
	</div>
	</gwideal:perm> --%>

	<h1>流程配置管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/wflow/list">
		<h2 onclick="addTabs('流程配置','${base}/wflow/list');">流程配置</h2>
		<div></div> 
		</gwideal:perm>

		<gwideal:perm url="/Monitoring/list"> 
		<h2 onclick="addTabs('流程监控','${base}/Monitoring/list');">流程监控</h2>
		<div></div> 
		</gwideal:perm>	
	</div>

	<gwideal:perm url="/systemcentergl/list?menuMark=fromMenu"> 
	<h1 onclick="addTabs('制度中心管理','${base}/systemcentergl/list?menuMark=fromMenu');">制度中心管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/zdzxglnav"> 
		<h2 onclick="addTabs('制度中心管理','${base}/systemcentergl/list?menuMark=fromMenu');">制度中心管理</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/notice/list"> 
	<h1 onclick="addTabs('公告管理','${base}/notice/list');">公告管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/ggglnav">
		<h2 onclick="addTabs('公告管理','${base}/notice/list');">公告管理</h2>
		<div></div> 
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>

	<gwideal:perm url="/ProMgrLevel/list"> 
	<h1 onclick="addTabs('一二级分类管理','${base}/ProMgrLevel/list');">一二级分类管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/yejxmglnav"> 
		<h2 onclick="addTabs('一二级分类管理','${base}/ProMgrLevel/list');">一二级分类管理</h2>
		<div></div>  
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/purchaseCatagl/list"> 
	<h1 onclick="addTabs('采购目录管理','${base}/purchaseCatagl/list');">采购目录管理</h1>
	<%-- <div class="opened-for-codepen">
		<gwideal:perm url="/cgmlglnav"> 
		<h2 onclick="addTabs('采购目录管理','${base}/purchaseCatagl/list');">采购目录管理</h2>
		<div></div>
		</gwideal:perm>
	</div> --%>
	<div></div>
	</gwideal:perm>
	
	<h1>支出事项管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/ExpenditureMatter/list"> 
		<h2 onclick="addTabs('支出事项管理','${base}/ExpenditureMatter/list');">支出事项管理</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/vehicle/list"> 
		<h2 onclick="addTabs('交通工具维护','${base}/vehicle/list');">交通工具维护</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/area/list">
		<h2 onclick="addTabs('省市地区维护','${base}/area/list');">省市地区维护</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/hotelStandard/list?outType=travel">
		<h2 onclick="addTabs('差旅费配置','${base}/hotelStandard/list?outType=travel');">差旅费配置</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/hotelStandard/list?outType=meet">
		<h2 onclick="addTabs('会议费配置','${base}/hotelStandard/list?outType=meet');">会议费配置</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/hotelStandard/list?outType=train">
		<h2 onclick="addTabs('培训费配置','${base}/hotelStandard/list?outType=train');">培训费配置</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/hotelStandard/list?outType=recep">
		<h2 onclick="addTabs('公务接待费用配置','${base}/hotelStandard/list?outType=recep');">公务接待费用配置</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/hotelStandard/list?outType=aboard">
		<h2 onclick="addTabs('出国经费配置','${base}/hotelStandard/list?outType=aboard');">出国经费配置</h2>
		<div></div>
		</gwideal:perm>
	</div>
	<gwideal:perm url="/backups/list">
	<h1 onclick="addTabs('数据备份管理','${base}/backups/list');">数据备份管理</h1>
	<div></div>
	</gwideal:perm>
	
	<gwideal:perm url="/PerformanceIndicator/list"> 
	<h1 onclick="addTabs('绩效指标管理','${base}/PerformanceIndicator/list');">绩效指标管理</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/jxzbglnav"> 
		<h2 onclick="addTabs('绩效指标管理','${base}/PerformanceIndicator/list');">绩效指标管理</h2>
		<div></div>
		</gwideal:perm>
	</div>
	<div></div>
	</gwideal:perm> 
</aside>
