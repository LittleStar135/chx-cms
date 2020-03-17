package com.chx.cms.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.chx.cms.dao.ChannelMapper;
import com.chx.cms.domain.Category;
import com.chx.cms.domain.Channel;
import com.chx.cms.service.ChannelService;

@Service
public class ChannelServiceImpl implements ChannelService{

	@Resource
	private ChannelMapper channelMapper;
	
	
	@Override
	public List<Channel> channelselects() {
		
		return channelMapper.channelselects();
	}


	@Override
	public List<Category> selectsBychannelId(Integer channelId) {
		
		return channelMapper.selectsBychannelId(channelId);
	}

}
