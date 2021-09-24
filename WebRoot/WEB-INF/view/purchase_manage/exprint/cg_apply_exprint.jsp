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
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font2
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:windowtext;
	font-size:24.0pt;
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
	font-family:"Times New Roman";
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
	{color:#FF0000;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font8
	{color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font9
	{color:#FF0000;
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
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font20
	{color:#44546A;
	font-size:13.0pt;
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
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font24
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font25
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font26
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font27
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font28
	{color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
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
	white-space:normal;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	vertical-align:top;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	vertical-align:top;
	white-space:normal;
	color:windowtext;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl73
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl74
	{mso-style-parent:style0;
	text-align:justify;
	vertical-align:top;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
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
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	font-weight:700;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl89
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl90
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	padding-left:27px;
	mso-char-indent-count:1;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	vertical-align:top;
	white-space:normal;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl96
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl97
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl98
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl99
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-right:.5pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl110
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	padding-left:27px;
	mso-char-indent-count:1;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-family:Times New Roman;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl112
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
 -->  </style>
 </head>
 <body link="blue" vlink="purple" class="xl65">
  <table width="1802.20" border="0" cellpadding="0" cellspacing="0" style='width:1351.65pt;border-collapse:collapse;'>
   <col width="109.27" class="xl65" style='mso-width-source:userset;mso-width-alt:3496;'/>
   <col width="204.40" class="xl65" style='mso-width-source:userset;mso-width-alt:6540;'/>
   <col width="129.67" class="xl65" style='mso-width-source:userset;mso-width-alt:4149;'/>
   <col width="84.93" class="xl65" style='mso-width-source:userset;mso-width-alt:2717;'/>
   <col width="210" class="xl65" style='mso-width-source:userset;mso-width-alt:6720;'/>
   <col width="92.40" class="xl65" style='mso-width-source:userset;mso-width-alt:2956;'/>
   <col width="241.67" class="xl65" style='mso-width-source:userset;mso-width-alt:7733;'/>
   <col width="120.40" class="xl65" style='mso-width-source:userset;mso-width-alt:3852;'/>
   <col width="202.53" class="xl65" style='mso-width-source:userset;mso-width-alt:6481;'/>
   <col width="21.47" class="xl65" style='mso-width-source:userset;mso-width-alt:686;'/>
   <col width="111.07" class="xl65" style='mso-width-source:userset;mso-width-alt:3554;'/>
   <col width="86.87" class="xl66" style='mso-width-source:userset;mso-width-alt:2779;'/>
   <col width="187.53" class="xl65" style='mso-width-source:userset;mso-width-alt:6001;'/>
   <col width="82.27" span="243" class="xl65" style='mso-width-source:userset;mso-width-alt:2632;'/>
   <tr height="36" style='height:27.00pt;mso-height-source:userset;mso-height-alt:540;'>
    <td class="xl67" height="36" width="109.27" style='height:27.00pt;width:81.95pt;' x:str>附件:</td>
    <td class="xl68" width="204.40" style='width:153.30pt;'></td>
    <td class="xl69" width="129.67" style='width:97.25pt;'></td>
    <td class="xl69" width="84.93" style='width:63.70pt;'></td>
    <td class="xl69" width="210" style='width:157.50pt;'></td>
    <td class="xl69" width="92.40" style='width:69.30pt;'></td>
    <td class="xl69" width="241.67" style='width:181.25pt;'></td>
    <td class="xl69" width="120.40" style='width:90.30pt;'></td>
    <td class="xl69" width="202.53" style='width:151.90pt;'></td>
    <td class="xl69" width="21.47" style='width:16.10pt;'></td>
    <td class="xl69" width="111.07" style='width:83.30pt;'></td>
    <td class="xl96" width="86.87" style='width:65.15pt;'></td>
    <td class="xl69" width="187.53" style='width:140.65pt;'></td>
   </tr>
   <tr height="18" style='height:13.50pt;'>
    <td class="xl69" height="18" colspan="11" style='height:13.50pt;mso-ignore:colspan;'></td>
    <td class="xl96"></td>
    <td class="xl69"></td>
   </tr>
   <tr height="152" style='height:114.00pt;mso-height-source:userset;mso-height-alt:2280;'>
    <td class="xl70" height="152" colspan="13" style='height:114.00pt;border-right:none;border-bottom:none;' x:str>天津现代职业技术学院货物服务项目采购申请表</td>
   </tr>
   <tr height="56" style='height:42.00pt;mso-height-source:userset;mso-height-alt:840;'>
    <td class="xl71" height="56" colspan="2" style='height:42.00pt;border-right:none;border-bottom:none;' x:str>申请部门（盖章）：</td>
    <td class="xl72" colspan="3" style='border-right:none;border-bottom:none;'>${bean.fDeptName }</td>
    <td class="xl73" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl71" x:str>经办人:${bean.fUserName }</td>
    <td class="xl97" colspan="2" style='border-right:none;border-bottom:none;'></td>
    <td class="xl98"></td>
    <td class="xl73"></td>
   </tr>
   <tr height="30.67" style='height:23.00pt;mso-height-source:userset;mso-height-alt:460;'>
    <td class="xl74" height="30.67" colspan="13" style='height:23.00pt;border-right:.5pt solid windowtext;border-bottom:none;' x:str>购置申请说明：（可附相关资料）</td>
   </tr>
   <tr height="66.67" style='height:50.00pt;mso-height-source:userset;mso-height-alt:1000;'>
    <td class="xl75" height="66.67" colspan="13" style='height:50.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>${bean.fRemark }</td>
   </tr>
   <tr height="57.33" style='height:43.00pt;mso-height-source:userset;mso-height-alt:860;'>
    <td class="xl76" height="57.33" style='height:43.00pt;' x:str>序号</td>
    <td class="xl76" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>货物或服务名称</td>
    <td class="xl77" x:str>数量</td>
    <td class="xl76" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>预算金额<font class="font28"><br/></font><font class="font1">（万元）</font></td>
    <td class="xl76" x:str>进口产品</td>
    <td class="xl76" x:str>论证</td>
    <td class="xl99" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>安装使用地点<font class="font28"><br/></font><font class="font1">服务周期</font></td>
    <td class="xl76" x:str>负责人</td>
   </tr>
   <c:if test="${!empty mingxiList }">
	   <c:forEach items="${mingxiList }" var="i" varStatus="j">
		   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
		    <td class="xl78" height="33.33" style='height:25.00pt;' x:num>${j.index+1 }</td>
		    <td class="xl79" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>${i.fpurName }</td>
		    <td class="xl79">${i.fnum }</td>
		    <td class="xl78" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.fsumMoney/10000 }" minFractionDigits="6" maxFractionDigits="6"/></td>
		    <td class="xl78" x:str><c:if test="${i.fIsImp=='1' }">是</c:if><c:if test="${i.fIsImp=='0' }">否</c:if></td>
		    <td class="xl78" x:str><c:if test="${i.fIsImp=='1' }">是</c:if><c:if test="${i.fIsImp=='0' }">否</c:if></td>
		    <td class="xl100" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fSiteAndPeriod }</td>
		    <td class="xl101" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fManager }</td>
		   </tr>
       </c:forEach>
   </c:if>
   <c:if test="${empty mingxiList }">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl78" height="33.33" style='height:25.00pt;' x:str>-</td>
    <td class="xl79" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl79">-</td>
    <td class="xl78" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl78" x:str>□<font class="font6">是</font><font class="font5">□</font><font class="font6">否</font></td>
    <td class="xl78" x:str>□<font class="font6">是</font><font class="font5">□</font><font class="font6">否</font></td>
    <td class="xl100" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl101">-</td>
   </tr>
   </c:if>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl80" height="33.33" colspan="2" style='height:25.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>资金所属项目：</td>
    <td class="xl81" colspan="5" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.proDetailName }</td>
    <td class="xl82" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>项目负责人：</td>
    <td class="xl102" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.proCharger }</td>
   </tr>
	
   <tr height="56" style='height:42.00pt;mso-height-source:userset;mso-height-alt:840;'>
    <td class="xl80" height="56" colspan="2" style='height:42.00pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>部门负责人（签字）：</td>
    <td class="xl83">${listTProcessChecks0.fuserName}</td>
    <td class="xl82" x:str>日期：</td>
    <td class="xl81" x:str>${listTProcessChecks0.fcheckTimes}</td>
    <td class="xl82" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>归口部门负责人（签字）</td>
    <td class="xl81">${listTProcessChecks1.fuserName}</td>
    <td class="xl82" x:str>采购方式：</td>
    <td class="xl103" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.fpmethod }</td>
    <td class="xl104" x:str>日期：</td>
    <td class="xl105" x:str>${listTProcessChecks1.fcheckTimes}</td>
   </tr>
   <tr height="78.67" style='height:59.00pt;mso-height-source:userset;mso-height-alt:1180;'>
    <td class="xl84" height="78.67" style='height:59.00pt;' x:str>意见：</td>
    <td class="xl85" colspan="3" style='border-right:none;border-bottom:none;'>${listTProcessChecks2.fcheckRemake}</td>
    <td class="xl84" x:str>意见：</td>
    <td class="xl86" colspan="3" style='border-right:none;border-bottom:none;'>${listTProcessChecks3.fcheckRemake}</td>
    <td class="xl84" x:str>意见：</td>
    <td class="xl86"></td>
    <td class="xl106" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:none;'>${listTProcessChecks4.fcheckRemake}</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl87" height="33.33" colspan="2" style='height:25.00pt;border-right:none;border-bottom:none;' x:str>部门主管院长（签字）：</td>
    <td class="xl88" colspan="2" style='border-right:none;border-bottom:none;'>${listTProcessChecks2.fuserName}</td>
    <td class="xl87" colspan="2" style='border-right:none;border-bottom:none;' x:str>归口部门主管院长（签字）：</td>
    <td class="xl89" colspan="2" style='border-right:none;border-bottom:none;'>${listTProcessChecks3.fuserName}</td>
    <td class="xl107" x:str>院长（签字）：</td>
    <td class="xl108" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;'>${listTProcessChecks4.fuserName}</td>
   </tr>
   <tr height="52" style='height:39.00pt;mso-height-source:userset;mso-height-alt:780;'>
    <td class="xl90" height="52" style='height:39.00pt;'></td>
    <td class="xl91" x:str>日期：</td>
    <td class="xl92" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>${listTProcessChecks2.fcheckTimes}</td>
    <td class="xl93"></td>
    <td class="xl91" x:str>日期：</td>
    <td class="xl94" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>${listTProcessChecks3.fcheckTimes}</td>
    <td class="xl109"></td>
    <td class="xl110"></td>
    <td class="xl111" x:str>日期：</td>
    <td class="xl112" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>${listTProcessChecks4.fcheckTimes}</td>
   </tr>
   <tr height="18" style='height:13.50pt;'>
    <td class="xl69" height="18" colspan="11" style='height:13.50pt;mso-ignore:colspan;'></td>
    <td class="xl96"></td>
    <td class="xl69"></td>
   </tr>
   <tr height="18" style='height:13.50pt;'>
    <td class="xl95" height="18" colspan="2" style='height:13.50pt;mso-ignore:colspan;'></td>
    <td class="xl69" colspan="9" style='mso-ignore:colspan;'></td>
    <td class="xl96"></td>
    <td class="xl69"></td>
   </tr>
  </table>
  
  <script type="text/javascript">
  $(document).ready(function() {
		//生成二维码
	  $('#applyreception').qrcode({
		render: "canvas",
		width   : 80,     //设置宽度  
		height  : 80, 
		x: 200, y: 100,
		text:'${urlbase}/expendPrintDetail?id='+${bean.fpId}+'&type=apply'
 	});
	window.print();
	}); 
  </script>
 </body>
</html>

