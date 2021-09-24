package com.braker.icontrol.budget.project.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.budget.project.manager.ExecuteProjectMng;
import com.braker.icontrol.contract.Formulation.model.ExecuteProject;
@Service
@Transactional
public class ExecuteProjectImpl extends BaseManagerImpl<ExecuteProject> implements ExecuteProjectMng{

}
