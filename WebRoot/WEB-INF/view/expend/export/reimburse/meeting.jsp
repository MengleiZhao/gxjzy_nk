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
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font2
	{color:#BFBFBF;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font10
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font11
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font13
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font17
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
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
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font21
	{color:#FF0000;
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
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
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
	vertical-align:bottom;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	color:#BFBFBF;
	font-size:14.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt dashed windowtext;
	border-bottom-style:dot-dash;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#F2F2F2;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#F2F2F2;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	vertical-align:bottom;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl93
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#F2F2F2;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
 -->  </style>
 </head>
 <body link="blue" vlink="purple" class="xl65">
  <table width="1019.87" border="0" cellpadding="0" cellspacing="0" style='width:764.90pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="155" class="xl65" style='mso-width-source:userset;mso-width-alt:4960;'/>
   <col width="52.47" class="xl65" style='mso-width-source:userset;mso-width-alt:1678;'/>
   <col width="115" class="xl65" style='mso-width-source:userset;mso-width-alt:3680;'/>
   <col width="30" class="xl65" style='mso-width-source:userset;mso-width-alt:960;'/>
   <col width="50" class="xl65" style='mso-width-source:userset;mso-width-alt:1600;'/>
   <col width="42.47" class="xl65" style='mso-width-source:userset;mso-width-alt:1358;'/>
   <col width="62.53" class="xl65" style='mso-width-source:userset;mso-width-alt:2001;'/>
   <col width="59.93" class="xl65" style='mso-width-source:userset;mso-width-alt:1917;'/>
   <col width="60" class="xl65" style='mso-width-source:userset;mso-width-alt:1920;'/>
   <col width="47.47" class="xl65" style='mso-width-source:userset;mso-width-alt:1518;'/>
   <col width="32.53" class="xl65" style='mso-width-source:userset;mso-width-alt:1041;'/>
   <col width="57.47" class="xl65" style='mso-width-source:userset;mso-width-alt:1838;'/>
   <col width="37.53" class="xl65" style='mso-width-source:userset;mso-width-alt:1201;'/>
   <col width="47.53" class="xl65" style='mso-width-source:userset;mso-width-alt:1521;'/>
   <col width="42.47" class="xl65" style='mso-width-source:userset;mso-width-alt:1358;'/>
   <col width="29.93" class="xl65" style='mso-width-source:userset;mso-width-alt:957;'/>
   <col width="50" class="xl65" style='mso-width-source:userset;mso-width-alt:1600;'/>
   <col width="47.53" class="xl65" style='mso-width-source:userset;mso-width-alt:1521;'/>
   <col width="157.47" class="xl65" style='mso-width-source:userset;mso-width-alt:5038;'/>
   <col width="70.40" class="xl65" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <col width="85" class="xl65" style='mso-width-source:userset;mso-width-alt:2720;'/>
   <col width="70.40" span="2" class="xl65" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <col width="44.93" class="xl65" style='mso-width-source:userset;mso-width-alt:1437;'/>
   <col width="62.53" class="xl65" style='mso-width-source:userset;mso-width-alt:2001;'/>
   <col width="95" class="xl65" style='mso-width-source:userset;mso-width-alt:3040;'/>
   <col width="70.40" span="5" class="xl65" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <col width="62.47" class="xl65" style='mso-width-source:userset;mso-width-alt:1998;'/>
   <col width="35" class="xl65" style='mso-width-source:userset;mso-width-alt:1120;'/>
   <col width="47.47" class="xl65" style='mso-width-source:userset;mso-width-alt:1518;'/>
   <col width="70.40" span="222" class="xl65" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <tr height="41.60" style='height:31.20pt;mso-height-source:userset;mso-height-alt:624;'>
    <td class="xl66" height="41.60" width="1019.87" colspan="18" style='height:31.20pt;width:764.90pt;border-right:none;border-bottom:1.0pt dashed windowtext;border-bottom-style:dot-dash;' x:str>装 订 线</td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl67" height="138.67" colspan="16" style='height:104.00pt;border-right:none;border-bottom:none;' x:str>天津现代职业技术学院会议费报账单</td>
    <td style="text-align: center;" colspan="2" id="reimburseMeeting"></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl68" height="53.33" style='height:40.00pt;' x:str>报账部门：</td>
    <td class="xl68" colspan="4" style='border-right:none;border-bottom:none;'>${bean.deptName }</td>
    <td class="xl69"></td>
    <td class="xl70" colspan="2" style='border-right:none;border-bottom:none;' x:str>经办人：</td>
    <td class="xl68" colspan="4" style='border-right:none;border-bottom:none;'>${bean.userName }</td>
    <td class="xl69"></td>
    <td class="xl70" colspan="5" style='border-right:none;border-bottom:none;' x:str><fmt:formatDate value="${bean.reqTime }" pattern="yyyy年MM月dd日"/></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl71" height="53.33" style='height:40.00pt;' x:str>会议起止日期</td>
    <td class="xl72" x:str>自</td>
    <td class="xl73" colspan="6">${reimbStartTime }</td>
    <!-- <td class="xl73" x:str>年</td>
    <td class="xl73"></td>
    <td class="xl73" x:str>月</td>
    <td class="xl73"></td>
    <td class="xl73" x:str>日</td> -->
    <td class="xl73" x:str>——</td>
    <td class="xl73" colspan="6">${reimbEndTime }</td>
    <!-- <td class="xl73" x:str>年</td>
    <td class="xl73"></td>
    <td class="xl73" x:str>月</td>
    <td class="xl73"></td>
    <td class="xl73" x:str>日</td> -->
    <td class="xl73" x:str>共</td>
    <td class="xl73">${reimbDay }</td>
    <td class="xl96" x:str>天</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>会议名称</td>
    <td class="xl75" colspan="17" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${meetingBean.meetingName}</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl76" height="53.33" style='height:40.00pt;' x:str>摘要</td>
    <td class="xl77" colspan="11" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>明细支出</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>总金额（元）</td>
    <td class="xl97" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>附件</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>住宿费</td>
    <td class="xl78"></td>
    <td class="xl79" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl80">${meetingBean.hotelPersonNum}</td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>人·天*</td>
    <td class="xl80"><fmt:formatNumber groupingUsed="true" value="${meetingBean.realityHotelMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>元/人天</td>
    <td class="xl79" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl81" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.hotelMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl75" colspan="2" rowspan="6" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>共<font class="font4"><br/><br/><br/><br/><br/></font><font class="font4">张</font></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>伙食费</td>
    <td class="xl78"></td>
    <td class="xl79" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl80">${meetingBean.foodPersonNum}</td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>人·天*</td>
    <td class="xl80"><fmt:formatNumber groupingUsed="true" value="${meetingBean.realityFoodMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>元/人天</td>
    <td class="xl79" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl81" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.foodMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>文件印刷费</td>
    <td class="xl78"></td>
    <td class="xl79" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl80">${meetingBean.printingPersonNum}</td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>人*</td>
    <td class="xl80"><fmt:formatNumber groupingUsed="true" value="${meetingBean.realityPrintingMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>元/人</td>
    <td class="xl79" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl81" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.printingMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>会议场地租金</td>
    <td class="xl81" colspan="11" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.rentMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl93" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.rentMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>交通费</td>
    <td class="xl81" colspan="11" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.trafficMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl93" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.trafficMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>其他</td>
    <td class="xl81" colspan="11" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.otherMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl93" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${meetingBean.otherMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>合计</td>
    <td class="xl78" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>人民币（大写）：</td>
    <td class="xl82" colspan="8" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.reimAmountcapital}</td>
    <td class="xl79" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>（小写）￥：</td>
    <td class="xl98" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl83" height="53.33" colspan="18" style='height:40.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>收款人信息</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str>序号</td>
    <td class="xl81" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>收款人姓名</td>
    <td class="xl81" colspan="11" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>银行卡号</td>
    <td class="xl75" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额</td>
   </tr>
   <c:if test="${!empty listPayee }">
	   <c:forEach items="${listPayee }" var="payee">
		   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
		    <td class="xl74" height="53.33" style='height:40.00pt;'>${payee.num }</td>
		    <td class="xl81" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${payee.payeeName }</td>
		    <td class="xl81" colspan="11" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${payee.bankAccount }</td>
		    <td class="xl75" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${payee.payeeAmount }" minFractionDigits="2" maxFractionDigits="2"/></td>
		   </tr>
   	   </c:forEach>
   </c:if>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="53.33" style='height:40.00pt;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==0 }">checked="checked" </c:if>>基本支出</td>
    <td class="xl84" colspan="6" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==1 }">checked="checked" </c:if>> 项目支出名称（编号）：</td>
    <td class="xl85" colspan="11" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><c:if test="${pro.FProOrBasic==1  }">${bean.proDetailName}</c:if></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl74" height="106.67" rowspan="2" style='height:80.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审<font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font4">批</font></td>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>项目负责人：</td>
    <td class="xl88" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${proHead }</td>
    <td class="xl88" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>部门负责人：</td>
    <td class="xl88" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role1 }</td>
    <td class="xl88" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>主管校长：</td>
    <td class="xl88" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2 }</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>财务校长：</td>
    <td class="xl88" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role3 }</td>
    <td class="xl88" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>校<font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font4">长：</font></td>
    <td class="xl88" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role4 }</td>
    <td class="xl88" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl85" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl89" height="53.33" style='height:40.00pt;' x:str>财务审核：</td>
    <td class="xl88" colspan="5" style='border-right:none;border-bottom:1.0pt solid windowtext;'>${financeCheck }</td>
    <td class="xl91" colspan="3" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>财务报销：</td>
    <td class="xl94" colspan="3" style='border-right:none;border-bottom:1.0pt solid windowtext;'></td>
    <td class="xl91" colspan="3" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>领款人：</td>
    <td class="xl95" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:1.0pt solid windowtext;'></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl92" height="53.33" colspan="18" style='height:40.00pt;mso-ignore:colspan;'></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl92" height="53.33" colspan="18" style='height:40.00pt;mso-ignore:colspan;'></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl92" height="53.33" colspan="18" style='height:40.00pt;mso-ignore:colspan;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="155" style='width:116;'></td>
     <td width="52" style='width:39;'></td>
     <td width="115" style='width:86;'></td>
     <td width="30" style='width:23;'></td>
     <td width="50" style='width:38;'></td>
     <td width="42" style='width:32;'></td>
     <td width="63" style='width:47;'></td>
     <td width="60" style='width:45;'></td>
     <td width="60" style='width:45;'></td>
     <td width="47" style='width:36;'></td>
     <td width="33" style='width:24;'></td>
     <td width="57" style='width:43;'></td>
     <td width="38" style='width:28;'></td>
     <td width="48" style='width:36;'></td>
     <td width="42" style='width:32;'></td>
     <td width="30" style='width:22;'></td>
     <td width="50" style='width:38;'></td>
     <td width="48" style='width:36;'></td>
     <td width="157" style='width:118;'></td>
     <td width="70" style='width:53;'></td>
     <td width="85" style='width:64;'></td>
     <td width="70" style='width:53;'></td>
     <td width="45" style='width:34;'></td>
     <td width="63" style='width:47;'></td>
     <td width="95" style='width:71;'></td>
     <td width="70" style='width:53;'></td>
     <td width="62" style='width:47;'></td>
     <td width="35" style='width:26;'></td>
     <td width="47" style='width:36;'></td>
     <td width="70" style='width:53;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">
  $(document).ready(function() {
		//生成二维码
	 	$('#reimburseMeeting').qrcode({
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
			window.open("${base}/exportApplyAndReim/requestApply?id="+${id});//
			window.open("${base}/exportApplyAndReim/PastePage");
		} else {
			window.close();
		}
	}
  </script>
 </body>
</html>

