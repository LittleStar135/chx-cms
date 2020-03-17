package com.chx.cms.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chx.cms.domain.Article;
import com.chx.cms.domain.User;
import com.chx.cms.service.ArticleLogService;
import com.chx.cms.service.ArticleService;
import com.chx.cms.service.UserService;
import com.github.pagehelper.PageInfo;
/**
 * 
 * @ClassName: AdminController 
 * @Description: 管理员中心
 * @author: MACHENIKE
 * @date: 2020年3月6日 下午5:23:42
 */
@Controller
@RequestMapping("admin")
public class AdminController {

	@Resource
	ArticleService articleService;
	
	@Resource
	UserService userService;
	
	@Resource
	ArticleLogService articleLogService;
	
	/**
	 * 
	 * @Title: index 
	 * @Description: 进入首页
	 * @return
	 * @return: String
	 */
	@RequestMapping(value = {"","/","index"})
	public String index() {
		return "admin/index";
	}
	/**
	 * 
	 * @Title: index 
	 * @Description: 进入文章审核列表
	 * @return
	 * @return: String
	 */
	
	@RequestMapping("articles")
	public String articles(Model model,Article article,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "10")Integer pageSize) {
		PageInfo<Article> info = articleService.selects(article, page, pageSize);
		model.addAttribute("info", info);
		model.addAttribute("article", article);
		
		return "admin/articles";
	}
	/**
	 * 
	 * @Title: name 
	 * @Description: 修改审核状态
	 * @param article
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("update")
	public boolean name(Article article) {

		return articleService.update(article)>0;
		
	}
	/**
	 * 
	 * @Title: users 
	 * @Description: 查询用户表  分页
	 * @param model
	 * @param user
	 * @param page
	 * @param pageSize
	 * @return
	 * @return: String
	 */
	@RequestMapping("users")
	public String users(Model model,User user,@RequestParam(defaultValue = "1") Integer page,@RequestParam(defaultValue = "10")Integer pageSize) {
		
		PageInfo<User> info = userService.selects(user, page, pageSize);
		model.addAttribute("info", info);
		model.addAttribute("user", user);
		
		return "admin/users";
		
	}	
	/**
	 * 
	 * @Title: update 
	 * @Description: 修改用户状态
	 * @param user
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("updateUser")
	public boolean update(User user) {
		
		return userService.update(user)>0;
	}
	/**
	 * 
	 * @Title: settings 
	 * @Description: 去设置
	 * @return
	 * @return: String
	 */
	@GetMapping("settings")
	public String settings() {
		return "admin/settings";
		
	}
	
	
	/**
	 * 
	 * @Title: settings 
	 * @Description: 去执行sql设置
	 * @return
	 * @return: String
	 */
	@ResponseBody
	@PostMapping("execute")
	public boolean execute() {
		
		
		return articleLogService.update()>0;
		
	}
	
}
