package com.zyytkj.system.dao;

import java.util.List;

import com.zyytkj.system.model.User;

/**
 * 用户数据库操作接口
 * 
 * @author 黄超
 * @company 北京众谊越泰科技
 * @Date 2015年3月11日
 */
public interface UserDaoI extends BaseDaoI<User> {

	List<User> findUserListByRoleName(String roleName);
}
