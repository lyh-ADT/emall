package com.emall.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("userDao")
public class UserDaoImpl implements UserDao {

	@Autowired
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
}