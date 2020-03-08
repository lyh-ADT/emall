package com.emall.user;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public boolean checkUserIdRepeated(String userId) {
		return userDao.checkUserIdRepeated(userId);
	}

	@Override
	public boolean register(RegisterController.Account account) {
		Account a = new Account();
		a.setUserId(account.userId);
		StringBuilder password = new StringBuilder(account.password);
		// 插入 -
		int i=0;
		for(int t=0; t < 3; ++t) {
			i += 8;
			password.insert(i, '-');
			i += 1;
		}
		
		a.setPassword(password.toString());
		
		return userDao.register(a);
	}
	
	@Override
	public String login(LoginController.Account account) {
		Account a = new Account();
		a.setUserId(account.userId);
		StringBuilder password = new StringBuilder(account.password);
		// 插入 -
		int i=0;
		for(int t=0; t < 3; ++t) {
			i += 8;
			password.insert(i, '-');
			i += 1;
		}
		
		a.setPassword(password.toString());
		UUID uuid = UUID.randomUUID();
		boolean success = userDao.login(a, uuid.toString());
		if(success) {
			return uuid.toString();
		}
		if(userDao.checkUserIdRepeated(account.userId)) {
			// 用户名不存在
			return "userId";
		}else {
			return "password";
		}
	}

	@Override
	public Object[] getUserId(String uuid) {
		try {
			String userId = userDao.getUserId(uuid);
			return new Object[] {true, userId};
		} catch (Exception e) {
			e.printStackTrace();
			return new Object[] {false, ""};
		}
	}
}
