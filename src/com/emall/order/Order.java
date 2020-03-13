package com.emall.order;

import java.util.List;

public class Order {
	private String orderId;
	private String buyerId;
	private String sellerId;
	private String status;
	private String address;
	private double totalPrice;
	private List<String> goodId_list;
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public List<String> getGoodId_list() {
		return goodId_list;
	}
	public void setGoodId_list(List<String> goodId_list) {
		this.goodId_list = goodId_list;
	}
}
