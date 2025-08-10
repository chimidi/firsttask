package com.klu.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.*;

import com.klu.dto.GroceryResponse;
import com.klu.dto.ItemCreationRequest;
import com.klu.entity.Grocery;
import com.klu.entity.Note;
import com.klu.manger.AccessoryManager;
import com.klu.manger.GroceryManager;
import com.klu.manger.ItemManager;
import com.klu.manger.Roomatesmodel;
import com.klu.repository.GroceryRepo;
import com.klu.repository.NoteRepo;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "https://firsttask-jmub.onrender.com", allowCredentials = "true")
public class UserController {

    @Autowired
    Roomatesmodel rm;
    
    @Autowired
    ItemManager im;
    
    @Autowired
    GroceryManager gm;
    
    @Autowired
    GroceryRepo gr;
    
    @Autowired
    AccessoryManager am;
    
    
    @GetMapping("/login/{pass}/{name}")
    public String getLogin(@PathVariable("pass") int password, @PathVariable("name") String name, HttpSession session) {
        String check = rm.getname(password, name);
        int id = rm.getid(name);
        if (check != null) {
            session.setAttribute("username", check);
            session.setAttribute("id", id);
            gm.p((Integer) session.getAttribute("id"));
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
     
    @GetMapping("/getacunv")
    public String accunv(HttpSession session)
    {
    	return am.getunv((Integer)session.getAttribute("id")).toString();
    }
    
 
    
    
    @PutMapping("/updateStatus/{itemId}")
    public ResponseEntity<String> updateItemStatus(@PathVariable("itemId") int itemId, HttpSession session) {
        try {
            // Retrieve the logged-in user's ID from the session
            Integer userId = (Integer) session.getAttribute("id");
            if (userId == null) {
                return new ResponseEntity<>("User not logged in.", HttpStatus.UNAUTHORIZED);
            }

            // Call the ItemManager with both the item ID and the user ID
            String result = im.makeAvailable1(itemId, userId);
            
            if ("success".equals(result)) {
                return new ResponseEntity<>("Item marked as available successfully!", HttpStatus.OK);
            } else if ("not_found".equals(result)) {
                return new ResponseEntity<>("Item or user not found.", HttpStatus.NOT_FOUND);
            } else if ("error".equals(result)) {
                // Return a generic error message for the client
                return new ResponseEntity<>("Failed to make item available due to a server error.", HttpStatus.INTERNAL_SERVER_ERROR);
            }
            
            return new ResponseEntity<>("An unknown error occurred.", HttpStatus.INTERNAL_SERVER_ERROR);

        } catch (Exception e) {
            e.printStackTrace();
            // This is the key change: log the full exception message for debugging.
            String errorMessage = "An unexpected error occurred: " + e.getMessage();
            System.err.println(errorMessage); // Log the full message to the console
            return new ResponseEntity<>(errorMessage, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    // NEW: Endpoint to update the status of a grocery item
    @PutMapping("/updateGroceryStatus/{groceryId}")
    public ResponseEntity<String> updateGroceryStatus(@PathVariable("groceryId") int groceryId, HttpSession session) {
        try {
            Integer userId = (Integer) session.getAttribute("id");
            if (userId == null) {
                return new ResponseEntity<>("User not logged in.", HttpStatus.UNAUTHORIZED);
            }
            
            // Call the grocery manager to update the item status
            // NOTE: This assumes a `makeAvailableForGrocery` method exists in `GroceryManager`
            String result = gm.makeAvailableForGrocery(groceryId, userId);
            
            if ("success".equals(result)) {
                return new ResponseEntity<>("Grocery item marked as available successfully!", HttpStatus.OK);
            } else if ("not_found".equals(result)) {
                return new ResponseEntity<>("Grocery item with ID " + groceryId + " or user not found.", HttpStatus.NOT_FOUND);
            } else {
                return new ResponseEntity<>("Failed to update grocery item: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PutMapping("/updateAccessoryStatus/{accessoryId}")
    public ResponseEntity<String> updateAccessoryStatus(@PathVariable("accessoryId") int accessoryId, HttpSession session) {
        try {
            Integer userId = (Integer) session.getAttribute("id");
            if (userId == null) {
                return new ResponseEntity<>("User not logged in.", HttpStatus.UNAUTHORIZED);
            }
            // Call the accessory manager to update the item status
            String result = am.makeAvailableForAccessory(accessoryId, userId);
            
            if ("success".equals(result)) {
                return new ResponseEntity<>("Accessory item marked as available successfully!", HttpStatus.OK);
            } else if ("not_found".equals(result)) {
                return new ResponseEntity<>("Accessory item with ID " + accessoryId + " or user not found.", HttpStatus.NOT_FOUND);
            } else {
                return new ResponseEntity<>("Failed to update accessory item: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @GetMapping("/count")
    public int count(HttpSession session)
    {
    	Integer userId = (Integer) session.getAttribute("id");
        if (userId == null) {
            return 0;
        }

        // We assume the GroceryRepo has a method to count unavailable items for a user.
        // This is a more efficient approach than getting the entire list and counting.
        Integer count = gm.countf(userId);
    	return im.count(userId)+count+am.counta(userId);
    }
    
 }