package com.emall.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.emall.aspect.Response;
import com.emall.user.CartController.Good;

@Controller
@ResponseBody
public class CheckoutController {
	@Autowired
	private UserService userService;
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	static public class Good{
		String id;
		String img;
		String title;
		String description;
		double price;
		int number;
		
		static public Good newInstance(com.emall.good.Good good) {
			Good g = new Good();
			g.id = good.getGoodId();
			g.img = good.getImgs().get(0);
			g.title = good.getGoodName();
			g.description = good.getDescription();
			g.price = good.getPrice();
			g.number = good.getNumber();
			return g;
		}
		
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getImg() {
			return img;
		}
		public void setImg(String img) {
			this.img = img;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getDescription() {
			return description;
		}
		public void setDescription(String description) {
			this.description = description;
		}
		public double getPrice() {
			return price;
		}
		public void setPrice(double price) {
			this.price = price;
		}
		public int getNumber() {
			return number;
		}
		public void setNumber(int number) {
			this.number = number;
		}
	}
	
	@RequestMapping(value="/good", method = RequestMethod.GET)
	public Response good(@CookieValue("UUID") String userId, @RequestParam(value="id", defaultValue="null") List<String> ids, @RequestParam(value="all", defaultValue="false") boolean all){
		return new Response(true, userService.getGoodById(userId, all, ids));
	}
	
	static public class CheckoutGood{
		String id;
		int number;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public int getNumber() {
			return number;
		}
		public void setNumber(int number) {
			this.number = number;
		}
	}
	
	@RequestMapping(value="/checkout", method = RequestMethod.POST)
	public Response checkout(@CookieValue("UUID") String userId, @RequestBody List<CheckoutGood> goods){
		userService.checkout(userId, goods);
		return new Response(true, null);
	}
}
