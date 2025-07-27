package com.klu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.klu.manger.Roomatesmodel;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "https://firsttask-production.up.railway.app", allowCredentials = "true")
public class UserController {

    @Autowired
    Roomatesmodel rm;

    @GetMapping("/login/{pass}/{name}")
    public String getLogin(@PathVariable("pass") int password, @PathVariable("name") String name, HttpSession session) {
        String check = rm.getname(password, name);
        if (check != null) {
            session.setAttribute("username", check); // Store in session
            session.setMaxInactiveInterval(600); // 10 minutes
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
            return "index.jsp"; // Not logged in or session expired
        }
    }
}
