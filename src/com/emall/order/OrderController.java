package com.emall.order;

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
import com.emall.good.GoodController;

@Controller
@ResponseBody
public class OrderController {
	@Autowired
	private OrderService orderService;
	
	public void setGoodService(OrderService goodService) {
		this.orderService = goodService;
	}
	
	static class Order{
		String orderId;
		String buyerId;
		String sellerId;
		String address;
		String status;
		double totalPrice;
		List<String> goods;
		
		
		static public Order newInstance(com.emall.order.Order order) {     
			Order o = new Order();
			o.setOrderId(order.getOrderId());
			o.setBuyerId(order.getBuyerId());
			o.setSellerId(order.getSellerId());
			o.setAddress(order.getAddress());
			o.setStatus(order.getStatus());
			o.setTotalPrice(order.getTotalPrice());
			o.setGoods(order.getGoodId_list());
			return o;
		}
		public String getOrderId() {
			return orderId;
		}
		
		public void setOrderId(String orderId) {
			this.orderId = orderId;
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
	public Response orders(@CookieValue("UUID") String userId, @RequestParam(value="page", defaultValue="1")int page, @RequestParam(value="search", defaultValue="") String search) {
		Response r = new Response(true, null);
		try {
			r.setData(orderService.getPage(userId, page, search)); 
		}catch(Exception e) {
			e.printStackTrace();
			r.setSuccess(false);
		}
		return r;
	}
	
	static class OrderDetail{
		Order order;
		List<GoodController.Good> goods;
		public Order getOrder() {
			return order;
		}
		public void setOrder(Order order) {
			this.order = order;
		}
		public List<GoodController.Good> getGoods() {
			return goods;
		}
		public void setGoods(List<GoodController.Good> goods) {
			this.goods = goods;
		}
	}
	@RequestMapping(value="/order-detail", method = RequestMethod.GET)
	@ResponseBody
	public Response getUserId(@CookieValue("UUID") String userId, @RequestParam("id")String orderId) {
		Response r = new Response(true, orderService.getOrderDetailById(userId, orderId));
		return r;
	}
	
	static class Receive{
		String id;

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}
	}
	@RequestMapping(value="/order/receive", method = RequestMethod.POST)
	@ResponseBody
	public Response receive(@CookieValue("UUID") String userId, @RequestBody Receive receive) {
		Response r = new Response(true, null);
		orderService.receive(userId, receive.id);
		return r;
	}
	
	@RequestMapping(value="/order/send", method = RequestMethod.POST)
	@ResponseBody
	public Response send(@CookieValue("UUID") String userId, @RequestBody Receive receive) {
		Response r = new Response(true, null);
		orderService.send(userId, receive.id);
		return r;
	}
}
