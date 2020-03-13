package com.emall.order;

import java.util.List;

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
public class OrderController {
	@Autowired
	private OrderService orderService;
	
	public void setGoodService(OrderService goodService) {
		this.orderService = goodService;
	}
	
	static class Order{
		String buyerId;
		String sellerId;
		String address;
		String status;
		double totalPrice;
		List<String> goods;
		
		
		static public Order newInstance(com.emall.order.Order order) {     
			Order o = new Order();                                  
			o.setBuyerId(order.getBuyerId());
			o.setSellerId(order.getSellerId());
			o.setAddress(order.getAddress());
			o.setStatus(order.getStatus());
			o.setTotalPrice(order.getTotalPrice());
			o.setGoods(order.getGoodId_list());
			return o;
		}

		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		public double getTotalPrice() {
			return totalPrice;
		}
		public void setTotalPrice(double totalPrice) {
			this.totalPrice = totalPrice;
		}
		public String getBuyerId() {
			return buyerId;
		}
		public void setBuyerId(String buyerId) {
			this.buyerId = buyerId;
		}
		public String getSellerId() {
			return sellerId;
		}
		public void setSellerId(String sellerId) {
			this.sellerId = sellerId;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public List<String> getGoods() {
			return goods;
		}
		public void setGoods(List<String> goods) {
			this.goods = goods;
		}
		
	}

	@RequestMapping(value="/orders", method = RequestMethod.GET)
	@ResponseBody
	public Response getUserId(@CookieValue("UUID") String userId, @RequestParam(value="page", defaultValue="1")int page, @RequestParam(value="search", defaultValue="") String search) {
		Response r = new Response(true, null);
		try {
			r.setData(orderService.getPage(userId, page, search)); 
		}catch(Exception e) {
			e.printStackTrace();
			r.setSuccess(false);
		}
		return r;
	}
}
