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
	mso-header-margin:0.51in;
	mso-footer-margin:0.51in;}
tr
	{mso-height-source:auto;
	mso-ruby-visibility:none;}
col
	{mso-width-source:auto;
	mso-ruby-visibility:none;}
br
	{mso-data-placement:same-cell;}
.font0
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font1
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font2
	{color:#000000;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font7
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font8
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font9
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font10
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font11
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font12
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font13
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font14
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font15
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font18
	{color:#FFFFFF;
	font-size:11.0pt;
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
	mso-font-charset:134;}
.font20
	{color:#FA7D00;
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
	mso-pattern:auto;
	mso-background-source:auto;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"常规";
	mso-style-id:0;}
.style16
	{mso-number-format:"_ \0022\00A5\0022* \#\,\#\#0_ \;_ \0022\00A5\0022* \\-\#\,\#\#0_ \;_ \0022\00A5\0022* \0022-\0022_ \;_ \@_ ";
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border:.5pt solid #7F7F7F;
	mso-style-name:"输入";}
.style19
	{mso-number-format:"_ \0022\00A5\0022* \#\,\#\#0\.00_ \;_ \0022\00A5\0022* \\-\#\,\#\#0\.00_ \;_ \0022\00A5\0022* \0022-\0022??_ \;_ \@_ ";
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-style-name:"60% - 强调文字颜色 3";}
.style25
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-style-name:"60% - 强调文字颜色 2";}
.style30
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-style-name:"标题 4";}
.style31
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-style-name:"警告文本";}
.style32
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-style-name:"标题";}
.style33
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-style-name:"解释性文本";}
.style34
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
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
	mso-generic-font-family:auto;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-style-name:"60% - 强调文字颜色 1";}
.style37
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
	mso-style-name:"强调文字颜色 2";}
.style44
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border-bottom:2.0pt double #FF8001;
	mso-style-name:"链接单元格";}
.style45
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-generic-font-family:auto;
	mso-font-charset:134;
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
	mso-pattern:auto;
	mso-background-source:auto;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-generic-font-family:auto;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;}
