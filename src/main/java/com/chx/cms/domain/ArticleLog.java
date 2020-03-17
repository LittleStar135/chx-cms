package com.chx.cms.domain;

import java.io.Serializable;
import java.util.Date;

public class ArticleLog implements Serializable{

	/**
	 * @fieldName: serialVersionUID
	 * @fieldType: long
	 * @Description: TODO
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	private Integer articleId;// 文章ID
	private Date visitDate;// 访问日期
	private String username;// 访问人

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getArticleId() {
		return articleId;
	}

	public void setArticleId(Integer articleId) {
		this.articleId = articleId;
	}

	
	public Date getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(Date visitDate) {
		this.visitDate = visitDate;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String toString() {
		return "ArticleLog [id=" + id + ", articleId=" + articleId + ", visitDate=" + visitDate + ", username="
				+ username + "]";
	}
	
	
	

}
