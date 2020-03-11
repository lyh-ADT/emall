package com.emall.user;

import java.util.List;

public interface UserService {
	boolean checkUserIdRepeated(String userId);
	boolean register(RegisterController.Account account);
	String login(LoginController.Account account);
	Object[] getUserId(String uuid);
	List<CartController.Good> getCartGoods(String useerId, int page, String search);
	String removeFromCart(String userId, String id);
	String addToCart(String userId, String id);
	List<CheckoutController.Good> getGoodById(String userId, boolean all, List<String> ids);
	String getBalance(String userId);
}
