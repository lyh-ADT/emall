package com.emall.user;

import java.util.List;

public interface UserService {
	boolean checkUserIdRepeated(String userId);
	boolean register(RegisterController.Account account);
	String login(LoginController.Account account);
	Object[] getUserId(String uuid);
	List<CartController.Good> getCartGoods(String useerId, int page, String search);
	String removeFromCart(String userId, String id);
}
