package com.emall.order;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.emall.good.GoodController;
import com.emall.good.GoodDao;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	@Autowired
	private GoodDao goodDao;
	
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

	@Override
	public com.emall.order.OrderController.OrderDetail getOrderDetailById(String userId, String orderId) {
		OrderController.OrderDetail orderDetail = new OrderController.OrderDetail();
		Order order = orderDao.getOrderById(userId, orderId);
		orderDetail.setOrder(OrderController.Order.newInstance(order));
		List<GoodController.Good> goods = new LinkedList<GoodController.Good>();
		for(String goodId : order.getGoodId_list()) {
			goods.add(GoodController.Good.newInstance(goodDao.getGoodById(goodId)));
		}
		orderDetail.setGoods(goods);
		return orderDetail;
	}
}
