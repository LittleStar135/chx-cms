package com.chx.cms.dao;

import java.util.List;

import com.chx.cms.domain.Category;
import com.chx.cms.domain.Channel;

public interface ChannelMapper {

	/**
	 * 
	 * @Title: selects 
	 * @Description: 查询所有
	 * @return
	 * @return: List<Channel>
	 */
	List<Channel> channelselects();
	/**
	 * 
	 * @Title: selectsBychannelId 
	 * @Description: 分类
	 * @param channelId
	 * @return
	 * @return: List<Category>
	 */
	List<Category> selectsBychannelId(Integer channelId);
	
}
