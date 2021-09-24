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
	{margin:0.59in 0.31in 0.20in 0.47in;
	mso-header-margin:0.00in;
	mso-footer-margin:0.00in;
	mso-horizontal-page-align:center;}
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
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font2
	{color:windowtext;
	font-size:12.0pt;
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
	font-size:14.0pt;
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
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
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
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font10
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font12
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#9C0006;
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
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#FA7D00;
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
	{color:#44546A;
	font-size:15.0pt;
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
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
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
	white-space:normal;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:12.0pt;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:#BFBFBF;
	font-size:14.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt dashed #D9D9D9;
	border-bottom-style:dot-dash;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:top;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
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
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
 -->  </style>
  <!--[if gte mso 9]>
   <xml>
    <x:ExcelWorkbook>
     <x:ExcelWorksheets>
      <x:ExcelWorksheet>
       <x:Name>其他事项事前申请表</x:Name>
       <x:WorksheetOptions>
        <x:DefaultRowHeight>402</x:DefaultRowHeight>
        <x:Unsynced/>
        <x:Selected/>
        <x:TopRowVisible>3</x:TopRowVisible>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>2</x:ActiveCol>
          <x:ActiveRow>13</x:ActiveRow>
          <x:RangeSelection>C14:D14</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:PageBreakZoom>100</x:PageBreakZoom>
        <x:Zoom>40</x:Zoom>
        <x:Print>
         <x:ValidPrinterInfo/>
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
 <body link="blue" vlink="purple" class="xl66">
  <table width="1097.40" border="0" cellpadding="0" cellspacing="0" style='width:823.05pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="97.47" class="xl66" style='mso-width-source:userset;mso-width-alt:3118;'/>
   <col width="62.80" class="xl66" style='mso-width-source:userset;mso-width-alt:2009;'/>
   <col width="74.27" class="xl66" style='mso-width-source:userset;mso-width-alt:2376;'/>
   <col width="84.33" class="xl66" style='mso-width-source:userset;mso-width-alt:2698;'/>
   <col width="93.33" class="xl66" style='mso-width-source:userset;mso-width-alt:2986;'/>
   <col width="122.53" class="xl66" style='mso-width-source:userset;mso-width-alt:3921;'/>
   <col width="87.13" class="xl66" style='mso-width-source:userset;mso-width-alt:2788;'/>
   <col width="47.47" class="xl66" style='mso-width-source:userset;mso-width-alt:1518;'/>
   <col width="64.80" class="xl66" style='mso-width-source:userset;mso-width-alt:2073;'/>
   <col width="85" class="xl66" style='mso-width-source:userset;mso-width-alt:2720;'/>
   <col width="134.27" class="xl66" style='mso-width-source:userset;mso-width-alt:4296;'/>
   <col width="72" span="245" class="xl66" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <tr height="41.60" style='height:31.20pt;mso-height-source:userset;mso-height-alt:624;'>
    <td class="xl67" height="41.60" width="953.40" colspan="11" style='height:31.20pt;width:715.05pt;border-right:none;border-bottom:1.0pt dashed #D9D9D9;border-bottom-style:dot-dash;' x:str>装<font class="font3"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font3">订</font><font class="font3"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font3">线</font></td>
    <td class="xl66" width="72" style='width:54.00pt;'></td>
    <td class="xl66" width="72" style='width:54.00pt;'></td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl68" height="138.67" colspan="10" style='height:104.00pt;border-right:none;border-bottom:none;' x:str>天津现代职业技术学院其他特殊经费支出事项事前申请表</td>
      	<td style="text-align: center;" colspan="1" id="applycomm"></td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="44.80" style='height:33.60pt;mso-height-source:userset;mso-height-alt:672;'>
    <td class="xl69" height="44.80" style='height:33.60pt;' x:str>申请部门：</td>
    <td class="xl70" colspan="3" style='border-right:none;border-bottom:none;'>${bean.deptName}</td>
    <td class="xl69"></td>
    <td class="xl71" x:str>经办人：</td>
    <td class="xl70" colspan="2" style='border-right:none;border-bottom:none;'>${bean.userNames}</td>
    <td class="xl71" colspan="3" style='border-right:none;border-bottom:none;' x:str>${time }</td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="42.80" style='height:32.10pt;mso-height-source:userset;mso-height-alt:642;'>
    <td class="xl72" height="200.40" colspan="11" rowspan="2" style='height:150.30pt;border-right:1.0pt solid windowtext;border-bottom:none;' x:str>申请事由说明：${bean.reason }</td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="157.60" style='height:118.20pt;mso-height-source:userset;mso-height-alt:2364;'>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="36" style='height:27.00pt;mso-height-source:userset;mso-height-alt:540;'>
    <td class="xl73" height="36" colspan="11" style='height:27.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font5">可另附页或文件</font></td>
    <td colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="42.80" class="xl65" style='height:32.10pt;mso-height-source:userset;mso-height-alt:642;'>
    <td class="xl74" height="42.80" colspan="6" style='height:32.10pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>支出明细</td>
    <td class="xl75" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金<font class="font5"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font5">额（元）</font></td>
    <td class="xl65" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <c:if test="${!empty mingxiList }">
   	<c:forEach items="${mingxiList }" var="i">
	   <tr height="42.80" class="xl65" style='height:32.10pt;mso-height-source:userset;mso-height-alt:642;'>
	    <td class="xl74" height="42.80" colspan="6" style='height:32.10pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.costDetail}</td>
	    <td class="xl75" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.applySum}" minFractionDigits="2" maxFractionDigits="2"/></td>
	    <td class="xl65" colspan="2" style='mso-ignore:colspan;'></td>
	   </tr>
      	</c:forEach>
   </c:if>
   <c:if test="${empty mingxiList }">
	   <tr height="42.80" class="xl65" style='height:32.10pt;mso-height-source:userset;mso-height-alt:642;'>
	    <td class="xl74" height="42.80" colspan="6" style='height:32.10pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	    <td class="xl75" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	    <td class="xl65" colspan="2" style='mso-ignore:colspan;'></td>
	   </tr>
   </c:if>
   <tr height="49.33" style='height:37.00pt;mso-height-source:userset;mso-height-alt:740;'>
    <td class="xl76" height="49.33" colspan="11" style='height:37.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font5">如有需要，可随附列表清单</font></td>
    <td class="xl66"></td>
   </tr>
   <tr height="41.20" style='height:30.90pt;mso-height-source:userset;mso-height-alt:618;'>
    <td class="xl74" height="41.20" colspan="2" style='height:30.90pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>合计</td>
    <td class="xl77" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>人民币（大写）：</td>
    <td class="xl78" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.applyAmountcapital }</td>
    <td class="xl79" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>（小写）¥：</td>
    <td class="xl89" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="41.20" style='height:30.90pt;mso-height-source:userset;mso-height-alt:618;'>
    <td class="xl74" height="41.20" colspan="2" style='height:30.90pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==0 }">checked="checked" </c:if>>基本支出</td>
    <td class="xl80" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==1 }">checked="checked" </c:if>>项目支出（名称）：<font class="font5"><span style='mso-spacerun:yes;'><c:if test="${pro.FProOrBasic==1 }">${bean.proDetailName }</c:if></span></font></td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="41.20" style='height:30.90pt;mso-height-source:userset;mso-height-alt:618;'>
    <td class="xl81" height="386.13" colspan="2" rowspan="6" style='height:289.60pt;border-right:.5pt solid windowtext;border-bottom:none;' x:str>审<font class="font5"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font5">批</font></td>
    <td class="xl82" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str>项目负责人：</td>
    <td class="xl83" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str>部门负责人：</td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="116" style='height:87.00pt;mso-height-source:userset;mso-height-alt:1740;'>
    <td class="xl84" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;'>${proHead }</td>
    <td class="xl85" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:none;'>${role1 }</td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="41.20" style='height:30.90pt;mso-height-source:userset;mso-height-alt:618;'>
    <td class="xl86" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font5">${proHeadYear }<c:if test="${empty proHeadYear}">&nbsp;&nbsp;</c:if>年</font><font class="font5"><span style='mso-spacerun:yes;'></span></font><font class="font5">${proHeadMonth }<c:if test="${empty proHeadMonth}">&nbsp;&nbsp;</c:if>月</font><font class="font5"><span style='mso-spacerun:yes;'></span></font><font class="font5">${proHeadDay }<c:if test="${empty proHeadDay}">&nbsp;&nbsp;</c:if>日</font><font class="font5"><span style='mso-spacerun:yes;'>&nbsp;</span></font></td>
    <td class="xl85" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font5">${roleYear1 }<c:if test="${empty roleYear1}">&nbsp;&nbsp;</c:if>年</font><font class="font5"><span style='mso-spacerun:yes;'></span></font><font class="font5">${roleMonth1 }<c:if test="${empty roleYear1}">&nbsp;&nbsp;</c:if>月</font><font class="font5"><span style='mso-spacerun:yes;'></span></font><font class="font5">${roleDay1 }<c:if test="${empty roleYear1}">&nbsp;&nbsp;</c:if>日</font><font class="font5"><span style='mso-spacerun:yes;'>&nbsp;</span></font></td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="41.20" style='height:30.90pt;mso-height-source:userset;mso-height-alt:618;'>
    <td class="xl82" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str>主管校长：</td>
    <td class="xl83" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str>校<font class="font5"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font5">长：</font></td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="105.33" style='height:79.00pt;mso-height-source:userset;mso-height-alt:1580;'>
    <td class="xl84" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;'>${role2 }</td>
    <td class="xl85" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:none;'>${role3 }</td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="41.20" style='height:30.90pt;mso-height-source:userset;mso-height-alt:618;'>
    <td class="xl86" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font5">${roleYear2}<c:if test="${empty roleYear2}">&nbsp;&nbsp;</c:if>年</font><font class="font5"><span style='mso-spacerun:yes;'> </span></font><font class="font5">${roleMonth2}<c:if test="${empty roleYear2}">&nbsp;&nbsp;</c:if>月</font><font class="font5"><span style='mso-spacerun:yes;'> </span></font><font class="font5">${roleDay2}<c:if test="${empty roleYear2}">&nbsp;&nbsp;</c:if>日</font><font class="font5"><span style='mso-spacerun:yes;'>&nbsp;</span></font></td>
    <td class="xl85" colspan="5" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font5">${roleYear3}<c:if test="${empty roleYear3}">&nbsp;&nbsp;</c:if>年</font><font class="font5"><span style='mso-spacerun:yes;'> </span></font><font class="font5">${roleMonth3}<c:if test="${empty roleYear3}">&nbsp;</c:if>月</font><font class="font5"><span style='mso-spacerun:yes;'> </span></font><font class="font5">${roleDay3}<c:if test="${empty roleYear3}">&nbsp;&nbsp;</c:if>日</font><font class="font5"><span style='mso-spacerun:yes;'>&nbsp;</span></font></td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="64.80" style='height:48.60pt;mso-height-source:userset;mso-height-alt:972;'>
    <td class="xl81" height="64.80" colspan="2" style='height:48.60pt;border-right:.5pt solid windowtext;border-bottom:none;' x:str>备<font class="font5"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font5">注</font></td>
    <td class="xl87" colspan="9" style='border-right:1.0pt solid windowtext;border-bottom:none;'></td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="73.33" style='height:55.00pt;mso-height-source:userset;mso-height-alt:1100;'>
    <td class="xl88" height="73.33" colspan="11" style='height:55.00pt;border-right:1.0pt solid windowtext;border-bottom:1.0pt solid windowtext;' x:str>若申请事项是重点经费且有归口管理部门的，部门负责人处还需归口管理部门负责人签字，总金额大于等于一万元的，须签批至校长。</td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="97" style='width:73;'></td>
     <td width="63" style='width:47;'></td>
     <td width="74" style='width:56;'></td>
     <td width="84" style='width:63;'></td>
     <td width="93" style='width:70;'></td>
     <td width="123" style='width:92;'></td>
     <td width="87" style='width:65;'></td>
     <td width="47" style='width:36;'></td>
     <td width="65" style='width:49;'></td>
     <td width="85" style='width:64;'></td>
     <td width="134" style='width:101;'></td>
     <td width="72" style='width:54;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">
	$(document).ready(function() {
		
		//生成二维码
		 $('#applycomm').qrcode({
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
