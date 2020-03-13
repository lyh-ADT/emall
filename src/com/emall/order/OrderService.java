package com.emall.order;

import java.util.List;

public interface OrderService {
	List<OrderController.Order> getPage(String userId, int page, String search);
}
