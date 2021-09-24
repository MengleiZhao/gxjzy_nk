package com.braker.workflow.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.braker.common.util.JSONUtils;
import com.braker.common.util.PoiUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.workflow.entity.TLinkData;
import com.braker.workflow.entity.TLinkRule;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TLinkDataMng;
import com.braker.workflow.manager.TLinkRuleMng;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 流程节点处理类
 * @author 安达
 * 2019-4-23
 */

@Service
public class TNodeLinkMngImpl implements TNodeLinkMng {
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private TLinkDataMng tLinkDataMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private RoleMng roleMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TLinkRuleMng tLinkRuleMng;
	
	/**
	 * 保存流程图的节点信息
	 * @param flowJson	
	 * @return
	 */
	@Override
	public String saveNodeAndLink(Integer flowId,String flowJson) throws Exception{
		// TODO Auto-generated method stub
		JSONObject jsonObject = JSONObject.fromObject(flowJson);  
		//转换成json对象
		String nodeDataArray=JSON.toJSONString(jsonObject.get("nodeDataArray"));
		String linkDataArray=(String) jsonObject.get("linkDataArray").toString();
		//将json格式转换成List<TLinkData>对象
		List<TLinkData> linkDataList=(List<TLinkData>) JSONUtils.jsonToList(linkDataArray,TLinkData.class);
		//根据流程id删除流程下的所有节点
		tLinkDataMng.deleteByFlowId(flowId);
		//保存流程流转信息
		tLinkDataMng.saveLink(flowId, linkDataList);
		//将json格式转换成List<TNodeData>对象
		List<TNodeData> nodeDataList=(List<TNodeData>) JSONUtils.jsonToList(nodeDataArray,TNodeData.class);
		//根据流程id删除流程下的所有节点
		tNodeDataMng.deleteByFlowId(flowId);
		//保存流程节点信息
		tNodeDataMng.saveNode(flowId, nodeDataList);//保存节点信息
		//修改流程状态为已激活
		TProcessDefin processDefin=tProcessDefinMng.findById(flowId);
		processDefin.setFStauts("1");
		tProcessDefinMng.updateDefault(processDefin);
//		inputExcel();  //从excel导入流程
//		setNodeCustom(1738,"BXTYLC"); //设置节点跳转规则
//		setLinkCustom(1738,"BXTYLC"); //设置连线跳转规则
		return null;
	}

	
	/**
	 * 根据流程id组装流程图的json
	 * @param flowJson	
	 * @return
	 */
	@Override
	public String getGraphLinksModelByFlowId(Integer flowId) throws Exception{
		// TODO Auto-generated method stub
		//创建JSON对象
	    JSONObject jsonObject = new JSONObject();
	    jsonObject.put("class", "go.GraphLinksModel");
	    jsonObject.put("linkFromPortIdProperty", "fromPort");//固定住出发节点
	    jsonObject.put("linkToPortIdProperty", "toPort");  //固定住到达节点
	    JSONObject modelDatajsonObject = new JSONObject();
	    modelDatajsonObject.put("position", "-5 -5");
	    jsonObject.put("modelData", modelDatajsonObject);
	    
	    //节点json数组
	    JSONArray nodeDatajsonArray = new JSONArray();
	  //获取流程节点集合
	  		List<TNodeData> nodeDataList=tNodeDataMng.findByFlowId(flowId);
	    for(TNodeData node:nodeDataList){
	    	//JSONObject nodejsonObject = JSONUtils.bean2json(node);
	    	JSONObject nodejsonObject =nodeData2JSONObject(node);
	    	nodeDatajsonArray.add(nodejsonObject);
	    }
	    jsonObject.put("nodeDataArray", nodeDatajsonArray);
	   //流程流转json数组
	    JSONArray linkDatajsonArray = new JSONArray();
	   //获取流程流转集合
	    List<TLinkData> linkDataList=tLinkDataMng.findByFlowId(flowId);
	    for(TLinkData link:linkDataList){
	    	//JSONObject linkjsonObject = JSONUtils.bean2json(link);
	    	JSONObject linkjsonObject =linkData2JSONObject(link);
	    	linkDatajsonArray.add(linkjsonObject);
	    }
	    jsonObject.put("linkDataArray", linkDatajsonArray);
		return jsonObject.toString();
	}
	
	
	/**
	 * TNodeData 转换成json
	 * @param node
	 * @return
	 */
	private JSONObject nodeData2JSONObject(TNodeData node){
		JSONObject jsonObject = new JSONObject();
		if(!StringUtil.isEmpty(node.getKeyId()+"")){
			jsonObject.put("key", node.getKeyId());
		}
		if(!StringUtil.isEmpty(node.getText())){//文本
			jsonObject.put("text", node.getText());
		}	
		if(!StringUtil.isEmpty(node.getFigure())){//形状
			jsonObject.put("figure", node.getFigure());
		}
		if(!StringUtil.isEmpty(node.getFill())){//填充颜色
			jsonObject.put("fill", node.getFill());
		}
		if(!StringUtil.isEmpty(node.getStepType())){//节点类型
			jsonObject.put("stepType", node.getStepType());
		}
		if(!StringUtil.isEmpty(node.getLoc())){//坐标
			jsonObject.put("loc", node.getLoc());
		}
		if(!StringUtil.isEmpty(node.getRoleId())){//角色id
			jsonObject.put("roleId", node.getRoleId());
		}
		if(!StringUtil.isEmpty(node.getDepartId())){//部门id
			jsonObject.put("departId", node.getDepartId());
		}
		if(!StringUtil.isEmpty(node.getUserId())){//用户id
			jsonObject.put("userId", node.getUserId());
		}
		if(!StringUtil.isEmpty(node.getAgree()+"")){//同意跳转节点
			jsonObject.put("agree", node.getAgree());
		}
		if(!StringUtil.isEmpty(node.getRefuse()+"")){ //拒绝跳转节点
			jsonObject.put("refuse", node.getRefuse());
		}
		if(!StringUtil.isEmpty(node.getCategory())){ //节点模板
			jsonObject.put("category", node.getCategory());
		}
		if(!StringUtil.isEmpty(node.getCustom())){ //自定义跳转模板
			jsonObject.put("custom", node.getCustom());
		}
		return jsonObject;
	}
	
	
	/**
	 * TLinkData 转换成json
	 * @param link
	 * @return
	 */
	private JSONObject linkData2JSONObject(TLinkData link){
		JSONObject jsonObject = new JSONObject();
		if(!StringUtil.isEmpty(link.getFromKey()+"")){//连线起始点
			jsonObject.put("from", link.getFromKey());
		}
		if(!StringUtil.isEmpty(link.getToKey()+"")){//连线目标点
			jsonObject.put("to", link.getToKey());
		}
		if(!StringUtil.isEmpty(link.getColor())){//颜色
			jsonObject.put("color", link.getColor());
		}
		if(!StringUtil.isEmpty(link.getText())){//文本
			jsonObject.put("text", link.getText());
		}	
		if(!StringUtil.isEmpty(link.getCustom())){ //自定义跳转模板
			jsonObject.put("custom", link.getCustom());
		}
		if(!StringUtil.isEmpty(link.getFromPort())){//出发点  T顶端    L左边   R右边 
			jsonObject.put("fromPort", link.getFromPort());
		}	
		if(!StringUtil.isEmpty(link.getToPort())){//到达点  T顶端    L左边   R右边 
			jsonObject.put("toPort", link.getToPort());
		}	
		return jsonObject;
	}
	private void inputExcel(){
//		File file = new File("C:\\Users\\叶崇辉\\Desktop\\流程确认表zuixin.xlsx");
//		File file = new File("C:\\Users\\Administrator\\Desktop\\流程确认表20210416.xlsx");
		File file = new File("C:\\Users\\zhaomenglei\\Desktop\\流程确认表导入最新0917.xlsx");
		Date d = new Date();
		PoiUtil pu = new PoiUtil();
		if (file.exists()) {
			FileInputStream fis = null;
			Workbook workBook = null;
			try {
				fis = new FileInputStream(file);
				workBook = WorkbookFactory.create(fis);
				Sheet sheetAt = workBook.getSheetAt(0);
              	int rowsOfSheet = sheetAt.getPhysicalNumberOfRows(); // 获取当前Sheet的总列数
				System.out.println("当前表格的总行数:" + rowsOfSheet);
				
				//获得所有部门
				List<Depart> departList=departMng.findAll();
				Map<String,String> deptMap=deptList2Map(departList);
				Map<String,String> roleMap=roleList2Map();
				for (int r = 2; r < rowsOfSheet; r++) { // 从第三行开始
					System.out.println(r);
					Row row = sheetAt.getRow(r);
					if (row == null) {
						break;
					} else {
						List<DeptRole> deptRoleList=new ArrayList<DeptRole>();
						String fPName="";
						String dept="";
						String FBusiArea="";
						boolean outflag=false;//退出列循环标记
						int numberOfCells = row.getPhysicalNumberOfCells();
						for (int c = 0; c < numberOfCells; c++) { // 总列(格)
							if(c==1) {
								//获取第二列数据，这个是流程名称
								Cell cell = row.getCell(c);
								fPName = pu.getCellValue(cell);
							}
							if(c==2){
								//流程编码
								Cell cell = row.getCell(c);
								FBusiArea = pu.getCellValue(cell);
								
							}
							if(c==5) {
								//获取第5列，这个是对应部门，如果对应部门包含有“相关部门”，则for循环所有部门,生成所有流程名。 否则 获取对应部门
								Cell cell = row.getCell(c);
								dept = pu.getCellValue(cell);
							}
							for(int i=9;i<100;){
								//从第9列开始读，获取审批节点的部门名称，如果包含“相关部门”，则部门是当前循环的部门名称，如果不是，则读取获取的部门名称
								if(c==i) {
									DeptRole deptRole=new DeptRole(); 
									Cell cell1 = row.getCell(c);
									String deptName = pu.getCellValue(cell1).trim();
									if(StringUtils.isEmpty(deptName)){
										outflag=true;
										break;
									}
									deptRole.setDeptName(deptName);
									Cell cell2 = row.getCell(c+1);
									String roleName = pu.getCellValue(cell2).trim();
									deptRole.setRoleName(roleName);
									deptRoleList.add(deptRole);
								}
								i=i+4;
							}
							if(outflag){
								break;
							}
						}
						
						
						if("相关部门".equals(dept)){
							for(Depart depart:departList){
								if("广西交通职业技术学院".equals(depart.getName())){
									continue;
								}
								addDateLink(depart,deptMap,roleMap,deptRoleList, fPName,FBusiArea);
								
							}
						}else{
							Depart depart=departMng.findUniqueByProperty("name", dept);
							addDateLink(depart,deptMap,roleMap,deptRoleList, fPName,FBusiArea);
						}
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServiceException("读取excel文件报错,请检查excel格式");
				//e.printStackTrace();
			}finally{
				if (fis != null) {
					try {
						fis.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		} else {
			throw new ServiceException("文件不存在");
		}
	
	}
	private void addDateLink(Depart depart,Map<String,String> deptMap,Map<String,String> roleMap,List<DeptRole> deptRoleList,String fPName,String FBusiArea){
			TProcessDefin processDefin=new TProcessDefin();
			processDefin.setFPName(fPName+"("+depart.getName()+")");
			processDefin.setDepartCode(depart.getId());
			processDefin.setDepartName(depart.getName());
			processDefin.setFPath("全局");
			processDefin.setFStauts("1");
			processDefin.setFCreateUser("admin");
			processDefin.setFBusiArea(FBusiArea);
			processDefin.setFPCode(String.valueOf(StringUtil.random8()));
			processDefin=(TProcessDefin) tProcessDefinMng.saveOrUpdate(processDefin);
			Integer fPid=processDefin.getFPId();
			//定义开始节点
			TNodeData startnode=new TNodeData();
			startnode.setKeyId(0);  //键值
			startnode.setFPId(processDefin.getFPId());  //流程id
			startnode.setText("开始");  //文字显示
			startnode.setFigure("Circle");  //形状 圆形
			startnode.setFill("#4fba4f");  //填充颜色
			startnode.setStepType("1");  //节点类型
			startnode.setLoc("300 0");  //坐标
			startnode.setAgree(1);   //同意跳转节点
			startnode.setCategory("Start");   //类型
			tNodeDataMng.save(startnode);
			//开始节点的连线
			TLinkData startlink=new TLinkData();
			startlink.setFromKey(0);
			startlink.setToKey(1);
			startlink.setFPId(fPid);
			startlink.setFromPort("T");
			startlink.setToPort("T");
			tLinkDataMng.save(startlink);
			for(int i=0;i<deptRoleList.size();i++){
				DeptRole deptRole=deptRoleList.get(i);
				//从第十列开始读，获取审批节点的部门名称，如果包含“相关部门”，则部门是当前循环的部门名称，如果不是，则读取获取的部门名称
				String deptId="";
				String roleId="";
				if("相关部门".equals(deptRole.getDeptName())){
					deptId=depart.getId();
					roleId=roleMap.get(deptRole.getRoleName()+deptId);
				}else{
					deptId=deptMap.get(deptRole.getDeptName());
					roleId=roleMap.get(deptRole.getRoleName()+deptId);
				}
				if("分管业务校领导".equals(deptRole.getRoleName()) || "相关部门主管校长".equals(deptRole.getRoleName())){//
					if("相关部门".equals(deptRole.getDeptName())){
						deptId=depart.getId();
					}else{
						deptId=deptMap.get(deptRole.getDeptName());
					}
				}else if(deptRole.getRoleName().contains("财务主管校长")){
					deptId=deptMap.get("校领导");
				}else if(deptRole.getRoleName().contains("主管校长")){
					//如果角色名称包含主管校长，那就是主管校长,截取相应的部门   相关部门主管校长
					String deptname=deptRole.getRoleName().substring(0,deptRole.getRoleName().length()-4);
					deptId=deptMap.get(deptname);
				}
				Depart depart1=departMng.findById(deptId);
				User user=new User();
				if(deptRole.getRoleName().equals("校长")){
					user.setId("3");
					user.setName("李文勇");
				}else if(StringUtils.isEmpty(roleId)){ //如果是主管校长，直接获取部门对应的主管校长
					user=depart1.getManager();
				}else{
					user=userMng.getUserByRoleIdAndDepartId(roleId, deptId);
				}
				
				TNodeData rolenode=new TNodeData();
				rolenode.setKeyId(i+1);  //键值
				rolenode.setFPId(fPid);  //流程id
				
				if("广西交通职业技术学院".equals(deptRole.getDeptName())){
					rolenode.setText(null);  //文字显示
					rolenode.setUserId(null);//用户id
				}else{
					if(user==null || "李文勇".equals(user.getName())){
						rolenode.setText(user.getName()+"|校长");  //文字显示
					}else{
						rolenode.setText(user.getName()+"|"+depart1.getName());  //文字显示
					}
					rolenode.setUserId(user.getId());//用户id
				}
				
				rolenode.setFill("#1E9FFF");  //填充颜色
				rolenode.setStepType("2");  //节点类型
				String x=(650)+"";
				String y=(i*100)+"";
				String loc=x+" "+y;
				rolenode.setLoc(loc);  //坐标
				rolenode.setAgree(i+2);   //同意跳转节点
				rolenode.setRefuse(0);
				rolenode.setCategory("Role");   //类型
				/*rolenode.setRoleId(roleId);
				rolenode.setDepartId(deptId);*/
				tNodeDataMng.save(rolenode);
				
				TLinkData agreelink=new TLinkData();
				agreelink.setFromKey(i+1);
				agreelink.setToKey(i+2);
				agreelink.setFPId(fPid);
				agreelink.setText("同意");
				agreelink.setFromPort("B");
				agreelink.setToPort("T");
				tLinkDataMng.save(agreelink);
				
//				TLinkData jujuelink=new TLinkData();
//				jujuelink.setFromKey(i+1);
//				jujuelink.setToKey(0);
//				jujuelink.setFPId(fPid);
//				jujuelink.setFromPort("L");
//				jujuelink.setToPort("B");
//				jujuelink.setText("不同意");
//				tLinkDataMng.save(jujuelink);
				
			}
			TNodeData endnode=new TNodeData();
			endnode.setKeyId(deptRoleList.size()+1);  //键值
			endnode.setFPId(fPid);  //流程id
			endnode.setText("结束");  //文字显示
			endnode.setFigure("Circle");  //形状 圆形
			endnode.setFill("#CE0620");  //填充颜色
			endnode.setStepType("4");  //节点类型
			String x2=(300)+"";
			String y2=((deptRoleList.size())*100)+"";
			String loc2=x2+" "+y2;
			endnode.setLoc(loc2);  //坐标
			endnode.setCategory("End");   //类型
			tNodeDataMng.save(endnode);
	}
	/**
	 * 
	* @author:安达
	* @Title: setCustom 
	* @Description: 这里用一句话描述这个方法的作用 
	* @param flowId  模板流程连线
	* @param FBusiArea  业务范围
	* @throws Exception
	* @return void    返回类型 
	* @date： 2020年1月9日下午4:54:27 
	* @throws
	 */
	private void setNodeCustom(Integer flowId,String FBusiArea) throws Exception{
		/*update t_node_data set custom='F_AMOUNT<10000,6' where  key_id='3' and   F_P_ID>2178;
		update t_node_data set custom='F_AMOUNT>=50000,5;F_AMOUNT>=10000 and F_AMOUNT<50000,6' where  key_id='4' and   F_P_ID>2178;
		update t_link_data set custom='F_AMOUNT>=50000',text='金额大于等于50000元' where  from_key='4' and to_key='5' and   F_P_ID>2178;*/
		List<TProcessDefin>  processdefinList=tProcessDefinMng.findTProcessDefinsByFBusiArea(FBusiArea);
		List<TNodeData>  nodeDataList=tNodeDataMng.findByFlowId(flowId); //查询模板的节点
		for(TProcessDefin processdefin:processdefinList){
			if(flowId !=processdefin.getFPId()){   //只修改非模板的节点
				List<TNodeData>  list=tNodeDataMng.findByFlowId(processdefin.getFPId()); //查询非模板的节点
				for(int i=0;i<list.size();i++){
					TNodeData node=list.get(i);
					node.setCustom(nodeDataList.get(i).getCustom());
					node.setLoc(nodeDataList.get(i).getLoc());
					node.setAgree(nodeDataList.get(i).getAgree());
					node.setKeyId(nodeDataList.get(i).getKeyId());
					tNodeDataMng.updateDefault(node);
				}
			}
		}
	}
	
	/**
	 * 
	* @author:安达
	* @Title: setCustom 
	* @Description: 这里用一句话描述这个方法的作用 
	* @param flowId  模板流程连线
	* @param FBusiArea  业务范围
	* @throws Exception
	* @return void    返回类型 
	* @date： 2020年1月9日下午4:54:27 
	* @throws
	 */
	private void setLinkCustom(Integer flowId,String FBusiArea) throws Exception{
		/*update t_node_data set custom='F_AMOUNT<10000,6' where  key_id='3' and   F_P_ID>2178;
		update t_node_data set custom='F_AMOUNT>=50000,5;F_AMOUNT>=10000 and F_AMOUNT<50000,6' where  key_id='4' and   F_P_ID>2178;
		update t_link_data set custom='F_AMOUNT>=50000',text='金额大于等于50000元' where  from_key='4' and to_key='5' and   F_P_ID>2178;*/
		List<TProcessDefin>  processdefinList=tProcessDefinMng.findTProcessDefinsByFBusiArea(FBusiArea);
		List<TLinkData>  linkDataList=tLinkDataMng.findByFlowId(flowId); //查询模板的连线
		for(TProcessDefin processdefin:processdefinList){
			if(flowId !=processdefin.getFPId()){   //只修改非模板的连线
				tLinkDataMng.deleteByFlowId(processdefin.getFPId());  //删除老数据
				for(TLinkData link:linkDataList){
					//下面这段，把模板的数据设置到新对象里
					TLinkData linkdata=new TLinkData();
					linkdata.setFPId(processdefin.getFPId());  //流程id改变一下，其他跟模板一样
					linkdata.setFromKey(link.getFromKey());
					linkdata.setToKey(link.getToKey());
					linkdata.setText(link.getText());
					linkdata.setLoc(link.getLoc());
					linkdata.setColor(link.getColor());
					linkdata.setFromPort(link.getFromPort());
					linkdata.setToPort(link.getToPort());
					linkdata.setCustom(link.getCustom());
					tLinkDataMng.save(linkdata);  //插入数据，  因为上面已经删掉老数据了
				}
			}
		}
		
		List<TNodeData>  nodeDataList=tNodeDataMng.findByFlowId(flowId);  //获取所有节点集合
		for(TProcessDefin processdefin:processdefinList){
			if(flowId !=processdefin.getFPId()){   //只修改非模板的节点
				for(TNodeData node:nodeDataList){
					if(StringUtils.isNotEmpty(node.getCustom())){ //如果模板节点有跳转条件
						//根据当前流程id和模板的 key查询要修改的节点
						TNodeData node1=tNodeDataMng.getByFlowIdAndKey(processdefin.getFPId(),node.getKeyId());
						node1.setCustom(node.getCustom());//把模板的节点跳转条件设置进去
						tNodeDataMng.updateDefault(node1); //修改
					}
				}
			}
		}
	}
	
	
	
	private Map<String,String> deptList2Map(List<Depart> departList){
		Map<String,String> map=new HashMap<String,String>();
		for(Depart depart:departList){
			map.put(depart.getName(), depart.getId());
		}
		return map;
	}
	
	private Map<String,String> roleList2Map(){
		List<Role> roleList=roleMng.findAll();
		Map<String,String> map=new HashMap<String,String>();
		for(Role role:roleList){
			map.put(role.getName()+role.getDepartid(),role.getId());
		}
		return map;
	}
	public class DeptRole{
		String deptName;
		String roleName;
		public String getDeptName() {
			return deptName;
		}
		public void setDeptName(String deptName) {
			this.deptName = deptName;
		}
		public String getRoleName() {
			return roleName;
		}
		public void setRoleName(String roleName) {
			this.roleName = roleName;
		}
	}
}
