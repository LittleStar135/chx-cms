package com.chx.cms.service;

import com.chx.cms.domain.User;
import com.github.pagehelper.PageInfo;

public interface UserService {

	
	/**
	 * 
	 * @Title: selectByUsername 
	 * @Description: 用户查重
	 * @param username
	 * @return
	 * @return: User
	 */
	User selectByUsername(String username);
	
	/**
	 * 
	 * @Title: insert 
	 * @Description: 注册用户
	 * @param user
	 * @return
	 * @return: int
	 */
	int insert(User user);
	
	
	/**
	 * 
	 * @Title: selects 
	 * @Description: 查询所有用户
	 * @param user
	 * @return
	 * @return: List<User>
	 */
	PageInfo<User> selects(User user,Integer page,Integer pageSize);
	
	
	/**
	 * 
	 * @Title: update 
	 * @Description: 修改状态
	 * @param user
	 * @return
	 * @return: int
	 */
	int update(User user);
	
	/**
	 * 
	 * @Title: login 
	 * @Description: 登录
	 * @param user
	 * @return
	 * @return: User
	 */
	User login(User user);
	
}
