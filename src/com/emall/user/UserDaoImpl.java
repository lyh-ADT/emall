package com.emall.user;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.emall.good.Good;

@Repository("userDao")
public class UserDaoImpl implements UserDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

	public void setNamedParameterJdbcTemplate(NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
		this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public boolean checkUserIdRepeated(String userId) {
		String sql = "select userId from account where userId=?;";

		RowMapper<String> rowMapper = new BeanPropertyRowMapper<String>(String.class);
		
		return jdbcTemplate.query(sql, rowMapper, userId).size() == 0;
	}

	@Override
	public boolean register(Account account) {
		String sql = "insert into account(userId, password) values(?, ?);";
		Object[] obj = new Object[] {
			account.getUserId(),
			account.getPassword()
		};
		return jdbcTemplate.update(sql, obj) == 1;
	}
	
	@Override
	public boolean login(Account account, String uuid) {
		String sql = "update account set uuid=? where userId=? and password=?;";
		Object[] obj = new Object[] {
			uuid,
			account.getUserId(),
			account.getPassword()
		};
		return jdbcTemplate.update(sql, obj) == 1;
	}

	@Override
	public String getUserId(String uuid) throws Exception {
		String sql = "select userId from account where uuid=?;";

		List<String> list = jdbcTemplate.queryForList(sql, String.class, uuid);
		if(list.size() != 1) {
			throw new Exception("获取用户名失败，找到了："+list.size());
		}
		return list.get(0);
	}

	@Override
	public List<Good> getCartGoods(String userId, int page, String like_string) {
		final int ITEM_PER_PAGE = 10;
		
		String sql = "select * from goods where goodId in (select goodId from carts where userId=?) and goodName like ? order by goodName limit ?,?;";
		
		int offset = (page-1) * ITEM_PER_PAGE;
		
		RowMapper<Good> rowMapper = new BeanPropertyRowMapper<Good>(Good.class);
		
		return jdbcTemplate.query(sql, rowMapper, userId, like_string, offset, ITEM_PER_PAGE);
	}

	@Override
	public void removeFromCart(String userId, String id) throws Exception {

		String sql = "delete from carts where userId=? and goodId=?;";
		
		if(jdbcTemplate.update(sql, userId, id) != 1) {
			throw new Exception();
		}
	}

	@Override
	public void addToCart(String userId, String id) throws Exception {
		String sql = "insert into carts(userId, goodId) values(?, ?);";
		
		if(jdbcTemplate.update(sql, userId, id) != 1) {
			throw new Exception();
		}
	}
	
	@Override
	public List<Good> getGoods(List<String> ids) {
		String sql = "select * from goods where goodId in (:ids);";
		
		MapSqlParameterSource parameters = new MapSqlParameterSource();
	    parameters.addValue("ids", ids);
		
		RowMapper<Good> rowMapper = new BeanPropertyRowMapper<Good>(Good.class);
		return namedParameterJdbcTemplate.query(sql, parameters, rowMapper);
	}

	@Override
	public List<Good> getGoodsInCart(String userId) {
		String sql = "select * from goods where goodId in (select goodId from carts where userId=:userId);";
		
		MapSqlParameterSource parameters = new MapSqlParameterSource();
	    parameters.addValue("userId", userId);
		
		RowMapper<Good> rowMapper = new BeanPropertyRowMapper<Good>(Good.class);
		
		return namedParameterJdbcTemplate.query(sql, parameters, rowMapper);
	}

	@Override
	public String getBalance(String userId) {
		String sql = "select balance from account where userId=?;";
		return jdbcTemplate.queryForObject(sql, String.class, userId);
	}

	@Override
	public void checkout(String userId, List<Good> daoGoods) {
		String sql = "select userId from goods where goodId in (:ids) group by userId;";
		List<String> ids = new LinkedList<>();
		for(Good g : daoGoods) {
			ids.add(g.getGoodId());
		}
		
		// 每个卖家单独处理
		MapSqlParameterSource parameters = new MapSqlParameterSource();
		parameters.addValue("ids", ids);
		for(String sellerId : namedParameterJdbcTemplate.queryForList(sql, parameters, String.class)) {
			checkoutOneSeller(userId, sellerId, daoGoods);
		}
		// 删除买家购物车中的物品
		parameters.addValue("userId", userId);
		sql = "delete from carts where userId=:userId and goodId in (:ids)";
		namedParameterJdbcTemplate.update(sql, parameters);
	}
	
	private void checkoutOneSeller(String buyerId, String sellerId, List<Good> allGoods) {
		String sql;
		MapSqlParameterSource parameters = new MapSqlParameterSource();
		parameters.addValue("buyerId", buyerId);
		parameters.addValue("sellerId", sellerId);
		
		// 扣除卖家库存
		sql = "update goods set number=number-:number where goodId=:goodId and userId=:sellerId;";
		for(Good g : allGoods) {
			parameters.addValue("number", g.getNumber());
			parameters.addValue("goodId", g.getGoodId());
			namedParameterJdbcTemplate.update(sql, parameters);
		}
		
		// 计算总价
		double totalPrice = 0;
		sql = "select price from goods where goodId=:goodId and userId=:sellerId;";
		for(Good g : allGoods) {
			parameters.addValue("goodId", g.getGoodId());
			totalPrice += namedParameterJdbcTemplate.queryForObject(sql, parameters, Double.class);
		}
		parameters.addValue("totalPrice", totalPrice);
		
		// 扣除买家的钱
		sql = "update account set balance=balance-:totalPrice where userId=:buyerId;";
		namedParameterJdbcTemplate.update(sql, parameters);
		
		// 增加卖家的钱
		sql = "update account set balance=balance+:totalPrice where userId=:sellerId;";
		namedParameterJdbcTemplate.update(sql, parameters);
		
		// 增加买家订单记录
		// 增加卖家订单记录
	}
}