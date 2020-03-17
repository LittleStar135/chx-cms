package com.chx.cms.service.impl;

import java.awt.color.CMMException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chx.cms.dao.CollectMapper;
import com.chx.cms.domain.Collect;
import com.chx.cms.service.CollectService;
import com.chx.common.utils.StringUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class CollectServiceImpl implements CollectService {

	@Resource
	private CollectMapper collectMapper;
	
	@Override
	public int insert(Collect collect) {
		if (!StringUtil.isHttpUrl(collect.getUrl())) {
			throw new CMMException("不是合法的url");
		}
		return collectMapper.insert(collect);
	}

	@Override
	public int delete(Integer id) {
		
		return collectMapper.delete(id);
	}

	@Override
	public PageInfo<Collect> selects(Integer userId,Integer page,Integer pageSize) {
		Page<Object> info = PageHelper.startPage(page, pageSize);
		List<Collect> list = collectMapper.selects(userId);
		
		return new PageInfo<Collect>(list); 
	}

	@Override
	public Collect selectByTitleAndUserId(String title, Integer userId) {
		
		return collectMapper.selectByTitleAndUserId(title, userId);
	}

}
