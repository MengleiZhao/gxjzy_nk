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
	mso-footer-margin:0.50in;
	mso-page-orientation:landscape;}
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
	{color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:#BFBFBF;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font7
	{color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font8
	{color:#FFFFFF;
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
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#006100;
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
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font19
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font20
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font21
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font22
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font23
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font24
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	white-space:normal;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:9.0pt;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	layout-flow:vertical;
	color:#BFBFBF;
	font-size:14.0pt;
	mso-font-charset:134;
	border-right:1.0pt dashed #000000;
	border-right-style:dot-dash;}
.xl69
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
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
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl74
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
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
	border-right:.5pt solid windowtext;
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
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
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
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl90
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
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
        <x:DefaultRowHeight>402</x:DefaultRowHeight>
        <x:Unsynced/>
        <x:Selected/>
        <x:TopRowVisible>6</x:TopRowVisible>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>7</x:ActiveCol>
          <x:ActiveRow>12</x:ActiveRow>
          <x:RangeSelection>H13</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:ShowPageBreakZoom/>
        <x:PageBreakZoom>80</x:PageBreakZoom>
        <x:Print>
         <x:ValidPrinterInfo/>
         <x:PaperSizeIndex>9</x:PaperSizeIndex>
         <x:Scale>63</x:Scale>
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
    <x:ExcelName>
     <x:Name>Print_Area</x:Name>
     <x:SheetIndex>1</x:SheetIndex>
     <x:Formula>=Sheet1!$A$1:$N$15</x:Formula>
    </x:ExcelName>
   </xml>
  <![endif]-->
 </head>
 <body link="blue" vlink="purple" class="xl67">
  <table width="1409.33" border="0" cellpadding="0" cellspacing="0" style='width:1057.00pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="92" class="xl67" style='mso-width-source:userset;mso-width-alt:2944;'/>
   <col width="49.60" class="xl67" style='mso-width-source:userset;mso-width-alt:1587;'/>
   <col width="87" class="xl67" style='mso-width-source:userset;mso-width-alt:2784;'/>
   <col width="80" class="xl67" style='mso-width-source:userset;mso-width-alt:2560;'/>
   <col width="177.47" class="xl67" style='mso-width-source:userset;mso-width-alt:5678;'/>
   <col width="144" class="xl67" style='mso-width-source:userset;mso-width-alt:4608;'/>
   <col width="71.20" class="xl67" style='mso-width-source:userset;mso-width-alt:2278;'/>
   <col width="137.47" class="xl67" style='mso-width-source:userset;mso-width-alt:4398;'/>
   <col width="57.47" class="xl67" style='mso-width-source:userset;mso-width-alt:1838;'/>
   <col width="127" class="xl67" style='mso-width-source:userset;mso-width-alt:4064;'/>
   <col width="86.27" class="xl67" style='mso-width-source:userset;mso-width-alt:2760;'/>
   <col width="141.20" class="xl67" style='mso-width-source:userset;mso-width-alt:4518;'/>
   <col width="57.47" class="xl67" style='mso-width-source:userset;mso-width-alt:1838;'/>
   <col width="101.20" class="xl67" style='mso-width-source:userset;mso-width-alt:3238;'/>
   <col width="72" span="242" class="xl67" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <tr height="106.67" style='height:80.00pt;mso-height-source:userset;mso-height-alt:1600;'>
    <td class="xl68" height="882.40" width="92" rowspan="15" style='height:661.80pt;width:69.00pt;border-right:1.0pt dashed #000000;border-right-style:dot-dash;border-bottom:none;' x:str>装<font class="font4"><br/></font><font class="font4">订</font><font class="font4"><br/></font><font class="font4">线</font></td>
    <td class="xl67" width="49.60" style='width:37.20pt;'></td>
    <td class="xl69" width="1267.73" colspan="10" style='width:950.80pt;border-right:none;border-bottom:none;padding-left: 150px;' x:str>天津现代职业技术学院财务报账单</td>
  	<td style="text-align: center;" colspan="2" id="receptionPayee"></td> 
   </tr>
   <tr height="49.33" style='height:37.00pt;mso-height-source:userset;mso-height-alt:740;'>
    <td class="xl67"></td>
    <td class="xl70" colspan="2" style='border-right:none;border-bottom:none;' x:str>报账部门：</td>
    <td class="xl70" colspan="2" style='border-right:none;border-bottom:none;'>${bean.deptName}</td>
    <td class="xl72"></td>
    <td class="xl73" x:str>经办人：</td>
    <td class="xl70" colspan="2" style='border-right:none;border-bottom:none;'>${bean.userName}</td>
    <td class="xl72"></td>
    <td class="xl89" colspan="3" style='border-right:none;border-bottom:none;' x:str>${time}</td>
   </tr>
   <tr height="52.80" class="xl65" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl65"></td>
    <td class="xl74" colspan="4" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>付款方式：${payType }</td>
    <td class="xl73" colspan="5" style='mso-ignore:colspan;'></td>
    <td class="xl73" x:str>附件</td>
    <td class="xl89"></td>
    <td class="xl89" x:str>张</td>
   </tr>
   <tr height="52.80" class="xl66" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl66"></td>
    <td class="xl75" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>摘<font class="font7"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font7">要</font></td>
    <td class="xl76" x:str>数<font class="font7"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font7">量</font></td>
    <td class="xl76" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>单<font class="font7"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font7">价</font></td>
    <td class="xl90" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金<font class="font7"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font7">额（元）</font></td>
   </tr>
   <c:if test="${!empty listHotel}">
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl67"></td>
    <td class="xl77" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>住宿费</td>
    <td class="xl78"></td>
    <td class="xl78" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl91" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${receptionBean.costHotel }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   </c:if>
    <c:if test="${!empty listFood}">
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl67"></td>
    <td class="xl77" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>餐费</td>
    <td class="xl78"></td>
    <td class="xl78" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl91" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${receptionBean.costFood }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   </c:if>
    <c:if test="${!empty listOther}">
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl67"></td>
    <td class="xl77" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>其他费用</td>
    <td class="xl78"></td>
    <td class="xl78" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl91" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${receptionBean.costOther }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   </c:if>
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl67"></td>
    <td class="xl79" colspan="12" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>对方单位全称</td>
   </tr>
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl67"></td>
    <td class="xl79" colspan="12" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${paymentPeople}</td>
   </tr>
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl67"></td>
    <td class="xl80" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>合计</td>
    <td class="xl81" x:str>人民币（大写）：</td>
    <td class="xl82" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.reimAmountcapital }</td>
    <td class="xl92" x:str>（小写）¥：</td>
    <td class="xl93" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="52.80" style='height:39.60pt;mso-height-source:userset;mso-height-alt:792;'>
    <td class="xl67"></td>
    <td class="xl83" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==0 }">checked="checked" </c:if>>基本支出</td>
    <td class="xl84" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox" disabled="disabled" <c:if test="${pro.FProOrBasic==1 }">checked="checked" </c:if>>项目支出名称（编号）：</td>
    <td class="xl85" colspan="8" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><c:if test="${pro.FProOrBasic==1  }">${bean.proDetailName}</c:if></td>
   </tr>
   <tr height="67.20" style='height:50.40pt;mso-height-source:userset;mso-height-alt:1008;'>
    <td class="xl67"></td>
    <td class="xl83" colspan="2" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审<font class="font6"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp; </span></font><font class="font6">批</font></td>
    <td class="xl84" x:str>项目负责人：</td>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${fPorHead}</td>
    <td class="xl86" x:str>部门负责人：</td>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role1}</td>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>归口管理部门负责人：</td>
    <td class="xl94" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2}</td>
   </tr>
   <tr height="67.20" style='height:50.40pt;mso-height-source:userset;mso-height-alt:1008;'>
    <td class="xl67"></td>
    <td class="xl84" x:str>主管校长：</td>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role4}</td>
    <td class="xl86" x:str>财务校长：</td>
    <td class="xl86" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl95" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>校<font class="font6"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp; </span></font><font class="font6">长：</font></td>
    <td class="xl94" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'></td>
   </tr>
   <tr height="64" style='height:48.00pt;mso-height-source:userset;mso-height-alt:960;'>
    <td class="xl67"></td>
    <td class="xl87" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>财务审核：</td>
    <td class="xl74" colspan="3" style='border-right:none;border-bottom:1.0pt solid windowtext;'>${financeCheck}</td>
    <td class="xl88" x:str>财务报销：</td>
    <td class="xl88" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;'></td>
    <td class="xl96" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>领款人：</td>
    <td class="xl97" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:1.0pt solid windowtext;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="92" style='width:69;'></td>
     <td width="50" style='width:37;'></td>
     <td width="87" style='width:65;'></td>
     <td width="80" style='width:60;'></td>
     <td width="177" style='width:133;'></td>
     <td width="144" style='width:108;'></td>
     <td width="71" style='width:53;'></td>
     <td width="137" style='width:103;'></td>
     <td width="57" style='width:43;'></td>
     <td width="127" style='width:95;'></td>
     <td width="86" style='width:65;'></td>
     <td width="141" style='width:106;'></td>
     <td width="57" style='width:43;'></td>
     <td width="101" style='width:76;'></td>
     <td width="72" style='width:54;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">
  $(document).ready(function() {
	//生成二维码
		 $('#receptionPayee').qrcode({
			render: "canvas",
			width   : 80,     //设置宽度  
			height  : 80, 
			x: 200, y: 100,
			text:'${urlbase}/expendPrintDetail?id='+${bean.rId}+'&type=reimburse'
	 	});
	}); 
  </script>
 </body>
</html>

