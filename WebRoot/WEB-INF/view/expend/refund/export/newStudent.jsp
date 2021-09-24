<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta name="ProgId" content="Excel.Sheet"/>
  <meta name="Generator" content="WPS Office ET"/>
  
<!-- jquery.min.js   -->
<script type="text/javascript" src="${base}/resource/ui/jquery.min.js"></script>
<!-- jquery.js  -->
<script type="text/javascript" src="${base}/resource/js/jquery.js"></script>
<!-- jquery二维码  -->
<script type="text/javascript" src="${base}/resource-now/js/qrcode.js"></script>
<!-- jquery生成二维码  -->
<script type="text/javascript" src="${base}/resource-now/js/jquery.qrcode.min.js"></script>
  <!--[if gte mso 9]>
   <xml>
    <o:DocumentProperties>
     <o:Author>202019504</o:Author>
     <o:Created>2020-11-12T14:57:54</o:Created>
     <o:LastAuthor>余海波</o:LastAuthor>
     <o:LastSaved>2020-11-14T18:25:29</o:LastSaved>
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
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:#BFBFBF;
	font-size:9.0pt;
	font-weight:700;
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
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#44546A;
	font-size:18.0pt;
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
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font18
	{color:#9C6500;
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
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
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
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#FF0000;
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
.style64
	{mso-number-format:"General";
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:宋体;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"常规 2";}
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
.xl66
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style64;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:9.0pt;
	mso-font-charset:134;}
.xl69
	{mso-style-parent:style64;
	text-align:center;
	white-space:normal;
	color:#BFBFBF;
	font-size:9.0pt;
	font-weight:700;
	mso-font-charset:134;
	border-right:1.0pt dashed #D9D9D9;
	border-right-style:dot-dash;}
.xl70
	{mso-style-parent:style64;
	color:windowtext;
	font-size:10.0pt;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style64;
	color:windowtext;
	font-size:14.0pt;
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
	text-align:right;
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
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl83
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:bottom;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl84
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
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
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:9.0pt;
	mso-font-charset:134;}
