package com.chx.cms.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.chx.cms.dao.ArticleMapper;
import com.chx.cms.domain.Article;
import com.chx.cms.service.ArticleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service

public class ArticleServiceImpl implements ArticleService{

	@Resource
	ArticleMapper mapper;
	
	@Override
	public int insert(Article article) {
		
		return mapper.insert(article);
	}

	@Override
	public PageInfo<Article> selects(Article article, Integer page, Integer pageSize) {
		PageHelper.startPage(page, pageSize);
		List<Article> list = mapper.selects(article);
		return new PageInfo<Article>(list);
	}

	@Override
	public Article select(Integer id) {
		
		return mapper.select(id);
	}

	@Override
	public int update(Article article) {
		
		return mapper.update(article);
	}

	
	
	
}
