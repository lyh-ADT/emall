package com.emall.good;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.emall.aspect.Response;

@Controller
@ResponseBody
public class GoodController {
	@Autowired
	private GoodService goodService;
	
	public void setGoodService(GoodService goodService) {
		this.goodService = goodService;
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


	@RequestMapping(value="/goods", method = RequestMethod.GET)
	@ResponseBody
	public Response getUserId(@CookieValue("UUID") String userId, @RequestParam(value="page", defaultValue="1")int page, @RequestParam(value="search", defaultValue="") String search) {
		Response r = new Response(true, null);
		try {
			r.setData(goodService.getPage(page, search)); 
		}catch(Exception e) {
			e.printStackTrace();
			r.setSuccess(false);
		}
		return r;
	}
}
