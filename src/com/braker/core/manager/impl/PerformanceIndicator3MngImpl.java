package com.braker.core.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PerformanceIndicator1Mng;
import com.braker.core.manager.PerformanceIndicator2Mng;
import com.braker.core.manager.PerformanceIndicator3Mng;
import com.braker.core.model.PerformanceIndicator1;
import com.braker.core.model.PerformanceIndicator2;
import com.braker.core.model.PerformanceIndicator3;

import java.util.List;

@Service
@Transactional
public class PerformanceIndicator3MngImpl extends BaseManagerImpl<PerformanceIndicator3> implements PerformanceIndicator3Mng{
}
