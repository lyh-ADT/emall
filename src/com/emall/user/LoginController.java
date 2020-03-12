package com.emall.user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@ResponseBody
public class LoginController{

	@Autowired
	private UserService userService;
	
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	static public class Response{

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
	
	
   @RequestMapping(value="/login", method = RequestMethod.POST)
   @ResponseBody
   public Response login(@RequestBody Account account, HttpServletResponse response) {
	  Response r = new Response();
	  String data = userService.login(account);
	  if(data.length() == 36) {
		  r.success = true;
		  response.addCookie(new Cookie("UUID", data));
	      return r;
	  }
	  r.success = false;
	  r.data = data;
	  return r;
   }

   @RequestMapping(value="/userId", method = RequestMethod.GET)
   @ResponseBody
   public Response getUserId(@CookieValue("UUID") String userId, HttpServletResponse response) {
	  Response r = new Response();
	  r.success = true;
	  r.data = userId;
	  return r;
   }
   
   @RequestMapping(value="/balance", method = RequestMethod.GET)
   @ResponseBody
   public com.emall.aspect.Response getBalance(@CookieValue("UUID") String userId) {
	  com.emall.aspect.Response r = new com.emall.aspect.Response(true, userService.getBalance(userId));
	  return r;
   }
}