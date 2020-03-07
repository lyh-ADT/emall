package com.emall.user;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDaoImpl implements UserDao {
	
	private JdbcTemplate jdbcTemplate;

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
}