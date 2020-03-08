package com.emall.user;

public interface UserService {
	boolean checkUserIdRepeated(String userId);
	boolean register(RegisterController.Account account);
	String login(LoginController.Account account);
	Object[] getUserId(String uuid);
}
