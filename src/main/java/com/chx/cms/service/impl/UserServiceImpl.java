package com.chx.cms.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chx.cms.dao.UserMapper;
import com.chx.cms.domain.User;
import com.chx.cms.service.UserService;
import com.chx.cms.util.CMSException;
import com.chx.cms.util.Md5Util;
import com.chx.common.utils.StringUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class UserServiceImpl implements UserService{

	@Resource
	UserMapper userMapper;
	

	@Override
	public PageInfo<User> selects(User user,Integer page,Integer pageSize) {
		
		PageHelper.startPage(page,pageSize);
		List<User> list = userMapper.selects(user);

		return new PageInfo<User>(list);
	}


	@Override
	public int update(User user) {
		
		return userMapper.update(user);
	}


	@Override
	public User selectByUsername(String username) {
		
		return userMapper.selectByUsername(username);
	}


	@Override
	public int insert(User user) {
		//通过自定义校验规则 对注册用户验证
		//1用户名不能为空
		if (!StringUtil.hasText(user.getUsername())) 
			throw  new CMSException("用户名不能为空");
		if (!(user.getUsername().length()>=2 && user.getUsername().length()<=10)) 
			throw  new CMSException("用户名长度在2-10之间");
		
		User findUser = this.selectByUsername(user.getUsername());
		if (null != findUser)
			throw new CMSException("用户名已经被注册.");
		
		//2.密码
		if (!StringUtil.hasText(user.getPassword())) 
			throw  new CMSException("密码不能为空");
		if (!(user.getPassword().length()>=6 && user.getPassword().length()<=10)) 
			throw  new CMSException("密码长度在6-10之间");
		//3.确认密码
		if (!StringUtil.hasText(user.getRepassword())) 
			throw  new CMSException("确认密码不能为空");
		if (!user.getRepassword().equals(user.getPassword())) 
			throw  new CMSException("两次密码不一致");
		//4.对密码进行加密
		user.setPassword(Md5Util.encode(user.getPassword()));
		//初始用户的注册信息
		user.setCreated(new Date());//注册时间
		user.setNickname(user.getUsername());
		user.setLocked("0");//默认用户状态可用

		return userMapper.insert(user);
	}

	/**
	 * 登录
	 */
	@Override
	public User login(User user) {
		//1用户名不能为空
		if (!StringUtil.hasText(user.getUsername())) 
			throw  new CMSException("用户名不能为空");
		//2. 验证用户名是否存在
		User u = this.selectByUsername(user.getUsername());
		if (u==null) {
			throw  new CMSException("用户名不存在");
		}
		//3.比较密码  数据库中的密码是加密后的密码  
		// 对登录的密码再次加密  在和数据库中的比较
		if (!Md5Util.encode(user.getPassword()).equals(u.getPassword())) {
			throw  new CMSException("密码不正确，请重新登录哦");
		}
		
		if (u.getLocked().equals("1")) {
			throw  new CMSException("当前账户被禁用，不能登录");
		}
		
		
		
		return u;
	}

}
