<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="bd" style="width:89%;">
		<div class="sidebar">
			<div class="sidebar-bg"></div>
				<i class="sidebar-hide"></i>
				<h2>
					<a href="javascript:;"><i class="h2-icon" title="切换到树型结构"></i><span>安全管理</span></a>
				</h2>
				<ul class="nav">
					<li class="nav-li current"><a href="javascript:;" class="ue-clear"><i
							class="nav-ivon"></i><span class="nav-text">项目库管理</span></a>
						<ul class="subnav">
							<li class="subnav-li current"
								href="${base}/project/list" data-id="8"><a
								href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">申报库</span></a></li>
						
							<li class="subnav-li" href="${base}/main/index.jsp" data-id="9"><a
								href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">备选库</span></a></li>
							<li class="subnav-li" href="" data-id="10"><a
								href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">执行库</span></a></li>
							<li class="subnav-li" data-id="11"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">结转库</span></a></li>
						</ul></li>
					<li class="nav-li"><a href="javascript:;"
						class="ue-clear"><i class="nav-ivon"></i><span
							class="nav-text">预算控制数（一下）</span></a>
						<ul class="subnav">
							<li class="subnav-li" href="" data-id="1"><a
								href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">首页</span></a></li>
							<li class="subnav-li" href="form.html" data-id="2"><a
								href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">表单</span></a></li>
							<li class="subnav-li" href="table.html" data-id="3"><a
								href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">表格</span></a></li>
							<li class="subnav-li" data-id="4"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">自定义设置2</span></a></li>
						</ul></li>
					<li class="nav-li"><a href="javascript:;" class="ue-clear"><i
							class="nav-ivon"></i><span class="nav-text">工作安排</span></a>
						<ul class="subnav">
							<li class="subnav-li" data-id="5"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">工作安排查询1</span></a></li>
							<li class="subnav-li" data-id="6"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">安排管理1</span></a></li>
							<li class="subnav-li" data-id="7"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">类型选择1</span></a></li>
						</ul></li>
					<li class="nav-li last-nav-li"><a href="javascript:;"
						class="ue-clear"><i class="nav-ivon"></i><span
							class="nav-text">数据管理</span></a>
						<ul class="subnav">
							<li class="subnav-li" data-id="12"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">工作安排查询2</span></a></li>
							<li class="subnav-li" data-id="13"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">安排管理2</span></a></li>
							<li class="subnav-li" data-id="14"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">类型选择2</span></a></li>
						</ul></li>
					<li class="nav-li last-nav-li"><a href="javascript:;"
						class="ue-clear"><i class="nav-ivon"></i><span
							class="nav-text">事前申请</span></a>
						<ul class="subnav">
							<li class="subnav-li"
							 data-id="79" ><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">申请（菜单）</span></a></li>
									
							<li class="subnav-li"
							href="${base}/apply/list/1" data-id="80" ><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">通用事前申请</span></a></li>
							<li class="subnav-li"
							href="${base}/apply/list/2" data-id="81" ><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">会议申请</span></a></li>
							<li class="subnav-li"
							href="${base}/apply/list/3" data-id="82" ><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">培训申请</span></a></li>
							<li class="subnav-li"
							href="${base}/apply/list/4" data-id="83" ><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">差旅申请</span></a></li>
							<li class="subnav-li"
							href="${base}/apply/list/5" data-id="84" ><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">接待申请</span></a></li>
									
									
							<li class="subnav-li" data-id="85"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">审批</span></a></li>
							<li class="subnav-li" data-id="86"><a href="javascript:;"
								class="ue-clear"><i class="subnav-icon"></i><span
									class="subnav-text">台账</span></a></li>
						</ul></li>
					<li class="nav-li last-nav-li"><a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span class="nav-text">合同拟定</span></a>
						<ul class="subnav">
							<li class="subnav-li" href="${base}/Formulation/list" data-id="93" >
								<a href="javascript:;"class="ue-clear"><i class="subnav-icon"></i><span class="subnav-text">合同拟定</span></a>
							</li>
							<li class="subnav-li" href="${base}/Approval/list" data-id="94">
								<a href="javascript:;" class="ue-clear"><i class="subnav-icon"></i><span class="subnav-text">合同拟定审批</span></a>
							</li>
						</ul>
					</li>
					<li class="nav-li last-nav-li"><a href="javascript:;" class="ue-clear"><i class="nav-ivon"></i><span class="nav-text">合同备案</span></a>
						<ul class="subnav">
							<li class="subnav-li" href="${base}/Filing/list" data-id="95" >
								<a href="javascript:;"class="ue-clear"><i class="subnav-icon"></i><span class="subnav-text">合同备案</span></a>
							</li>
						</ul>
					</li>
				</ul>
				<div class="tree-list outwindow">
					<div class="tree ztree"></div>
				</div>
			</div>
			<div class="main">
				<div class="title">
					<i class="sidebar-show"></i>
					<ul class="tab ue-clear">

					</ul>
					<i class="tab-more"></i> <i class="tab-close"></i>
				</div>
				<div class="content"></div>
			</div>
		</div>
