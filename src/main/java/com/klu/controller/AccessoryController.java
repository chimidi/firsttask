package com.klu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.klu.dto.AccessoryCreationRequest;
import com.klu.manger.AccessoryManager;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/accessories") // Base path for all accessory endpoints
@CrossOrigin(origins = "https://firsttask-jmub.onrender.com", allowCredentials = "true")
public class AccessoryController {

    @Autowired
    private AccessoryManager accessoryManager;

    @GetMapping
    public String getAccessories(HttpSession session) {
        Integer id = (Integer) session.getAttribute("id");
        if (id == null) {
            // Consider returning an HTTP status like 401 Unauthorized here
            // instead of an empty array, or redirect to login.
            return "[]"; 
        }
        return accessoryManager.getVisibleAccessories(id); 
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateAccessoryAvailability(@PathVariable("id") int id) {
        try {
            String result = accessoryManager.updateAccessoryAvailability(id, false);
            if ("successfull".equals(result)) {
                return new ResponseEntity<>("Accessory marked as not available successfully!", HttpStatus.OK);
            } else if (result.contains("NoSuchElementException")) {
                return new ResponseEntity<>("Accessory with ID " + id + " not found.", HttpStatus.NOT_FOUND);
            } else {
                return new ResponseEntity<>("Failed to update accessory: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // NEW: Endpoint to make an accessory available
    @PutMapping("/makeAvailable/{id}")
    public ResponseEntity<String> makeAccessoryAvailable(@PathVariable("id") int id) {
        try {
            String result = accessoryManager.makeAvailable(id);
            if ("success".equals(result)) {
                return new ResponseEntity<>("Accessory marked as available successfully!", HttpStatus.OK);
            } else if ("not_found".equals(result)) {
                return new ResponseEntity<>("Accessory with ID " + id + " not found.", HttpStatus.NOT_FOUND);
            } else {
                return new ResponseEntity<>("Failed to make accessory available: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping
    public ResponseEntity<String> createAccessory(@RequestBody AccessoryCreationRequest request, HttpSession session) {
        try {
            Integer loggedInUserId = (Integer) session.getAttribute("id");
            if (loggedInUserId == null) {
                return new ResponseEntity<>("User not logged in.", HttpStatus.UNAUTHORIZED);
            }

            String result = accessoryManager.createAccessory(request, loggedInUserId);

            if ("successfull".equals(result)) {
                return new ResponseEntity<>("Accessory added successfully!", HttpStatus.CREATED);
            } else {
                return new ResponseEntity<>("Failed to add accessory: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred while adding accessory: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}