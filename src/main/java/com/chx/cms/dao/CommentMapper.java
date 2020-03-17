package com.chx.cms.dao;

import java.util.List;

import com.chx.cms.domain.Article;
import com.chx.cms.domain.Comment;

public interface CommentMapper {

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
	List<Comment> selects(Article article);
	
	
	/**
	 * 
	 * @Title: selectsByCommentNum 
	 * @Description: 按照评论数量排序
	 * @return
	 * @return: List<Comment>
	 */
	List<Article> selectsByCommentNum();
	
	/**
	 * 
	 * @Title: updateArticle 
	 * @Description: 评论数+1
	 * @param articleId
	 * @return
	 * @return: int
	 */
	int updateArticle(Integer articleId);
	
	/**
	 * 
	 * @Title: selectsComment 
	 * @Description: 查询用户评论
	 * @return
	 * @return: List<Comment>
	 */
	List<Comment> selectsComment(Integer userId);
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
