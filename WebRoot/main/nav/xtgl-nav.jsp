<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<gwideal:perm url="/xtgl/yskmgl"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 预算科目管理</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/YearsBsaic/mainList"> 
		<li class="subnav-li" data-id="900" href="${base}/YearsBsaic/mainList"><a class="sanji" href="#" onclick="changeColor(this)"> 年度科目模板管理</a></li> 
		</gwideal:perm>
		<gwideal:perm url="/yearsUnionBasic/list">
		<li class="subnav-li" data-id="901" href="${base}/yearsUnionBasic/list"><a class="sanji" href="#" onclick="changeColor(this)"> 年度科目树管理</a></li> 
		</gwideal:perm> 
	</ul>
</li>
</gwideal:perm> 
<gwideal:perm url="/xtgl/lcpzgl"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 流程配置管理</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/wflow/list"> 
		<li class="subnav-li" data-id="902" href="${base}/wflow/list"><a class="sanji" href="#" onclick="changeColor(this)"> 流程配置</a></li> 
		</gwideal:perm>
	</ul>
</li>
</gwideal:perm> 
<gwideal:perm url="/xtgl/lcjkgl"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 流程监控管理</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/Monitoring/list"> 
		<li class="subnav-li" data-id="903" href="${base}/Monitoring/list"><a class="sanji" href="#" onclick="changeColor(this)"> 流程监控</a></li> 
		</gwideal:perm>
	</ul>
</li>
</gwideal:perm> 
<gwideal:perm url="/xtgl/suppliergl"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 供应商管理</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/suppliergl/list"> 
		<li class="subnav-li" data-id="904" href="${base}/suppliergl/list"><a class="sanji" href="#" onclick="changeColor(this)"> 供应商管理</a></li> 
		</gwideal:perm>
	</ul>
</li>
</gwideal:perm> 
<gwideal:perm url="/xtgl/expertgl"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 专家库管理</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/expertgl/list"> 
		<li class="subnav-li" data-id="905" href="${base}/expertgl/list"><a class="sanji" href="#" onclick="changeColor(this)"> 专家库管理</a></li> 
		</gwideal:perm>
	</ul>
</li>
</gwideal:perm> 
<gwideal:perm url="/xtgl/systemcentergl"> 
<li><a href="#" class="inactive" onclick="erji(this)"> 制度中心管理</a>
	<ul style="display: none" class="subnav">
		<gwideal:perm url="/systemcentergl/list"> 
		<li class="subnav-li" data-id="906" href="${base}/systemcentergl/list"><a class="sanji" href="#" onclick="changeColor(this)"> 制度中心管理</a></li> 
		</gwideal:perm>
	</ul>
</li>
</gwideal:perm> 
