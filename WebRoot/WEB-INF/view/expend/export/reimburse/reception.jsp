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
	font-size:16.0pt;
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
	font-size:6.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:#000000;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:#000000;
	font-size:10.5pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Calibri";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:#000000;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font7
	{color:#000000;
	font-size:24.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font8
	{color:#000000;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font9
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font13
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font15
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font19
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
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
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font22
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font24
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font25
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font26
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font27
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
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
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:.5pt dashed windowtext;
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
	text-align:right;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:6.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:14.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	white-space:normal;
	font-size:10.5pt;
	font-family:Calibri;
	mso-font-charset:134;}
.xl79
	{mso-style-parent:style0;
	text-align:justify;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	font-size:24.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl81
	{mso-style-parent:style0;
	text-align:justify;
	mso-char-indent-count:15;
	font-size:10.5pt;
	font-family:Calibri;
	mso-font-charset:134;}
.xl82
	{mso-style-parent:style0;
	text-align:justify;
	mso-char-indent-count:15;
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
        <x:DefaultRowHeight>270</x:DefaultRowHeight>
        <x:Selected/>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>0</x:ActiveCol>
          <x:ActiveRow>16</x:ActiveRow>
          <x:RangeSelection>A17</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:PageBreakZoom>100</x:PageBreakZoom>
        <x:Zoom>40</x:Zoom>
        <x:Print>
         <x:PaperSizeIndex>9</x:PaperSizeIndex>
        </x:Print>
       </x:WorksheetOptions>
      </x:ExcelWorksheet>
     </x:ExcelWorksheets>
     <x:ProtectStructure>False</x:ProtectStructure>
     <x:ProtectWindows>False</x:ProtectWindows>
     <x:SelectedSheets>0</x:SelectedSheets>
     <x:WindowHeight>7710</x:WindowHeight>
     <x:WindowWidth>19215</x:WindowWidth>
    </x:ExcelWorkbook>
   </xml>
  <![endif]-->
 </head>
 <body link="blue" vlink="purple">
  <table width="942.40" border="0" cellpadding="0" cellspacing="0" style='width:706.80pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="172.47" style='mso-width-source:userset;mso-width-alt:5518;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="128" style='mso-width-source:userset;mso-width-alt:4096;'/>
   <col width="103" style='mso-width-source:userset;mso-width-alt:3296;'/>
   <col width="172.47" style='mso-width-source:userset;mso-width-alt:5518;'/>
   <col width="32.47" style='mso-width-source:userset;mso-width-alt:1038;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="190" style='mso-width-source:userset;mso-width-alt:6080;'/>
   <tr height="38.67" style='height:29.00pt;mso-height-source:userset;mso-height-alt:580;'>
    <td class="xl65" height="38.67" width="942.40" colspan="8" style='height:29.00pt;width:706.80pt;border-right:none;border-bottom:.5pt dashed windowtext;border-bottom-style:dot-dash;' x:str>装订线</td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl66" height="138.67" colspan="7" style='height:104.00pt;border-right:none;border-bottom:none;padding-left:160px' x:str>公务接待清单</td>
    <td style="text-align: center;" colspan="1" id="reimbursereception"></td> 
   </tr>
   <tr height="32" style='height:24.00pt;mso-height-source:userset;mso-height-alt:480;'>
    <td class="xl67" height="32" colspan="4" style='height:24.00pt;mso-ignore:colspan;'></td>
    <td class="xl68" colspan="3" style='border-right:none;border-bottom:none;' x:str>编号：</td>
    <td class="xl69"  style='border-right:none;border-bottom:none;'>${bean.rCode }</td>
   </tr>
   <tr height="30.67" style='height:23.00pt;mso-height-source:userset;mso-height-alt:460;'>
    <td class="xl70" height="30.67" colspan="8" style='height:23.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>接待对象</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;' x:str>接待单位</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${receptionBeanEdit.receptionObject}</td>
    <td class="xl70" x:str>经办人</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.userName}</td>
   </tr>
   <tr height="72" style='height:54.00pt;mso-height-source:userset;mso-height-alt:1080;'>
    <td class="xl70" height="72" style='height:54.00pt;' x:str>接待事由及公函</td>
    <td class="xl70" colspan="7" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${receptionBeanEdit.receptionContent}</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;' x:str>姓名</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>单位</td>
    <td class="xl70" x:str>职务</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>备注及联系方式</td>
   </tr>
   <c:if test="${!empty listPeople}">
	<c:forEach items="${listPeople }" var="i"> 
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;'>${i.receptionPeopName }</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.unit }</td>
    <td class="xl70">${i.position }</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>备注：${i.jDremake } <c:if test="${empty i.jDremake}">无</c:if>&nbsp;联系方式：${i.contactInformation }<c:if test="${empty i.contactInformation}">无</c:if></td>
   </tr>
    </c:forEach>
   </c:if>
    <c:if test="${empty listPeople}">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;'>-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70">-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="8" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>接待内容</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;' x:str>住宿时间</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>地点</td>
    <td class="xl70" x:str>人数</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额</td>
    <td class="xl70" x:str>备注</td>
   </tr>
   <c:if test="${!empty listHotel}">
	<c:forEach items="${listHotel }" var="i"> 
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;'><fmt:formatDate value="${i.fStartTime }" pattern="yyyy-MM-dd "/> ~ <fmt:formatDate value="${i.fEndTime }" pattern="yyyy-MM-dd "/></td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fPlace }</td>
    <td class="xl70">${i.personNum }</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.fCostHotel }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl70"></td>
   </tr>
    </c:forEach>
   </c:if>
   <c:if test="${empty listHotel}">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;'>-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70">-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70">-</td>
   </tr>
   </c:if>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;' x:str>餐饮时间</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>地点</td>
    <td class="xl70" x:str>标准</td>
    <td class="xl70" x:str>用餐总人数</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额</td>
    <td class="xl70" x:str>其中：陪餐人数</td>
   </tr>
   <c:if test="${!empty listFood}">
	<c:forEach items="${listFood }" var="i">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;'><c:if test="${ receptionBeanEdit.isForeign==0}"><fmt:formatDate value="${i.time}" pattern="yyyy-MM-dd HH:ss"/></c:if> <c:if test="${ receptionBeanEdit.isForeign==1}"><fmt:formatDate value="${i.date}" pattern="yyyy-MM-dd "/></c:if></td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${ i.place}</td>
    <td class="xl70" ><c:if test="${i.fFoodType!='日常伙食'}"><fmt:formatNumber groupingUsed="true"  value="${i.fCostStd }"  minFractionDigits="2" maxFractionDigits="2"/></c:if><c:if test="${i.fFoodType=='日常伙食'}"> 详见制度标准</c:if></td>
    <td class="xl70">${i.fPersonNum }</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.fReimbCostFood }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl70">${i.fOtherNum }</td>
   </tr>
   </c:forEach>
   </c:if>
    <c:if test="${empty listFood}">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;'>-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl71" x:str>-</td>
    <td class="xl70">-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70">-</td>
   </tr>
   </c:if>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;' x:str>备注说明</td>
    <td class="xl72" colspan="7" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.reimburseReason}</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="8" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>其他项目费用</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" style='height:35.00pt;' x:str>其他项目</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>项目内容</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>备注</td>
   </tr>
   <c:if test="${!empty listOther}">
  	 <c:forEach items="${listOther }" var="i" varStatus="val">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl73" height="46.67" style='height:35.00pt;' x:str>${val.index+1}</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fCostName}</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.fCost }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fRemark}</td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty listOther}">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl73" height="46.67" style='height:35.00pt;' x:str>-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="8" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>报销金额合计（元）</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>金额（大写）：</td>
    <td class="xl75" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.reimAmountcapital }</td>
    <td class="xl76" x:str>金额（小写）：</td>
    <td class="xl77" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="8" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>陪同人员</td>
   </tr>
   
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="4" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>姓名</td>
    <td class="xl70" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>职务</td>
   </tr>
   
   <c:if test="${!empty listAccompany}">
  	 <c:forEach items="${listAccompany }" var="i" >
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="4" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.receptionPeopName }</td>
    <td class="xl70" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.position }</td>
   </tr>
    </c:forEach>
   </c:if>
   <c:if test="${empty listAccompany}">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="4" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="8" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审核情况</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="2" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>主要接待部门负责人</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role1 }</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>办公室主任</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2 }</td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl70" height="46.67" colspan="2" style='height:35.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>国际交流处处长</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role3 }</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>部门主管领导</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role4 }</td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl78" height="19" colspan="8" style='height:14.25pt;mso-ignore:colspan;'></td>
   </tr>
   <tr height="27" style='height:20.25pt;'>
    <td class="xl79" height="27" style='height:20.25pt;'></td>
    <td colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="42" style='height:31.50pt;'>
    <td class="xl80" height="42" style='height:31.50pt;'></td>
    <td colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl81" height="19" style='height:14.25pt;'></td>
    <td colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="19" style='height:14.25pt;'>
    <td class="xl82" height="19" style='height:14.25pt;'></td>
    <td colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="172" style='width:129;'></td>
     <td width="72" style='width:54;'></td>
     <td width="128" style='width:96;'></td>
     <td width="103" style='width:77;'></td>
     <td width="172" style='width:129;'></td>
     <td width="32" style='width:24;'></td>
     <td width="72" style='width:54;'></td>
     <td width="190" style='width:143;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">

	$(document).ready(function() {
		//生成二维码
		 $('#reimbursereception').qrcode({
			render: "canvas",
			width   : 80,     //设置宽度  
			height  : 80, 
			x: 200, y: 100,
			text:'${urlbase}/expendPrintDetail?id='+${bean.rId}+'&type=reimburse'
	 	});
		window.setTimeout(function (){
			CloseAfterPrint();
		},250);
	});
	function CloseAfterPrint() {
		if (document.execCommand("print")) {
			window.open("${base}/exportApplyAndReim/requestApply?id="+${id});//
			window.open("${base}/exportApplyAndReim/receptionPayee?id="+${id});//财务报账单
			window.open("${base}/exportApplyAndReim/PastePage?id="+ ${id});
		} else {
			window.close();
		}
	}
  </script>
 </body>
</html>

