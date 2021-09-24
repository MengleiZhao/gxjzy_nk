<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta name="ProgId" content="Excel.Sheet"/>
  <meta name="Generator" content="WPS Office ET"/>
  <!-- jquery.js  -->
	<script type="text/javascript" src="${base}/resource/js/jquery.js"></script>
	<!-- jquery.min.js   -->
	<script type="text/javascript" src="${base}/resource/ui/jquery.min.js"></script>
	<!-- jquery二维码  -->
<script type="text/javascript" src="${base}/resource-now/js/qrcode.js"></script>
<!-- jquery生成二维码  -->
<script type="text/javascript" src="${base}/resource-now/js/jquery.qrcode.min.js"></script>
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
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font5
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font6
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font7
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font13
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font14
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font19
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font20
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font21
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font22
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	mso-font-charset:134;
	border-bottom:.5pt dashed windowtext;
	border-bottom-style:dot-dot-dash;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	text-align:left;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:right;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	font-family:宋体;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:right;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl84
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
 -->  </style>
  <!--[if gte mso 9]>
   <xml>
    <x:ExcelWorkbook>
     <x:ExcelWorksheets>
      <x:ExcelWorksheet>
       <x:Name>Sheet2</x:Name>
       <x:WorksheetOptions>
        <x:DefaultRowHeight>270</x:DefaultRowHeight>
        <x:Selected/>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>9</x:ActiveCol>
          <x:ActiveRow>7</x:ActiveRow>
          <x:RangeSelection>J8:K8</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:CodeName>Sheet1</x:CodeName>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:PageBreakZoom>100</x:PageBreakZoom>
        <x:Zoom>80</x:Zoom>
        <x:Print>
         <x:PaperSizeIndex>9</x:PaperSizeIndex>
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
 <body link="blue" vlink="purple">
  <table width="951.20" border="0" cellpadding="0" cellspacing="0" style='width:713.40pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="97" style='mso-width-source:userset;mso-width-alt:3104;'/>
   <col width="89" style='mso-width-source:userset;mso-width-alt:2848;'/>
   <col width="72" span="2" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="96" style='mso-width-source:userset;mso-width-alt:3072;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="97" style='mso-width-source:userset;mso-width-alt:3104;'/>
   <col width="116.20" style='mso-width-source:userset;mso-width-alt:3718;'/>
   <col width="96" style='mso-width-source:userset;mso-width-alt:3072;'/>
   <col width="72" span="2" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <tr height="36" style='height:27.00pt;mso-height-source:userset;mso-height-alt:540;'>
    <td class="xl65" height="36" width="951.20" colspan="11" style='height:27.00pt;width:713.40pt;border-right:none;border-bottom:.5pt dashed windowtext;border-bottom-style:dot-dot-dash;' x:str>装订线</td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl66" height="138.67" colspan="9" style='height:104.00pt;border-right:none;border-bottom:none;' x:str>因公出国（境）费用报账单</td>
	<td style="text-align: center;" colspan="2" id="reimburseAbroad"></td> 
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl67" height="46.67" style='height:35.00pt;' x:str>报账部门<font class="font3">：</font></td>
    <td class="xl68" colspan="4" style='border-right:none;border-bottom:none;'>${bean.deptName }</td>
    <td class="xl67" x:str>经办人<font class="font3">：</font></td>
    <td class="xl68" colspan="2" style='border-right:none;border-bottom:none;'>${bean.userName }</td>
    <td class="xl83" colspan="3" style='border-right:none;border-bottom:none;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl67" height="46.67" style='height:35.00pt;'></td>
    <td class="xl69" colspan="4" style='mso-ignore:colspan;'></td>
    <td class="xl67"></td>
    <td class="xl69" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl83" x:str>附件：</td>
    <td class="xl84"></td>
    <td class="xl83" x:str>张</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;' x:str>出国人员<font class="font3">：</font></td>
    <td class="xl71" colspan="7" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${abroadPeopleName}</td>
    <td class="xl70" x:str>出国人数<font class="font3">：</font></td>
    <td class="xl85" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${abroadEdit.fThisUnitTeamPersonNum}</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="2" style='height:35.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>出访国家（含经停）<font class="font3">：</font></td>
    <td class="xl71" colspan="9" style='text-align:center;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.arriveCountry }</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" style='height:35.00pt;' x:str>项目</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额</td>
    <td class="xl72" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>起止地点</td>
    <td class="xl72" x:str>项目</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>备注</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" style='height:35.00pt;' x:str>飞机票</td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${airplaneAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl73" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${airplaneStartAndEnd}</td>
    <td class="xl72" x:str>住宿费</td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${hotelExpenseInfoAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" style='height:35.00pt;' x:str>火车票</td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl73" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${trainStartAndEnd}</td>
    <td class="xl72" x:str>交通费</td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${outsideTrafficAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" style='height:35.00pt;' x:str>轮船票</td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${shipAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl73" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${shipStartAndEnd}</td>
    <td class="xl72" x:str>其他</td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${otherReimbAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" colspan="7" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>小计</td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${totalAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" colspan="2" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>启程</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>归程</td>
    <td class="xl72" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>天数</td>
    <td class="xl72" colspan="2" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>人数</td>
    <td class="xl72" colspan="2" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>标准</td>
    <td class="xl72" colspan="2" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" style='height:35.00pt;' x:str>月</td>
    <td class="xl72" x:str>日</td>
    <td class="xl72" x:str>月</td>
    <td class="xl72" x:str>日</td>
   </tr>
   
   <c:if test="${!empty abroadPlanList }">
   	<c:forEach var="i" items="${abroadPlanList }">
   		<tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
	    <td class="xl73" height="46.67" style='height:35.00pt;'>${i.startMonth}</td>
	    <td class="xl73">${i.startDay}</td>
	    <td class="xl73">${i.endMonth}</td>
	    <td class="xl73">${i.endDay}</td>
	    <td class="xl73">${i.dayNum}</td>
	    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.peopleNum}</td>
	    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.standardAmount}</td>
	    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.reimbAmount}</td>
	   </tr>
   	</c:forEach>
   </c:if>
   <c:if test="${empty abroadPlanList }">
	   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
	    <td class="xl73" height="46.67" style='height:35.00pt;'>-</td>
	    <td class="xl73">-</td>
	    <td class="xl73">-</td>
	    <td class="xl73">-</td>
	    <td class="xl73">-</td>
	    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	    <td class="xl73" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	   </tr>
   </c:if>
   
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="93.33" colspan="2" rowspan="2" style='height:70.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额合计</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>（小写）</td>
    <td class="xl73" colspan="7" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>（大写）</td>
    <td class="xl74" colspan="7" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.reimAmountcapital}</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" colspan="2" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>项目名称（编号）</td>
    <td class="xl75" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;'><c:if test="${pro.FProOrBasic==1 }">${bean.proDetailName }</c:if></td>
    <td class="xl76" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>项目负责人：</td>
    <td class="xl86" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><c:if test="${pro.FProOrBasic==1 }">${bean.proCharger }</c:if></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl77" height="46.67" colspan="3" style='height:35.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>归口管理部门审核意见：</td>
    <td class="xl78" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>归口管理部门负责人：</td>
    <td class="xl86" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role1 }</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl80" height="46.67" colspan="2" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>部门负责人</td>
    <td class="xl81" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2 }</td>
    <td class="xl80" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>主管校长</td>
    <td class="xl81" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role3 }</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" colspan="2" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>财务校长</td>
    <td class="xl73" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role4 }</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>校长</td>
    <td class="xl73" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role5 }</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl72" height="46.67" colspan="2" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>备注</td>
    <td class="xl73" colspan="9" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;' x:str>财务审核<font class="font3">：</font></td>
    <td class="xl78" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${financeCheck }</td>
    <td class="xl82" x:str>财务报销<font class="font3">：</font></td>
    <td class="xl78" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl82" x:str>领款人：</td>
    <td class="xl87" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="97" style='width:73;'></td>
     <td width="89" style='width:67;'></td>
     <td width="72" style='width:54;'></td>
     <td width="96" style='width:72;'></td>
     <td width="72" style='width:54;'></td>
     <td width="97" style='width:73;'></td>
     <td width="116" style='width:87;'></td>
     <td width="96" style='width:72;'></td>
     <td width="72" style='width:54;'></td>
    </tr>
   <![endif]>
  </table>
<script type="text/javascript">
	$(document).ready(function() {
		//生成二维码
	 	$('#reimburseAbroad').qrcode({
			render: "canvas",
			width   : 100,     //设置宽度  
			height  : 100, 
			x: 200, y: 100,
			text:'${urlbase}/expendPrintDetail?id='+${bean.rId}+'&type=reimburse'
		});
		window.setTimeout(function (){
			CloseAfterPrint();
		},500);
	});
	function CloseAfterPrint() {
		if (document.execCommand("print")) {
			window.open("${base}/exportApplyAndReim/requestApply?id="+${id});
			window.open("${base}/exportApplyAndReim/PastePage");
		} else {
			window.close();
		}
	}
</script>
  </body>
</html>
