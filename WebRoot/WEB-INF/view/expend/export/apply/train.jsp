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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font2
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:#BFBFBF;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:windowtext;
	font-size:22.0pt;
	font-weight:700;
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
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
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
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#006100;
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
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
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
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
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
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font24
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
	font-size:12.0pt;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	vertical-align:bottom;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	color:#BFBFBF;
	font-size:14.0pt;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-bottom:1.0pt dashed windowtext;
	border-bottom-style:dot-dash;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	text-align:center;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:left;
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
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl73
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl74
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
.xl75
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
.xl76
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
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
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
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
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
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
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
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl95
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
.xl96
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl100
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
.xl101
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl102
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
.xl103
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	text-align:center;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
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
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>11</x:ActiveCol>
          <x:ActiveRow>29</x:ActiveRow>
          <x:RangeSelection>L30</x:RangeSelection>
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
     <x:WindowHeight>7860</x:WindowHeight>
     <x:WindowWidth>19815</x:WindowWidth>
    </x:ExcelWorkbook>
   </xml>
  <![endif]-->
 </head>
 <body link="blue" vlink="purple" class="xl66">
  <table width="1672.87" border="0" cellpadding="0" cellspacing="0" style='width:1254.65pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="157.47" class="xl66" style='mso-width-source:userset;mso-width-alt:5038;'/>
   <col width="160" class="xl66" style='mso-width-source:userset;mso-width-alt:5120;'/>
   <col width="45" class="xl66" style='mso-width-source:userset;mso-width-alt:1440;'/>
   <col width="145" class="xl66" style='mso-width-source:userset;mso-width-alt:4640;'/>
   <col width="62" class="xl66" style='mso-width-source:userset;mso-width-alt:1984;'/>
   <col width="47.47" class="xl66" style='mso-width-source:userset;mso-width-alt:1518;'/>
   <col width="169.93" class="xl66" style='mso-width-source:userset;mso-width-alt:5437;'/>
   <col width="70.40" span="4" class="xl66" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <col width="148" class="xl66" style='mso-width-source:userset;mso-width-alt:4736;'/>
   <col width="140" class="xl66" style='mso-width-source:userset;mso-width-alt:4480;'/>
   <col width="40" class="xl66" style='mso-width-source:userset;mso-width-alt:1280;'/>
   <col width="148" class="xl66" style='mso-width-source:userset;mso-width-alt:4736;'/>
   <col width="58" class="xl66" style='mso-width-source:userset;mso-width-alt:1856;'/>
   <col width="70.40" span="4" class="xl66" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <col width="100" class="xl66" style='mso-width-source:userset;mso-width-alt:3200;'/>
   <col width="70.40" span="235" class="xl66" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl67" height="33.33" width="998.07" colspan="10" style='height:25.00pt;width:748.55pt;border-right:none;border-bottom:1.0pt dashed windowtext;border-bottom-style:dot-dash;' x:str>装<span style='mso-spacerun:yes;'>&nbsp; </span>订<span style='mso-spacerun:yes;'>&nbsp; </span>线</td>
    <td class="xl66" width="70.40" style='width:52.80pt;'></td>
    <td class="xl66" width="148" style='width:111.00pt;'></td>
    <td class="xl66" width="140" style='width:105.00pt;'></td>
    <td class="xl66" width="40" style='width:30.00pt;'></td>
    <td class="xl66" width="148" style='width:111.00pt;'></td>
    <td class="xl66" width="58" style='width:43.50pt;'></td>
    <td class="xl66" width="70.40" style='width:52.80pt;'></td>
   </tr>
   <tr height="77.33" style='height:58.00pt;mso-height-source:userset;mso-height-alt:1160;'>
    <td class="xl68" height="77.33" colspan="8" style='height:58.00pt;border-right:none;border-bottom:none;' x:str>天津现代职业技术学院培训费申请表</td>
    <td style="text-align: center;" colspan="2" id="applytrain"></td> 
    <td class="xl66" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl70" height="33.33" style='height:25.00pt;' x:str>申请人：</td>
    <td class="xl70">${bean.userNames}</td>
    <td class="xl71" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl72" colspan="2" style='border-right:none;border-bottom:none;' x:str>申请日期：</td>
    <td class="xl73" colspan="3" style='border-right:none;border-bottom:none;' x:str>${time }</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl74" height="33.33" style='height:25.00pt;' x:str>申请部门</td>
    <td class="xl75" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.deptName}</td>
    <td class="xl75" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>申请金额（元）</td>
    <td class="xl75" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" style='height:25.00pt;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==0 }">checked="checked" </c:if>>基本支出</td>
    <td class="xl77" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==1 }">checked="checked" </c:if>>项目支出名称（编号）：</td>
    <td class="xl79" colspan="6" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><c:if test="${pro.FProOrBasic==1  }">${bean.proDetailName }</c:if></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" style='height:25.00pt;' x:str>申请事由</td>
    <td class="xl77" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${trainingBean.trainingName}</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" style='height:25.00pt;' x:str>培训起止日期</td>
    <td class="xl81" x:str>自</td>
    <td class="xl82" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str><fmt:formatDate value="${trainingBean.trDateStart}" pattern="yyyy年MM月dd日"/></td>
    <td class="xl82" x:str>——</td>
    <td class="xl82" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str><fmt:formatDate value="${trainingBean.trDateEnd}" pattern="yyyy年MM月dd日"/></td>
    <td class="xl83" x:str>共</td>
    <td class="xl82">${trainingBean.trDayNum }</td>
    <td class="xl103" x:str>天</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" style='height:25.00pt;' x:str>培训地点</td>
    <td class="xl77" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${trainingBean.trPlace}</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" style='height:25.00pt;' x:str>参训人数</td>
    <td class="xl77" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${trainingBean.trAttendNum}</td>
    <td class="xl77" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>工作人数</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${trainingBean.trStaffNum}</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" style='height:25.00pt;' x:str>参训人员说明</td>
    <td class="xl77" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${trainingBean.trAttendPeop }</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="10" style='height:25.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>培训日程</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>时间安排</td>
    <td class="xl84" colspan="6" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>事项安排</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <c:if test="${!empty listMeetPlan}">
	<c:forEach items="${listMeetPlan }" var="i">
		<tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
		<td class="xl76" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatDate value="${i.timeStart }" pattern="yyyy-MM-dd HH:ss"/> - <fmt:formatDate value="${i.timeEnd }" pattern="yyyy-MM-dd HH:ss"/></td>
		<td class="xl84" colspan="6" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.arrange }</td>
		<td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
		 <td class="xl109"></td>
		</tr>
 	</c:forEach>
   </c:if>
   <c:if test="${empty listMeetPlan}">
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl85" colspan="6" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>-</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   </c:if>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="10" style='height:25.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>费用明细</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="10" style='height:25.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>师资费</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl87" height="33.33" colspan="10" style='height:25.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>师资费——讲课费</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" style='height:25.00pt;' x:str>讲师姓名</td>
    <td class="xl77" x:str>学时</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>课时费标准（元/学时）</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额（元）</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
	<c:if test="${!empty listTeacherCost}">
	<c:forEach items="${listTeacherCost }" var="i">
	   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
	    <td class="xl76" height="33.33" style='height:25.00pt;'>${i.lecturerName }</td>
	    <td class="xl77">${i.lessonTime }</td>
	    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.realityLessonStd }" minFractionDigits="2" maxFractionDigits="2"/></td>
	    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.applySum }" minFractionDigits="2" maxFractionDigits="2"/></td>
	    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
	    <td class="xl109"></td>
	   </tr>
   </c:forEach>
   </c:if>
   
   <c:if test="${empty listTeacherCost}">
	   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
	    <td class="xl76" height="33.33" style='height:25.00pt;'>-</td>
	    <td class="xl77">-</td>
	    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
	    <td class="xl109"></td>
	   </tr>
   </c:if>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl87" height="33.33" colspan="10" style='height:25.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>师资费——住宿费</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>住宿人天</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>住宿标准（元/人）</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额（元）</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   
   	<c:if test="${!empty listHotel}">
	<c:forEach items="${listHotel }" var="i">
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.hotelDay }</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.realityHotelStd }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.applySum }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   </c:forEach>
   </c:if>
   
   	<c:if test="${empty listHotel}">
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   </c:if>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl87" height="33.33" colspan="10" style='height:25.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>师资费——伙食费</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>用餐人天</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>用餐标准（元/人·天）</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额（元）</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   
   	<c:if test="${!empty listFood}">
	<c:forEach items="${listFood }" var="i">   
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.foodDay }</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.realityFoodStd }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.applySum }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   </c:forEach>
   </c:if>
   
   	<c:if test="${empty listFood}">
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   </c:if>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl89" height="33.33" colspan="2" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>师资费——城市间交通费</td>
    <td class="xl82" colspan="4" style='mso-ignore:colspan;'></td>
    <td class="xl82" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>金额（元）:</td>
    <td class="xl82" colspan="2" style='text-align:left;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${listTraffic1applySum }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl89" height="33.33" colspan="2" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>师资费——其他</td>
    <td class="xl82" colspan="4" style='mso-ignore:colspan;'></td>
    <td class="xl82" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>金额（元）:</td>
    <td class="xl82" colspan="2" style='text-align:left;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${listTraffic2applySum }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="10" style='height:25.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>综合定额费用</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>住宿人天</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>住宿标准（元/人·天）</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额（元）</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.hotelPersonNum}"/></td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.realityHotelMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.hotelMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>用餐人天</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>用餐标准（元/人·天）</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额（元）</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.foodPersonNum}"/></td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.realityFoodMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.foodMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>培训资料发放人数</td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>培训资料费标准（元/人）</td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额（元）</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="2" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.dataPersonNum}"/></td>
    <td class="xl77" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.realityDataMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl77" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.dataMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl91" height="33.33" colspan="2" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>培训场地费</td>
    <td class="xl93" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl83" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>金额（元）:</td>
    <td class="xl82" colspan="2" style='text-align:left;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.spaceMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl91" height="33.33" colspan="2" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>交通费</td>
    <td class="xl93" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl83" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>金额（元）:</td>
    <td class="xl82" colspan="2" style='text-align:left;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.transportMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl91" height="33.33" colspan="2" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>其他费用</td>
    <td class="xl93" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl83" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>金额（元）:</td>
    <td class="xl82" colspan="2" style='text-align:left;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${trainingBean.costThreeTermsStd}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="66.67" rowspan="2" style='height:50.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审批</td>
    <td class="xl78" x:str>项目负责人：</td>
    <td class="xl82">${proHead }</td>
    <td class="xl83" x:str>部门负责人：</td>
    <td class="xl93" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role1 }</td>
    <td class="xl94" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>归口管理部门负责人：</td>
    <td class="xl93" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2 }</td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl78" x:str>主管校长：</td>
    <td class="xl82">${role3 }</td>
    <td class="xl83" x:str>校长：</td>
    <td class="xl93" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role4 }</td>
    <td class="xl82" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl106"></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" style='height:25.00pt;' x:str>校长办公会</td>
    <td class="xl78"></td>
    <td class="xl83" x:str>附</td>
    <td class="xl82">${bean.meetingSummaryYear1 }</td>
    <td class="xl82" x:str>年第</td>
    <td class="xl82">${bean.meetingSummaryTime1 }</td>
    <td class="xl90" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>次会议纪要</td>
    <td class="xl82"></td>
    <td class="xl106"></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <tr height="33.33" class="xl65" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl95" height="33.33" style='height:25.00pt;' x:str>党委会</td>
    <td class="xl96"></td>
    <td class="xl97" x:str>附</td>
    <td class="xl98">${bean.meetingSummaryYear2 }</td>
    <td class="xl98" x:str>年第</td>
    <td class="xl98">${bean.meetingSummaryTime2 }</td>
    <td class="xl99" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>次会议纪要</td>
    <td class="xl98"></td>
    <td class="xl108"></td>
    <td class="xl71" colspan="6" style='mso-ignore:colspan;'></td>
    <td class="xl109"></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="157" style='width:118;'></td>
     <td width="160" style='width:120;'></td>
     <td width="45" style='width:34;'></td>
     <td width="145" style='width:109;'></td>
     <td width="62" style='width:47;'></td>
     <td width="47" style='width:36;'></td>
     <td width="170" style='width:127;'></td>
     <td width="70" style='width:53;'></td>
     <td width="148" style='width:111;'></td>
     <td width="140" style='width:105;'></td>
     <td width="40" style='width:30;'></td>
     <td width="148" style='width:111;'></td>
     <td width="58" style='width:44;'></td>
     <td width="70" style='width:53;'></td>
     <td width="100" style='width:75;'></td>
     <td width="70" style='width:53;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">
  $(document).ready(function() {
		//生成二维码
	  $('#applytrain').qrcode({
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

