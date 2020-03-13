package com.emall.good;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("goodDao")
public class GoodDaoImpl implements GoodDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public List<Good> getPage(int page, String like_string) {
		final int ITEM_PER_PAGE = 10;
		
		String sql = "select * from goods where goodName like ? order by goodName limit ?,?";
		
		int offset = (page-1) * ITEM_PER_PAGE;
		
		RowMapper<Good> rowMapper = new BeanPropertyRowMapper<Good>(Good.class);
		
		return jdbcTemplate.query(sql, rowMapper, like_string, offset, ITEM_PER_PAGE);
	}

	@Override
	public Good getGoodById(String goodId) {
		String sql = "select * from goods where goodId=?;";
		
		return jdbcTemplate.queryForObject(sql, Good.class);
	}
}