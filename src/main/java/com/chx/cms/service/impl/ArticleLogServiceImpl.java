package com.chx.cms.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chx.cms.dao.ArticleLogMapper;
import com.chx.cms.domain.Article;
import com.chx.cms.domain.ArticleLog;
import com.chx.cms.service.ArticleLogService;

@Service
public class ArticleLogServiceImpl implements ArticleLogService{

	
	@Resource
	ArticleLogMapper articleLogMapper;

	@Override
	public int insert(ArticleLog log) {
		
		return articleLogMapper.insert(log);
	}

	@Override
	public int update() {
		
		//先清除已有数据
		articleLogMapper.delete();
		return articleLogMapper.update();
	}

	@Override
	public List<Article> selects() {
		
		return articleLogMapper.selects();
	}
	
	
}
