package com.chx.cms.dao;

import java.util.List;

import com.chx.cms.domain.Article;
import com.chx.cms.domain.ArticleLog;

public interface ArticleLogMapper {

	int insert(ArticleLog log);
	
	int update();
	
	int delete();
	
	List<Article> selects();
	
}