.xl93
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
.xl94
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
.xl95
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl96
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-right:1.0pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-right:1.0pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
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
        <x:StandardWidth>2250</x:StandardWidth>
        <x:Selected/>
        <x:TopRowVisible>9</x:TopRowVisible>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>10</x:ActiveCol>
          <x:ActiveRow>12</x:ActiveRow>
          <x:RangeSelection>K13:L13</x:RangeSelection>
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
     <x:WindowWidth>19785</x:WindowWidth>
    </x:ExcelWorkbook>
   </xml>
  <![endif]-->
 </head>
 <body link="blue" vlink="purple" class="xl68">
  <table width="1260.60" border="0" cellpadding="0" cellspacing="0" style='width:945.45pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="92" class="xl67" style='mso-width-source:userset;mso-width-alt:2944;'/>
   <col width="49.60" class="xl67" style='mso-width-source:userset;mso-width-alt:1587;'/>
   <col width="40" class="xl68" style='mso-width-source:userset;mso-width-alt:1280;'/>
   <col width="85" class="xl68" style='mso-width-source:userset;mso-width-alt:2720;'/>
   <col width="204" class="xl68" style='mso-width-source:userset;mso-width-alt:6528;'/>
   <col width="118" class="xl68" style='mso-width-source:userset;mso-width-alt:3776;'/>
   <col width="114" class="xl68" style='mso-width-source:userset;mso-width-alt:3648;'/>
   <col width="100" class="xl68" style='mso-width-source:userset;mso-width-alt:3200;'/>
   <col width="109.60" class="xl68" style='mso-width-source:userset;mso-width-alt:3507;'/>
   <col width="78" class="xl68" style='mso-width-source:userset;mso-width-alt:2496;'/>
   <col width="76" class="xl68" style='mso-width-source:userset;mso-width-alt:2432;'/>
   <col width="194.40" class="xl68" style='mso-width-source:userset;mso-width-alt:6220;'/>
   <col width="70.40" span="244" class="xl68" style='mso-width-source:userset;mso-width-alt:2252;'/>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl69" height="854.20" width="92" rowspan="15" style='height:640.65pt;width:69.00pt;border-right:1.0pt dashed #D9D9D9;border-right-style:dot-dash;border-bottom:none;' x:str>装<font class="font3"><br/><br/></font><font class="font3">订</font><font class="font3"><br/><br/></font><font class="font3">线</font></td>
    <td class="xl70" width="49.60" style='width:37.20pt;'></td>
    <td class="xl71" width="1119" colspan="10" style='width:839.25pt;border-right:none;border-bottom:none;' x:str>天津现代职业技术学院新生退费单</td>
   </tr>
   <tr height="22" class="xl66" style='height:16.50pt;mso-height-source:userset;mso-height-alt:330;'>
    <td class="xl72"></td>
    <td class="xl73" colspan="5" style='mso-ignore:colspan;'></td>
    <td class="xl74" colspan="5" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>${time }</td>
   </tr>
   <tr height="48" style='height:36.00pt;mso-height-source:userset;mso-height-alt:720;'>
    <td class="xl70"></td>
    <td class="xl75" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>学生姓名</td>
    <td class="xl76">${studentbean.studentName }</td>
    <td class="xl76" x:str>所属学院</td>
    <td class="xl76" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${studentbean.studentCollege }</td>
    <td class="xl76" x:str>专业班级</td>
    <td class="xl93" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${studentbean.studentClass }</td>
   </tr>
   <tr height="48" style='height:36.00pt;mso-height-source:userset;mso-height-alt:720;'>
    <td class="xl70"></td>
    <td class="xl77" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>身份证号</td>
    <td class="xl78">${studentbean.identityId }</td>
    <td class="xl78" x:str>收费单号</td>
    <td class="xl78" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${studentbean.moneyCode }</td>
    <td class="xl78" x:str>联系电话</td>
    <td class="xl94" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${studentbean.tel }</td>
   </tr>
   <tr height="33.20" style='height:24.90pt;mso-height-source:userset;mso-height-alt:498;'>
    <td class="xl70"></td>
    <td class="xl79" colspan="2" rowspan="3" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str>退费原因<font class="font6"><br/></font><font class="font6">（可附页）</font></td>
    <td class="xl80" colspan="8" rowspan="2" style='border-right:1.0pt solid windowtext;border-bottom:none;'>${studentbean.refundReason }</td>
   </tr>
   <tr height="219.20" style='height:164.40pt;mso-height-source:userset;mso-height-alt:3288;'>
    <td class="xl70"></td>
   </tr>
   <tr height="30.67" style='height:23.00pt;mso-height-source:userset;mso-height-alt:460;'>
    <td class="xl70"></td>
    <td class="xl81"></td>
    <td class="xl82"></td>
    <td class="xl83" colspan="2" style='border-right:none;border-bottom:none;' x:str>学生签字：</td>
    <td class="xl95"></td>
    <td class="xl83" colspan="2" style='border-right:none;border-bottom:none;' x:str>家长签字：</td>
    <td class="xl96"></td>
   </tr>
   <tr height="36" style='height:27.00pt;mso-height-source:userset;mso-height-alt:540;'>
    <td class="xl70"></td>
    <td class="xl77" colspan="2" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>已交学费</td>
    <td class="xl78" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${studentbean.payedTuition}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl78" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>已交住宿费</td>
    <td class="xl78" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${studentbean.payedRoom}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl78" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>合<font class="font6"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font6">计</font></td>
    <td class="xl97" colspan="2" style='border-right:none;border-bottom:none;' x:str>人民币（大写）：</td>
    <td class="xl98" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:none;'>${studentbean.chineseSumMoney }</td>
   </tr>
   <tr height="32" style='height:24.00pt;mso-height-source:userset;mso-height-alt:480;'>
    <td class="xl70"></td>
    <td class="xl99" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>（小写）¥：</td>
    <td class="xl100" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:none;'><fmt:formatNumber groupingUsed="true" value="${studentbean.sumMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="36" style='height:27.00pt;mso-height-source:userset;mso-height-alt:540;'>
    <td class="xl70"></td>
    <td class="xl77" colspan="2" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>应退学费</td>
    <td class="xl78" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${studentbean.refundTuition}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl78" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>应退住宿费</td>
    <td class="xl78" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatNumber groupingUsed="true" value="${studentbean.refundRoom}" minFractionDigits="2" maxFractionDigits="2"/></td>
    <td class="xl84" rowspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>合<font class="font6"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font6">计</font></td>
    <td class="xl97" colspan="2" style='border-right:none;border-bottom:none;' x:str>人民币（大写）：</td>
    <td class="xl98" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:none;'>${studentbean.chinesePayedSumMoney }</td>
   </tr>
   <tr height="32" style='height:24.00pt;mso-height-source:userset;mso-height-alt:480;'>
    <td class="xl70"></td>
    <td class="xl99" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>（小写）¥：</td>
    <td class="xl100" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:none;'><fmt:formatNumber groupingUsed="true" value="${studentbean.payedRoom+studentbean.payedTuition}" minFractionDigits="2" maxFractionDigits="2"/></td>
   </tr>
   <tr height="70.67" style='height:53.00pt;mso-height-source:userset;mso-height-alt:1060;'>
    <td class="xl70"></td>
    <td class="xl85" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审<font class="font6"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font6">批</font></td>
    <td class="xl86" x:str>招生办公室负责人：</td>
    <td class="xl87">${role1 }</td>
    <td class="xl88" x:str>主管校长：</td>
    <td class="xl87">${role2 }</td>
    <td class="xl101"></td>
    <td class="xl88" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>财务校长：</td>
    <td class="xl102">${role3 }</td>
   </tr>
   <tr height="48" style='height:36.00pt;mso-height-source:userset;mso-height-alt:720;'>
    <td class="xl70"></td>
    <td class="xl89" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>财务审核：</td>
    <td class="xl90">${financeCheck }</td>
    <td class="xl91" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl74" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>财务报销：</td>
    <td class="xl103" colspan="2" style='border-right:1.0pt solid windowtext;border-bottom:1.0pt solid windowtext;'></td>
   </tr>
   <tr height="33" style='height:24.75pt;mso-height-source:userset;mso-height-alt:495;'>
    <td class="xl70"></td>
    <td class="xl92" colspan="10" style='border-right:none;border-bottom:none;'></td>
   </tr>
   <tr height="26.80" style='height:20.10pt;mso-height-source:userset;mso-height-alt:402;'>
    <td class="xl70"></td>
    <td class="xl68" colspan="10" style='mso-ignore:colspan;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="92" style='width:69;'></td>
     <td width="50" style='width:37;'></td>
     <td width="40" style='width:30;'></td>
     <td width="85" style='width:64;'></td>
     <td width="204" style='width:153;'></td>
     <td width="118" style='width:89;'></td>
     <td width="114" style='width:86;'></td>
     <td width="100" style='width:75;'></td>
     <td width="110" style='width:82;'></td>
     <td width="78" style='width:59;'></td>
     <td width="76" style='width:57;'></td>
     <td width="194" style='width:146;'></td>
     <td width="70" style='width:53;'></td>
    </tr>
   <![endif]>
  </table>
  <script type="text/javascript">
  $(document).ready(function() {
		window.print();
	}); 
  
  </script>
 </body>
</html>
