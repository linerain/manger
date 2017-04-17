package com.zyytkj.system.service;

import java.sql.Timestamp;
import java.util.List;

import com.zyytkj.system.model.SystemLog;
import com.zyytkj.system.model.User;

/**
 * 系统日志接口
 * @author 谭锦华
 * @company 北京众谊越泰科技
 * @Date 2015年3月13日
 */
public interface SystemLogServiceI {
	
	/**
	 * 保存日志
	 * @param sys
	 * @return
	 */
	public boolean saveSystemLog(SystemLog sys);
	
	
	/**
	 * 删除日志
	 * @param sys
	 * @return
	 */
	public String deleteSystemLog(String ids,User userObj);
	
	/**
	 * 更新日志
	 * @param sys
	 * @return
	 */
	public void updateSystemLog(SystemLog sys);
	
	/**
	 * 通过id查找日志
	 * @param id
	 * @return
	 */
	public SystemLog findById(String id);
	
	/**
	 * 查找所有日志
	 * @return
	 */
	public List<SystemLog> findAllMenus();
	

	/**
	 *  分页查询
	 * @param page
	 * @param rows
	 * @return
	 */
	public List<SystemLog> findPage(Integer page, Integer rows ,Timestamp start,Timestamp end,String userCount,User user);

	/**
	 * 获取总记录
	 * @return
	 */
	public Long getCount(Timestamp start,Timestamp end,String userCount,User user);

}
