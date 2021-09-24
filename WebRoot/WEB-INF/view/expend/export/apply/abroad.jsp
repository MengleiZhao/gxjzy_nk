<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta name="ProgId" content="Excel.Sheet"/>
  <meta name="Generator" content="WPS Office ET"/>
  
<!-- jquery.min.js   -->
<script type="text/javascript" src="${base}/resource/ui/jquery.min.js"></script>
<!-- jquery.js  -->
<script type="text/javascript" src="${base}/resource/js/jquery.js"></script>
<!-- jquery二维码  -->
<script type="text/javascript" src="${base}/resource-now/js/qrcode.js"></script>
<!-- jquery生成二维码  -->
<script type="text/javascript" src="${base}/resource-now/js/jquery.qrcode.min.js"></script>
  <!--[if gte mso 9]>
   <xml>
    <o:DocumentProperties>
     <o:Author>202019504</o:Author>
     <o:Created>2020-11-12T14:57:54</o:Created>
     <o:LastAuthor>余海波</o:LastAuthor>
     <o:LastSaved>2020-11-14T18:25:29</o:LastSaved>
    </o:DocumentProperties>
    <o:CustomDocumentProperties>
     <o:KSOProductBuildVer dt:dt="string">2052-11.1.0.10132</o:KSOProductBuildVer>
    </o:CustomDocumentProperties>
   </xml>
  <![endif]-->
  <style>
<!-- @page
	{margin:1.00in 0.75in 1.00in 0.75in;
	mso-header-margin:0.50in;
	mso-footer-margin:0.50in;}
tr
	{mso-height-source:auto;
	mso-ruby-visibility:none;}
col
	{mso-width-source:auto;
	mso-ruby-visibility:none;}
br
	{mso-data-placement:same-cell;}
.font0
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font1
	{color:#000000;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font2
	{color:#000000;
	font-size:22.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:#000000;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:#000000;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Microsoft JhengHei Light";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:#000000;
	font-size:1.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Microsoft JhengHei Light";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font9
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font12
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font13
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font19
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font20
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font21
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font22
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font24
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font25
	{color:#000000;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.style0
	{mso-number-format:"General";
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"常规";
	mso-style-id:0;}
.style16
	{mso-number-format:"_ \\¥* \#\,\#\#0_ \;_ \\¥* \\-\#\,\#\#0_ \;_ \\¥* \0022-\0022_ \;_ \@_ ";
	mso-style-name:"货币[0]";
	mso-style-id:7;}
.style17
	{mso-pattern:auto none;
	background:#EDEDED;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"20% - 强调文字颜色 3";}
.style18
	{mso-pattern:auto none;
	background:#FFCC99;
	color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	border:.5pt solid #7F7F7F;
	mso-style-name:"输入";}
.style19
	{mso-number-format:"_ \\¥* \#\,\#\#0\.00_ \;_ \\¥* \\-\#\,\#\#0\.00_ \;_ \\¥* \0022-\0022??_ \;_ \@_ ";
	mso-style-name:"货币";
	mso-style-id:4;}
.style20
	{mso-number-format:"_ * \#\,\#\#0_ \;_ * \\-\#\,\#\#0_ \;_ * \0022-\0022_ \;_ \@_ ";
	mso-style-name:"千位分隔[0]";
	mso-style-id:6;}
.style21
	{mso-pattern:auto none;
	background:#DBDBDB;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"40% - 强调文字颜色 3";}
.style22
	{mso-pattern:auto none;
	background:#FFC7CE;
	color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"差";}
.style23
	{mso-number-format:"_ * \#\,\#\#0\.00_ \;_ * \\-\#\,\#\#0\.00_ \;_ * \0022-\0022??_ \;_ \@_ ";
	mso-style-name:"千位分隔";
	mso-style-id:3;}
.style24
	{mso-pattern:auto none;
	background:#C9C9C9;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 3";}
.style25
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"超链接";
	mso-style-id:8;}
.style26
	{mso-number-format:"0%";
	mso-style-name:"百分比";
	mso-style-id:5;}
.style27
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"已访问的超链接";
	mso-style-id:9;}
.style28
	{mso-pattern:auto none;
	background:#FFFFCC;
	border:.5pt solid #B2B2B2;
	mso-style-name:"注释";}
.style29
	{mso-pattern:auto none;
	background:#F4B084;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 2";}
.style30
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	mso-style-name:"标题 4";}
.style31
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"警告文本";}
.style32
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	mso-style-name:"标题";}
.style33
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"解释性文本";}
.style34
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border-bottom:1.0pt solid #5B9BD5;
	mso-style-name:"标题 1";}
