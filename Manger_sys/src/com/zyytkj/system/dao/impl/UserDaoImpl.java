package com.zyytkj.system.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyytkj.system.dao.UserDaoI;
import com.zyytkj.system.model.User;

@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDaoI {


	public List<User> findUserListByRoleName(String roleName) {
		String sql=	"select u.* from sys_role r "+
		        " left join sys_role_sys_user ru on ru.sys_role_id=r.ID "+
			    " left join sys_user u on u.ID=ru.sys_user_id "+
                " where r.name='"+roleName+"'";
		@SuppressWarnings("unchecked")
		List<User> userlist = super.getSessionFactory().getCurrentSession().createSQLQuery(sql).addEntity(User.class).list();  
		return userlist;
	}

}
