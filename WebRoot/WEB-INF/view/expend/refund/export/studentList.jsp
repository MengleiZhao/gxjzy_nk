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
	{color:#000000;
	font-size:22.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font2
	{color:#000000;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font4
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font5
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font6
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font8
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font11
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:#006100;
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
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#000000;
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
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
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
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	font-size:22.0pt;
	font-weight:700;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
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
	text-align:center;
	white-space:normal;
	word-wrap:break-word;
	font-size:16.0pt;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	text-align:left;
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
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
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
        <x:TopRowVisible>3</x:TopRowVisible>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>5</x:ActiveCol>
          <x:ActiveRow>13</x:ActiveRow>
          <x:RangeSelection>F14:G14</x:RangeSelection>
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
 <body link="blue" vlink="purple">
  <table width="1012" border="0" cellpadding="0" cellspacing="0" style='width:759.00pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="113" style='mso-width-source:userset;mso-width-alt:3616;'/>
   <col width="99" style='mso-width-source:userset;mso-width-alt:3168;'/>
   <col width="104" style='mso-width-source:userset;mso-width-alt:3328;'/>
   <col width="123" style='mso-width-source:userset;mso-width-alt:3936;'/>
   <col width="114" style='mso-width-source:userset;mso-width-alt:3648;'/>
   <col width="109" style='mso-width-source:userset;mso-width-alt:3488;'/>
   <col width="120" style='mso-width-source:userset;mso-width-alt:3840;'/>
   <col width="123" style='mso-width-source:userset;mso-width-alt:3936;'/>
   <col width="107" style='mso-width-source:userset;mso-width-alt:3424;'/>
   <tr height="76" style='height:57.00pt;mso-height-source:userset;mso-height-alt:1140;'>
    <td class="xl65" height="76" width="1012" colspan="9" style='height:57.00pt;width:759.00pt;border-right:none;border-bottom:none;' x:str>天津现代职业技术学院<font class="font1"><br/></font><font class="font1">学生（新生）批量退费明细审核单</font></td>
   </tr>
   <tr height="27" style='height:20.25pt;'>
    <td class="xl66" height="27" style='height:20.25pt;' x:str>经办人：</td>
    <td class="xl67">${bean.fUserName }</td>
    <td class="xl66"></td>
    <td class="xl66" x:str>申请日期：</td>
    <td class="xl68" colspan="2" style='border-right:none;border-bottom:none;' x:str>${time }</td>
    <td class="xl66" colspan="2" style='mso-ignore:colspan;'></td>
    <td class="xl66" x:str>单位：元</td>
   </tr>
   <tr height="27" style='height:20.25pt;'>
    <td class="xl69" height="27" style='height:20.25pt;' x:str>申请学院</td>
    <td class="xl70" colspan="8" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>
    <c:if test="${bean.fNewOrOld==1 }">
	    ${bean.fDeptName }
    </c:if>
    <c:if test="${bean.fNewOrOld==0 }">
	    招生办
    </c:if>
    </td>
   </tr>
   <tr height="27" style='height:20.25pt;'>
    <td class="xl69" height="27" style='height:20.25pt;' x:str>序号</td>
    <td class="xl69" x:str>学生姓名</td>
    <td class="xl69" x:str>学号</td>
    <td class="xl69" x:str>专业</td>
    <td class="xl69" x:str>联系电话</td>
    <td class="xl69" x:str>退费类型</td>
    <td class="xl69" x:str>应退学费</td>
    <td class="xl69" x:str>应退住宿费</td>
    <td class="xl69" x:str>合计金额</td>
   </tr>
   <c:if test="${!empty mingxiList }">
  	 <c:forEach items="${mingxiList }" var="i" varStatus="vs">
	   <tr height="27" style='height:20.25pt;'>
	    <td class="xl69" height="27" style='height:20.25pt;'>${vs.count }</td>
	    <td class="xl69">${i.studentName }</td>
	    <td class="xl69">${i.idNumber }</td>
	    <td class="xl69">${i.studentClass }</td>
	    <td class="xl69">${i.tel }</td>
	    <td class="xl69"></td>
	    <td class="xl69"><fmt:formatNumber groupingUsed="true" value="${i.refundTuition}" minFractionDigits="2" maxFractionDigits="2"/></td>
	    <td class="xl69"><fmt:formatNumber groupingUsed="true" value="${i.refundRoom}" minFractionDigits="2" maxFractionDigits="2"/></td>
	    <td class="xl69"><fmt:formatNumber groupingUsed="true" value="${i.sumMoney}" minFractionDigits="2" maxFractionDigits="2"/></td>
	   </tr>
      </c:forEach>
   </c:if>
   <c:if test="${empty mingxiList }">
	   <tr height="27" style='height:20.25pt;'>
	    <td class="xl69" height="27" style='height:20.25pt;'>-</td>
	    <td class="xl69">-</td>
	    <td class="xl69">-</td>
	    <td class="xl69">-</td>
	    <td class="xl69">-</td>
	    <td class="xl69">-</td>
	    <td class="xl69">-</td>
	    <td class="xl69">-</td>
	    <td class="xl69">-</td>
	   </tr>
   </c:if>
   <tr height="28" style='height:21.00pt;mso-height-source:userset;mso-height-alt:420;'>
    <td class="xl69" height="140" colspan="2" rowspan="4" style='height:105.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审核环节</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>二级学院院长</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>公寓管理中心</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>学生处/招生办</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role1 }</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2 }</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role3 }</td>
   </tr>
   <tr height="28" style='height:21.00pt;mso-height-source:userset;mso-height-alt:420;'>
    <td class="xl71" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str>主管校长：</td>
    <td class="xl72" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:none;' x:str>财务校长：</td>
   </tr>
   <tr height="44" style='height:33.00pt;mso-height-source:userset;mso-height-alt:660;'>
    <td class="xl73" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role4 }</td>
    <td class="xl74" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role5 }</td>
   </tr>
   <tr height="27" style='height:20.25pt;'>
    <td class="xl75" height="27" style='height:20.25pt;' x:str>财务审核：</td>
    <td class="xl76" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${financeCheck }</td>
    <td class="xl77"></td>
    <td class="xl78" x:str>财务报销：</td>
    <td class="xl76" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'></td>
    <td class="xl77"></td>
    <td class="xl79"></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="113" style='width:85;'></td>
     <td width="99" style='width:74;'></td>
     <td width="104" style='width:78;'></td>
     <td width="123" style='width:92;'></td>
     <td width="114" style='width:86;'></td>
     <td width="109" style='width:82;'></td>
     <td width="120" style='width:90;'></td>
     <td width="123" style='width:92;'></td>
     <td width="107" style='width:80;'></td>
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
