<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>


<aside class="menu-accordion">

	<%-- <h1>大项目管理</h1>
	<div class="opened-for-codepen">
		
		<h2>子项目申报</h2>
		<div class="opened-for-codepen">
			<gwideal:perm url="/project/zxmList"> 
			<h3 onclick="addTabs('子项目申请','${base}/project/list?proLibType=5&sbkLx=zxmsb&fproOrBasic=2');">子项目申请</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/project/zxmCheckList">
			<h3 onclick="addTabs('子项目审批','${base}/project/list?proLibType=5&sbkLx=zxmsp&FFlowStauts=11');">子项目审批</h3>
			<div></div>
			</gwideal:perm>
			
		</div>
		
		
		<gwideal:perm url="/project/zxmLegerList"> 
		<h2 onclick="addTabs('子项目台账','${base}/project/list?sbkLx=zxmtz');">子项目台账</h2>
		<div></div>
		</gwideal:perm>
		
	</div> --%>


	<h1>项目库管理</h1>
	<div class="opened-for-codepen">
		<h2>备选库</h2>
		<div class="opened-for-codepen">
			<gwideal:perm url="/project/basicExpInfolist?proLibType=1&sbkLx=xmsb&fproOrBasic=0"> 
			<h3 onclick="addTabs('基本支出申报','${base}/project/basicExpInfolist?proLibType=1&sbkLx=xmsb&fproOrBasic=0');">基本支出申报</h3>
			<div></div>
			</gwideal:perm>
				
			<gwideal:perm url="/project/list?proLibType=1&sbkLx=xmsb&fproOrBasic=1"> 
			<h3 onclick="addTabs('项目申报','${base}/project/list?proLibType=1&sbkLx=xmsb&fproOrBasic=1');">项目申报</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/project/list?proLibType=1&sbkLx=xmsp&FFlowStauts=11"> 
			<h3 onclick="addTabs('预算审批','${base}/project/list?proLibType=1&sbkLx=xmsp&FFlowStauts=11');">预算审批</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/project/approvalRecordlist"> 
			<h3 onclick="addTabs('审批记录','${base}/project/approvalRecordlist');">审批记录</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/project/list?sbkLx=xmtz"> 
			<h3 onclick="addTabs('预算台账','${base}/project/list?sbkLx=xmtz');">预算台账</h3>
			<div></div>
			</gwideal:perm>
			
		</div>
		
		<h2>上报库</h2>
		<div class="opened-for-codepen">
			<gwideal:perm url="/projectReview/list"> 
			<h3 onclick="addTabs('项目评审','${base}/projectReview/list');">项目评审</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/declare/list?type=essb">
			<h3 onclick="addTabs('二上申报','${base}/declare/list?type=essb');">二上申报</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/declare/list?type=essp">
			<h3 onclick="addTabs('二上审批','${base}/declare/list?type=essp');">二上审批</h3>
			<div></div>
			</gwideal:perm>
		</div>
		
		<h2>执行库</h2>
		<div class="opened-for-codepen">
			<gwideal:perm url="/project/list?proLibType=3&sbkLx=myzxk"> 
			<h3 onclick="addTabs('我的执行项目','${base}/project/list?proLibType=3&sbkLx=myzxk');">我的执行项目</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/projectknot/list">
			<h3 onclick="addTabs('项目完结审批','${base}/projectknot/list');">项目完结审批</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/project/list?proLibType=3&sbkLx=zxk">
			<h3 onclick="addTabs('执行项目台账','${base}/project/list?proLibType=3&sbkLx=zxk');">执行项目台账</h3>
			<div></div>
			</gwideal:perm>
		</div>
		
		<gwideal:perm url="/project/list?proLibType=4&sbkLx=wjk"> 
		<h2 onclick="addTabs('完结库','${base}/project/list?proLibType=4&sbkLx=wjk');">完结库</h2>
		<div></div>
		</gwideal:perm>
		
		<%-- <h2>数据分析</h2>
		<div class="opened-for-codepen">
			<h3>申报过程</h3>
			<div class="opened-for-codepen">
				<gwideal:perm url="/bData/dataAnalysisJsp"> 
				<h4 onclick="addTabs('报表一','${base}/bData/dataAnalysisJsp');">报表一</h4>
				<div></div>
				</gwideal:perm>
				
				<gwideal:perm url="/bData/reportCollectJsp">
				<h4 onclick="addTabs('报表二','${base}/bData/reportCollectJsp');">报表二</h4>
				<div></div>
				</gwideal:perm>
				<gwideal:perm url="/bData/threeCollectJsp?sign=0">
				<h4 onclick="addTabs('报表三','${base}/bData/threeCollectJsp?sign=0');">报表三</h4>
				<div></div>
				</gwideal:perm>
				<gwideal:perm url="/project/list?sbkLx=ysshoub"> 
				<h4 onclick="addTabs('报表收报','${base}/project/list?sbkLx=ysshoub');">报表收报</h4>
				<div></div>
				</gwideal:perm>
				<gwideal:perm url="/bData/sjfxJsp"> 
				<h4 onclick="addTabs('对比表','${base}/bData/sjfxJsp');">对比表</h4>
				<div></div>
				</gwideal:perm>
			</div>
			
			<h3>执行过程</h3>
			<div class="opened-for-codepen">
				<gwideal:perm url="/bData/firstExecuteJsp"> 
				<h4 onclick="addTabs('报表一','${base}/bData/firstExecuteJsp');">报表一</h4>
				<div></div>
				</gwideal:perm>
				
				<gwideal:perm url="/bData/secondExecuteJsp">
				<h4 onclick="addTabs('报表二','${base}/bData/secondExecuteJsp');">报表二</h4>
				<div></div>
				</gwideal:perm>
				<gwideal:perm url="/bData/threeCollectJsp?sign=1">
				<h4 onclick="addTabs('报表三','${base}/bData/threeCollectJsp?sign=1');">报表三</h4>
				<div></div>
				</gwideal:perm>
				<gwideal:perm url="/project/list?sbkLx=ysshoub"> 
				<h4 onclick="addTabs('报表收报','${base}/project/list?sbkLx=ysshoub');">报表收报</h4>
				<div></div>
				</gwideal:perm>
			</div>
		</div> --%>
	</div>
	
	<h1>预算指标管理 </h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/resolve/list">
		<h2 onclick="addTabs('预算控制数分解','${base}/resolve/list');">预算控制数分解</h2>
		<div></div>
		</gwideal:perm> 
	
		<gwideal:perm url="/quota/list">
		<h2 onclick="addTabs('预算指标生成','${base}/quota/list');">预算指标生成</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/transmit/list">
		<h2 onclick="addTabs('预算指标下达','${base}/transmit/list');">预算指标下达</h2>
		<div></div>
		</gwideal:perm>
		
		<h2>指标调整</h2>
		<div class="opened-for-codepen">
			<gwideal:perm url="/insideAdjust/list">
			<h3 onclick="addTabs('预算指标调整申请','${base}/insideAdjust/list');">预算指标调整申请</h3>
			<div></div>
			</gwideal:perm>
			
			<gwideal:perm url="/insideCheck/list">
			<h3 onclick="addTabs('预算指标调整申请','${base}/insideCheck/list');">预算指标调整审批</h3>
			<div></div>
			</gwideal:perm> 
			
			<%-- <gwideal:perm url="/insideLedger/list">
			<h3 onclick="addTabs('指标调整台账','${base}/insideLedger/list');">指标调整台账</h3>
			<div></div>
			</gwideal:perm>
			 
			 <gwideal:perm url="/insideAdjust/dataJsp">
			 <h3 onclick="addTabs('指标调整报表','${base}/insideAdjust/dataJsp');">指标调整报表</h3>
			<div></div>
			</gwideal:perm>
			<gwideal:perm url="/outsideAdjust/list">
			<h3 onclick="addTabs('外部调整申报','${base}/outsideAdjust/list');">外部调整申报</h3>
			<div></div>
			</gwideal:perm> 
			
			<gwideal:perm url="/outsideCheck/list">
			<h3 onclick="addTabs('外部调整审批','${base}/outsideCheck/list');">外部调整审批</h3>
			<div></div>
			</gwideal:perm> --%>
		</div>
	</div>
	
	<%-- <h1>预算绩效</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/pfmmonitor/list">
		<h2 onclick="addTabs('绩效监控','${base}/pfmmonitor/list');">绩效监控</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/selfevaluation/list?type=0">
		<h2 onclick="addTabs('绩效自评','${base}/selfevaluation/list?type=0');">绩效自评</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/selfevaluationrule/list">
		<h2 onclick="addTabs('自评规则配置','${base}/selfevaluationrule/list');">自评规则配置</h2>
		<div></div>
		</gwideal:perm> 
		
		<gwideal:perm url="/selfevaluation/list?type=1">
		<h2 onclick="addTabs('绩效自评台账','${base}/selfevaluation/list?type=1');">绩效自评台账</h2>
		<div></div>
		</gwideal:perm> 
	</div> --%>
	
	<h1>科研项目预算管理 </h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/researchProjects/list">
		<h2 onclick="addTabs('科研项目登记','${base}/researchProjects/list');">科研项目登记</h2>
		<div></div>
		</gwideal:perm> 
	
		<gwideal:perm url="/researchProjects/checkList">
		<h2 onclick="addTabs('科研项目登记审批','${base}/researchProjects/checkList');">科研项目登记审批</h2>
		<div></div>
		</gwideal:perm> 
	</div>
</aside>