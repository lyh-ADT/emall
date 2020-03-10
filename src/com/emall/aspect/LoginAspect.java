package com.emall.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.emall.user.UserDao;

/**
 * 检查是否登录的切面类
 * @author 10439
 *
 */
@Aspect
@Component
public class LoginAspect {
	@Autowired
	private UserDao userDao;
	
	@Pointcut("execution(* com.emall.good.*Controller.*(..)) || execution(* com.emall.user.CartController.*(..))")
	private void loginPointCut() {}
	
	@Around("loginPointCut()")
	public Object myAround(ProceedingJoinPoint proceedingJoinPoint) throws Throwable{
		Object[] args = proceedingJoinPoint.getArgs();
		String uuid = (String) args[0];
		String userId = null;
		try {
			userId = userDao.getUserId(uuid);
		}catch(Exception e) {
			return new Response(false, null);
		}
		args[0] = userId; 
		return proceedingJoinPoint.proceed(args);
	}
	
}
