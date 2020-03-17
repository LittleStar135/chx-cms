package com.chx.cms.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chx.cms.domain.Article;
import com.chx.cms.domain.ArticleLog;
import com.chx.cms.domain.Category;
import com.chx.cms.domain.Channel;
import com.chx.cms.domain.Collect;
import com.chx.cms.domain.Comment;
import com.chx.cms.domain.Silde;
import com.chx.cms.domain.User;
import com.chx.cms.service.ArticleLogService;
import com.chx.cms.service.ArticleService;
import com.chx.cms.service.ChannelService;
import com.chx.cms.service.CollectService;
import com.chx.cms.service.CommentService;
import com.chx.cms.service.SildeService;
import com.github.pagehelper.PageInfo;

/**
 * 
 * @ClassName: IndexController 
 * @Description: 系统首页入口
 * @author: MACHENIKE
 * @date: 2020年3月9日 上午11:20:40
 */
@Controller
public class IndexController {

	@Resource
	private ChannelService channelService;
	@Resource
	private ArticleService articleService;
	@Resource
	private SildeService sildeService;
	@Resource
	private CommentService commentService;
	@Resource
	private CollectService collectService;
	
	@Resource
	ArticleLogService articleLogService;
	
	@RequestMapping(value = {"","/","index"})
	public String index(Model model,Article article,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "5")Integer pageSize) {
	
		article.setStatus(1);
		article.setDeleted(0);
		model.addAttribute("article", article);
		//左侧栏目数据查询
		List<Channel> channels = channelService.channelselects();
		model.addAttribute("channels", channels);
		
		//如果栏目ID 不为空则查查其下所有的分类
		if (article.getChannelId()!=null) {
			List<Category> categorys = channelService.selectsBychannelId(article.getChannelId());
			model.addAttribute("categorys", categorys);
		}
		
		//如果栏目为空  说明没有点击左侧栏目  默认为热点1
		if (article.getChannelId()==null) {
			article.setHot(1);
			
			List<Silde> sildes = sildeService.selects();
			model.addAttribute("sildes", sildes);
		}
		
		//查询所有的文章
		PageInfo<Article> info = articleService.selects(article, page, pageSize);
		model.addAttribute("info", info);
		
		//封装查询条件
		model.addAttribute("article", article);
		//在右侧显示10篇最新文章
		Article article2 = new Article();
		article2.setStatus(1);
		article2.setDeleted(0);
		PageInfo<Article> lastArticles = articleService.selects(article2, 1, 5);
		model.addAttribute("lastArticles", lastArticles);
		
		
		//文章点击排行榜
		List<Article> topArticles = articleLogService.selects();
		model.addAttribute("topArticles", topArticles);
		
		
		
		
		return "index/index";
	}
	
	/**
	 * 
	 * @Title: name 
	 * @Description: 文章详情
	 * @param id
	 * @return
	 * @return: String
	 */
	@RequestMapping("articleDeatil")
	public String articleDeatil(HttpSession session,Integer id,Model model,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "5")Integer pageSize) {
		
		User user = (User) session.getAttribute("user");
		
		Article article = articleService.select(id);
		model.addAttribute("article", article);
		//查询出当前文章的评论内容
		PageInfo<Comment> info = commentService.selects(article, page, pageSize);
		model.addAttribute("info", info);
		
		//查询所有文章评论
		PageInfo<Article> info2 = commentService.selectsByCommentNum(1, 10);
		model.addAttribute("info2", info2);

		//查询该文章是否被收藏
		Collect collect =null;
		if (null!=user) {//如果用户已经被登录，则查询是否收藏
			collect = collectService.selectByTitleAndUserId(article.getTitle(), user.getId());
		}
		model.addAttribute("collect", collect);
		
		
		
		
		return "index/articleDeatil";
		
	}
	/**
	 * 
	 * @Title: addComment 
	 * @Description: 增加评论
	 * @param comment
	 * @param articleId
	 * @param session
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("addComment")
	public boolean addComment(Comment comment,Integer articleId,HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		if (null==user)  //用户登录后才可以评论
		return false;
			
		comment.setUserId(user.getId());
		comment.setArticleId(articleId);
		comment.setCreated(new Date());
		
		return commentService.insert(comment)>0;
		
	}
	/**
	 * 
	 * @Title: addComment 
	 * @Description: 收藏文章
	 * @param comment
	 * @param articleId
	 * @param session
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("collect")
	public boolean collect(Collect collect,Integer articleId,HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		if (null==user)  //登录后才可以收藏
			return false;
		
		collect.setUser(user);
		collect.setCreated(new Date());

		return collectService.insert(collect)>0;
		
	}
	
	/**
	 * 
	 * @Title: addComment 
	 * @Description: 取消收藏
	 * @param comment
	 * @param articleId
	 * @param session
	 * @return
	 * @return: boolean
	 */
	@ResponseBody
	@RequestMapping("deleteCollect")
	public boolean deleteCollect(Integer id) {
		
		return collectService.delete(id)>0;
		
	}
	
	
	
	//插入访问日志
	@ResponseBody
	@RequestMapping("insertLog")
	public boolean insertLog(ArticleLog log,HttpSession session) {
		log.setVisitDate(new Date());
		//如果登录则记录访问人
		User user = (User) session.getAttribute("user");
		if(null !=user) {
			log.setUsername(user.getUsername());
		}else {
			log.setUsername("普通游客");
		}
		
		return articleLogService.insert(log) >0;
	}
	
	

	
	
}
