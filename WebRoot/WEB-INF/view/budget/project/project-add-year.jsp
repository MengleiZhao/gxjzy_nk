<%@ page language="java" pageEncoding="UTF-8"%>
<html>

<body>

	<table style="width:100%" class="a_table">
					<tr>
						<th class="br">目标信息
					</tr>
        			<tr>
        				<th class="br">序号
        				</th>
        				<td class="br">
        					<input  name="name" class="easyui-textbox" data-options="required:false" prompt="请输入项目名称" name="">
        				</td>
        				<th class="br">目标名称
        				</th>
        				<td class="br">
        					<input class="easyui-textbox" data-options="required:false" prompt="<系统自动生成>" name="">
        				</td>
        				<td>
        					<a href="javascript:void(0)" class="tablelink"
									onclick="clonerow(this)">添加</a> &nbsp;&nbsp; <a
									href="javascript:void(0)" class="tablelink"
									onclick="delrow(this)"> 删除</a>
        				</td>
        			</tr>
      </table>
      
	<table style="width:100%" class="a_table">
					<tr>
						<th class="br">指标信息
					</tr>
        			<tr>
        				<th class="br">一级指标
        				</th>
        				<td class="br">
        					<input  name="name" class="easyui-textbox" data-options="required:false" prompt="请输入项目名称" name="">
        				</td>
        				<th class="br">二级指标
        				</th>
        				<td class="br">
        					<input class="easyui-textbox" data-options="required:false" prompt="<系统自动生成>" name="">
        				</td>
        				<th class="br">指标名称
        				</th>
        				<td class="br">
        					<input class="easyui-textbox" data-options="required:false" prompt="<系统自动生成>" name="">
        				</td>
        				<th class="br">指标值
        				</th>
        				<td class="br">
        					<input class="easyui-textbox" data-options="required:false" prompt="<系统自动生成>" name="">
        				</td>
        				<th class="br">绩效标准
        				</th>
        				<td class="br">
        					<input class="easyui-textbox" data-options="required:false" prompt="<系统自动生成>" name="">
        				</td>
        				<td>
        					<a href="javascript:void(0)" class="tablelink"
									onclick="clonerow(this)">添加</a> &nbsp;&nbsp; <a
									href="javascript:void(0)" class="tablelink"
									onclick="delrow(this)"> 删除</a>
        				</td>
        			</tr>
      </table>















<script type="text/javascript">
function delrow(btn) {
	var row = btn.parentNode;
	if (row.id != 't_tr') {
		var table = btn.parentNode.parentNode;
		table.remove(row);
	}
}
function clonerow(btn) {
	var newrow = btn.parentNode.parentNode.cloneNode(true);
	newrow.id = '';
	btn.parentNode.parentNode.parentNode.append(newrow)
}
</script>




</body>
</html>