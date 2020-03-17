package com.chx.cms.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.chx.cms.domain.Article;
import com.chx.cms.domain.Collect;
import com.chx.cms.domain.Comment;
import com.chx.cms.domain.User;
import com.chx.cms.service.ArticleService;
import com.chx.cms.service.CollectService;
import com.chx.cms.service.CommentService;
import com.github.pagehelper.PageInfo;



/**
 * 
 * @ClassName: MyController 
 * @Description: 个人中心
 * @author: MACHENIKE
 * @date: 2020年3月4日 下午6:58:05
 */

@RequestMapping("my")
@Controller
public class MyController {

	@Resource
	ArticleService articleService;
	@Resource
	CollectService collectService;
	@Resource
	CommentService commentService;
	
	/**
	 * 
	 * @Title: index 
	 * @Description: 进入个人中心的首页
	 * @return
	 * @return: String
	 */
	
	@RequestMapping(value = {"","/","index"})
	public String index() {
		return "my/index";
	}
	
	/**
	 * 
	 * @Title: articles 
	 * @Description: 我的文章
	 * @return
	 * @return: String
	 */
	@RequestMapping("articles")
	public String articles( HttpSession session,Model model,@RequestParam(defaultValue = "1") Integer page,@RequestParam(defaultValue = "3") Integer pageSize) {
		Article article = new Article();
		
		User user = (User) session.getAttribute("user");//获取当前人的信息
		article.setUserId(user.getId());//只显示当前登录的文章
		PageInfo<Article> info = articleService.selects(article, page, pageSize);
		
		model.addAttribute("info", info);
		
		return "my/articles";
		
	}
	/**
	 * 
	 * @Title: publish 
	 * @Description: 去发布文章
	 * @return
	 * @return: String
	 */
	@GetMapping("publish")
	public String publish() {
		
		return "my/publish";
		
	}
	/**
	 * 
	 * @Title: publish 
	 * @Description: 发布文章
	 * @return
	 * @return: String
	 */
	@ResponseBody
	@PostMapping("publish")
	public boolean publish(MultipartFile file,Article article,HttpSession session) {
		//文件上传
		if (null!=file &&  !file.isEmpty()) {
			String path="d:/pic/";
			//文件的原始名称
			String filename = file.getOriginalFilename();
			//为了防止文件重名，需要改变文件的名字
			String newFilename=UUID.randomUUID()+filename.substring(filename.lastIndexOf("."));
			
			File f = new File(path,newFilename);
			//把文件写入硬盘
			try {
				file.transferTo(f);
				article.setPicture(newFilename);
			} catch (IllegalStateException e) {
				
				e.printStackTrace();
			} catch (IOException e) {
				
				e.printStackTrace();
			}
			
		}
		//文章初始化数据
		User user = (User) session.getAttribute("user");
		article.setUserId(user.getId());//目前没有写登录  1表示一个用户的id
		article.setCreated(new Date());
		article.setHits(0);//默认0
		article.setDeleted(0);//默认未删除
		article.setHot(0);//默认非热门
		article.setStatus(0);//默认待审核
		
		return articleService.insert(article)>0;//增加文章
		
	}
	/**
	 * 
	 * @Title: articleDetail 
	 * @Description:单个文章内容
	 * @param id
	 * @return
	 * @return: Article
	 */
	@ResponseBody
	@RequestMapping("articleDetail")
	public Article articleDetail(Integer id) {
		
		
		return articleService.select(id);
		
		
	}
	
	/**
	 * 
	 * @Title: articleDetail 
	 * @Description:我的收藏
	 * @param id
	 * @return
	 * @return: Article
	 */
	@RequestMapping("collect")
	public String collect(HttpSession session,Model model,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "10")Integer pageSize) {
		User user = (User) session.getAttribute("user");
		PageInfo<Collect> info = collectService.selects(user.getId(), page, pageSize);
		model.addAttribute("info", info);
		return "my/collect";
		
	}
	
	/**
	 * 
	 * @Title: articleDetail 
	 * @Description:取消收藏
	 * @param id
	 * @return
	 * @return: Article
	 */
	@ResponseBody
	@RequestMapping("deleteCollect")
	public boolean deleteCollect(Integer id) {
		
		
		return collectService.delete(id)>0;
		
		
	}
	
	/**
	 * 
	 * @Title: collect 
	 * @Description: 我的评论
	 * @param session
	 * @param model
	 * @param page
	 * @param pageSize
	 * @return
	 * @return: String
	 */
	@RequestMapping("myComment")
	public String myComment(HttpSession session,Model model,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "10")Integer pageSize) {
		User user = (User) session.getAttribute("user");  
		//查询用户文章评论
		PageInfo<Comment> info = commentService.selectsComment(user.getId(), page, pageSize);
		model.addAttribute("info", info);
		return "my/comment";
		
	}
	/**
	 * 
	 * @Title: deleteCollect 
	 * @Description: 删除评论
	 * @param id
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("deleteComment")
	public boolean deleteComment(Integer id) {
		
		
		return commentService.deleteComment(id)>0;
		
		
	}
}
