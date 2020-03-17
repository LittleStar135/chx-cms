package com.chx.cms.service;

import java.util.List;

import com.chx.cms.domain.Article;
import com.chx.cms.domain.Comment;
import com.github.pagehelper.PageInfo;

public interface CommentService {


	/**
	 * 
	 * @Title: insert 
	 * @Description: 增加评论
	 * @param comment
	 * @return
	 * @return: int
	 */
	int insert(Comment comment);
	
	/**
	 * 
	 * @Title: selects 
	 * @Description: 根据文章查询文章评论
	 * @param article
	 * @return
	 * @return: List<Comment>
	 */
	PageInfo<Comment> selects(Article article,Integer page,Integer pageSize);
	
	/**
	 * 
	 * @Title: selectsByCommentNum 
	 * @Description: 按照评论数量排序
	 * @return
	 * @return: List<Comment>
	 */
	PageInfo<Article> selectsByCommentNum(Integer page,Integer pageSize);
	
	/**
	 * 
	 * @Title: selectsComment 
	 * @Description: 查询用户评论
	 * @return
	 * @return: List<Comment>
	 */
	PageInfo<Comment> selectsComment(Integer userIdt,Integer page,Integer pageSize);
	
	/**
	 * 
	 * @Title: delectComment 
	 * @Description: 删除评论
	 * @param id
	 * @return
	 * @return: int
	 */
	int deleteComment(Integer id);
	
}
