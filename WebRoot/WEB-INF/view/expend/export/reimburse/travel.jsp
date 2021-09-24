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
	{mso-header-data:"&C装   订   线\000A-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-";
	margin:1.00in 0.47in 1.00in 0.39in;
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
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font10
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font11
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
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
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font14
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font19
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font20
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font21
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font22
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font24
	{color:#800080;
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
	font-size:14.0pt;
	mso-font-charset:134;
	border-bottom:.5pt dashed windowtext;
	border-bottom-style:dot-dash;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	white-space:normal;
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
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:right;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
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
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:right;
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
	font-size:16.0pt;
	mso-font-charset:134;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
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
       <x:Name>Sheet1</x:Name>
       <x:WorksheetOptions>
        <x:DefaultRowHeight>270</x:DefaultRowHeight>
        <x:Selected/>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>1</x:ActiveCol>
          <x:ActiveRow>6</x:ActiveRow>
          <x:RangeSelection>B7</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:CodeName>Sheet1</x:CodeName>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:ShowPageBreakZoom/>
        <x:PageBreakZoom>40</x:PageBreakZoom>
        <x:Print>
         <x:ValidPrinterInfo/>
         <x:PaperSizeIndex>9</x:PaperSizeIndex>
         <x:Scale>66</x:Scale>
         <x:HorizontalResolution>600</x:HorizontalResolution>
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
    <x:ExcelName>
     <x:Name>Print_Area</x:Name>
     <x:SheetIndex>1</x:SheetIndex>
     <x:Formula>=Sheet1!$A$1:$I$33</x:Formula>
    </x:ExcelName>
   </xml>
  <![endif]-->
 </head>
 <body link="blue" vlink="purple">
  <table width="1021.80" border="0" cellpadding="0" cellspacing="0" style='width:766.35pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="134.93" style='mso-width-source:userset;mso-width-alt:4317;'/>
   <col width="147.47" style='mso-width-source:userset;mso-width-alt:4718;'/>
   <col width="99.93" style='mso-width-source:userset;mso-width-alt:3197;'/>
   <col width="157.47" style='mso-width-source:userset;mso-width-alt:5038;'/>
   <col width="135" style='mso-width-source:userset;mso-width-alt:4320;'/>
   <col width="10" style='mso-width-source:userset;mso-width-alt:320;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="152.53" style='mso-width-source:userset;mso-width-alt:4881;'/>
   <col width="112.47" style='mso-width-source:userset;mso-width-alt:3598;'/>
   <tr height="37.33" style='height:28.00pt;mso-height-source:userset;mso-height-alt:560;'>
    <td class="xl65" height="37.33" width="1021.80" colspan="9" style='height:28.00pt;width:766.35pt;border-right:none;border-bottom:.5pt dashed windowtext;border-bottom-style:dot-dash;' x:str>装订线</td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl66" height="138.67" colspan="7" style='height:104.00pt;border-right:none;border-bottom:none;' x:str>天津现代职业技术学院差旅费报销单</td>
  	<td style="text-align: center;" colspan="2" id="reimbursetravel"></td> 
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl67" height="33.33" style='height:25.00pt;' x:str>报账部门：</td>
    <td class="xl68" colspan="2" style='border-right:none;border-bottom:none;'>${bean.deptName }</td>
    <td class="xl69" x:str>经办人：</td>
    <td class="xl67">${bean.userName}</td>
    <td class="xl70" colspan="4" style='border-right:none;border-bottom:none;' x:str>${time }</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl67" height="33.33" style='height:25.00pt;'></td>
    <td class="xl68" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl67"></td>
    <td class="xl68"></td>
    <td class="xl69" colspan="2" style='border-right:none;border-bottom:none;' x:str>附单据</td>
    <td class="xl71"></td>
    <td class="xl71" x:str>张</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;' x:str>出差人员</td>
    <td class="xl73" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.travelpepol }<</td>
    <td class="xl72" x:str>出差人数</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${travelpepolnumber }</td>
    <td class="xl72" x:str>出差地点</td>
    <td class="xl73">${travelAreaName }</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl74" height="33.33" colspan="9" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>行程清单</td>
   </tr>
   <tr height="52" style='height:39.00pt;mso-height-source:userset;mso-height-alt:780;'>
    <td class="xl72" height="52" style='height:39.00pt;' x:str>出发时间</td>
    <td class="xl72" x:str>撤离时间/<font class="font3"><br/></font><font class="font3">抵津时间</font></td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>目的地</td>
    <td class="xl72" x:str>人员</td>
    <td class="xl72" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>主要工作内容</td>
   </tr>
   
   <c:if test="${!empty travellist }">
   <c:forEach items="${travellist }" var="i">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;'><fmt:formatDate value="${i.travelDateStart }" pattern="yyyy-MM-dd"/></td>
    <td class="xl72"><fmt:formatDate value="${i.travelDateEnd }" pattern="yyyy-MM-dd"/></td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.travelAreaName }</td>
    <td class="xl75">${i.travelAttendPeop }</td>
    <td class="xl72" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.reason }</td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty travellist }">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;'>-</td>
    <td class="xl72">-</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl75">-</td>
    <td class="xl72" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl74" height="33.33" colspan="9" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>费用明细</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="9" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>城市间交通费</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;' x:str>出发日期</td>
    <td class="xl72" x:str>到达日期</td>
    <td class="xl72" x:str>交通工具</td>
    <td class="xl77" x:str>交通工具级别</td>
    <td class="xl78" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>出行人员</td>
    <td class="xl72" x:str>报销金额</td>
   </tr>
   <c:if test="${!empty outsidelist }">
   <c:forEach items="${outsidelist }" var="ol">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl77" height="33.33" style='height:25.00pt;'><fmt:formatDate value="${ol.fStartDate }" pattern="yyyy-MM-dd"/></td>
    <td class="xl77"><fmt:formatDate value="${ol.fEndDate }" pattern="yyyy-MM-dd"/></td>
    <td class="xl77">${ol.vehicle }</td>
    <td class="xl77">${ol.vehicleLevel }</td>
    <td class="xl79" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;'>${ol.travelPersonnel }</td>
    <td class="xl77"><fmt:formatNumber groupingUsed="true" value="${ol.reimbAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty outsidelist }">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl77" height="33.33" style='height:25.00pt;'>-</td>
    <td class="xl77">-</td>
    <td class="xl77">-</td>
    <td class="xl77">-</td>
    <td class="xl79" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl77">-</td>
   </tr>
   </c:if>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="9" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>住宿费</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;' x:str>入住时间</td>
    <td class="xl72" x:str>退房时间</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>所在城市</td>
    <td class="xl72" x:str>住宿人员</td>
    <td class="xl72" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>同住人员</td>
    <td class="xl72" x:str>报销金额</td>
   </tr>
   <c:if test="${!empty hotellist }">
   <c:forEach items="${hotellist }" var="hl">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;'><fmt:formatDate value="${hl.checkInTime }" pattern="yyyy-MM-dd"/></td>
    <td class="xl72"><fmt:formatDate value="${hl.checkOUTTime }" pattern="yyyy-MM-dd"/></td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${hl.locationCity }</td>
    <td class="xl72">${hl.travelPersonnel }</td>
    <td class="xl72" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${hl.travelChummage }</td>
    <td class="xl72"><fmt:formatNumber groupingUsed="true" value="${hl.reimbAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty hotellist }">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;'>-</td>
    <td class="xl72">-</td>
    <td class="xl72" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl72">-</td>
    <td class="xl72" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl72">-</td>
   </tr>
   </c:if>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="9" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>市内交通费</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>姓名</td>
    <td class="xl72" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>补贴金额</td>
   </tr>
   <c:if test="${!empty inCitylist }">
   <c:forEach items="${inCitylist }" var="icl">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${icl.fPerson }</td>
    <td class="xl72" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${icl.fReimbAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty inCitylist }">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl72" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76" height="33.33" colspan="9" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>伙食补助费</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>姓名</td>
    <td class="xl72" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>补贴金额</td>
   </tr>
   <c:if test="${!empty foodlist }">
   <c:forEach items="${foodlist }" var="fl">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${fl.fname }</td>
    <td class="xl72" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${icl.fReimbAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty foodlist }">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" colspan="4" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl72" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <c:if test="${!empty receptionOtherlist }">
   <c:forEach items="${receptionOtherlist }" var="rol">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl80" height="33.33" colspan="4" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>${rol.fCostName }</td>
    <td class="xl81" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>报销金额：<font class="font3"><span style='mso-spacerun:yes;'><fmt:formatNumber groupingUsed="true" value="${icl.fTeacherCost+icl.fStudentCost}" minFractionDigits="2" maxFractionDigits="2"/></span></font><font class="font3">元</font></td>
   </tr>
   </c:forEach>
   </c:if>
   <c:if test="${empty receptionOtherlist }">   
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl80" height="33.33" colspan="4" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>培训费</td>
    <td class="xl81" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>报销金额：<font class="font3"><span style='mso-spacerun:yes;'>0.00</span></font><font class="font3">元</font></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl80" height="33.33" colspan="4" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>会务费</td>
    <td class="xl81" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>报销金额：<font class="font3"><span style='mso-spacerun:yes;'>0.00 </span></font><font class="font3">元</font></td>
   </tr>
   </c:if>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl74" height="33.33" colspan="9" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>报销金额合计（元)</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;' x:str>金额(小写）</td>
    <td class="xl72" colspan="8" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl72" height="33.33" style='height:25.00pt;' x:str>金额(大写）</td>
    <td class="xl72" colspan="8" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.reimAmountcapital }</td>
   </tr>
   <tr height="52" style='height:39.00pt;mso-height-source:userset;mso-height-alt:780;'>
    <td class="xl72" height="52" colspan="2" style='height:39.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled"  <c:if test="${pro.FProOrBasic==0  }">checked="checked" readonly="readonly"</c:if>>基本支出</td>
    <td class="xl82" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled"  <c:if test="${pro.FProOrBasic==1  }">checked="checked" readonly="readonly"</c:if>>项目支出名称（编号）：</td>
    <td class="xl82" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><c:if test="${pro.FProOrBasic==1  }">${bean.proDetailName }</c:if></td>
   </tr>
   <tr height="64" style='height:48.00pt;mso-height-source:userset;mso-height-alt:960;'>
    <td class="xl82" height="124" rowspan="2" style='height:93.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审批</td>
    <td class="xl83" x:str>项目负责人：</td>
    <td class="xl84">${proHead }</td>
    <td class="xl83" x:str>部门负责人：</td>
    <td class="xl85">${role1 }</td>
    <td class="xl83" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>归口管理部门负责人：</td>
    <td class="xl89">${role2 }</td>
   </tr>
   <tr height="60" style='height:45.00pt;mso-height-source:userset;mso-height-alt:900;'>
    <td class="xl83" x:str>主管校长：</td>
    <td class="xl84">${role3 }</td>
    <td class="xl83" x:str>财务校长：</td>
    <td class="xl85">${role4 }</td>
    <td class="xl83" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>校长：</td>
    <td class="xl90">${role5 }</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl78" height="33.33" style='height:25.00pt;' x:str>财务审核：</td>
    <td class="xl86" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${financeCheck }</td>
    <td class="xl87" x:str>财务报销：</td>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl88" x:str>领款人：</td>
    <td class="xl91"></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td height="33.33" colspan="9" style='height:25.00pt;mso-ignore:colspan;'></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td height="33.33" colspan="9" style='height:25.00pt;mso-ignore:colspan;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="135" style='width:101;'></td>
     <td width="147" style='width:111;'></td>
     <td width="100" style='width:75;'></td>
     <td width="157" style='width:118;'></td>
     <td width="135" style='width:101;'></td>
     <td width="10" style='width:8;'></td>
     <td width="72" style='width:54;'></td>
     <td width="153" style='width:114;'></td>
     <td width="112" style='width:84;'></td>
    </tr>
   <![endif]>
  </table>
   <script type="text/javascript">

  $(document).ready(function() {
		//生成二维码
	  $('#reimbursetravel').qrcode({
		render: "canvas",
		width   : 80,     //设置宽度  
		height  : 80, 
		x: 200, y: 100,
		text:'${urlbase}/expendPrintDetail?id='+${bean.rId}+'&type=reimburse'
 	});
	  window.setTimeout(function (){
		//CloseAfterPrint();
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