package com.chx.cms.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chx.cms.domain.Category;
import com.chx.cms.domain.Channel;
import com.chx.cms.service.ChannelService;

@Controller
@RequestMapping("channel")
public class ChannelController {

	@Resource
	private ChannelService channelService;
	
	/**
	 * 
	 * @Title: Channels 
	 * @Description: 所属栏目
	 * @return
	 * @return: List<Channel>
	 */
	@ResponseBody
	@RequestMapping("channels")
	public List<Channel> Channels() {	
		List<Channel> list = channelService.channelselects();
		
		return list;
	}
	/**
	 * 
	 * @Title: selectsBychannelId 
	 * @Description:所属栏目分类
	 * @param channelId
	 * @return
	 * @return: List<Category>
	 */
	@ResponseBody
	@RequestMapping("selectsBychannelId")
	public List<Category> selectsBychannelId(Integer channelId) {
		
		return channelService.selectsBychannelId(channelId);
		
	}
	
	
}

