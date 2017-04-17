package com.zyytkj.system.service;

import java.util.List;

import com.zyytkj.system.model.User;
import com.zyytkj.system.pageModel.UserPageModel;

/**
 * 用户服务接口
 * 
 * @author 黄超
 * @company 北京众谊越泰科技
 * @Date 2015年3月11日
 */

public interface UserServiceI {
	/**
	 * 用户登录
	 * 
	 * @param account
	 *            账号
	 * @param password
	 *            密码
	 * @return 返回用户，如果输入错误则返回null
	 */
	public String login(String account, String password);

	/**
	 * 注册用户
	 * 
	 * @param user
	 *            传入的新用户对象
	 * @return 注册完毕的用户对象
	 */
	public User register(User user, boolean isAdmin);

	/**
	 * 删除用户
	 * 
	 * @param user
	 *            需要删除的用户对象
	 */
	public void deleteUser(String ids);

	/**
	 * 通过账号查询用户
	 * 
	 * @param account
	 * @return
	 */
	public User getUserByAccount(String account);

	/**
	 * 通过ID查找用户
	 * 
	 * @param id
	 * @return
	 */
	public User getUserById(String id);

	// public String getNameById(String id);

	/**
	 * 查询所有用户
	 * 
	 * @return
	 */
	public List<User> findAllUsers();

	/**
	 * 分页查询用户
	 * 
	 * @param pageSize
	 *            每页大小
	 * @param PageNumber
	 *            页数
	 * @return
	 */

	public List<UserPageModel> findUsersByPage(Integer pageSize, Integer pageNumber, String name);

	/**
	 * 修改用户
	 * 
	 * @param user
	 *            要修改的用户
	 * @return
	 */
	public String[] updateUser(User userObj, String oldPwd, String newPwd);

	/**
	 * 统计User总数
	 * 
	 * @return
	 */
	public long countUsers(String name);

	/**
	 * 按用户名模糊查询
	 */
	public List<User> findUserByName(String name);

	/**
	 * 按名称查询
	 * 
	 * @param name
	 * @return
	 */
	public User findByName(String name);


	// 修改或者新建用户
	public String[] saveOrupdate(User user, String userType);

	/**
	 * 根据用户名密码获取用户
	 * 
	 * @param account
	 * @param pwd
	 * @return
	 */
	public User getByAccountAndPwd(String account, String pwd);

	/**
	 * 超级管理员重置非管理员的密码
	 */
	public String adminResetPassword(String userid, User user, String password);

	/**
	 * 更新用户
	 * 
	 * @param user
	 */
	public void updateU(User user);

	public byte[] checkOpenDoor(String account, String password, String rand);

	/**
	 * 用户认证
	 * 
	 * @return
	 */
	public boolean checkUserPassword(String account, String password);

}
