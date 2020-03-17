package com.chx.cms.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chx.cms.dao.CommentMapper;
import com.chx.cms.domain.Article;
import com.chx.cms.domain.Comment;
import com.chx.cms.service.CommentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class CommentServiceImpl implements CommentService {

	@Resource
	private CommentMapper commentmapper;
	
	
	@Override
	public int insert(Comment comment) {
		
		try {
			//增加评论
			commentmapper.insert(comment);
			//文章的评论数量+1
			commentmapper.updateArticle(comment.getArticleId());
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public PageInfo<Comment> selects(Article article, Integer page, Integer pageSize) {
		PageHelper.startPage(page,pageSize);
		List<Comment> list = commentmapper.selects(article);
		return new PageInfo<Comment>(list);
	}

	@Override
	public PageInfo<Article> selectsByCommentNum(Integer page, Integer pageSize) {
		PageHelper.startPage(page,pageSize);
		List<Article> list = commentmapper.selectsByCommentNum();
		return new PageInfo<Article>(list);
	}

	@Override
	public PageInfo<Comment> selectsComment(Integer userId, Integer page, Integer pageSize) {
		PageHelper.startPage(page,pageSize);
		List<Comment> list = commentmapper.selectsComment(userId);
		
		return new PageInfo<Comment>(list);
	}

	@Override
	public int deleteComment(Integer id) {
		
		return commentmapper.deleteComment(id);
	}

}
