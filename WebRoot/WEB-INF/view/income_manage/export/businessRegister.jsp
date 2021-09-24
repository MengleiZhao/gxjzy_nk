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
	{color:#BFBFBF;
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
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:#000000;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
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
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:#44546A;
	font-size:11.0pt;
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
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font19
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font20
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font21
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font24
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
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
	color:#BFBFBF;
	font-size:14.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt dashed #D9D9D9;
	border-bottom-style:dot-dash;}
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
	font-size:16.0pt;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
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
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl84
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
.xl85
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
 -->  </style>
 </head>
 <body link="blue" vlink="purple">
  <table width="1037" border="0" cellpadding="0" cellspacing="0" style='width:777.75pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="135" style='mso-width-source:userset;mso-width-alt:4320;'/>
   <col width="138" style='mso-width-source:userset;mso-width-alt:4736;'/>
   <col width="88" style='mso-width-source:userset;mso-width-alt:2816;'/>
   <col width="140" style='mso-width-source:userset;mso-width-alt:4480;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="118" span="2" style='mso-width-source:userset;mso-width-alt:3456;'/>
   <col width="20" style='mso-width-source:userset;mso-width-alt:640;'/>
   <col width="218" style='mso-width-source:userset;mso-width-alt:6976;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <tr height="32" style='height:24.00pt;mso-height-source:userset;mso-height-alt:480;'>
    <td class="xl65" height="32" width="1037" colspan="9" style='height:24.00pt;width:777.75pt;border-right:none;border-bottom:1.0pt dashed #D9D9D9;border-bottom-style:dot-dash;' x:str>装 订 线</td>
   </tr>
   <tr height="92" style='height:69.00pt;mso-height-source:userset;mso-height-alt:1380;'>
    <td class="xl66" height="92" colspan="9" style='height:69.00pt;border-right:none;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;</span><font class="font2">天津现代职业技术学院来款登记表</font></td>
   </tr>
   <tr height="33.33" style='height:30.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl67" height="33.33" style='height:30.00pt;' x:str>申请人：</td>
    <td class="xl68">${bean.fregisterPerson}</td>
    <td class="xl67"></td>
    <td class="xl67"></td>
    <td class="xl69"></td>
    <td class="xl69"></td>
    <td class="xl70" colspan="2" style='border-right:none;border-bottom:none;' x:str>申请日期：</td>
    <td class="xl70" x:str><fmt:formatDate value="${bean.fregisterTime}" pattern="yyyy年MM月dd日"/></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl71" height="53.33" style='height:40.00pt;' x:str>来款项目名称</td>
    <td class="xl72" colspan="8" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.fproName}</td>
   </tr>
   <tr height="164" style='height:123.00pt;mso-height-source:userset;mso-height-alt:2460;'>
    <td class="xl73" height="198.67" rowspan="2" style='height:149.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>依据及<font class="font3"><br/></font><font class="font3">简要说明</font></td>
    <td class="xl74" colspan="8" style='border-right:1.0pt solid windowtext;border-bottom:none;'>${bean.fRemark}</td>
   </tr>
   <tr height="34.67" style='height:26.00pt;mso-height-source:userset;mso-height-alt:520;'>
    <td class="xl75" colspan="8" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>（附合同、协议等书面文件资料）</td>
   </tr>
   <tr height="34.67" style='height:26.00pt;mso-height-source:userset;mso-height-alt:520;'>
    <td class="xl76" height="34.67" colspan="9" style='height:26.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>来款明细</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl73" height="53.33" colspan="3" style='height:40.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>对方单位名称</td>
    <td class="xl77" x:str>金额（元）</td>
    <td class="xl77" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>来款性质</td>
    <td class="xl77" x:str>来款日期</td>
    <td class="xl78" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>开票种类</td>
   </tr>
   <c:if test="${!empty list}">
   <c:forEach items="${list}" var="list">
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl73" height="53.33" colspan="3" style='height:40.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${list.oppositeUnit }</td>
    <td class="xl79">${list.planMoney}</td>
    <td class="xl77" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>
    <input type="checkbox" disabled="disabled" <c:if test="${list.fType!='2' }">checked="checked" </c:if>>收入/
    <input type="checkbox" disabled="disabled" <c:if test="${list.fType=='2' }">checked="checked" </c:if>>往来</td>
    <td class="xl77"><fmt:formatDate value="${list.planTime }" pattern="yyyy-MM-dd"/></td>
    <td class="xl78" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>
    <input type="checkbox" disabled="disabled" <c:if test="${list.invoiceKindShow=='发票' }">checked="checked" </c:if>>发票/
	<input type="checkbox" disabled="disabled" <c:if test="${list.invoiceKindShow=='收据' }">checked="checked" </c:if>>收据/
	<input type="checkbox" disabled="disabled" <c:if test="${list.invoiceKindShow=='其他' }">checked="checked" </c:if>>其他</td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty list}">
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl73" height="53.33" colspan="3" style='height:40.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl79">-</td>
    <td class="xl77" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>□收入/□往来</td>
    <td class="xl77">-</td>
    <td class="xl78" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>□发票/□收据/□其他</td>
   </tr>
	</c:if>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl73" height="53.33" style='height:40.00pt;' x:str>金额合计（元）</td>
    <td class="xl80" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>人民币（大写）：</td>
    <td class="xl81" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.fregisterAmountCapital}</td>
    <td class="xl82" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>（小写）¥：</td>
    <td class="xl83" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.fregisterAmount}</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl84" height="106.67" rowspan="2" style='height:80.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审<font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font4">批</font></td>
    <td class="xl85" x:str>项目负责人：</td>
    <td class="xl86"></td>
    <td class="xl87" x:str>部门负责人：</td>
    <td class="xl86"></td>
    <td class="xl86" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>归口管理部门负责人：</td>
    <td class="xl97"></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl85" x:str>主管校长：</td>
    <td class="xl86"></td>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl87" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>校<font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font class="font4">长：</font></td>
    <td class="xl97"></td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl88" height="106.67" rowspan="2" style='height:80.00pt;border-right:none;border-bottom:1.0pt solid windowtext;' x:str>备注</td>
    <td class="xl89"></td>
    <td class="xl90" x:str>附</td>
    <td class="xl91"></td>
    <td class="xl90" x:str>年第</td>
    <td class="xl91"></td>
    <td class="xl92" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str>次校长办公会会议纪要</td>
   </tr>
   <tr height="53.33" style='height:40.00pt;mso-height-source:userset;mso-height-alt:800;'>
    <td class="xl93"></td>
    <td class="xl94" x:str>附</td>
    <td class="xl95"></td>
    <td class="xl94" x:str>年第</td>
    <td class="xl95"></td>
    <td class="xl96" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:1.0pt solid windowtext;' x:str>次党委会会议纪要</td>
   </tr>
  </table>
  <script type="text/javascript">
  $(document).ready(function() {
	window.print();
	});
  </script>
 </body>
</html>
