package com.emall.order;

import java.util.List;

public interface OrderDao {
	List<Order> getPage(String userId, int page, String like_string);
}
