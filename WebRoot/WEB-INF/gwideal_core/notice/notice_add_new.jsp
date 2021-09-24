<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

   <script type="text/javascript" charset="utf-8" src="${base}/resource-modality/ueditor/ueditor.config.js"></script>
   <script type="text/javascript" charset="utf-8" src="${base}/resource-modality/ueditor/ueditor.all.min.js"> </script>
   <script type="text/javascript" charset="utf-8" src="${base}/resource-modality/ueditor/lang/zh-cn/zh-cn.js"></script>

<!--style给定宽度可以影响编辑器的最终宽度-->
<script id="editor" type="text/plain" style="width:1024px;height:500px;"></script>


<html>
<script type="text/javascript">
//实例化编辑器
var ue = UE.getEditor('editor');
</script>
</html>
