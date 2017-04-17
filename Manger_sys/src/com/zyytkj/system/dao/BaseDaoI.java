package com.zyytkj.system.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 数据库操作基础类
 * 
 * @author 黄超
 * @company 北京众谊越泰科技
 * @Date 2015年3月10日
 * @param <T>
 */
public interface BaseDaoI<T> {

	/**
	 * 保存一个对象
	 * 
	 * @param o
	 * @return
	 */
	public Serializable save(T o);

	/**
	 * 删除一个对象
	 * 
	 * @param o
	 */
	public void delete(T o);

	/**
	 * 更新一个对象
	 * 
	 * @param o
	 */
	public void update(T o);

	/**
	 * 保存或更新对象
	 * 
	 * @param o
	 */
	public void saveOrUpdate(T o);

	/**
	 * 查询
	 * 
	 * @param hql
	 * @return
	 */
	public List<T> find(String hql);

	/**
	 * 查询集合
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public List<T> find(String hql, Object[] param);

	/**
	 * 查询集合
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public List<T> find(String hql, List<Object> param);

	/**
	 * 查询集合(带分页)
	 * 
	 * @param hql
	 * @param param
	 * @param page
	 *            查询第几页
	 * @param rows
	 *            每页显示几条记录
	 * @return
	 */
	public List<T> find(String hql, Object[] param, Integer page, Integer rows);

	/**
	 * 查询集合(带分页)
	 * 
	 * @param hql
	 * @param param
	 * @param page
	 * @param rows
	 * @return
	 */
	public List<T> find(String hql, List<Object> param, Integer page,
			Integer rows);

	/**
	 * 获得一个对象
	 * 
	 * @param c
	 *            对象类型
	 * @param id
	 * @return Object
	 */
	public T get(Class<T> c, Serializable id);

	/**
	 * 获得一个对象
	 * 
	 * @param hql
	 * @param param
	 * @return Object
	 */
	public T get(String hql, Object[] param);

	/**
	 * 获得一个对象
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public T get(String hql, List<Object> param);

	/**
	 * select count(*) from 类
	 * 
	 * @param hql
	 * @return
	 */
	public Long count(String hql);

	/**
	 * select max(id) from 类
	 * 
	 * @param hql
	 * @return
	 */
	public Integer countInt(String hql);

	/**
	 * select count(*) from 类
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public Long count(String hql, Object[] param);

	/**
	 * select count(*) from 类
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public Long count(String hql, List<Object> param);

	/**
	 * 执行HQL语句
	 * 
	 * @param hql
	 * @return 响应数目
	 */
	public Integer executeHql(String hql);

	/**
	 * 执行HQL语句
	 * 
	 * @param hql
	 * @param param
	 * @return 响应数目
	 */
	public Integer executeHql(String hql, Object[] param);

	/**
	 * 执行HQL语句
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public Integer executeHql(String hql, List<Object> param);

	public T getObject(String hql, Map<String, Object> params);

	public List<T> find(String hql, Map<String, Object> params);

	public List<T> find(String hql, Map<String, Object> params, int page,
			int rows);
	
	public List<T> find(String hql, List<Object> param, int page,
			int rows);

	public List<T> find(String hql, int page, int rows);

	public Long count(String hql, Map<String, Object> params);
	
	
	//进行IN查询
	 public List<T> findByInHql(String hql, Map<String, Object> map, int pageSize,int pageNo);
	 
	 public List<Object[]> queryBySql(String sql, List<Object> param);
	 
	 public List<Object[]> queryBySql(String sql, List<Object> param, int pageNum, int pageSize);

	 public List<String> queryPageSql(String sql, List<Object> param);

	 public List<T> queryPageHql(String hql, Map<String, Object> params);
	 /**
	  * sql语句的查询  分类型
	  */
	 public List<Object[]> queryBySql(String sql, Map<String, Object> param);
	 
	 /**
	  * 根据表名删除记录
	  * @param table
	  */
	 void delTable(String table);
	 
	 /**
	  * 执行原始insert语句
	  * @param sql
	  * @param param
	  * @return
	  */
	 int  InsertBySql(String sql, List<Object> param)throws Exception;
}
