package com.klu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.klu.manger.Roomatesmodel;

@Controller
@RequestMapping("/api")
public class UserController {
	
	@Autowired
	Roomatesmodel rm;
	
	static String name;
	
	@GetMapping("/login/{pass}/{name}")
	public String getlogin(@PathVariable("pass") int password,@PathVariable("name") String name)
	{
		String check = rm.getname(password, name);
		if(check!=null) {
			UserController.name = check;
			return "home.jsp";
		}
		else
			return "error.jsp";
		
	}
	@GetMapping("/username")
	public String getname() {
		return "My name is Tanjusha piyaa";

	}
	
	@GetMapping("/loginstatus")
	public String loginstatus()
	{
		if(name!=null){
			return name;
		}
		else
			return "index.jsp";
	}
	

}
