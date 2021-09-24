package com.braker.icontrol.budget.manager.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.MatheUtil;
import com.braker.common.util.PoiUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.manager.impl.DepartMngImpl;
import com.braker.core.model.Depart;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.expend.apply.manager.ApplicationBasicInfoMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;

/**
 * 预算指标管理的service实现类
 * @author 叶崇晖
 * @createtime 2018-09-12
 * @updatetime 2018-09-12
 */
@Service
@Transactional
public class BudgetIndexMgrMngImpl extends BaseManagerImpl<TBudgetIndexMgr> implements BudgetIndexMgrMng {
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private DepartMng departMng;

	@Autowired
	private TProBasicInfoMng projectMng;
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	
	@Autowired
	private ApplicationBasicInfoMng applicationBasicInfoMng;
	/*
	 * 指标分页查询
	 * @author 叶崇晖
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@Override
	public Pagination pageList(TBudgetIndexMgr bean, String indexType, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" FROM TBudgetIndexMgr WHERE indexType="+indexType );
		if(!StringUtil.isEmpty(bean.getIndexName())) {
			finder.append(" AND indexName LIKE '%"+bean.getIndexName()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getIndexCode())) {
			finder.append(" AND indexCode LIKE '%"+bean.getIndexCode()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getDeptName())) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getStauts())) {
			finder.append(" AND stauts='"+bean.getStauts()+"'");
		}
		
		finder.append(" order by bId desc ");
		return super.find(finder, pageNo, pageSize);
	}
	
	
	/*
	 * 保存导入的模板文件
	 * @author 叶崇晖
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@Override
	public void saveFile(File file, User user) throws Exception {
		Date d = new Date();
		PoiUtil pu = new PoiUtil();
		if (file.exists()) {
			FileInputStream fis = null;
			Workbook workBook = null;
			try {
				fis = new FileInputStream(file);
				workBook = WorkbookFactory.create(fis);
				org.apache.poi.ss.usermodel.Sheet sheetAt = workBook.getSheetAt(0);
               /* String sheetName = sheetAt.getSheetName(); //获取工作表名称
*/					int rowsOfSheet = sheetAt.getPhysicalNumberOfRows(); // 获取当前Sheet的总列数
				/*System.out.println("当前表格的总行数:" + rowsOfSheet);*/

				//获取预算年度
				Row yrow = sheetAt.getRow(1);
				Cell ycell = yrow.getCell(0);
				ycell.setCellType(HSSFCell.CELL_TYPE_STRING);
				String years = pu.getCellValue(ycell);
				
