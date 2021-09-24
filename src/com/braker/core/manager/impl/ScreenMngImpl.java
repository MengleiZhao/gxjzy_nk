package com.braker.core.manager.impl;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.core.manager.ScreenMng;
import com.braker.core.model.Screen;


@SuppressWarnings("unchecked")
@Service
@Transactional
public class ScreenMngImpl extends BaseManagerImpl<Screen> implements ScreenMng {

}
