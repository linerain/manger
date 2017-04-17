package com.zyytkj.system.service.impl;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyytkj.system.dao.SystemLogDoaI;
import com.zyytkj.system.model.SystemLog;
import com.zyytkj.system.model.User;
import com.zyytkj.system.service.SystemLogServiceI;

/**
 * 系统日志
 * 
 * @author 谭锦华
 * @company 北京众谊越泰科技
 * @Date 2015年3月13日
 */
@Service("systemlogService")
public class SystemLogServiceImpl implements SystemLogServiceI {
	@Autowired
	private SystemLogDoaI systemLogDao;

	private boolean isOk = false;

	@Override
	public boolean saveSystemLog(SystemLog sys) {
		Serializable str = systemLogDao.save(sys);
		if (str != null) {
			isOk = true;
		}
		return isOk;
	}

	@Override
	public void updateSystemLog(SystemLog sys) {
		systemLogDao.update(sys);

	}

	@Override
	public SystemLog findById(String id) {

		return systemLogDao.get(SystemLog.class, id);
	}

	@Override
	public List<SystemLog> findAllMenus() {
		String hql = " from SystemLog where 1=1 ";
		return systemLogDao.find(hql);
	}

	@Override
	public List<SystemLog> findPage(Integer pageSize, Integer pageNumber, Timestamp start, Timestamp end, String userCount,User user) {
		List<Object> param = new ArrayList<Object>();
		String hql = "from SystemLog where 1=1";
		if ((null != start && !"".equals(start)) && (null != end && !"".equals(end))) {
			hql += " and datetime>=? and datetime<=?";
			param.add(start);
			param.add(end);
		} else if (null != end && !"".equals(end)) {
			hql += " and datetime<=?";
			param.add(end);
		} else if (null != start && !"".equals(start)) {
			hql += " and datetime>=?";
			param.add(start);
		}
		if (userCount != null && !userCount.equals("")) {
			hql += " and userCount like ? ";
			param.add("%" + userCount.trim() + "%");
		}
		if (!user.getAccount().equals("admin")) {
			hql+=" and userCount <> 'admin'";
		}
		hql += " order by datetime desc ";

		return systemLogDao.find(hql, param, pageNumber, pageSize);
	}

	@Override
	public Long getCount(Timestamp start, Timestamp end, String userCount,User user) {
		String hql = "select count(id) from SystemLog where 1=1";
		List<Object> param = new ArrayList<Object>();
		if ((null != start && !"".equals(start)) && (null != end && !"".equals(end))) {
			hql += " and datetime>=? and datetime<=?";
			param.add(start);
			param.add(end);
		} else if (null != end && !"".equals(end)) {
			hql += " and datetime<=?";
			param.add(end);
		} else if (null != start && !"".equals(start)) {
			hql += " and datetime>=?";
			param.add(start);
		}
		if (userCount != null && !userCount.equals("")) {
			hql += " and userCount like ?";
			param.add("%" + userCount.trim() + "%");
		}
		if (!user.getAccount().equals("admin")) {
			hql+=" and userCount <> 'admin'";
		}
		return this.systemLogDao.count(hql, param);
	}

	@Override
	public String deleteSystemLog(String ids, User userObj) {
		if (userObj.isAdmin()) {
			if (ids != null && !ids.equals("")) {
				String[] idList = ids.split(",");
				for (String id : idList) {
					SystemLog log = this.findById(id);
					this.systemLogDao.delete(log);
				}
				return "删除成功";
			}else {
				return "删除失败";
			}
		}else {
			return "您没有管理员权限删除失败";
		}
		
	}

}
