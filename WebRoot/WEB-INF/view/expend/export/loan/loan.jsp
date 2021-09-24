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
	font-size:12.0pt;
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
	{color:#000000;
	font-size:22.0pt;
	font-weight:700;
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
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:#FF0000;
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
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font11
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font13
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font17
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font19
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font20
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font21
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font22
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
	{color:#44546A;
	font-size:11.0pt;
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
	vertical-align:bottom;
	font-size:12.0pt;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	vertical-align:bottom;
	font-size:12.0pt;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	color:#BFBFBF;
	font-size:14.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt dashed #000000;
	border-bottom-style:dot-dash;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	text-align:left;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style0;
	text-align:right;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
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
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-right:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	text-align:center;
	font-size:12.0pt;
	mso-font-charset:134;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-font-charset:134;}
 -->  </style>
  <!--[if gte mso 9]>
   <xml>
    <x:ExcelWorkbook>
     <x:ExcelWorksheets>
      <x:ExcelWorksheet>
       <x:Name>Sheet1</x:Name>
       <x:WorksheetOptions>
        <x:DefaultRowHeight>285</x:DefaultRowHeight>
        <x:StandardWidth>2069</x:StandardWidth>
        <x:Selected/>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>7</x:ActiveCol>
          <x:ActiveRow>14</x:ActiveRow>
          <x:RangeSelection>H15</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:CodeName>Sheet1</x:CodeName>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:ShowPageBreakZoom/>
        <x:PageBreakZoom>80</x:PageBreakZoom>
        <x:Print>
         <x:ValidPrinterInfo/>
         <x:PaperSizeIndex>9</x:PaperSizeIndex>
         <x:Scale>64</x:Scale>
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
 <body link="blue" vlink="purple" class="xl66">
  <table width="957.27" border="0" cellpadding="0" cellspacing="0" style='width:717.95pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="201.20" class="xl65" style='mso-width-source:userset;mso-width-alt:6438;'/>
   <col width="183.73" class="xl65" style='mso-width-source:userset;mso-width-alt:5879;'/>
   <col width="132.40" class="xl65" style='mso-width-source:userset;mso-width-alt:4236;'/>
   <col width="137.53" class="xl66" style='mso-width-source:userset;mso-width-alt:4401;'/>
   <col width="136.20" class="xl66" style='mso-width-source:userset;mso-width-alt:4358;'/>
   <col width="166.20" class="xl66" style='mso-width-source:userset;mso-width-alt:5318;'/>
   <col width="64.80" span="250" class="xl66" style='mso-width-source:userset;mso-width-alt:2073;'/>
   <tr height="41.60" style='height:31.20pt;mso-height-source:userset;mso-height-alt:624;'>
    <td class="xl67" height="41.60" width="957.27" colspan="6" style='height:31.20pt;width:717.95pt;border-right:none;border-bottom:1.0pt dashed #000000;border-bottom-style:dot-dash;' x:str>装<font class="font2"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font2">订</font><font class="font2"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font2">线</font></td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl68" height="138.67" colspan="5" style='height:104.00pt;border-right:none;border-bottom:none;padding-left: 180px;' x:str>天津现代职业技术学院借款单</td>
  	<td style="text-align: center;" colspan="1" id="loan"></td> 
   </tr>
   <tr height="35.20" style='height:26.40pt;mso-height-source:userset;mso-height-alt:528;'>
    <td class="xl69" height="35.20" style='height:26.40pt;' x:str>经办人：${bean.userName}<font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></td>
    <td class="xl69"></td>
    <td class="xl70" x:str>借款部门：${bean.deptName}</td>
    <td class="xl71"></td>
    <td class="xl70" x:str>申请日期：</td>
    <td class="xl72" x:str>${time}</td>
   </tr>
   <tr height="52" style='height:39.00pt;mso-height-source:userset;mso-height-alt:780;'>
    <td class="xl73" height="52" style='height:39.00pt;' x:str>借款时间</td>
    <td class="xl74" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatDate value="${bean.reqTime}" pattern="yyyy-MM-dd "/></td>
    <td class="xl75" x:str>预计还款时间</td>
    <td class="xl76" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatDate value="${bean.estChargeTime}" pattern="yyyy-MM-dd "/></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl77" height="46.67" style='height:35.00pt;' x:str>借款金额</td>
    <td class="xl78" x:str>人民币（大写）：</td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.dxLamount }</td>
    <td class="xl80" x:str>（小写）¥：</td>
    <td class="xl81"><fmt:formatNumber groupingUsed="true" value="${bean.lAmount }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="58.67" style='height:44.00pt;mso-height-source:userset;mso-height-alt:880;'>
    <td class="xl77" height="58.67" style='height:44.00pt;' x:str>项目名称（编号）</td>
    <td class="xl79" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl79" x:str>项目负责人：</td>
    <td class="xl82"></td>
   </tr>
   <tr height="223.20" style='height:167.40pt;mso-height-source:userset;mso-height-alt:3348;'>
    <td class="xl77" height="223.20" style='height:167.40pt;' x:str>申请事由、用途</td>
    <td class="xl83" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.loanReason }</td>
   </tr>
   <tr height="45.33" style='height:34.00pt;mso-height-source:userset;mso-height-alt:680;'>
    <td class="xl84" height="45.33" colspan="6" style='height:34.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>借款信息</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl77" height="46.67" style='height:35.00pt;' x:str>收款人</td>
    <td class="xl82" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${payee.payeeName}</td>
   </tr>
   <tr height="48" style='height:36.00pt;mso-height-source:userset;mso-height-alt:720;'>
    <td class="xl77" height="48" style='height:36.00pt;' x:str>收款方式</td>
    <td class="xl83" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled" <c:if test="${payee.paymentType==2}">checked="checked" </c:if>>现金<font class="font4"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font4"><input type="checkbox" disabled="disabled" <c:if test="${payee.paymentType==1}">checked="checked" </c:if>>银行转账</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font4"><input type="checkbox" disabled="disabled" <c:if test="${payee.paymentType==3}">checked="checked" </c:if>>公务卡</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font4"><input type="checkbox" disabled="disabled" <c:if test="${payee.paymentType==4}">checked="checked" </c:if>>支票</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font4"><input type="checkbox" disabled="disabled" <c:if test="${payee.paymentType==5}">checked="checked" </c:if>>电汇</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font4"><input type="checkbox" disabled="disabled" <c:if test="${payee.paymentType==6}">checked="checked" </c:if>>其他（</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font4">）</font></td>
   </tr>
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl77" height="52.80" style='height:39.60pt;' x:str>收款单位名称</td>
    <td class="xl82" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl77" height="52.80" style='height:39.60pt;' x:str>收款单位开户行名称</td>
    <td class="xl82" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${payee.bank}</td>
   </tr>
   <tr height="48" style='height:36.00pt;mso-height-source:userset;mso-height-alt:720;'>
    <td class="xl77" height="48" style='height:36.00pt;' x:str>收款单位银行账号</td>
    <td class="xl82" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${payee.bankAccount}</td>
   </tr>
   <tr height="37.33" style='height:28.00pt;mso-height-source:userset;mso-height-alt:560;'>
    <td class="xl85" height="37.33" colspan="3" style='height:28.00pt;border-right:none;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;</span><font class="font4">部门负责人</font></td>
    <td class="xl86" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;</span><font class="font4">主管校长</font></td>
   </tr>
   <tr height="124" style='height:93.00pt;mso-height-source:userset;mso-height-alt:1860;'>
    <td class="xl87" height="124" colspan="3" style='height:93.00pt;border-right:none;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;</span><font class="font4"><br/><br/>${role1 }</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;</span></font><font class="font4"><br/></font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></td>
    <td class="xl88" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font4"><br/><br/>${role2 }</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;</span></font><font class="font4"><br/></font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></td>
   </tr>
   <tr height="36" style='height:27.00pt;mso-height-source:userset;mso-height-alt:540;'>
    <td class="xl89" height="36" colspan="3" style='height:27.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>${date1 }</td>
    <td class="xl90" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str>${date2 }</td>
   </tr>
   <tr height="38.67" style='height:29.00pt;mso-height-source:userset;mso-height-alt:580;'>
    <td class="xl91" height="38.67" colspan="3" style='height:29.00pt;border-right:none;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;</span><font class="font4">财务校长</font></td>
    <td class="xl86" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;</span><font class="font4">校</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font4">长</font></td>
   </tr>
   <tr height="124" style='height:93.00pt;mso-height-source:userset;mso-height-alt:1860;'>
    <td class="xl87" height="124" colspan="3" style='height:93.00pt;border-right:none;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;</span><font class="font4"><br/><br/>${role3 }</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;</span></font><font class="font4"><br/></font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></td>
    <td class="xl92" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font4"><br/><br/>${role4 }</font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;</span></font><font class="font4"><br/></font><font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></td>
   </tr>
   <tr height="30.67" style='height:23.00pt;mso-height-source:userset;mso-height-alt:460;'>
    <td class="xl90" height="30.67" colspan="3" style='height:23.00pt;border-right:1.0pt solid windowtext;border-bottom:none;' x:str>${date3 }</td>
    <td class="xl93" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str>${date4 }</td>
   </tr>
   <tr height="48" style='height:36.00pt;mso-height-source:userset;mso-height-alt:720;'>
    <td class="xl94" height="48" style='height:36.00pt;' x:str>财务审核：</td>
    <td class="xl95">${financeCheck }</td>
    <td class="xl95" x:str>财务报销：</td>
    <td class="xl95"></td>
    <td class="xl95" x:str>领款人：</td>
    <td class="xl96"></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl97" height="19" colspan="3" style='height:14.25pt;mso-ignore:colspan;'></td>
    <td class="xl98" colspan="3" style='mso-ignore:colspan;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="201" style='width:151;'></td>
     <td width="184" style='width:138;'></td>
     <td width="132" style='width:99;'></td>
     <td width="138" style='width:103;'></td>
     <td width="136" style='width:102;'></td>
     <td width="166" style='width:125;'></td>
     <td width="65" style='width:49;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">
  $(document).ready(function() {
		//生成二维码
	  $('#loan').qrcode({
		render: "canvas",
		width   : 80,     //设置宽度  
		height  : 80, 
		x: 200, y: 100,
		text:'${urlbase}/expendPrintDetail?id='+${bean.lId}+'&type=loan'
	});
	window.print();
	}); 
  </script>
 </body>
</html>

