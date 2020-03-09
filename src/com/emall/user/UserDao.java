package com.emall.user;

public interface UserDao {
	boolean checkUserIdRepeated(String userId);
	boolean register(Account account);
	boolean login(Account account, String uuid);
}
