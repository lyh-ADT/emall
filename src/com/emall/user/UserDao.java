package com.emall.user;

import java.util.List;

import com.emall.good.Good;

public interface UserDao {
	boolean checkUserIdRepeated(String userId);
	boolean register(Account account);
	boolean login(Account account, String uuid);
	String getUserId(String uuid) throws Exception;
	List<Good> getCartGoods(String userId, int page, String like_string);
	void removeFromCart(String userId, String id) throws Exception;
	void addToCart(String userId, String id) throws Exception;
	List<Good> getGoods(List<String> ids);
	List<Good> getGoodsInCart(String userId);
	String getBalance(String userId);
}
