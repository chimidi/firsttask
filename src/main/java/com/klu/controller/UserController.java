package com.klu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.klu.manger.ItemManager;
import com.klu.manger.Roomatesmodel;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "https://firsttask-production.up.railway.app", allowCredentials = "true")
public class UserController {

    @Autowired
    Roomatesmodel rm;
    
    @Autowired
    ItemManager im;
    
    @GetMapping("/login/{pass}/{name}")
    public String getLogin(@PathVariable("pass") int password, @PathVariable("name") String name, HttpSession session) {
        String check = rm.getname(password, name);
        int id = rm.getid(name);
        if (check != null) {
        	session.setAttribute("username", check);
            session.setAttribute("id", id);
            session.setMaxInactiveInterval(600); 
            return "home.jsp";
        } else {
            return "error.jsp";
        }
    }

    @GetMapping("/username")
    public String getName(HttpSession session) {
        String user = (String) session.getAttribute("username");
        return user != null ? user : "Guest";
    }

    @GetMapping("/loginstatus")
    public String loginStatus(HttpSession session) {
        String user = (String) session.getAttribute("username");
        if (user != null) {
            return user;
        } else {
            return "index.jsp";
        }
    }
    
    @GetMapping("/getitems")
    public String getitems(HttpSession session)
    {
    	int id = (Integer) session.getAttribute("id");
    	return im.itemlist(id).toString();
    }

}
