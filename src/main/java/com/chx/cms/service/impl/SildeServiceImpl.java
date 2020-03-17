package com.chx.cms.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chx.cms.dao.SildeMapper;
import com.chx.cms.domain.Silde;
import com.chx.cms.service.SildeService;

@Service
public class SildeServiceImpl implements SildeService {

	@Resource
	SildeMapper sildeMapper;
	
	
	@Override
	public List<Silde> selects() {
		
		return sildeMapper.selects();
	}

}
