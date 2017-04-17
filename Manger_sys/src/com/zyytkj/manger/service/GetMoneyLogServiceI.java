package com.zyytkj.manger.service;

import java.util.List;

import com.zyytkj.manger.model.GetMoneyLog;
import com.zyytkj.system.model.User;
import com.zyytkj.system.pageModel.ExcelPageModel;

public interface GetMoneyLogServiceI {

	User askMoney(String userId, double money);
	
	void pass(String ids);
	
	void stop(String ids);
	
	GetMoneyLog findById(String id);
	
	Object[] findByPage(Integer page, Integer rows ,int state,String userId,String search);
	
	List<ExcelPageModel> findForExcel(int state);

}
