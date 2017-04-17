package com.zyytkj.system.dao.impl;

import org.springframework.stereotype.Repository;

import com.zyytkj.system.dao.SystemLogDoaI;
import com.zyytkj.system.model.SystemLog;

@Repository("systemLogDao")
public class SystemLogDoaImpl extends BaseDaoImpl<SystemLog> implements
		SystemLogDoaI {
	
}
