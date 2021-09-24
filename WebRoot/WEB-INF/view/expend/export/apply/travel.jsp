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
	<script type="text/javascript" src="${base}/resource-now/js/qrcode.js"></script>
	<!-- jquery生成二维码  -->
	<script type="text/javascript" src="${base}/resource-now/js/jquery.qrcode.min.js"></script>				
  <!--[if gte mso 9]>
   <xml>
    <o:DocumentProperties>
     <o:Author>余海波</o:Author>
     <o:Created>2020-06-01T13:27:00</o:Created>
     <o:LastAuthor>202019504</o:LastAuthor>
     <o:LastSaved>2020-06-02T16:39:59</o:LastSaved>
    </o:DocumentProperties>
    <o:CustomDocumentProperties>
     <o:KSOProductBuildVer dt:dt="string">2052-11.1.0.9662</o:KSOProductBuildVer>
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
	{color:#BFBFBF;
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
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:#9C0006;
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
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#44546A;
	font-size:15.0pt;
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
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font15
	{color:#FF0000;
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
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
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
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
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
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font22
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
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
	color:#BFBFBF;
	font-size:14.0pt;
	mso-font-charset:134;
	border-bottom:1.0pt dashed windowtext;
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
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;}
.xl71
	{mso-style-parent:style0;
	white-space:normal;
	mso-font-charset:134;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#FFFFFF;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-font-charset:134;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl81
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
.xl82
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:center;
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
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:1.0pt solid windowtext;
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
	border:.5pt solid windowtext;}
.xl87
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
.xl88
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	text-align:right;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
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
	text-align:center;
	white-space:normal;
	color:windowtext;
	font-size:16.0pt;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
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
        <x:DefaultRowHeight>270</x:DefaultRowHeight>
        <x:Selected/>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>25</x:ActiveCol>
          <x:ActiveRow>12</x:ActiveRow>
          <x:RangeSelection>Z13</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:PageBreakZoom>100</x:PageBreakZoom>
        <x:Zoom>54</x:Zoom>
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
  <table width="947.13" border="0" cellpadding="0" cellspacing="0" style='width:710.35pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="139" style='mso-width-source:userset;mso-width-alt:4448;'/>
   <col width="36" style='mso-width-source:userset;mso-width-alt:1152;'/>
   <col width="72.20" style='mso-width-source:userset;mso-width-alt:2310;'/>
   <col width="38.87" style='mso-width-source:userset;mso-width-alt:1243;'/>
   <col width="62.93" style='mso-width-source:userset;mso-width-alt:2013;'/>
   <col width="30" style='mso-width-source:userset;mso-width-alt:960;'/>
   <col width="50" style='mso-width-source:userset;mso-width-alt:1600;'/>
   <col width="63" style='mso-width-source:userset;mso-width-alt:2016;'/>
   <col width="50" style='mso-width-source:userset;mso-width-alt:1600;'/>
   <col width="38.87" style='mso-width-source:userset;mso-width-alt:1243;'/>
   <col width="32" style='mso-width-source:userset;mso-width-alt:1024;'/>
   <col width="40.67" style='mso-width-source:userset;mso-width-alt:1301;'/>
   <col width="42" style='mso-width-source:userset;mso-width-alt:1344;'/>
   <col width="42.53" style='mso-width-source:userset;mso-width-alt:1361;'/>
   <col width="94.40" style='mso-width-source:userset;mso-width-alt:3020;'/>
   <col width="15" style='mso-width-source:userset;mso-width-alt:480;'/>
   <col width="13" style='mso-width-source:userset;mso-width-alt:416;'/>
   <col width="33" style='mso-width-source:userset;mso-width-alt:1056;'/>
   <col width="53.67" style='mso-width-source:userset;mso-width-alt:1717;'/>
   <tr height="26" style='height:19.50pt;'>
    <td class="xl65" height="26" width="947.13" colspan="19" style='height:19.50pt;width:710.35pt;border-right:none;border-bottom:1.0pt dashed windowtext;border-bottom-style:dot-dash;' x:str>装<font class="font1"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font1">订</font><font class="font1"><span style='mso-spacerun:yes;'>&nbsp; </span></font><font class="font1">线</font></td>
   </tr>
   <tr height="138.67" style='height:104.00pt;mso-height-source:userset;mso-height-alt:2080;'>
    <td class="xl66" height="138.67" colspan="17" style='height:104.00pt;border-right:none;border-bottom:none;' x:str>天津现代职业技术学院差旅事前申请单</td>
    <td style="text-align: center;" colspan="2" id="applytravel"></td> 
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl67" height="40" style='height:30.00pt;' x:str>申请人：</td>
    <td class="xl68" colspan="2" style='border-right:none;border-bottom:none;'>${bean.userNames}</td>
    <td class="xl69" colspan="3" style='border-right:none;border-bottom:none;'></td>
    <td class="xl70"></td>
    <td class="xl71" colspan="3" style='mso-ignore:colspan;'></td>
    <td class="xl69" colspan="4" style='border-right:none;border-bottom:none;' x:str>申请日期：</td>
    <td class="xl70" colspan="5" style='border-right:none;border-bottom:none;' x:str>${time }</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl72" height="40" style='height:30.00pt;' x:str>申请部门</td>
    <td class="xl73" colspan="18" style='center;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.deptName}</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl74" height="40" style='height:30.00pt;' x:str><input type="checkbox" disabled="disabled"  <c:if test="${pro.FProOrBasic==0 }">checked="checked" </c:if>>基本支出</td>
    <td class="xl75" colspan="6" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str><input type="checkbox"  disabled="disabled" <c:if test="${pro.FProOrBasic==1 }">checked="checked" </c:if>>项目支出名称（编号）：</td>
    <td class="xl73" colspan="12" style='border-left:none;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'><c:if test="${pro.FProOrBasic==1 }">${bean.proDetailName }</c:if></td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl77" height="205.33" rowspan="3" style='height:154.00pt;border-right:none;border-bottom:none;' x:str>差旅事项说明</td>
    <td class="xl73" colspan="18" rowspan="2" style='border-right:1.0pt solid windowtext;border-bottom:none;'>${bean.reason }</td>
   </tr>
   <tr height="93.33" style='height:70.00pt;mso-height-source:userset;mso-height-alt:1400;'/>
   <tr height="72" style='height:54.00pt;mso-height-source:userset;mso-height-alt:1080;'>
    <td class="xl80" colspan="18" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>请附正式差旅文件通知，若为调研，请附详细调研行程等，如需乘坐飞机、缴纳会务费、培训费或有其它需要说明的事项，请简述或附截图</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl81" height="40" style='height:30.00pt;' x:str>出差日期</td>
    <td class="xl82" x:str>自</td>
    <td class="xl83" colspan="6"><fmt:formatDate value="${travelBean.travelDateStart}" pattern="yyyy-MM-dd"/></td>
    <td class="xl83" x:str>——</td>
    <td class="xl83" colspan="6"><fmt:formatDate value="${travelBean.travelDateEnd}" pattern="yyyy-MM-dd"/></td>
    <td class="xl83" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>共</td>
    <td class="xl83">${day }</td>
    <td class="xl94" x:str>天</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl81" height="40" style='height:30.00pt;' x:str>目的地</td>
    <td class="xl84" colspan="18" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${travelAreaName }</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl85" height="40" colspan="19" style='height:30.00pt;border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>出差人员信息</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl81" height="40" style='height:30.00pt;' x:str>姓名</td>
    <td class="xl86" colspan="9" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>身份证号</td>
    <td class="xl86" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>职务/职称</td>
    <td class="xl84" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>联系方式</td>
   </tr>
   <c:if test="${!empty travellist }">
   <c:forEach items="${travellist }" var="tl">
	   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
	    <td class="xl81" height="40" style='height:30.00pt;'>${tl.travelAttendPeop }</td>
	    <td class="xl86" colspan="9" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${tl.fIdentityNumber }</td>
	    <td class="xl86" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${tl.travelPersonnelLevel }</td>
	    <td class="xl84" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${tl.fTel }</td>
	   </tr>
   </c:forEach>
   </c:if>
	<c:if test="${empty travellist }">
	   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
	    <td class="xl81" height="40" style='height:30.00pt;'>-</td>
	    <td class="xl86" colspan="9" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	    <td class="xl86" colspan="5" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	    <td class="xl84" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
	   </tr>
   </c:if>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl87" height="80" rowspan="2" style='height:60.00pt;border-right:.5pt solid windowtext;border-bottom:1.0pt solid windowtext;' x:str>审批</td>
    <td class="xl88" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>项目负责人：</td>
    <td class="xl83" colspan="2" >${proHead }</td>
    <td class="xl89" colspan="3" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>部门负责人：</td>
    <td class="xl83" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;'>${role1 }</td>
    <td class="xl89" colspan="5" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>归口管理部门负责人：</td>
    <td class="xl94" colspan="3" style='border-right:1.0pt solid windowtext;border-bottom:.5pt solid windowtext;'>${role2 }</td>
   </tr>
   <tr height="40" style='height:30.00pt;mso-height-source:userset;mso-height-alt:600;'>
    <td class="xl90" colspan="3" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>主管校长：</td>
    <td class="xl91">${role3 }</td>
    <td class="xl92" colspan="3" style='border-right:none;border-bottom:1.0pt solid windowtext;' x:str>校<font class="font4"><span style='mso-spacerun:yes;'>&nbsp;&nbsp; </span></font><font class="font4">长：</font></td>
    <td class="xl91" colspan="2" style='border-right:none;border-bottom:1.0pt solid windowtext;'>${role4 }</td>
    <td class="xl91" colspan="5" style='border-right:none;border-bottom:1.0pt solid windowtext;'></td>
    <td class="xl95" colspan="4" style='border-right:1.0pt solid windowtext;border-bottom:1.0pt solid windowtext;'></td>
   </tr>
   <![if supportMisalignedColumns]>
    <tr width="0" style='display:none;'>
     <td width="139" style='width:104;'></td>
     <td width="36" style='width:27;'></td>
     <td width="72" style='width:54;'></td>
     <td width="39" style='width:29;'></td>
     <td width="63" style='width:47;'></td>
     <td width="30" style='width:23;'></td>
     <td width="50" style='width:38;'></td>
     <td width="63" style='width:47;'></td>
     <td width="50" style='width:38;'></td>
     <td width="39" style='width:29;'></td>
     <td width="32" style='width:24;'></td>
     <td width="41" style='width:31;'></td>
     <td width="42" style='width:32;'></td>
     <td width="43" style='width:32;'></td>
     <td width="94" style='width:71;'></td>
     <td width="15" style='width:11;'></td>
     <td width="13" style='width:10;'></td>
     <td width="33" style='width:25;'></td>
     <td width="54" style='width:40;'></td>
    </tr>
   <![endif]>
  </table>
<script type="text/javascript">
  $(document).ready(function() {
			//生成二维码
		 $('#applytravel').qrcode({
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
