package com.braker.icontrol.budget.project.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.budget.project.entity.TCapitalSourceMatter;
import com.braker.icontrol.budget.project.manager.TCapitalSourceMatterMng;

@Service
@Transactional
public class TCapitalSourceMatterMngImpl extends BaseManagerImpl<TCapitalSourceMatter> implements TCapitalSourceMatterMng {

}