.xl65
	{mso-style-parent:style0;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	color:#000000;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	text-align:left;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:left;
	color:#000000;
	font-size:11.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
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
          <x:ActiveRow>0</x:ActiveRow>
          <x:RangeSelection>A1:D2</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:PageBreakZoom>100</x:PageBreakZoom>
        <x:Print>
         <x:ValidPrinterInfo/>
         <x:PaperSizeIndex>9</x:PaperSizeIndex>
        </x:Print>
       </x:WorksheetOptions>
      </x:ExcelWorksheet>
     </x:ExcelWorksheets>
     <x:ProtectStructure>False</x:ProtectStructure>
     <x:ProtectWindows>False</x:ProtectWindows>
     <x:WindowHeight>7860</x:WindowHeight>
     <x:WindowWidth>19815</x:WindowWidth>
    </x:ExcelWorkbook>
   </xml>
  <![endif]-->
 </head>
 <body link="blue" vlink="purple" class="xl65">
  <table width="737" border="0" cellpadding="0" cellspacing="0" style='width:552.75pt;border-collapse:collapse;'>
   <col width="182" class="xl65" style='mso-width-source:userset;mso-width-alt:5824;'/>
   <col width="197" class="xl65" style='mso-width-source:userset;mso-width-alt:6304;'/>
   <col width="161" class="xl65" style='mso-width-source:userset;mso-width-alt:5152;'/>
   <col width="197" class="xl65" style='mso-width-source:userset;mso-width-alt:6304;'/>
   <col width="72" span="252" class="xl65" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <tr height="18" class="xl65" style='height:13.50pt;'>
    <td class="xl66" height="36" width="737" colspan="4" rowspan="2" style='height:27.00pt;width:552.75pt;border-right:none;border-bottom:none;' x:str>广西交通职业技术学院直接报销单</td>
   </tr>
   <tr height="18" class="xl65" style='height:13.50pt;'/>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl65" height="29.33" style='height:22.00pt;' x:str>报销时间:<fmt:formatDate value="${bean.reqTime }" pattern="yyyy年MM月dd日"/></td>
    <td class="xl65" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl67" rowspan="2" style='border-right:none;border-bottom:none;' x:str id="reimburseDir"></td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl65" height="29.33" style='height:22.00pt;' x:str>单据编号:${bean.drCode}</td>
    <td class="xl65" colspan="2" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>经办人</td>
    <td class="xl68">${bean.userName}</td>
    <td class="xl68" x:str>经办部门</td>
    <td class="xl68">${bean.deptName}</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>支出项目</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.indexName}</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>事项摘要</td>
    <td class="xl68">${bean.summary}</td>
    <td class="xl68" x:str>报销类型</td>
    <td class="xl68">${bean.dirTypeName}</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>报销事由</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.reason}</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>常规支出</td>
    <td class="xl72" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><span style='mso-spacerun:yes;'>
    <input type="radio" name="standard" value="1" disabled="disabled" <c:if test="${bean.isconvention==1}">checked="checked"</c:if> />是
	<input type="radio" name="standard" value="0" <c:if test="${bean.isconvention !=1}">checked="checked"</c:if> />否
	</span></td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl69" height="29.33" colspan="4" style='height:22.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>费用明细</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>费用名称</td>
    <td class="xl68" x:str>报销金额（元）</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>描述</td>
   </tr>
   <c:if test="${!empty listDirectly}">
   		 <c:forEach items="${listDirectly }" var="directly">
		   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
		    <td class="xl68" height="29.33" style='height:22.00pt;'>${directly.costDetail }</td>
		    <td class="xl68">${directly.applySum }</td>
		    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${directly.remark }</td>
		   </tr>
		  </c:forEach>
   </c:if>
   <c:if test="${empty listDirectly}">
	   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
	    <td class="xl68" height="29.33" style='height:22.00pt;'>-</td>
	    <td class="xl68">-</td>
	    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	   </tr>
   </c:if>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl69" height="29.33" colspan="4" style='height:22.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>合计（元）</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>金额（小写）</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>金额（大写）</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.reimAmountcapital}</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl69" height="29.33" colspan="4" style='height:22.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>冲销借款</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl69" height="29.33" colspan="2" style='height:22.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>借款单编号</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>冲销借款（元）</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl69" height="29.33" colspan="2" style='height:22.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl69" height="29.33" colspan="4" style='height:22.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>收款人信息</td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl74" height="29.33" style='height:22.00pt;' x:str>收款人姓名</td>
    <td class="xl74" x:str>公务卡转账金额</td>
    <td class="xl74" x:str>收款人公务卡开户行</td>
    <td class="xl74" x:str>收款人公务卡账号</td>
   </tr>
   <c:if test="${!empty listPayee }">
   	<c:forEach items="${listPayee }" var="payee">
	   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
	    <td class="xl74" height="29.33" style='height:22.00pt;'>${payee.payeeName }</td>
	    <td class="xl74">${payee.payeeAmount }</td>
	    <td class="xl74">${payee.bankAccount }</td>
	    <td class="xl74">${payee.bank }</td>
	   </tr>
	</c:forEach>
   </c:if>
   <c:if test="${empty listPayee }">
	   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
	    <td class="xl74" height="29.33" style='height:22.00pt;'>-</td>
	    <td class="xl74">-</td>
	    <td class="xl74">-</td>
	    <td class="xl74">-</td>
	   </tr>
   </c:if>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl74" height="29.33" style='height:22.00pt;' x:str>个人转账金额</td>
    <td class="xl74" x:str>收款人个人卡开户行</td>
    <td class="xl74" x:str>收款人个人卡账号</td>
    <td class="xl74"></td>
   </tr>
   <c:if test="${!empty listPayee }">
   	<c:forEach items="${listPayee }" var="payee">
	   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
	    <td class="xl74" height="29.33" style='height:22.00pt;'>${payee.payeeAmountGR }</td>
	    <td class="xl74">${payee.zfbAccount }</td>
	    <td class="xl74">${payee.wxAccount }</td>
	    <td class="xl74">-</td>
	   </tr>
	</c:forEach>
	</c:if>
   <c:if test="${empty listPayee }">
	   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
	    <td class="xl74" height="29.33" style='height:22.00pt;'>-</td>
	    <td class="xl74">-</td>
	    <td class="xl74">-</td>
	    <td class="xl74">-</td>
	   </tr>
	</c:if>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl69" height="29.33" colspan="4" style='height:22.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审批</td>
   </tr>
   <c:forEach items="${listTProcessChecks }" var="listTProcess">
	   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
	    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>${listTProcess.fRoleName}</td>
	    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${listTProcess.fcheckRemake}</td>
	    <td class="xl69" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${listTProcess.fuserName}&nbsp;&nbsp;${listTProcess.fcheckTimes}</td>
	   </tr>
   </c:forEach>
   <!-- <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>归口管理部门负责人审核</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>会计审核</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>财务处负责人审核</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="29.33" class="xl65" style='height:22.00pt;mso-height-source:userset;mso-height-alt:440;'>
    <td class="xl68" height="29.33" style='height:22.00pt;' x:str>学校领导审核</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr> -->
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="182" style='width:137;'></td>
     <td width="197" style='width:148;'></td>
     <td width="161" style='width:121;'></td>
     <td width="197" style='width:148;'></td>
     <td width="72" style='width:54;'></td>
    </tr>
   <![endif]>
  </table>
<script type="text/javascript">
  $(document).ready(function() {
		//生成二维码
	 	$('#reimburseDir').qrcode({
			render: "canvas",
			width   : 50,     //设置宽度  
			height  : 50, 
			x: 200, y: 100,
			text:'${bean.drCode}'
		});
	  window.setTimeout(function (){
		CloseAfterPrint();
	  },500);
	});
	function CloseAfterPrint() {
		if (document.execCommand("print")) {
			window.open("${base}/exportApplyAndReim/PastePageDir?id="+ ${id});
		} else {
			window.close();
		}
	}
</script>
 </body>
</html>
