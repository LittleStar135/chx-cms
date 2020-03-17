package com.chx.cms.dao;

import java.util.List;

import com.chx.cms.domain.User;

public interface UserMapper {

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
	List<User> selects(User user);
	
	/**
	 * 
	 * @Title: update 
	 * @Description: 修改状态
	 * @param user
	 * @return
	 * @return: int
	 */
	int update(User user);
	
	
}
