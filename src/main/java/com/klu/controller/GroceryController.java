package com.klu.controller; // Adjust package

import com.klu.dto.GroceryRequest; // Adjust package
import com.klu.dto.GroceryResponse; // Adjust package
import com.klu.manger.GroceryManager; // Adjust package
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/groceries")
public class GroceryController {

    @Autowired
    private GroceryManager groceryManager;

    @PostMapping
    public ResponseEntity<GroceryResponse> addGrocery(@RequestBody GroceryRequest request) {
        GroceryResponse response = groceryManager.createGrocery(request);
        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<List<GroceryResponse>> getGroceries() {
        List<GroceryResponse> groceries = groceryManager.getAllGroceriesVisibleToRoomate(); // Changed method call
        return ResponseEntity.ok(groceries);
    }

    @PutMapping("/{id}/unavailable")
    public ResponseEntity<GroceryResponse> markGroceryUnavailable(@PathVariable Integer id) { // Changed to Integer
        GroceryResponse response = groceryManager.markGroceryUnavailable(id);
        return ResponseEntity.ok(response);
    }

    // NEW: Endpoint to make a grocery available
    @PutMapping("/makeAvailable/{id}")
    public ResponseEntity<String> makeGroceryAvailable(@PathVariable Integer id) {
        try {
            String result = groceryManager.makeAvailable(id);
            if ("success".equals(result)) {
                return new ResponseEntity<>("Grocery marked as available successfully!", HttpStatus.OK);
            } else if ("not_found".equals(result)) {
                return new ResponseEntity<>("Grocery with ID " + id + " not found.", HttpStatus.NOT_FOUND);
            } else {
                return new ResponseEntity<>("Failed to make grocery available: " + result, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("An unexpected error occurred: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}