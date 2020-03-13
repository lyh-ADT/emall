package com.emall.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("orderDao")
public class OrderDaoImpl implements OrderDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public List<Order> getPage(String userId, int page, String like_string) {
		final int ITEM_PER_PAGE = 10;
		
		String sql = "select * from orders where buyerId=? or sellerId=? order by buyerId limit ?,?";
		
		int offset = (page-1) * ITEM_PER_PAGE;
		
		RowMapper<Order> rowMapper = new BeanPropertyRowMapper<Order>(Order.class);
		
		return jdbcTemplate.query(sql, rowMapper, userId, userId, offset, ITEM_PER_PAGE);
	}

	@Override
	public Order getOrderById(String userId, String orderId) {
		String sql = "select * from orders where orderId=? and ? in (buyerId, sellerId);";
		RowMapper<Order> rowMapper = new BeanPropertyRowMapper<Order>(Order.class);
		return jdbcTemplate.query(sql, rowMapper, orderId, userId).get(0);
	}
}