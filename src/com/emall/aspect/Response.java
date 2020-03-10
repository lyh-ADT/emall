package com.emall.aspect;

public class Response {
	private boolean success;
	private Object data;
	
	public Response(boolean success, Object data) {
		super();
		this.success = success;
		this.data = data;
	}
	
	@Override
	public String toString() {
		return "Response [success=" + success + ", data=" + data + "]";
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
}
