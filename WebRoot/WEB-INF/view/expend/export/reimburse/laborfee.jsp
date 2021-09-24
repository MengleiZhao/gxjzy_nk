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
	{color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:#000000;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font7
	{color:#000000;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font9
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font10
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font11
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font12
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font13
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font15
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font21
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font22
	{color:#006100;
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
	font-weight:700;
	font-style:normal;
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
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font26
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font27
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font28
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font29
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font30
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
	{mso-number-format:"General";
	text-align:general;
	vertical-align:bottom;
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
	mso-style-name:"常规_劳务报酬-给各部门";}
.style21
	{mso-number-format:"_ * \#\,\#\#0_ \;_ * \\-\#\,\#\#0_ \;_ * \0022-\0022_ \;_ \@_ ";
	mso-style-name:"千位分隔[0]";
	mso-style-id:6;}
.style22
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
.style23
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
.style24
	{mso-number-format:"_ * \#\,\#\#0\.00_ \;_ * \\-\#\,\#\#0\.00_ \;_ * \0022-\0022??_ \;_ \@_ ";
	mso-style-name:"千位分隔";
	mso-style-id:3;}
.style25
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
.style26
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
.style27
	{mso-number-format:"0%";
	mso-style-name:"百分比";
	mso-style-id:5;}
.style28
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
.style29
	{mso-pattern:auto none;
	background:#FFFFCC;
	border:.5pt solid #B2B2B2;
	mso-style-name:"注释";}
.style30
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
.style31
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	mso-style-name:"标题 4";}
.style32
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"警告文本";}
.style33
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	mso-style-name:"标题";}
.style34
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	mso-style-name:"解释性文本";}
.style35
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border-bottom:1.0pt solid #5B9BD5;
	mso-style-name:"标题 1";}
.style36
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border-bottom:1.0pt solid #5B9BD5;
	mso-style-name:"标题 2";}
.style37
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
.style38
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border-bottom:1.0pt solid #ACCCEA;
	mso-style-name:"标题 3";}
.style39
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
.style40
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
.style41
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
.style42
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
.style43
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
.style44
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
.style45
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:0;
	border-bottom:2.0pt double #FF8001;
	mso-style-name:"链接单元格";}
.style46
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
.style47
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
.style48
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
.style49
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
.style50
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
.style51
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
.style52
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
.style53
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
.style54
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
.style55
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
.style56
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
.style57
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
.style58
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
.style59
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
.style60
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
.style61
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
.style62
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
.style63
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
.style64
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
.style65
	{mso-number-format:"General";
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"常规_改-劳务费发放明细表";}
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
.xl67
	{mso-style-parent:style20;
	text-align:center;
	white-space:normal;
	color:#BFBFBF;
	font-size:14.0pt;
	mso-font-charset:134;
	border-right:1.0pt dashed #D9D9D9;
	border-right-style:dot-dash;}
