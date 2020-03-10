package com.emall.good;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("goodService")
public class GoodServiceImpl implements GoodService {

	@Autowired
	private GoodDao goodDao;
	
	public void setUserDao(GoodDao userDao) {
		this.goodDao = userDao;
	}

	@Override
	public List<GoodController.Good> getPage(int page, String search) {
		final String SYMBOL = "%";
		
		StringBuilder like_string = new StringBuilder(search);
		
		int i=0;
		while(i < search.length()) {
			like_string.insert(i, SYMBOL);
			i += 2;
		}
		like_string.append(SYMBOL);
		
		List<Good> goods = goodDao.getPage(page, like_string.toString());
		List<GoodController.Good> returnList = new LinkedList<>();
		
		for(Good g : goods) {
			returnList.add(GoodController.Good.newInstance(g));
		}
		
		return returnList;
	}
}
