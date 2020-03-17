package com.chx.cms.service;

import java.util.List;

import com.chx.cms.domain.Article;
import com.chx.cms.domain.ArticleLog;

public interface ArticleLogService {

	int insert(ArticleLog log);
	
	int update();
	
	List<Article> selects();
	
}
