package com.chx.cms.domain;

import java.io.Serializable;

/**
 * 
 * @ClassName: Silde 
 * @Description: 广告表
 * @author: MACHENIKE
 * @date: 2020年3月3日 下午3:35:41
 */
public class Silde implements Serializable{

	/**
	 * @fieldName: serialVersionUID
	 * @fieldType: long
	 * @Description: TODO
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;//主键
	private String title;//广告的文字说明
	private String picture;//广告图片地址
	private String url;//点击进入广告详情
	public Silde() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Override
	public String toString() {
		return "Silde [id=" + id + ", title=" + title + ", picture=" + picture + ", url=" + url + "]";
	}
	
	
	
	
	
}
