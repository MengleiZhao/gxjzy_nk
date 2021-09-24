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
	{margin:0.75in 0.70in 0.75in 0.70in;
	mso-header-margin:0.30in;
	mso-footer-margin:0.30in;}
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
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font1
	{color:#000000;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font2
	{color:#000000;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font3
	{color:#000000;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font4
	{color:#000000;
	font-size:10.5pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Calibri";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font5
	{color:#F2F2F2;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Calibri";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font6
	{color:#D9D9D9;
	font-size:72.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"宋体";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font7
	{color:#000000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font10
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:#9C0006;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:#9C6500;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font13
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font15
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font16
	{color:#3F3F3F;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font17
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font18
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:134;}
.font19
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font20
	{color:#3F3F76;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font21
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font22
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font23
	{color:#800080;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font24
	{color:#006100;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font25
	{color:#FFFFFF;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"等线";
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 3";}
.style25
	{color:#0000FF;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 2";}
.style30
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
	mso-font-charset:134;
	mso-style-name:"标题 4";}
.style31
	{color:#FF0000;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
	mso-font-charset:0;
	mso-style-name:"警告文本";}
.style32
	{color:#44546A;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
	mso-font-charset:134;
	mso-style-name:"标题";}
.style33
	{color:#7F7F7F;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:等线;
	mso-font-charset:0;
	mso-style-name:"解释性文本";}
.style34
	{color:#44546A;
	font-size:15.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
	mso-font-charset:134;
	border-bottom:1.0pt solid #5B9BD5;
	mso-style-name:"标题 1";}
.style35
	{color:#44546A;
	font-size:13.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
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
	font-family:等线;
	mso-font-charset:0;
	mso-style-name:"60% - 强调文字颜色 1";}
.style37
	{color:#44546A;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
	mso-font-charset:0;
	mso-style-name:"强调文字颜色 2";}
.style44
	{color:#FA7D00;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
	mso-font-charset:0;
	border-bottom:2.0pt double #FF8001;
	mso-style-name:"链接单元格";}
.style45
	{color:#000000;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-family:等线;
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
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:等线;
	mso-font-charset:134;
	border:none;
	mso-protection:locked visible;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	font-size:20.0pt;
	font-weight:700;
	font-family:宋体;
	mso-font-charset:134;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	text-align:left;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;}
.xl67
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	white-space:normal;
	text-align:center;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	white-space:normal;
	font-size:14.0pt;
	font-family:宋体;
	text-align:center;
	mso-font-charset:134;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#F2F2F2;
	font-size:14.0pt;
	font-weight:700;
	font-family:宋体;
	mso-font-charset:134;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;
	mso-pattern:auto none;
	background:#F2F2F2;
	font-size:14.0pt;
	font-weight:700;
	font-family:宋体;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#F2F2F2;
	font-size:14.0pt;
	font-weight:700;
	font-family:宋体;
	mso-font-charset:134;
	border-bottom:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:bottom;
	white-space:normal;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:bottom;
	white-space:normal;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;
	border-left:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	white-space:normal;
	font-size:10.5pt;
	font-family:Calibri;
	mso-font-charset:134;}
.xl79
	{mso-style-parent:style0;
	text-align:justify;
	font-size:10.5pt;
	font-family:Calibri;
	mso-font-charset:134;}
.xl80
	{mso-style-parent:style0;
	text-align:justify;
	color:#F2F2F2;
	font-size:14.0pt;
	font-family:Calibri;
	mso-font-charset:134;}
.xl81
	{mso-style-parent:style0;
	white-space:normal;
	color:#D9D9D9;
	font-size:72.0pt;
	font-family:宋体;
	mso-font-charset:134;}
.xl82
	{mso-style-parent:style0;
	text-align:right;
	font-size:14.0pt;
	font-family:宋体;
	mso-font-charset:134;}
.xl83
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;
	mso-pattern:auto none;
	background:#F2F2F2;
	font-size:14.0pt;
	font-weight:700;
	font-family:宋体;
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
        <x:DefaultRowHeight>285</x:DefaultRowHeight>
        <x:Selected/>
        <x:TopRowVisible>6</x:TopRowVisible>
        <x:Panes>
         <x:Pane>
          <x:Number>3</x:Number>
          <x:ActiveCol>14</x:ActiveCol>
          <x:ActiveRow>6</x:ActiveRow>
          <x:RangeSelection>O7</x:RangeSelection>
         </x:Pane>
        </x:Panes>
        <x:DoNotDisplayGridlines/>
        <x:ProtectContents>False</x:ProtectContents>
        <x:ProtectObjects>False</x:ProtectObjects>
        <x:ProtectScenarios>False</x:ProtectScenarios>
        <x:ShowPageBreakZoom/>
        <x:Zoom>50</x:Zoom>
        <x:Print>
         <x:ValidPrinterInfo/>
         <x:PaperSizeIndex>9</x:PaperSizeIndex>
         <x:Scale>64</x:Scale>
         <x:HorizontalResolution>300</x:HorizontalResolution>
         <x:VerticalResolution>300</x:VerticalResolution>
        </x:Print>
       </x:WorksheetOptions>
      </x:ExcelWorksheet>
     </x:ExcelWorksheets>
     <x:ProtectStructure>False</x:ProtectStructure>
     <x:ProtectWindows>False</x:ProtectWindows>
     <x:SelectedSheets>0</x:SelectedSheets>
     <x:WindowHeight>7590</x:WindowHeight>
     <x:WindowWidth>19890</x:WindowWidth>
    </x:ExcelWorkbook>
   </xml>
  <![endif]-->
  </head>
<script type="text/javascript">
/* $(document).ready(function() {
	window.print();
}); */
</script>
  <body>
 <table width="953" border="0" cellpadding="0" cellspacing="0" style='width:714.75pt;border-collapse:collapse;table-layout:fixed;'>
   <col width="161" style='mso-width-source:userset;mso-width-alt:5152;'/>
   <col width="110" style='mso-width-source:userset;mso-width-alt:3520;'/>
   <col width="58" style='mso-width-source:userset;mso-width-alt:1856;'/>
   <col width="72" span="5" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <col width="90" style='mso-width-source:userset;mso-width-alt:2880;'/>
   <col width="49" style='mso-width-source:userset;mso-width-alt:1568;'/>
   <col width="125" style='mso-width-source:userset;mso-width-alt:4000;'/>
   <col width="72" span="5" style='mso-width-source:userset;mso-width-alt:2304;'/>
   <tr height="34" style='height:25.50pt;'>
    <td class="xl65" height="34" width="953" colspan="11" style='height:25.50pt;width:714.75pt;border-right:none;border-bottom:none;' x:str>天津市滨海新区财政局公务出行申请单</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl66" height="33.27" style='height:24.95pt;' x:str>摘要：${bean.gName}<font class="font2"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl67"></td>
    <td class="xl82" colspan="3" style='border-right:none;border-bottom:none;' x:str>单据编号：${bean.gCode}</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl66" height="33.27" style='height:24.95pt;' x:str>申请日期：${time }<font class="font2"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl66"></td>
    <td class="xl82" colspan="3" style='border-right:none;border-bottom:none;'></td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl68" height="33.27" style='height:24.95pt;' x:str>申请人姓名</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.userNames}</td>
    <td class="xl68" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>部门（处室）</td>
    <td class="xl70" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.deptName}</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl68" height="33.27" style='height:24.95pt;' x:str>出差事由</td>
    <td class="xl69" colspan="10" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.reason}</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl71" height="33.27" colspan="11" style='height:24.95pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>行程清单</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl68" height="33.27" style='height:24.95pt;' x:str>姓名</td>
    <td class="xl68" x:str>出行日期</td>
    <td class="xl68" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>目的地</td>
    <td class="xl68" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>出行区域</td>
    <td class="xl68" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>乘车方式</td>
    <td class="xl68" colspan="2" x:str>主要工作内容</td>
   </tr>
   <c:forEach items="${travellist}" var="travelbean">
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl69" height="33.27" style='height:24.95pt;'>${travelbean.travelAttendPeop}</td>
    <td class="xl69"><fmt:formatDate value="${travelbean.travelAreaTime}" pattern="yyyy-MM-dd"/></td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${travelbean.travelAreaName}</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${travelbean.areaNames}</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${travelbean.fDriveWay}</td>
    <td class="xl69" colspan="2" >${travelbean.reason}</td>
   </tr>
   </c:forEach>
   <c:if test="${empty travellist}">
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl69" height="33.27" style='height:24.95pt;'>-</td>
    <td class="xl69">-</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl69">-</td>
   </tr>
   </c:if>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl71" height="33.27" colspan="11" style='height:24.95pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>费用明细</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl72" height="33.27" colspan="7" style='height:24.95pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>市内交通费</td>
    <td class="xl73" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>汇总金额（元）：</td>
    <td class="xl83" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.cityAmount }</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl74" height="33.27" style='height:24.95pt;' x:str>姓名</td>
    <td class="xl74" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>相邻区补贴天数</td>
    <td class="xl74" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>相隔区补贴天数</td>
    <td class="xl74" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>补贴金额（元）</td>
   </tr>
    <c:forEach items="${inCitylist}" var="inCitybean">
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl69" height="33.27" style='height:24.95pt;'>${inCitybean.fPerson }</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${inCitybean.fAdjacentDay}</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${inCitybean.fDistanceDay}</td>
    <td class="xl69" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${inCitybean.fApplyAmount }</td>
   </tr>
   </c:forEach>
   <c:if test="${empty inCitylist}">
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl69" height="33.27" style='height:24.95pt;'>-</td>
    <td class="xl69" colspan="6" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl69" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    </tr>
    </c:if>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl72" height="33.27" colspan="7" style='height:24.95pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>伙食补助费</td>
    <td class="xl73" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>汇总金额（元）：</td>
    <td class="xl83" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.foodAmount }</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl68" height="33.27" style='height:24.95pt;' x:str>姓名</td>
    <td class="xl68" colspan="6" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>补贴天数</td>
    <td class="xl68" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>补贴金额（元）</td>
   </tr>
   <c:forEach items="${foodlist}" var="foodbean">
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl69" height="33.27" style='height:24.95pt;'>${foodbean.fname }</td>
    <td class="xl69" colspan="6" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${foodbean.fDays }</td>
    <td class="xl69" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${foodbean.fApplyAmount }</td>
   </tr>
   </c:forEach>
    <c:if test="${empty foodlist}">
    <td class="xl69" height="33.27" style='height:24.95pt;'>-</td>
    <td class="xl69" colspan="6" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl69" colspan="4" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    </c:if>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl72" height="33.27" colspan="7" style='height:24.95pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>住宿费</td>
    <td class="xl73" colspan="2" style='border-right:none;border-bottom:.5pt solid windowtext;' x:str>汇总金额（元）：</td>
    <td class="xl83" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.hotelAmount }</td>
   </tr>
   
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl68" height="33.27" style='height:24.95pt;' x:str>入住时间</td>
    <td class="xl68" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>退房时间</td>
    <td class="xl68" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>所在辖区</td>
    <td class="xl68" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>住宿人员</td>
    <td class="xl68" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>申请金额（元）</td>
   </tr>
   <c:forEach items="${hotellist}" var="hotelbean">
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl69" height="33.27" style='height:24.95pt;'><fmt:formatDate value="${hotelbean.checkInTime}" pattern="yyyy-MM-dd"/></td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'><fmt:formatDate value="${hotelbean.checkOUTTime}" pattern="yyyy-MM-dd"/></td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${hotelbean.locationCity}</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${hotelbean.travelPersonnel}</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${hotelbean.applyAmount}</td>
   </tr>
   </c:forEach>
   <c:if test="${empty hotellist}">
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl69" height="33.27" style='height:24.95pt;'>-</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl69" colspan="3" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
    <td class="xl69" colspan="2" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>-</td>
   </tr>
   </c:if>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl71" height="33.27" colspan="11" style='height:24.95pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>合计（元）</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl68" height="33.27" style='height:24.95pt;' x:str>金额（小写）</td>
    <td class="xl69" colspan="10" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.amount }</td>
   </tr>
   <tr height="46" style='height:34.50pt;mso-height-source:userset;mso-height-alt:690;'>
    <td class="xl68" height="46" style='height:24.95pt;' x:str>金额（大写）</td>
    <td class="xl69" colspan="10" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;'>${bean.applyAmountcapital }</td>
   </tr>
   <tr height="33.33" style='height:25.00pt;mso-height-source:userset;mso-height-alt:500;'>
    <td class="xl71" height="33.33" colspan="11" style='height:25.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>审签</td>
   </tr>
   <c:forEach items="${listTProcessChecks}" var="check">
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl75" height="133.07" rowspan="2" style='height:79.80pt;border-right:none;border-bottom:.5pt solid windowtext;' x:str>${check.fRoleName }</td>
    <td class="xl76" colspan="10" rowspan="1" style='border-right:.5pt solid windowtext;border-bottom:none;'>${check.fcheckRemake }</td>
   </tr>
   <tr height="33.27" style='height:24.95pt;mso-height-source:userset;mso-height-alt:499;'>
    <td class="xl77" colspan="10" style='border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>
    <c:if test="${!empty check.fuserId}">
    <font class="font2"><span style='mso-spacerun:yes;'><img style="vertical-align:bottom;width: 150px; height: 60px;margin-left:0px"  src="${base}/attachment/downloadQZ/${check.fuserId}"/></span></font><font class="font2">${check.fcheckTimes }</font>
    </c:if>
    <c:if test="${empty check.fuserId}">
    <font class="font2"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font><font class="font2">&nbsp;&nbsp;年&nbsp;月&nbsp;日</font>
    </c:if>
    </td>
   </tr>
   </c:forEach>
  </table>
<script type="text/javascript">
  $(document).ready(function() {
		window.print();
	}); 
  </script>
  </body>
</html>
