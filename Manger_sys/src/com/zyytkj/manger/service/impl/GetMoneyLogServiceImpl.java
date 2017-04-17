package com.zyytkj.manger.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyytkj.manger.dao.GetMoneyLogDao;
import com.zyytkj.manger.model.GetMoneyLog;
import com.zyytkj.manger.service.GetMoneyLogServiceI;
import com.zyytkj.system.model.User;
import com.zyytkj.system.pageModel.ExcelPageModel;
import com.zyytkj.system.pageModel.MoneyLogPageModel;
import com.zyytkj.system.service.UserServiceI;

@Service("getMoneyLogService")
public class GetMoneyLogServiceImpl implements GetMoneyLogServiceI {

	@Autowired
	UserServiceI userService;
	@Autowired
	GetMoneyLogDao getMoneyLogDao;

	@Override
	public User askMoney(String userId, double money) {
		User user = this.userService.getUserById(userId);
		if (user != null && user.getCanGetMoney() >= money) {
			GetMoneyLog log = new GetMoneyLog(userId, money, 0, user.getBankCard(), user.getBankAddr(), new Date(),
					user.getName(), user.getIdCard(), user.getPhone());
			user.setCanGetMoney(user.getCanGetMoney() - money);
			this.getMoneyLogDao.save(log);
			this.userService.updateU(user);
		}

		return user;

	}

	@Override
	public void pass(String ids) {

		String[] idArr = ids.split(",");

		for (String id : idArr) {
			GetMoneyLog log = this.findById(id);
			if (log != null && log.getState() == 0) {
				log.setState(1);
				this.getMoneyLogDao.update(log);
			}
		}

	}

	@Override
	public void stop(String ids) {

		String[] idArr = ids.split(",");

		for (String id : idArr) {
			GetMoneyLog log = this.findById(id);
			if (log != null && log.getState() == 0) {
				User user = this.userService.getUserById(log.getUserId());
				if (user != null) {
					user.setCanGetMoney(user.getCanGetMoney() + log.getMoney());
					this.userService.updateU(user);
					log.setState(2);
					this.getMoneyLogDao.update(log);
				}
			}
		}

	}

	@Override
	public GetMoneyLog findById(String id) {
		return this.getMoneyLogDao.get(GetMoneyLog.class, id);
	}

	@Override
	public Object[] findByPage(Integer page, Integer rows, int state, String userId, String search) {
		String hql = " from GetMoneyLog where 1 = 1 ";
		List<Object> param = new ArrayList<>();
		if (state != -1) {
			hql += " and state = ? ";
			param.add(state);
		}

		if (userId != null && !userId.equals("")) {
			hql += " and userId = ? ";
			param.add(userId);
		}

		if (search != null && !search.equals("")) {
			hql += " and ( name like ? or idCard like ? or phone like ? or cardNum like ? or cardAddr like ? or remark like ? ) ";
			param.add("%" + search + "%");
			param.add("%" + search + "%");
			param.add("%" + search + "%");
			param.add("%" + search + "%");
			param.add("%" + search + "%");
			param.add("%" + search + "%");
		}
		hql += " order by logTime desc ";

		List<GetMoneyLog> logs = this.getMoneyLogDao.find(hql, param, page, rows);

		List<MoneyLogPageModel> logps = new ArrayList<>();
		for (GetMoneyLog log : logs) {
			logps.add(new MoneyLogPageModel(log));
		}

		long count = this.getMoneyLogDao.count("select count(id)" + hql, param);

		return new Object[] { logps, count };
	}

	@Override
	public List<ExcelPageModel> findForExcel(int state) {

		String hql = " from GetMoneyLog where 1 = 1 ";
		List<Object> param = new ArrayList<>();
		if (state != -1) {
			hql += " and state = ? ";
			param.add(state);
		}

		hql += " order by logTime desc ";

		List<GetMoneyLog> logs = this.getMoneyLogDao.find(hql, param);

		List<ExcelPageModel> logps = new ArrayList<>();
		for (GetMoneyLog log : logs) {
			logps.add(new ExcelPageModel(log));
		}

		return logps;
	}

}
