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
  <!--[if gte mso 9]>
   <xml>
    <o:DocumentProperties>
     <o:Author>202019504</o:Author>
     <o:Created>2020-11-12T09:23:02</o:Created>
     <o:LastAuthor>余海波</o:LastAuthor>
     <o:LastSaved>2020-11-14T16:56:33</o:LastSaved>
    </o:DocumentProperties>
    <o:CustomDocumentProperties>
     <o:KSOProductBuildVer dt:dt="string">2052-11.1.0.10132</o:KSOProductBuildVer>
    </o:CustomDocumentProperties>
   </xml>
  <![endif]-->
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
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:#3F3F76;
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
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font10
	{color:#44546A;
	font-size:18.0pt;
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
	{color:#FFFFFF;
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
	font-weight:400;
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
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font19
	{color:#FFFFFF;
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
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
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
	text-align:right;
	white-space:normal;
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
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;}
.xl79
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	text-decoration:underline;
	text-underline-style:single;
	mso-font-charset:134;
	border-right:.5pt solid windowtext;}
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
        <x:TopRowVisible>9</x:TopRowVisible>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>6</x:ActiveCol>
          <x:ActiveRow>19</x:ActiveRow>
          <x:RangeSelection>G20:I20</x:RangeSelection>
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
  <table width="951.33" border="0" cellpadding="0" cellspacing="0" style='width:713.50pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="237.47" style='mso-width-source:userset;mso-width-alt:7598;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="55" style='mso-width-source:userset;mso-width-alt:1760;'/>
   <col width="72.47" style='mso-width-source:userset;mso-width-alt:2318;'/>
   <col width="150" style='mso-width-source:userset;mso-width-alt:4800;'/>
   <col width="72" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="100" style='mso-width-source:userset;mso-width-alt:3200;'/>
   <col width="37.47" style='mso-width-source:userset;mso-width-alt:1198;'/>
   <col width="154.93" style='mso-width-source:userset;mso-width-alt:4957;'/>
   <tr height="45.33" style='height:34.00pt;mso-height-source:userset;mso-height-alt:680;'>
    <td class="xl65" height="45.33" width="951.33" colspan="9" style='height:34.00pt;width:713.50pt;border-right:none;border-bottom:.5pt dashed windowtext;border-bottom-style:dot-dash;' x:str>装订线</td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl66" height="138.67" colspan="7" style='height:104.00pt;border-right:none;border-bottom:none;padding-left:160px' x:str>公务接待审批表</td>
   	<td style="text-align: center;" colspan="2" id="applyreception"></td> 
    <td class="xl66" colspan="7" style='mso-ignore:colspan;'></td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl67" height="33.33" colspan="6" style='height:25.00pt;mso-ignore:colspan;'></td>
    <td class="xl68" x:str>编号：</td>
    <td class="xl69" colspan="2" style='border-right:none;border-bottom:none;'>${bean.gCode}</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>接待部门</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.deptName}</td>
    <td class="xl70" x:str>经办人</td>
    <td class="xl70" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.userNames}</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>接待单位</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${receptionBean.receptionObject}</td>
    <td class="xl70" x:str>申请时间</td>
    <td class="xl70" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatDate value="${bean.reqTime}" pattern="yyyy-MM-dd"/></td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>接待事由及公函</td>
    <td class="xl71" colspan="8" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${receptionBean.receptionContent}</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" colspan="9" style='height:30.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>参观考察安排</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>时间</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>项目</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>人数</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>其中陪同人员</td>
   </tr>
   <c:if test="${!empty listObserve}">
   	<c:forEach items="${listObserve }" var="i">
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;'><fmt:formatDate value="${i.observeTime}" pattern="yyyy-MM-dd HH:ss"/></td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fProject}</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.personNum}</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.accompanyPerson}</td>
   </tr>
  	</c:forEach>
   </c:if>
   <c:if test="${empty listObserve}">
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;'>-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="80" rowspan="2" style='height:60.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>其他安排</td>
    <td class="xl71" colspan="8" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${receptionBean.otherContet}</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'/>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" colspan="9" style='height:30.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>用餐安排</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>时间</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>地点</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>用餐总人数</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>标准</td>
    <td class="xl70" x:str>其中陪餐人数</td>
   </tr>
   <c:if test="${!empty listFood}">
  	 <c:forEach items="${listFood }" var="i"> 
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;'><c:if test="${ receptionBean.isForeign==0}"><fmt:formatDate value="${i.time}" pattern="yyyy-MM-dd HH:ss"/></c:if> <c:if test="${ receptionBean.isForeign==1}"><fmt:formatDate value="${i.date}" pattern="yyyy-MM-dd "/></c:if></td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.place}</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fPersonNum}</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><c:if test="${i.fFoodType!='日常伙食'}"><fmt:formatNumber groupingUsed="true"  value="${i.fCostStd }"  minFractionDigits="2" maxFractionDigits="2"/></c:if><c:if test="${i.fFoodType=='日常伙食'}"> 详见制度标准</c:if></td>
    <td class="xl70">${i.fOtherNum}</td>
   </tr>
   	</c:forEach>
   </c:if>
   <c:if test="${empty listFood}">
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;'>-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70">-</td>
   </tr>
   </c:if>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" colspan="9" style='height:30.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>住宿安排</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" colspan="9" style='height:30.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${ receptionBean.hotelContet}</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" colspan="9" style='height:30.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>其他费用</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>其他项目</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>项目内容</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>金额</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>备注</td>
   </tr>
   <c:if test="${!empty listOther}">
  	 <c:forEach items="${listOther }" var="i" varStatus="val">
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>${val.index+1}</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fCostName}</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${i.fCost }" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${i.fRemark}</td>
   </tr>
   	</c:forEach>
   </c:if>
    <c:if test="${empty listOther}">
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" colspan="9" style='height:30.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>申请金额合计（元）</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl72" height="40" style='height:30.00pt;' x:str>金额（大写）：</td>
    <td class="xl73" colspan="4" style='border-right:none;border-bottom:.5pt solid windowtext;'>${bean.applyAmountcapital}</td>
    <td class="xl74" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>金额（小写）：</td>
    <td class="xl75" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${bean.amount }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>主要接待部门负责人</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role1 }</td>
    <td class="xl70" x:str>办公室主任</td>
    <td class="xl70" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2 }</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="40" style='height:30.00pt;' x:str>国际交流处处长</td>
    <td class="xl70" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role3 }</td>
    <td class="xl70" x:str>部门主管领导</td>
    <td class="xl70" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role4 }</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl70" height="120" rowspan="3" style='height:90.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>其他事项</td>
    <td class="xl76" colspan="8" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str>若被接待人员自行缴纳伙食费和交通费用的，须填列</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl77" colspan="2" style='border-right:none;border-bottom:none;' x:str>缴费人数：</td>
    <td class="xl78">${ receptionBean.paymentNum}</td>
    <td class="xl68" x:str>缴费标准：</td>
    <td class="xl78">${receptionBean.paymentStd }</td>
    <td class="xl68" colspan="2" style='border-right:none;border-bottom:none;' x:str>缴费总金额：</td>
    <td class="xl80"><fmt:formatNumber groupingUsed="true" value="${receptionBean.paymentAmount }" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl79" colspan="8" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>财务处收费后确认收费金额并盖章</td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="237" style='width:178;'></td>
     <td width="72" style='width:54;'></td>
     <td width="55" style='width:41;'></td>
     <td width="72" style='width:54;'></td>
     <td width="150" style='width:113;'></td>
     <td width="72" style='width:54;'></td>
     <td width="100" style='width:75;'></td>
     <td width="37" style='width:28;'></td>
     <td width="155" style='width:116;'></td>
    </tr>
   <![endif]>
  </table>
  
  <script type="text/javascript">
  $(document).ready(function() {
		//生成二维码
	  $('#applyreception').qrcode({
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

