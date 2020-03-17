package com.chx.cms.util;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * 
 * @ClassName: Md5Util 
 * @Description: 对密码加密
 * @author: MACHENIKE
 * @date: 2020年3月12日 上午9:51:57
 */
public class Md5Util {

	//加严
	private static String salt="qaz123";
	
	public static String encode(String password) {
		String md5Hex = DigestUtils.md5Hex(password+salt);
		
		return md5Hex;
		
	}
	
	
//	public static void main(String[] args) {
//		String encode = Md5Util.encode("123456");
//		String encode1 = Md5Util.encode("1");
//		String encode2 = Md5Util.encode("1");
//		
//		
//	}
	
}
