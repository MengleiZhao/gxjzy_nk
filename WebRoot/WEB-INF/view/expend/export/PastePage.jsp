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
		{color:#F2F2F2;
		font-size:72.0pt;
		font-weight:400;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:134;}
	.font2
		{color:#000000;
		font-size:11.0pt;
		font-weight:400;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font3
		{color:#FFFFFF;
		font-size:11.0pt;
		font-weight:400;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font4
		{color:#9C0006;
		font-size:11.0pt;
		font-weight:400;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font5
		{color:#000000;
		font-size:11.0pt;
		font-weight:700;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font6
		{color:#44546A;
		font-size:15.0pt;
		font-weight:700;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:134;}
	.font7
		{color:#800080;
		font-size:11.0pt;
		font-weight:400;
		font-style:normal;
		text-decoration:underline;
		text-underline-style:single;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font8
		{color:#FA7D00;
		font-size:11.0pt;
		font-weight:400;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font9
		{color:#9C6500;
		font-size:11.0pt;
		font-weight:400;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font10
		{color:#44546A;
		font-size:13.0pt;
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
		{color:#FA7D00;
		font-size:11.0pt;
		font-weight:700;
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
		{color:#3F3F76;
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
		font-weight:700;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font16
		{color:#3F3F3F;
		font-size:11.0pt;
		font-weight:700;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font17
		{color:#0000FF;
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
		{color:#FF0000;
		font-size:11.0pt;
		font-weight:400;
		font-style:normal;
		text-decoration:none;
		font-family:"宋体";
		mso-generic-font-family:auto;
		mso-font-charset:0;}
	.font20
		{color:#7F7F7F;
		font-size:11.0pt;
		font-weight:400;
		font-style:italic;
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
		font-size:14.0pt;
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
		color:#F2F2F2;
		font-size:72.0pt;
		mso-font-charset:134;
		border:.5pt solid windowtext;}
	.xl66
		{mso-style-parent:style0;
		text-align:right;
		mso-font-charset:134;}
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
	        <x:TopRowVisible>21</x:TopRowVisible>
	        <x:Panes>
	         <x:Pane>
	          <x:Number>3</x:Number>
	          <x:ActiveCol>9</x:ActiveCol>
	          <x:ActiveRow>29</x:ActiveRow>
	          <x:RangeSelection>30:33</x:RangeSelection>
	         </x:Pane>
	        </x:Panes>
	        <x:ProtectContents>False</x:ProtectContents>
	        <x:ProtectObjects>False</x:ProtectObjects>
	        <x:ProtectScenarios>False</x:ProtectScenarios>
	        <x:ShowPageBreakZoom/>
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
	     <x:SelectedSheets>0</x:SelectedSheets>
	     <x:WindowHeight>7860</x:WindowHeight>
	     <x:WindowWidth>20490</x:WindowWidth>
	    </x:ExcelWorkbook>
	   </xml>
	  <![endif]-->
  </head>
  
  <body>
	 <table width="648" border="0" cellpadding="0" cellspacing="0" style='width:486.00pt;border-collapse:collapse;table-layout:fixed;'>
	   <col width="72" span="9" style='mso-width-source:userset;mso-width-alt:2304;'/>
	   <tr height="18" style='height:13.50pt;'>
	    <td class="xl65" height="641" width="648" colspan="9" rowspan="47" style='height:641.50pt;width:486.00pt;border-right:.5pt solid windowtext;border-bottom:.5pt solid windowtext;' x:str>发票粘贴单</td>
	   </tr>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'/>
	   <tr height="18" style='height:13.50pt;'>
	    <td height="18" colspan="5" style='height:13.50pt;mso-ignore:colspan;'></td>
	    <td class="xl66" colspan="4" style='border-right:none;border-bottom:none;' x:str>报销单号：${code}</td>
	   </tr>
	   <tr height="18" style='height:13.50pt;'>
	    <td height="18" colspan="5" style='height:13.50pt;mso-ignore:colspan;'></td>
	    <td class="xl66" colspan="4" style='border-right:none;border-bottom:none;' x:str>总计金额：<font class="font0"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font class="font0">元</font></td>
	   </tr>
	   <tr height="18" style='height:13.50pt;'>
	    <td height="18" colspan="5" style='height:13.50pt;mso-ignore:colspan;'></td>
	    <td class="xl66" colspan="4" style='border-right:none;border-bottom:none;' x:str>票据张数：<font class="font0"><span style='mso-spacerun:yes;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font><font class="font0">张</font></td>
	   </tr>
	   <![if supportMisalignedColumns]>
	    <tr width="0" style='display:none;'>
	     <td width="72" style='width:54;'></td>
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