.style35
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border-bottom:1.0pt solid #5B9BD5;
	mso-style-name:"标题 2";}
.style36
	{mso-pattern:auto none;
	background:#9BC2E6;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 1";}
.style37
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border-bottom:1.0pt solid #ACCCEA;
	mso-style-name:"标题 3";}
.style38
	{mso-pattern:auto none;
	background:#FFD966;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 4";}
.style39
	{mso-pattern:auto none;
	background:#F2F2F2;
	color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	border:.5pt solid #3F3F3F;
	mso-style-name:"输出";}
.style40
	{mso-pattern:auto none;
	background:#F2F2F2;
	color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	border:.5pt solid #7F7F7F;
	mso-style-name:"计算";}
.style41
	{mso-pattern:auto none;
	background:#A5A5A5;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	border:2.0pt double #3F3F3F;
	mso-style-name:"检查单元格";}
.style42
	{mso-pattern:auto none;
	background:#E2EFDA;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"20% - 强调文字颜色 6";}
.style43
	{mso-pattern:auto none;
	background:#ED7D31;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"强调文字颜色 2";}
.style44
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	border-bottom:2.0pt double #FF8001;
	mso-style-name:"链接单元格";}
.style45
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	border-top:.5pt solid #5B9BD5;
	border-bottom:2.0pt double #5B9BD5;
	mso-style-name:"汇总";}
.style46
	{mso-pattern:auto none;
	background:#C6EFCE;
	color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"好";}
.style47
	{mso-pattern:auto none;
	background:#FFEB9C;
	color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"适中";}
.style48
	{mso-pattern:auto none;
	background:#D9E1F2;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"20% - 强调文字颜色 5";}
.style49
	{mso-pattern:auto none;
	background:#5B9BD5;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"强调文字颜色 1";}
.style50
	{mso-pattern:auto none;
	background:#DDEBF7;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"20% - 强调文字颜色 1";}
.style51
	{mso-pattern:auto none;
	background:#BDD7EE;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"40% - 强调文字颜色 1";}
.style52
	{mso-pattern:auto none;
	background:#FCE4D6;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"20% - 强调文字颜色 2";}
.style53
	{mso-pattern:auto none;
	background:#F8CBAD;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"40% - 强调文字颜色 2";}
.style54
	{mso-pattern:auto none;
	background:#A5A5A5;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"强调文字颜色 3";}
.style55
	{mso-pattern:auto none;
	background:#FFC000;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"强调文字颜色 4";}
.style56
	{mso-pattern:auto none;
	background:#FFF2CC;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"20% - 强调文字颜色 4";}
.style57
	{mso-pattern:auto none;
	background:#FFE699;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"40% - 强调文字颜色 4";}
.style58
	{mso-pattern:auto none;
	background:#4472C4;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"强调文字颜色 5";}
.style59
	{mso-pattern:auto none;
	background:#B4C6E7;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"40% - 强调文字颜色 5";}
.style60
	{mso-pattern:auto none;
	background:#8EA9DB;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 5";}
.style61
	{mso-pattern:auto none;
	background:#70AD47;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"强调文字颜色 6";}
.style62
	{mso-pattern:auto none;
	background:#C6E0B4;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"40% - 强调文字颜色 6";}
.style63
	{mso-pattern:auto none;
	background:#A9D08E;
	color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 6";}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	mso-number-format:"General";
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	font-size:14.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-bottom:.5pt dashed windowtext;
	border-bottom-style:dot-dash;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	font-size:14.0pt;
	mso-font-charset:134;
	border-bottom:.5pt dashed windowtext;
	border-bottom-style:dot-dash;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	font-size:22.0pt;
	font-weight:700;
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	font-family:Microsoft JhengHei Light;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-family:宋体;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:1.0pt;
	font-family:Microsoft JhengHei Light;
	mso-font-charset:134;}
 -->  </style>
  <!--[if gte mso 9]>
   <xml>
    <x:ExcelWorkbook>
     <x:ExcelWorksheets>
      <x:ExcelWorksheet>
       <x:Name>Sheet1</x:Name>
       <x:WorksheetOptions>
        <x:DefaultRowHeight>270</x:DefaultRowHeight>
        <x:Selected/>
        <x:TopRowVisible>3</x:TopRowVisible>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>1</x:ActiveCol>
          <x:ActiveRow>19</x:ActiveRow>
          <x:RangeSelection>B20:E20</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:CodeName>Sheet1</x:CodeName>
        <x:DoNotDisplayGridlines/>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:ShowPageBreakZoom/>
        <x:PageBreakZoom>50</x:PageBreakZoom>
        <x:Zoom>70</x:Zoom>
        <x:Print>
         <x:ValidPrinterInfo/>
         <x:PaperSizeIndex>9</x:PaperSizeIndex>
         <x:Scale>79</x:Scale>
        </x:Print>
       </x:WorksheetOptions>
      </x:ExcelWorksheet>
     </x:ExcelWorksheets>
     <x:ProtectStructure>False</x:ProtectStructure>
     <x:ProtectWindows>False</x:ProtectWindows>
     <x:SelectedSheets>0</x:SelectedSheets>
     <x:WindowHeight>7860</x:WindowHeight>
     <x:WindowWidth>19815</x:WindowWidth>
    </x:ExcelWorkbook>
   </xml>
  <![endif]-->
 </head>
 <body vlink="purple">
  <table width="844" border="0" cellpadding="0" cellspacing="0" style='width:633.00pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="184" style='mso-width-source:userset;mso-width-alt:5888;'/>
   <col width="148" span="2" style='mso-width-source:userset;mso-width-alt:4736;'/>
   <col width="146" style='mso-width-source:userset;mso-width-alt:4672;'/>
   <col width="218" style='mso-width-source:userset;mso-width-alt:6976;'/>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl65" height="40" width="844" colspan="5" style='height:30.00pt;width:633.00pt;border-right:none;border-bottom:.5pt dashed windowtext;border-bottom-style:dot-dash;' x:str>装订线</td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
	    <td class="xl67" height="138.67" colspan="4" style='padding-left: 250px;height:104.00pt;border-right:none;border-bottom:none;' x:str>因公出国（境）申请表</td>
   		<td style="text-align: center;" id="applyAbroad"></td>
   </tr>
   <tr height="52" style='height:39.00pt;mso-height-source:userset;mso-height-alt:780;'>
    <td class="xl69" height="52" style='height:39.00pt;' x:str>经办人：</td>
    <td class="xl70">${bean.userNames }</td>
    <td class="xl71"></td>
    <td class="xl69" x:str>申请时间：</td>
    <td class="xl70">${time }</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>申请部门</td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.deptName}</td>
    <td class="xl72" x:str>申请总金额</td>
    <td class="xl73"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${bean.amount }" /></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>项目名称（编号）</td>
    <td class="xl74" colspan="2"  style='text-align:center;border-right:none;border-bottom:.5pt solid windowtext;'><c:if test="${pro.FProOrBasic==1 }">${bean.proDetailName }</c:if></td>
    <td class="xl75" x:str>项目负责人：</td>
    <td class="xl76"><c:if test="${pro.FProOrBasic==1 }">${bean.proCharger }</c:if></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>申请事由</td>
    <td class="xl73" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.reason }</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="97.33" rowspan="2" style='height:73.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>出访国家<br/>（含经停）</td>
    <td class="xl77" colspan="4" rowspan="2" style='text-align:center;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.arriveCountry }</td>
   </tr>
   <tr height="44" style='height:33.00pt;mso-height-source:userset;mso-height-alt:660;'/>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="106.67" rowspan="2" style='height:80.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>出行方式</td>
    <td class="xl78" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str><input readonly="readonly" disabled="disabled" type="checkbox" <c:if test="${!empty airplane}">checked="checked"</c:if>>飞机（等级：<span style='mso-spacerun:yes;'>${airplaneLevel}</span>） <input readonly="readonly" disabled="disabled" type="checkbox" <c:if test="${!empty ship}">checked="checked"</c:if>>轮船（等级：<span style='mso-spacerun:yes;'>${shipLevel}</span>） <input readonly="readonly" disabled="disabled" type="checkbox" <c:if test="${!empty train}">checked="checked"</c:if>>火车（等级：<span style='mso-spacerun:yes;'>${trainLevel}</span>）</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl80" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><input readonly="readonly" disabled="disabled" type="checkbox" <c:if test="${!empty otherTraffic}">checked="checked"</c:if>>其他（ ${otherTrafficLevel}）</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>出国时间</td>
    <td class="xl85"   colspan="4" style='text-align: center;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>
    <fmt:formatDate value="${abroad.fAbroadDateStart }" pattern="yyyy年MM月dd日"/>-<fmt:formatDate value="${abroad.fAbroadDateEnd }" pattern="yyyy年MM月dd日"/>&nbsp;共<span style='mso-spacerun:yes;'>${day }</span>天</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>出访路线和计划</td>
    <td class="xl85" colspan="4" style='text-align: center;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.arrivePlan }</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" colspan="5" style='height:40.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>出国人员信息</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>姓名</td>
    <td class="xl72" x:str>身份证号</td>
    <td class="xl72" x:str>护照号</td>
    <td class="xl72" x:str>职务</td>
    <td class="xl72" x:str>联系方式</td>
   </tr>
   <c:if test="${!empty abroadPeopleList }">
   	<c:forEach var="i" items="${abroadPeopleList }">
	   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
	    <td class="xl73" height="53.33" style='height:40.00pt;'>${i.travelPeopName }</td>
	    <td class="xl73" style="word-wrap: break-word;">${i.idCard }</td>
	    <td class="xl73" style="word-wrap: break-word;">${i.fPassport }</td>
	    <td class="xl73" style="word-wrap: break-word;">${i.position }</td>
	    <td class="xl73" style="word-wrap: break-word;">${i.phoneNum }</td>
	   </tr>
      </c:forEach>
   </c:if>
   <c:if test="${empty abroadPeopleList }">
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl73" height="53.33" style='height:40.00pt;'>-</td>
    <td class="xl73">-</td>
    <td class="xl73">-</td>
    <td class="xl73">-</td>
    <td class="xl73">-</td>
   </tr>
   </c:if>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>部门负责人</td>
    <td class="xl87">${role1 }</td>
    <td class="xl72" x:str>国际交流处</td>
    <td class="xl87" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2 }</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>主管校长</td>
    <td class="xl87">${role3 }</td>
    <td class="xl72" x:str>校长</td>
    <td class="xl87" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role4 }</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>校长办公会</td>
    <td class="xl72" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>附<font class="font25"><span style='mso-spacerun:yes;'>&nbsp;${bean.meetingSummaryYear1 }&nbsp;</span></font><font class="font3">年第</font><font class="font25"><span style='mso-spacerun:yes;'>&nbsp;${bean.meetingSummaryTime1 }&nbsp;</span></font><font class="font3">次会议纪要</font></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl72" height="53.33" style='height:40.00pt;' x:str>党委会</td>
    <td class="xl72" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>附<font class="font25"><span style='mso-spacerun:yes;'>&nbsp;${bean.meetingSummaryYear2 }&nbsp;</span></font><font class="font3">年第</font><font class="font25"><span style='mso-spacerun:yes;'>&nbsp;${bean.meetingSummaryTime2 }&nbsp;</span></font><font class="font3">次会议纪要</font></td>
   </tr>
   <tr height="18" style='height:13.50pt;'>
    <td height="18" colspan="5" style='height:13.50pt;mso-ignore:colspan;'></td>
   </tr>
   <tr height="18" style='height:13.50pt;'>
    <td class="xl88" height="18" style='height:13.50pt;'></td>
    <td colspan="4" style='mso-ignore:colspan;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="184" style='width:138;'></td>
     <td width="148" style='width:111;'></td>
     <td width="146" style='width:110;'></td>
     <td width="218" style='width:164;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">
  $(document).ready(function() {
	 	$('#applyAbroad').qrcode({
	 			render: "canvas",
	 			width   : 100,     //设置宽度  
	 			height  : 100, 
	 			x: 200, y: 100,
	 			text:'${urlbase}/expendPrintDetail?id='+${bean.gId}+'&type=apply'
	 	});
		/* window.print(); */
	}); 
  
  </script>
 </body>
</html>
