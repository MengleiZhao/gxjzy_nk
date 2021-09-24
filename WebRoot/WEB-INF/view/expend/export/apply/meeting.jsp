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
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
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
	{color:#44546A;
	font-size:15.0pt;
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
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font13
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font16
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
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
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font19
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font20
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
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
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font24
	{color:#000000;
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
	border-left:none;
	border-top:none;
	border-right:none;
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
	border-left:none;
	border-top:none;
	border-right:none;
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
	border-left:none;
	border-top:none;
	border-right:none;
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
	border-left:none;
	border-top:none;
	border-right:none;
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
	border-left:none;
	border-top:.5pt solid #5B9BD5;
	border-right:none;
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
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:bottom;
	color:windowtext;
	font-size:10.0pt;
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
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
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
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
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
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
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
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl91
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
 -->  </style>
  <!--[if gte mso 9]>
   <xml>
    <x:ExcelWorkbook>
     <x:ExcelWorksheets>
      <x:ExcelWorksheet>
       <x:Name>Sheet1</x:Name>
       <x:WorksheetOptions>
        <x:DefaultRowHeight>240</x:DefaultRowHeight>
        <x:Selected/>
        <x:TopRowVisible>6</x:TopRowVisible>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>2</x:ActiveCol>
          <x:ActiveRow>17</x:ActiveRow>
          <x:RangeSelection>C18:C23</x:RangeSelection>
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
 <body link="blue" vlink="purple" class="xl65">
  <table width="2357.40" border="0" cellpadding="0" cellspacing="0" style='width:1768.05pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="152.47" class="xl65" style='mso-width-source:userset;mso-width-alt:4878;'/>
   <col width="34.93" class="xl65" style='mso-width-source:userset;mso-width-alt:1117;'/>
   <col width="122.47" class="xl65" style='mso-width-source:userset;mso-width-alt:3918;'/>
   <col width="55" class="xl65" style='mso-width-source:userset;mso-width-alt:1760;'/>
   <col width="60" class="xl65" style='mso-width-source:userset;mso-width-alt:1920;'/>
   <col width="100" class="xl65" style='mso-width-source:userset;mso-width-alt:3200;'/>
   <col width="80" class="xl65" style='mso-width-source:userset;mso-width-alt:2560;'/>
   <col width="125" class="xl65" style='mso-width-source:userset;mso-width-alt:4000;'/>
   <col width="124.93" class="xl65" style='mso-width-source:userset;mso-width-alt:3997;'/>
   <col width="140" class="xl65" style='mso-width-source:userset;mso-width-alt:4480;'/>
   <col width="70.40" span="4" class="xl65" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <col width="162.47" class="xl65" style='mso-width-source:userset;mso-width-alt:5198;'/>
   <col width="70.40" class="xl65" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <col width="137.47" class="xl65" style='mso-width-source:userset;mso-width-alt:4398;'/>
   <col width="70.40" span="2" class="xl65" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <col width="57.47" class="xl65" style='mso-width-source:userset;mso-width-alt:1838;'/>
   <col width="129.93" class="xl65" style='mso-width-source:userset;mso-width-alt:4157;'/>
   <col width="125" class="xl65" style='mso-width-source:userset;mso-width-alt:4000;'/>
   <col width="122.47" class="xl65" style='mso-width-source:userset;mso-width-alt:3918;'/>
   <col width="135" class="xl65" style='mso-width-source:userset;mso-width-alt:4320;'/>
   <col width="70.40" span="232" class="xl65" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <tr height="41.60" style='height:31.20pt;mso-height-source:userset;mso-height-alt:624;'>
    <td class="xl66" height="41.60" width="994.80" colspan="10" style='height:31.20pt;width:746.10pt;border-right:none;border-bottom:1.0pt dashed windowtext;border-bottom-style:dot-dash;' x:str>装 订 线</td>
    <td class="xl65" width="70.40" style='width:52.80pt;'></td>
    <td class="xl65" width="70.40" style='width:52.80pt;'></td>
    <td class="xl65" width="70.40" style='width:52.80pt;'></td>
    <td class="xl65" width="70.40" style='width:52.80pt;'></td>
    <td class="xl65" width="162.47" style='width:121.85pt;'></td>
    <td class="xl65" width="70.40" style='width:52.80pt;'></td>
    <td class="xl65" width="137.47" style='width:103.10pt;'></td>
    <td class="xl65" width="70.40" style='width:52.80pt;'></td>
    <td class="xl65" width="70.40" style='width:52.80pt;'></td>
    <td class="xl65" width="57.47" style='width:43.10pt;'></td>
    <td class="xl65" width="129.93" style='width:97.45pt;'></td>
    <td class="xl65" width="125" style='width:93.75pt;'></td>
    <td class="xl65" width="122.47" style='width:91.85pt;'></td>
    <td class="xl65" width="135" style='width:101.25pt;'></td>
   </tr>
   <tr height="114.67" style='height:86.00pt;mso-height-source:userset;mso-height-alt:1720;'>
    <td class="xl67" height="114.67" colspan="8" style='height:86.00pt;border-right:none;border-bottom:none;padding-left: 250px;' x:str>天津现代职业技术学院会议费申请表</td>
    <td style="text-align: center;" colspan="3" id="applymeeting"></td> 
    <td class="xl65" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="10" style='mso-ignore:colspan;'></td>
    <td class="xl68" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl68" height="46.67" style='height:35.00pt;' x:str>申请人：${bean.userNames}</td>
    <td class="xl69" colspan="2" style='border-right:none;border-bottom:none;'></td>
    <td class="xl65" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl70" x:str>申请日期：</td>
    <td class="xl70" colspan="2" style='border-right:none;border-bottom:none;' x:str>${ time}</td>
    <td class="xl65" colspan="14" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl71" height="46.67" style='height:35.00pt;' x:str>申请部门</td>
    <td class="xl72" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.deptName}</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>申请金额</td>
    <td class="xl73" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>会议名称</td>
    <td class="xl75" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${meetingBean.meetingName }</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>会议起止日期</td>
    <td class="xl76" x:str>自</td>
    <td class="xl77" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>${startTime }</td>
    <td class="xl77" x:str>——</td>
    <td class="xl77" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>${endTime}</td>
    <td class="xl78" x:str>共</td>
    <td class="xl77">${day+1 }</td>
    <td class="xl91" x:str>天</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>会议方式</td>
    <td class="xl75" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>
    <input type="checkbox" disabled="disabled" <c:if test="${meetingBean.meetingMethod==1 }">checked="checked" </c:if>>电话
     <input type="checkbox" disabled="disabled" <c:if test="${meetingBean.meetingMethod==2 }">checked="checked" </c:if>>网络视频会议
      <input type="checkbox" disabled="disabled" <c:if test="${meetingBean.meetingMethod==3 }">checked="checked" </c:if>>单位内部会议室
      <input type="checkbox" disabled="disabled" <c:if test="${meetingBean.meetingMethod==4 }">checked="checked" </c:if>>外部定点会议室</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>会议类型</td>
    <td class="xl79" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><c:if test="${meetingBean.meetingType==1 }">一类会议 </c:if><c:if test="${meetingBean.meetingType==2 }">二类会议 </c:if><c:if test="${meetingBean.meetingType==3 }">三类会议 </c:if><c:if test="${meetingBean.meetingType==4 }">四类会议 </c:if></td>
    <td class="xl79" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>会议地点</td>
    <td class="xl75" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${meetingBean.meetingPlace}</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>参会人数</td>
    <td class="xl79" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${meetingBean.attendNum}</td>
    <td class="xl79" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>工作人数</td>
    <td class="xl75" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${meetingBean.staffNum}</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>参会人员说明</td>
    <td class="xl75" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${meetingBean.attendPeople}</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl80" height="46.67" colspan="10" style='height:35.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>会议日程</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>时间安排</td>
    <td class="xl75" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>事项安排</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <c:if test="${!empty listMeetingPlan}">
  	 <c:forEach items="${listMeetingPlan }" var="i">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;'><fmt:formatDate value="${i.times }" pattern="yyyy-MM-dd "/> - <fmt:formatDate value="${i.timee }" pattern="yyyy-MM-dd "/></td>
    <td class="xl75" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.content }</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty listMeetingPlan}">
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;'>-</td>
    <td class="xl75" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   </c:if>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="280" rowspan="6" style='height:210.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>费用明细</td>
    <td class="xl81" x:str>1.</td>
    <td class="xl82" colspan="3" x:str>住宿费 <fmt:formatNumber groupingUsed="true" value="${meetingBean.hotelMoney}" minFractionDigits="2" maxFractionDigits="2"/>元</td>
    <td class="xl78" x:str>（</td>
    <td class="xl77">${meetingBean.hotelPersonNum}</td>
    <td class="xl77" x:str>人·天*</td>
    <td class="xl77"><fmt:formatNumber groupingUsed="true" value="${meetingBean.realityHotelMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl91" x:str>元/人天）；</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl81" x:str>2.</td>
    <td class="xl82" colspan="3" x:str>伙食费 <fmt:formatNumber groupingUsed="true" value="${meetingBean.foodMoney}" minFractionDigits="2" maxFractionDigits="2"/>元</td>
    <td class="xl78" x:str>（</td>
    <td class="xl77">${meetingBean.foodPersonNum}</td>
    <td class="xl77" x:str>人·天*</td>
    <td class="xl77"><fmt:formatNumber groupingUsed="true" value="${meetingBean.realityFoodMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl91" x:str>元/人天）；</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl81" x:str>3.</td>
    <td class="xl82" colspan="3" x:str>文件印刷费 <fmt:formatNumber groupingUsed="true" value="${meetingBean.printingMoney}" minFractionDigits="2" maxFractionDigits="2"/>元</td>
    <td class="xl78" x:str>（</td>
    <td class="xl77">${meetingBean.printingPersonNum}</td>
    <td class="xl77" x:str>人*</td>
    <td class="xl77"><fmt:formatNumber groupingUsed="true" value="${meetingBean.realityPrintingMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl91" x:str>元/人）；</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl81" x:str>4.</td>
    <td class="xl82" x:str>会议场租金</td>
    <td class="xl77" colspan="3"><fmt:formatNumber groupingUsed="true" value="${meetingBean.rentMoney}" minFractionDigits="2" maxFractionDigits="2"/>元；</td>
    <td class="xl77" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl84"></td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl81" x:str>5.</td>
    <td class="xl82" x:str>交通费</td>
    <td class="xl77" colspan="3"><fmt:formatNumber groupingUsed="true" value="${meetingBean.trafficMoney}" minFractionDigits="2" maxFractionDigits="2"/>元；</td>
    <td class="xl77" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl84"></td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl81" x:str>6.</td>
    <td class="xl82" x:str>其他费用</td>
    <td class="xl77" colspan="3"><fmt:formatNumber groupingUsed="true" value="${meetingBean.otherMoney}" minFractionDigits="2" maxFractionDigits="2"/>元；</td>
    <td class="xl77" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl84"></td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==0 }">checked="checked" </c:if>>基本支出</td>
    <td class="xl83" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==1 }">checked="checked" </c:if>> 项目支出名称（编号）：</td>
    <td class="xl84" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'> <c:if test="${pro.FProOrBasic!=0 }">${bean.proDetailName} </c:if></td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="93.33" rowspan="2" style='height:70.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审<font class="font5"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font5">批</font></td>
    <td class="xl76" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>项目负责人：</td>
    <td class="xl77" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${proHead }</td>
    <td class="xl78" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>部门负责人：</td>
    <td class="xl77">${role1 }</td>
    <td class="xl77" x:str>财务审核：</td>
    <td class="xl84">${role2 }</td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl76" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>主管校长：</td>
    <td class="xl77" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role3 }</td>
    <td class="xl78" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>校长：</td>
    <td class="xl77" colspan="2" style='mso-ignore:colspan;'>${role4 }</td>
    <td class="xl84"></td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl74" height="46.67" style='height:35.00pt;' x:str>校长办公会</td>
    <td class="xl83"></td>
    <td class="xl78" x:str>附</td>
    <td class="xl77" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.meetingSummaryYear1}</td>
    <td class="xl77" x:str>年第</td>
    <td class="xl77">${bean.meetingSummaryTime1}</td>
    <td class="xl82" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>次会议纪要</td>
    <td class="xl84"></td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="46.67" style='height:35.00pt;mso-height-source:userset;mso-height-alt:700;'>
    <td class="xl85" height="46.67" style='height:35.00pt;' x:str>党委会</td>
    <td class="xl86"></td>
    <td class="xl87" x:str>附</td>
    <td class="xl88" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;'>${bean.meetingSummaryYear2}</td>
    <td class="xl88" x:str>年第</td>
    <td class="xl88">${bean.meetingSummaryTime2}</td>
    <td class="xl89" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>次会议纪要</td>
    <td class="xl92"></td>
    <td class="xl90" colspan="7" style='mso-ignore:colspan;'></td>
    <td class="xl65" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="152" style='width:114;'></td>
     <td width="35" style='width:26;'></td>
     <td width="122" style='width:92;'></td>
     <td width="55" style='width:41;'></td>
     <td width="60" style='width:45;'></td>
     <td width="100" style='width:75;'></td>
     <td width="80" style='width:60;'></td>
     <td width="125" style='width:94;'></td>
     <td width="125" style='width:94;'></td>
     <td width="140" style='width:105;'></td>
     <td width="70" style='width:53;'></td>
     <td width="162" style='width:122;'></td>
     <td width="70" style='width:53;'></td>
     <td width="137" style='width:103;'></td>
     <td width="70" style='width:53;'></td>
     <td width="57" style='width:43;'></td>
     <td width="130" style='width:97;'></td>
     <td width="125" style='width:94;'></td>
     <td width="122" style='width:92;'></td>
     <td width="135" style='width:101;'></td>
     <td width="70" style='width:53;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">
  $(document).ready(function() {
		//生成二维码
	  $('#applymeeting').qrcode({
		render: "canvas",
		width   : 80,     //设置宽度  
		height  : 80, 
		x: 200, y: 100,
		text:'${urlbase}/expendPrintDetail?id='+${bean.gId}+'&type=apply'
	});
	window.print();
	});
  </script>
 </body>
</html>

