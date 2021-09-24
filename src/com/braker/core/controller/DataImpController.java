package com.braker.core.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartImpMng;

@SuppressWarnings("serial")
@Controller
@RequestMapping("/impData")
public class DataImpController extends BaseController {
	
	@Autowired 
	private DepartImpMng departImgMng;
	
	@RequestMapping("/imp")
	public void imp(){
//		File file = new File("C:\\Users\\Administrator\\Desktop\\2月24日汇总表2（长宁）.xls");
//		departImgMng.impMdjf(file, getUser());
		departImgMng.updateVersion();
	}
	
	@RequestMapping("/depart")
	public void importDepart() {
		//将xls导入临时表
//		File file = new File("C:\\Users\\Administrator\\Desktop\\z综治文件\\长宁组织机构.xlsx");
		File file = new File("C:\\Users\\Administrator\\Desktop\\z综治文件\\新建 Microsoft Excel 工作表.xls");
		departImgMng.impData(file);
		
		/**和sys_depart表关联**/
//		List<DepartImp> newList = departImgMng.findAll();
//		List<Depart> oldList = departMng.findAll();
		   
		//1、判断部门是否已经存在 不存在则新建 存在则修改排序
//		for(DepartImp newd: newList){
//			boolean exist = false;
//			Depart d1 = departMng.findByCode(newd.getCode());
//			if(d1!=null){
//				d1.setOrderNo(newd.getOrderNo());
//				d1.setDescription(newd.getShortName());
//				departMng.save(d1);
//				System.out.println("更新数据：" + d1.getName());
//			}else{
//				Depart depart = new Depart();
//				depart.setCode(newd.getCode());
//				depart.setDescription(newd.getShortName());
//				depart.setName(newd.getFullName());
//				depart.setOrderNo(newd.getOrderNo());dfssdffsd
//				departMng.save(depart);
//				System.out.println("添加数据：" + depart.getName());
//			}
//		}
		
		System.out.println("---------------------------");
		//2、获得更新后的sys_depart表遍历 逐个绑定上级单位
//		List<Depart> updatedList = departMng.findAll();
//		for(Depart depart: updatedList){
//			DepartImp departImp1 = departImgMng.findByCode(depart.getCode());
//			if(departImp1!=null){
//				DepartImp departImp2 = departImgMng.findById(departImp1!=null?departImp1.getParentId():null);
//				if(departImp2!=null){
//					String code = departImp2.getCode();
//					Depart depart1 = departMng.findByCode(code);
//					depart.setParent(depart1);
//					departMng.save(depart);
//					System.out.println(depart.getName()+ " 的上层单位是: " + depart1.getName());
//				}
//			}
//		}
		
	}
	
//	private Depart copyDepart(DepartImp impo){
//		Depart depart = new Depart();
//	}
	
	
}