				for1:
				for (int r = 4; r < rowsOfSheet; r++) { // 从第四行开始
					TBudgetIndexMgr bean = new TBudgetIndexMgr();
					bean.setIndexType("0"); //指标类型(0-基本指标；1-项目指标；)
					bean.setControlType("1");//控制方式(1-刚性控制（不允许超额支出）2-合理范围内控制
					bean.setAppDate(d);////批复日期
					bean.setYears(years.split("\\：")[1]);//预算年度
					bean.setStauts("1");//指标生成状态(0-未生成（新增记录时，默认为0） 1-已生成在项目列表二下之后
					bean.setReleaseStauts("1");//指标下达状态1
					Row row = sheetAt.getRow(r);
					if (row == null) {
						continue;
					} else {
						int numberOfCells = row.getPhysicalNumberOfCells();
						for (int c = 0; c < numberOfCells; c++) { // 总列(格)
							Cell cell = row.getCell(c);
//								if(c==1) {
//									//支出分类科目编码
//									cell.setCellType(HSSFCell.CELL_TYPE_STRING);
//									String stringCellValue = pu.getCellValue(cell);
//									/*if(stringCellValue.equals("301") || stringCellValue.equals("302") || stringCellValue.equals("303") || stringCellValue==null) {
//										continue for1;
//									}*/
//									bean.setExpItemCode(stringCellValue);
//								}
							if(c==1) {
								//归属部门
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtil.isEmpty(stringCellValue)){
									continue;
								}
								bean.setDeptName(stringCellValue);
							}
							else if(c==2) {
								//归属部门编码
								cell.setCellType(HSSFCell.CELL_TYPE_STRING);
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtil.isEmpty(stringCellValue)){
									continue;
								}
								Depart dept=DepartMngImpl.codeDepartMap.get(stringCellValue);
								bean.setDeptCode(dept.getId());
							}
							else if(c==3) {
								//上级科目编码
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtil.isEmpty(stringCellValue)){
									continue;
								}
								bean.setExpItemCode2(stringCellValue);
							}
							else if(c==4) {
								//科目编码
								cell.setCellType(HSSFCell.CELL_TYPE_STRING);//设置获取格式是字符串
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtil.isEmpty(stringCellValue)){
									continue;
								}
								bean.setExpItemCode(stringCellValue);
							}
							else if(c==6) {
								//指标名称
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtil.isEmpty(stringCellValue)){
									continue;
								}
								bean.setIndexName(stringCellValue);
								bean.setExpItemName(stringCellValue);
							}
							else if(c==7) {
								//项目编码
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtil.isEmpty(stringCellValue)){
									continue;
								}
								bean.setIndexCode(stringCellValue);
							}
							else if(c==8) {
								//批复金额
								cell.setCellType(HSSFCell.CELL_TYPE_STRING);
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtil.isEmpty(stringCellValue)){
									continue;
								}
								bean.setYsAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
								bean.setPfAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
								bean.setPfzAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
								bean.setSyAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
								bean.setXdAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
								bean.setDjAmount(BigDecimal.ZERO);
							}
							else if(c==9) {
								//资金性质
								String stringCellValue = pu.getCellValue(cell);
								if("财政性资金".equals(stringCellValue)){
									bean.setProperty("0");
								}else{
									bean.setProperty("1");
								}
								
							}
						}
						if(StringUtils.isNotEmpty(bean.getIndexCode())) {
							super.saveOrUpdate(bean);
						}
					}
				}
				
				file.delete();//删除临时文件
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


	@Override
	public Double sumpfAmount(String year) {
		Query query=getSession().createSQLQuery(" select sum(F_PF_AMOUNT) from T_BUDGET_INDEX_MGR where F_INDEX_TYPE='1' and F_YEARS='"+year+"'");
		return (double)(query.list().get(0));
	}


	/*
	 * 基本指标保存
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@Override
	public void saveIndex(TBudgetIndexMgr bean) {
		Depart dept=DepartMngImpl.codeDepartMap.get(bean.getDeptCode());
		bean.setDeptCode(dept.getId());
		bean.setYsAmount(bean.getPfzAmount());
		bean.setPfAmount(bean.getPfzAmount());
		bean.setDjAmount(BigDecimal.ZERO);
		bean.setReleaseStauts("0");//指标状态改为未下达
		bean.setStauts("0");
		bean.setAppDate(new Date());
		super.saveOrUpdate(bean);
	}

	/*
	 * 生成一下通过或二上审批通过的项目的指标
	 * @author 叶崇晖
	 * @createtime 2018-09-29
	 * @updatetime 2018-09-29
	 */
	@Override
	public void createIndex(List<TProBasicInfo> proList) {
		for (int i = 0; i < proList.size(); i++) {
			//遍历项目，建立新指标s
			TBudgetIndexMgr index = new TBudgetIndexMgr();
			index.setFProId(proList.get(i).getBeanId());
			index.setIndexName(proList.get(i).getFProName());//自动生成时和项目名称相同
			index.setIndexCode(proList.get(i).getBeanCode());
			index.setIndexType(String.valueOf(proList.get(i).getFProOrBasic()));//0-基本支出指标，1-项目指标
			index.setExpItemCode2(proList.get(i).getSecondLevelName());//二级分类名称
			index.setExpItemCode(proList.get(i).getSecondLevelCode());//二级分类编码
			
			User user = userMng.findById(proList.get(i).getFProAppliPeopleId());
			index.setDeptName(user.getDepartName());//使用部门项目为申报人的部门
			index.setDeptCode(user.getDepart().getId());//使用部门编码为申报人的部门的编码
			
			index.setControlType("1");//默认为1-刚性控制（不允许超额支出）
			index.setExcessRange(null);//超额范围默认为空
			index.setYears(proList.get(i).getPlanStartYear());//预算年度为计划开始执行年份
			index.setXdAmount(BigDecimal.ZERO);//指标累计下达金额（元）
			index.setYsAmount(proList.get(i).getFProBudgetAmount());//指标预算金额（元）为项目预算金额
			index.setPfAmount(proList.get(i).getFProBudgetAmount());//批复金额为一下项目预算金额
			index.setPfzAmount(proList.get(i).getFProBudgetAmount());
			index.setSyAmount(BigDecimal.ZERO);//剩余金额为累计下达金额（元）
			index.setDjAmount(BigDecimal.ZERO);//冻结金额为0
			index.setReleaseStauts("0");//指标下达状态0
			index.setStauts("1");//指标生成状态(0-未生成（新增记录时，默认为0）
			index.setSource("1");//预算来源(1、本年预算2、往年预算 )默认1
			index.setAppDate(new Date());
			index.setFext1(proList.get(i).getFProId().toString());//项目ID
			index.setProCharger(proList.get(i).getFProAppliPeopleId());//项目负责人
			index.setProUseType(proList.get(i).getProUseType());
			//保存
			super.saveOrUpdate(index);
		}
		
	}

	/*
	 * 指标生成
	 * @author 叶崇晖
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@Override
	public void generate(String fproIdLi) {
		String[] id = fproIdLi.split(",");
		for (int i = 0; i < id.length; i++) {
			getSession().createSQLQuery("UPDATE t_budget_index_mgr SET F_STAUTS='1',F_RELEASE_STAUTS='0' WHERE F_B_ID='"+id[i]+"'").executeUpdate();
		}
	}

	/*
	 * 删除指标
	 */
	@Override
	public void deleteIndex(String bId) {
		getSession().createSQLQuery("delete from t_budget_index_mgr WHERE F_B_ID="+bId).executeUpdate();
	}
	
	@Override
	public Pagination insideOrProject(Integer pageNo, Integer pageSize,TBudgetIndexMgr bean, User user, String indexType) {
		String nowYear=DateUtil.formatDate(new Date(), "yyyy");
		Finder finder=Finder.create("FROM TBudgetIndexMgr WHERE releaseStauts='1' and years='"+nowYear+"' ");
		/*finder.append(" and years =:years").setParam("years",String.valueOf(DateUtils.getThisYear()));*/
		finder.append(" and indexType =:indexType").setParam("indexType", indexType);
		String deptIdStr=departMng.getDeptIdStrByUser(user);
 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and deptCode = :deptCode").setParam("deptCode", user.getDpID());
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and deptCode in ("+deptIdStr+")");
 		}
 		
 		//根据预算名称查询指标
 		if (bean != null) {
			if (!StringUtil.isEmpty(bean.getIndexName())) {
				finder.append(" and indexName like:indexName").setParam("indexName", "%" + bean.getIndexName() + "%");
			}
		}
 		
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public TBudgetIndexMgr findByIndexCode(String indexCode) {
		Finder finder=Finder.create(" FROM TBudgetIndexMgr WHERE indexCode='"+indexCode+"'");
		List<TBudgetIndexMgr> list= super.find(finder);
		if(list==null || list.size()==0){
			return null;
		}else{
			return list.get(0) ;
		}
		
	}
	
	@Override
	public List<TBudgetIndexMgr> findByBids(String bids) {
		Finder finder=Finder.create(" FROM TBudgetIndexMgr WHERE bId in ("+bids+")");
		return  super.find(finder);
	}


	@Override
	public void saveYearOrStauts(String indexCode, String year, String stauts) {
		TBudgetIndexMgr bean = findByIndexCode(indexCode);
		if(year!=null){
			bean.setYears(year);
		}
		if(stauts!=null){
			bean.setStauts(stauts);
		}
		super.merge(bean);
	}
	
	//生成指标前 判断指标编码是否重复	false：重复；true：不重复
	public boolean isIndexCode(String code){
		TBudgetIndexMgr t=findByIndexCode(code);
		if(t==null){
			return true;	//指标编码不重复
		}
		return false;	//重复
	}

	@Override
	public Boolean checkAmount(ReimbAppliBasicInfo bean) throws Exception{
		TBudgetIndexMgr indexMgr = super.findById(bean.getIndexId());
		//获取事前申请单
		ApplicationBasicInfo applicationBasicInfo=applicationBasicInfoMng.getByGCode(bean.getgCode());
		//获取事前申请金额
		BigDecimal sqAmount=applicationBasicInfo.getAmount(); 
		//如果超出的金额大于剩余金额, 不允许报销
		if(StringUtil.isEmpty(String.valueOf(bean.getAmount()))){
			throw new ServiceException("未填写报销金额，请重新填写再申报");
		}
		if(null == sqAmount){
			sqAmount = BigDecimal.ZERO;
		}
		if(bean.getAmount().compareTo(sqAmount)<1){
			return true;
		}
		if((bean.getAmount().subtract(sqAmount)).compareTo((indexMgr.getSyAmount()))==1 ){
			return false;
		}
		if(bean.getProDetailId() !=null ){
			TProExpendDetail expendDetail = tProExpendDetailMng.findById(bean.getProDetailId());
			//如果超出的金额大于剩余金额, 不允许报销
			if((bean.getAmount().subtract(sqAmount)).compareTo((expendDetail.getSyAmount()))==1 ){
				return false;
			}
		}
		
		return true;
	}
	
	@Override
	public Boolean checkAmounts(String id, BigDecimal appleAmount) {
		TProExpendDetail indexMgr = tProExpendDetailMng.findById(Integer.valueOf(id));
		//判断是什么控制是否允许超额
			if (null == appleAmount) {
				appleAmount = BigDecimal.ZERO;
			}
			//刚性控制
			if(indexMgr.getSyAmount().compareTo(appleAmount)==-1){
				//剩余金额小于申请金额返回false
				return false;
			}else {
				//剩余金额不小于申请金额返回true
				return true;
			}
	}
	@Override
	public List<TBudgetIndexMgr>  getFirstSubject(String indexType,User user,String changeType,String isAcrossDept,String drdc,String deptName) {
		//只查询当前年度的预算
		String nowYear=DateUtil.formatDate(new Date(), "yyyy");//当前年份
		//releaseStauts =0 未下达，    releaseStauts=1 已下达
		Finder finder=Finder.create(" FROM TBudgetIndexMgr WHERE indexType='"+indexType+"'  and releaseStauts='1'  and years='"+nowYear+"'");
//		String deptIdStr=departMng.getDeptIdStrByUser(user);
		if("1".equals(drdc)) {
			if("WBYSZBTZ".equals(changeType)) {
				
			}else {
				finder.append(" and deptCode = :deptCode").setParam("deptCode", user.getDpID());
			}
		}else {
			if("NBYSZBTJ".equals(changeType) && "1".equals(isAcrossDept)) {
				finder.append(" and deptCode <> :deptCode").setParam("deptCode", user.getDpID());
			}else if("WBYSZBTZ".equals(changeType)) {
				
			}else {
				finder.append(" and deptCode = :deptCode").setParam("deptCode", user.getDpID());
			}
			
		}
		if(StringUtils.isNotEmpty(deptName)){
			finder.append(" and deptName like '%"+deptName+"%'");
		}
// 		if("".equals(deptIdStr)){ //普通岗位和部门负责人只能查看自己的
// 			finder.append(" and deptCode = :deptCode").setParam("deptCode", user.getDpID());
// 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
// 			
// 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
// 			finder.append(" and deptCode in ("+deptIdStr+")");
// 		}
 		
		return super.find(finder);
	}
	@Override
	public BigDecimal  addDjAmount(Integer indexId,Integer proDetailId,BigDecimal num){
		/** 修改指标金额 **/
		TBudgetIndexMgr index = this.findById(indexId);
		DecimalFormat df = new DecimalFormat("0.00");//保留6位小数
		if (null == num) {
			num = BigDecimal.ZERO;
		}
		//项目可用金额
		index.setSyAmount((index.getSyAmount().subtract(num)));
		//项目冻结金额
		index.setDjAmount((index.getDjAmount().add(num)));
		index=(TBudgetIndexMgr) super.merge(index);
		if (proDetailId != null) {
			/** 修改四级分类金额，也就是支出明细 **/
			TProExpendDetail expendDetail = tProExpendDetailMng.findById(proDetailId);
			//可用金额
			expendDetail.setSyAmount(expendDetail.getSyAmount().subtract(num));
			//冻结金额
			expendDetail.setDjAmount(expendDetail.getDjAmount().add(num));
			super.merge(expendDetail);
			return expendDetail.getSyAmount();
		}
		return index.getSyAmount();
	}
	@Override
	public BigDecimal deleteDjAmount(Integer indexId,Integer proDetailId,BigDecimal amount){
		TBudgetIndexMgr bim = this.findById(indexId);
		//修改项目剩余金额
		if (null == amount) {
			amount = BigDecimal.ZERO;
		}
		bim.setSyAmount(bim.getSyAmount().add(amount));
		//修改项目冻结金额
		bim.setDjAmount(bim.getDjAmount().subtract(amount));
		bim=(TBudgetIndexMgr) super.merge(bim);
		if(proDetailId!=null){
			TProExpendDetail expendDetail = tProExpendDetailMng.findById(proDetailId);
			//修改指标剩余金额
			expendDetail.setSyAmount(expendDetail.getSyAmount().add(amount));
			//修改指标冻结金额
			expendDetail.setDjAmount(expendDetail.getDjAmount().subtract(amount));
			super.merge(expendDetail);
			return expendDetail.getSyAmount();
		}
		return bim.getSyAmount();
	}


	@Override
	public TBudgetIndexMgr findbyProId(String id) {
		Finder finder=Finder.create(" FROM TBudgetIndexMgr WHERE FProId = '"+id+"'");
		return (TBudgetIndexMgr) super.find(finder).get(0);
	}
}
