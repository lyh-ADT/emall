package com.emall.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@ResponseBody
public class RegisterController{
	@Autowired
	private UserService userService;
	
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public class Response{
		boolean success;
		String data;
		public boolean isSuccess() {
			return success;
		}
		public void setSuccess(boolean success) {
			this.success = success;
		}
		public String getData() {
			return data;
		}
		public void setData(String data) {
			this.data = data;
		}
	}
	
	static public class Account{
		String userId;
		String password;
		public String getUserId() {
			return userId;
		}
		public void setUserId(String userId) {
			this.userId = userId;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
	}
	
	
   @RequestMapping(value="/register", method = RequestMethod.POST)
   @ResponseBody
   public Response register(@RequestBody Account account) {
	  Response r = new Response();
	  r.success = userService.register(account);
      return r;
   }
   
   @RequestMapping(value="/checkUserId", method=RequestMethod.GET)
   public Response checkuserId(@RequestParam String userId) {
	  Response r = new Response();
	  r.success = userService.checkUserIdRepeated(userId);
      return r;
   }
}