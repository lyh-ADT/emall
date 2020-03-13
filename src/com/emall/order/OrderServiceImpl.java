package com.emall.order;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	public void setUserDao(OrderDao userDao) {
		this.orderDao = userDao;
	}

	@Override
	public List<OrderController.Order> getPage(String userId, int page, String search) {
		final String SYMBOL = "%";
		
		StringBuilder like_string = new StringBuilder(search);
		
		int i=0;
		while(i < search.length()) {
			like_string.insert(i, SYMBOL);
			i += 2;
		}
		like_string.append(SYMBOL);
		
		List<Order> orders = orderDao.getPage(userId, page, like_string.toString());
		List<OrderController.Order> returnList = new LinkedList<>();
		
		for(Order g : orders) {
			returnList.add(OrderController.Order.newInstance(g));
		}
		
		return returnList;
	}
}
