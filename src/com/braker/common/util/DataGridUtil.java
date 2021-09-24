package com.braker.common.util;

import java.util.ArrayList;
import java.util.List;

import com.braker.common.entity.DataEntity;
import com.braker.common.entity.MergeCellInfo;

public class DataGridUtil {

	public static List<MergeCellInfo> getMergeCells1(List<DataEntity> dataList){
		
		List<Integer> indexList = new ArrayList<>();
		List<MergeCellInfo> mergeList = new ArrayList<>();
		indexList.add(0);
		//获得数据发生变化的坐标
		if (dataList != null && dataList.size() > 1) {
			for (int i = 1; i < dataList.size(); i++) {
				int rowspan = 0;
				DataEntity en1 = dataList.get(i-1);
				DataEntity en2 = dataList.get(i);
				if (en1 != null && en2 != null && en1.getCol1() != null) {
					if (en1.getCol1().equals(en2.getCol1())) {
						indexList.add(i);
					}
				} 
			}
		}
		//根据坐标生成合并数据
		if (indexList.size() > 1) {
			for (int i = 1; i < indexList.size(); i++) {
				MergeCellInfo info = new MergeCellInfo();
				info.setIndex(indexList.get(i-1));
				info.setColspan(indexList.get(i) - indexList.get(i-1));
				mergeList.add(info);
			}
		}
		return mergeList;
	}
	public static List<MergeCellInfo> getMergeCells2(List<DataEntity> dataList){
		
		if (dataList != null && dataList.size() > 0) {
			for (DataEntity entity: dataList) {
				
			}
		}
		return null;
	}
}
