package com.emall.user;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.emall.good.Good;
import com.emall.good.GoodController;
import com.emall.user.CheckoutController.CheckoutGood;


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

	@Override
	public List<CartController.Good> getCartGoods(String userId, int page, String search) {
		final String SYMBOL = "%";
		
		StringBuilder like_string = new StringBuilder(search);
		
		int i=0;
		while(i < search.length()) {
			like_string.insert(i, SYMBOL);
			i += 2;
		}
		like_string.append(SYMBOL);
		
		List<Good> goods = userDao.getCartGoods(userId, page, like_string.toString());
		List<CartController.Good> returnList = new LinkedList<>();
		
		for(Good g : goods) {
			returnList.add(CartController.Good.newInstance(g));
		}
		
		return returnList;
	}

	@Override
	public String removeFromCart(String userId, String id) {
		try {
			userDao.removeFromCart(userId, id);
		} catch (Exception e) {
			e.printStackTrace();
			return "删除失败";
		}
		return null;
	}

	@Override
	public String addToCart(String userId, String id) {
		try {
			userDao.addToCart(userId, id);
		} catch (Exception e) {
			e.printStackTrace();
			return "添加失败";
		}
		return null;
	}

	@Override
	public List<CheckoutController.Good> getGoodById(String userId, boolean all, List<String> ids) {
		List<Good> goods;
		if(all) {
			goods = userDao.getGoodsInCart(userId);
		} else {
			goods = userDao.getGoods(ids);
		}
		
		List<CheckoutController.Good> returnList = new LinkedList<CheckoutController.Good>();
		for(Good g : goods) {
			returnList.add(CheckoutController.Good.newInstance(g));
		}
		return returnList;
	}

	@Override
	public String getBalance(String userId) {
		return userDao.getBalance(userId);
	}

	@Override
	public void checkout(String userId, List<CheckoutGood> goods) {
		List<com.emall.good.Good> daoGoods = new LinkedList<>();
		for(CheckoutGood g: goods) {
			com.emall.good.Good daoGood = new Good();
			daoGood.setGoodId(g.id);
			daoGood.setNumber(g.number);
			daoGoods.add(daoGood);
		}
		userDao.checkout(userId, daoGoods);
	}
}
