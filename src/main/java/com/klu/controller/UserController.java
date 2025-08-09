package com.klu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.klu.dto.GroceryResponse;
import com.klu.dto.ItemCreationRequest;
import com.klu.entity.Grocery;
import com.klu.manger.GroceryManager;
import com.klu.manger.ItemManager;
import com.klu.manger.Roomatesmodel;
import com.klu.repository.GroceryRepo;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "https://firsttask-production.up.railway.app", allowCredentials = "true")
public class UserController {

    @Autowired
    Roomatesmodel rm;
    
    @Autowired
    ItemManager im;
    
    @Autowired
    GroceryManager gm;
    
    @Autowired
    GroceryRepo gr;
    
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
    public String getitems(HttpSession session) {
        int id = (Integer) session.getAttribute("id");
        return im.itemlist(id); // Changed to directly return the string from ItemManager
    }
    
    @PutMapping("/updateitems/{id}")
    public ResponseEntity<String> updateItemAvailability(@PathVariable("id") int id) {
        try {
            String result = im.update_visable(id, false);
            if ("successfull".equals(result)) {
                return new ResponseEntity<>("Item marked as not available successfully!", HttpStatus.OK);
            } else if (result.contains("NoSuchElementException")) {
                return new ResponseEntity<>("Item with ID " + id + " not found.", HttpStatus.NOT_FOUND);
            } else {
                return new ResponseEntity<>("Failed to update item: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // NEW: Endpoint to make an item available
    @PutMapping("/makeAvailable/{id}")
    public ResponseEntity<String> makeItemAvailable(@PathVariable("id") int id) {
        try {
            String result = im.makeAvailable(id);
            if ("success".equals(result)) {
                return new ResponseEntity<>("Item marked as available successfully!", HttpStatus.OK);
            } else if ("not_found".equals(result)) {
                return new ResponseEntity<>("Item with ID " + id + " not found.", HttpStatus.NOT_FOUND);
            } else {
                return new ResponseEntity<>("Failed to make item available: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/items")
    public ResponseEntity<String> createNewItem(@RequestBody ItemCreationRequest itemRequest, HttpSession session) {
        try {
            Integer loggedInUserId = (Integer) session.getAttribute("id");
            if (loggedInUserId == null) {
                return new ResponseEntity<>("User not logged in.", HttpStatus.UNAUTHORIZED);
            }

            String result = im.createItem(itemRequest, loggedInUserId);

            if ("successfull".equals(result)) {
                return new ResponseEntity<>("Item added successfully!", HttpStatus.CREATED);
            } else {
                return new ResponseEntity<>("Failed to add item: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred while adding item: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @GetMapping("/getunv")
    public String getunv(HttpSession session)
    {
    	int id = (Integer)session.getAttribute("id");
    	return im.getunv(id).toString();
    }
    
    
    @GetMapping("/getunvg")
    public ResponseEntity<List<GroceryResponse>> getUnavailableGroceries(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("id");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        List<Grocery> groceries = gr.findUnavailableGroceriesForUser(userId);
        List<GroceryResponse> responses = groceries.stream()
            .map(g -> new GroceryResponse(
                g.getId(),
                g.getName(),
                g.getIsAvailable(),
                g.getPurchasedBy() != null ? g.getPurchasedBy().getName() : "Unknown"
            ))
            .toList();

        return ResponseEntity.ok(responses);
    }

    
 }