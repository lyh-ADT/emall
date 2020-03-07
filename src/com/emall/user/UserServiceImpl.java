package com.emall.user;

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
		// ≤Â»Î -
		int i=0;
		for(int t=0; t < 3; ++t) {
			i += 8;
			password.insert(i, '-');
			i += 1;
		}
		
		a.setPassword(password.toString());
		
		return userDao.register(a);
	}
}