.xl68
	{mso-style-parent:style20;
	text-align:center;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style65;
	text-align:center;
	color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl70
	{mso-style-parent:style20;
	text-align:center;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style65;
	text-align:left;
	color:windowtext;
	mso-font-charset:134;
	mso-protection:unlocked visible;}
.xl72
	{mso-style-parent:style65;
	text-align:center;
	color:windowtext;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;
	mso-protection:unlocked visible;}
.xl73
	{mso-style-parent:style65;
	text-align:left;
	color:windowtext;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;
	mso-protection:unlocked visible;}
.xl74
	{mso-style-parent:style65;
	text-align:center;
	color:windowtext;
	font-weight:700;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style65;
	text-align:center;
	color:windowtext;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style20;
	text-align:center;
	font-size:12.0pt;
	mso-font-charset:134;}
.xl77
	{mso-style-parent:style65;
	mso-number-format:"\@";
	text-align:center;
	color:windowtext;
	font-size:12.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl78
	{mso-style-parent:style65;
	mso-number-format:"\@";
	text-align:center;
	color:windowtext;
	font-size:12.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl79
	{mso-style-parent:style65;
	mso-number-format:"0\.00_\)\;\\\(0\.00\\\)";
	text-align:center;
	color:windowtext;
	white-space:normal;
	font-size:12.0pt;
	word-wrap:break-word;word-break:break-all;
	mso-font-charset:134;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl80
	{mso-style-parent:style65;
	text-align:center;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl81
	{mso-style-parent:style20;
	text-align:left;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl82
	{mso-style-parent:style65;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:9.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	mso-protection:unlocked visible;}
.xl83
	{mso-style-parent:style65;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:9.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	mso-protection:unlocked visible;}
.xl84
	{mso-style-parent:style65;
	color:windowtext;
	font-size:14.0pt;
	mso-font-charset:134;
	border-top:1.0pt solid windowtext;
	mso-protection:unlocked visible;}
.xl85
	{mso-style-parent:style65;
	text-align:right;
	color:windowtext;
	mso-font-charset:134;
	border-bottom:1.0pt solid windowtext;
	mso-protection:unlocked visible;}
.xl86
	{mso-style-parent:style65;
	mso-number-format:"0\.00";
	text-align:center;
	color:windowtext;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl87
	{mso-style-parent:style65;
	mso-number-format:"0\.00";
	text-align:center;
	color:windowtext;
	font-weight:700;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl88
	{mso-style-parent:style65;
	mso-number-format:"\#\,\#\#0\.00_ ";
	text-align:right;
	color:windowtext;
	font-size:12.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style65;
	mso-number-format:"\#\,\#\#0\.00_ ";
	text-align:right;
	color:windowtext;
	font-size:12.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl90
	{mso-style-parent:style65;
	mso-number-format:"0\.00";
	text-align:center;
	color:windowtext;
	font-size:12.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	mso-protection:unlocked visible;}
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
          <x:ActiveCol>4</x:ActiveCol>
          <x:ActiveRow>1</x:ActiveRow>
          <x:RangeSelection>E2</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:PageBreakZoom>100</x:PageBreakZoom>
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
  <table width="1206" border="0" cellpadding="0" cellspacing="0" style='width:904.50pt;border-collapse:collapse;table-layout:fixed;word-wrap:break-word;word-break:break-all;'>
   <col width="72" span="2" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="74" style='mso-width-source:userset;mso-width-alt:2368;'/>
   <col width="81" style='mso-width-source:userset;mso-width-alt:2592;'/>
   <col width="97" style='mso-width-source:userset;mso-width-alt:3104;'/>
   <col width="108" style='mso-width-source:userset;mso-width-alt:3456;'/>
   <col width="85" style='mso-width-source:userset;mso-width-alt:2720;'/>
   <col width="65" style='mso-width-source:userset;mso-width-alt:2080;'/>
   <col width="87" style='mso-width-source:userset;mso-width-alt:2784;'/>
   <col width="72" span="3" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="85" style='mso-width-source:userset;mso-width-alt:2720;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="92" style='mso-width-source:userset;mso-width-alt:2944;'/>
   <tr height="92" style='height:69.00pt;mso-height-source:userset;mso-height-alt:1380;'>
    <td class="xl67" height="692" width="72" rowspan="19" style='height:519.00pt;width:54.00pt;border-right:1.0pt dashed #D9D9D9;border-right-style:dot-dash;border-bottom:none;' x:str>装<font class="font1"><br/><br/></font><font class="font1">订</font><font class="font1"><br/><br/></font><font class="font1">线</font></td>
    <td class="xl68" width="72" style='width:54.00pt;'></td>
    <td class="xl69" width="1062" colspan="13" style='width:796.50pt;border-right:none;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font2">天津现代职业技术学院劳务费发放明细表</font></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl70"></td>
    <td class="xl71" x:str>报账部门：</td>
    <td class="xl72">${bean.deptName }</td>
    <td class="xl73"></td>
    <td class="xl72"></td>
    <td class="xl71"></td>
    <td class="xl72"></td>
    <td class="xl72"></td>
    <td class="xl72"></td>
    <td class="xl72"></td>
    <td class="xl72"></td>
    <td class="xl72"></td>
    <td class="xl85" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>${time}</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl68"></td>
    <td class="xl74" x:str>序号</td>
    <td class="xl75" x:str>姓名</td>
    <td class="xl75" x:str>身份证号码</td>
    <td class="xl75" x:str>供职单位</td>
    <td class="xl75" x:str>职务/职称</td>
    <td class="xl75" x:str>课时</td>
    <td class="xl75" x:str>银行卡号</td>
    <td class="xl75" x:str>发卡属地</td>
    <td class="xl75" x:str>发卡行名</td>
    <td class="xl86" x:str>应发金额</td>
    <td class="xl86" x:str>个人所得税</td>
    <td class="xl86" x:str>实发金额</td>
    <td class="xl87" x:str>领款人签字</td>
   </tr>
   <c:if test="${!empty listLecturer }">
   	 <c:forEach items="${listLecturer }" var="i" varStatus="vs">
	   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
	    <td class="xl76"></td>
	    <td class="xl77" x:str>${vs.count }</td>
	    <td class="xl79">${i.lecturerName }</td>
	    <td class="xl79">${i.fIdentityNumber }</td>
	    <td class="xl79">${i.fUnit }</td>
	    <td class="xl79">${i.lecturerLevel }</td>
	    <td class="xl79">${i.lessonTime }</td>
	    <td class="xl79">${i.bankCard }</td>
	    <td class="xl79">${i.cardRegion }</td>
	    <td class="xl79">${i.bank }</td>
	    <td class="xl88">${i.amountpayable }</td>
	    <td class="xl89">${i.fIndividualIncomeTax }</td>
	    <td class="xl89">${i.fNetAmount }</td>
	    <td class="xl90"></td>
	   </tr>
      </c:forEach>
   </c:if>
   <c:if test="${empty listLecturer }">
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76"></td>
    <td class="xl77" x:str>-</td>
    <td class="xl78">-</td>
    <td class="xl78">-</td>
    <td class="xl78">-</td>
    <td class="xl79">-</td>
    <td class="xl79">-</td>
    <td class="xl79">-</td>
    <td class="xl79">-</td>
    <td class="xl79">-</td>
    <td class="xl88">-</td>
    <td class="xl89">-</td>
    <td class="xl89">-</td>
    <td class="xl90">-</td>
   </tr>
   </c:if>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl76"></td>
    <td class="xl80" colspan="9" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金 额 合 计（元）</td>
    <td class="xl88"><fmt:formatNumber groupingUsed="true" value="${amountpayable}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl89"><fmt:formatNumber groupingUsed="true" value="${fIndividualIncomeTax}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl88"><fmt:formatNumber groupingUsed="true" value="${netAmount}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl90"></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl81"></td>
    <td class="xl82" colspan="13" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str>填表说明：1.应发金额=实发金额+个人所得税<font class="font10"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font10">示例：实发800元及以下，税款为0元；实发1000元，税款50元；实发2000元，税款300元；实发3000元，税款550元；实发4000元，税款761.90元；实发5000元，税款952.38元。</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.请一律使用借记卡，必须为姓名本人开立的银行卡，注明卡号及发卡行名,行名精确至支行/分理处/经营网点，如天津农业银行四平道支行，银行卡发卡行原则上为：中国银行、建设银行、工商银行、农业银行。</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.此表纸质一份随费用报账单上报；电子版发至财务处邮箱：xdxy_cwc@126.com。</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.此表后请附详细说明，如讲座等的时间、地点、讲座内容及授课教师基本情况等。</font></td>
   </tr>
  <!--  <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl81"></td>
    <td class="xl82" colspan="13" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font10">2.请一律使用借记卡，必须为姓名本人开立的银行卡，注明卡号及发卡行名,行名精确至支行/分理处/经营网点，如天津农业银行四平道支行，银行卡发卡行原则上为：中国银行、建设银行、工商银行、农业银行。</font></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl81"></td>
    <td class="xl82" colspan="13" style='border-right:1.0pt solid windowtext;border-bottom:none;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font10">3.此表纸质一份随费用报账单上报；电子版发至财务处邮箱：xdxy_cwc@126.com。</font></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl81"></td>
    <td class="xl83" colspan="13" style='border-right:1.0pt solid windowtext;border-bottom:1.0pt solid windowtext;' x:str><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><font class="font10">4.此表后请附详细说明，如讲座等的时间、地点、讲座内容及授课教师基本情况等。</font><font class="font10"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></td>
   </tr> -->
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl68"></td>
    <td class="xl84" colspan="3" style='mso-ignore:colspan;' x:str>制表人：<font class="font11"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><span style='display:none;'><font class="font11"> </font><font class="font11"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></span></td>
    <td class="xl84" colspan="2" style='mso-ignore:colspan;' x:str>部门负责人：<font class="font11"><span style='mso-spacerun:yes;'>&nbsp;</span></font></td>
    <td class="xl84"></td>
    <td class="xl84" colspan="2" style='mso-ignore:colspan;' x:str>主管校长：</td>
    <td class="xl84"></td>
    <td class="xl84"></td>
    <td class="xl84" x:str>校长：</td>
    <td class="xl84"></td>
    <td class="xl84"></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="72" style='width:54;'></td>
     <td width="74" style='width:56;'></td>
     <td width="81" style='width:61;'></td>
     <td width="97" style='width:73;'></td>
     <td width="108" style='width:81;'></td>
     <td width="85" style='width:64;'></td>
     <td width="65" style='width:49;'></td>
     <td width="87" style='width:65;'></td>
     <td width="72" style='width:54;'></td>
     <td width="85" style='width:64;'></td>
     <td width="72" style='width:54;'></td>
     <td width="92" style='width:69;'></td>
    </tr>
   <![endif]>
  </table>
<script type="text/javascript">
  $(document).ready(function() {
	  window.setTimeout(function (){
		  window.print();
	  },500);
	});
</script>
 </body>
</html>


