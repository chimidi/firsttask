package com.klu.manger;

import com.klu.entity.Grocery;
import com.klu.entity.GroceryVisible;
import com.klu.entity.Items;
import com.klu.entity.Roomates;
import com.klu.repository.GroceryRepo;
import com.klu.repository.GroceryVisibleRepo;
import com.klu.repository.RoomatesRepo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.klu.dto.GroceryRequest;
import com.klu.dto.GroceryResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.stream.Collectors;

@Service
public class GroceryManager {

    @Autowired
    private GroceryRepo groceryRepo;

    @Autowired
    private RoomatesRepo roomatesRepo;

    @Autowired
    private GroceryVisibleRepo groceryVisibleRepo;

    private Integer getLoggedInRoomateId() {
        // This is a placeholder. In a real app, you'd get this from your session management.
        return 1; // Replace with actual logged-in roomate ID retrieval
    }

    @Transactional
    public GroceryResponse createGrocery(GroceryRequest request) {
        Roomates purchasedBy = roomatesRepo.findById(request.getPurchasedBy())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Purchaser roomate not found"));

        Grocery grocery = new Grocery();
        grocery.setName(request.getName());
        grocery.setIsAvailable(request.getIsAvailable());
        grocery.setPurchasedBy(purchasedBy);
        grocery.setVisibleToAll(request.getVisibleToAll());

        grocery = groceryRepo.save(grocery);

        if (!request.getVisibleToAll() && request.getVisibleToRoomates() != null) {
            for (Integer roomateId : request.getVisibleToRoomates()) {
                Roomates visibleRoomate = roomatesRepo.findById(roomateId)
                        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Visible roomate not found"));
                grocery.addVisibleRoomate(visibleRoomate);
            }
            groceryRepo.save(grocery);
        }

        return new GroceryResponse(grocery.getId(), grocery.getName(), grocery.getIsAvailable(), grocery.getPurchasedBy().getName());
    }

    @Transactional(readOnly = true)
    public List<GroceryResponse> getAllGroceriesVisibleToRoomate() {
        Integer currentRoomateId = getLoggedInRoomateId();

        if (currentRoomateId == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Roomate not logged in");
        }

        List<Grocery> visibleToAllGroceries = groceryRepo.findByVisibleToAllTrue();
        List<Grocery> visibleToSpecificRoomateGroceries = groceryRepo.findByVisibleToRoomates_Roomate_Id(currentRoomateId);

        Set<Grocery> combinedGroceries = new HashSet<>();
        combinedGroceries.addAll(visibleToAllGroceries);
        combinedGroceries.addAll(visibleToSpecificRoomateGroceries);

        return combinedGroceries.stream()
                .map(g -> new GroceryResponse(g.getId(), g.getName(), g.getIsAvailable(), g.getPurchasedBy() != null ? g.getPurchasedBy().getName() : "Unknown"))
                .collect(Collectors.toList());
    }

    @Transactional
    public GroceryResponse markGroceryUnavailable(Integer groceryId) {
        Grocery grocery = groceryRepo.findById(groceryId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Grocery not found"));

        grocery.setIsAvailable(false);
        grocery = groceryRepo.save(grocery);

        return new GroceryResponse(grocery.getId(), grocery.getName(), grocery.getIsAvailable(), grocery.getPurchasedBy().getName());
    }
    
    @Transactional
    public String makeAvailable(int groceryId) {
        try {
            Optional<Grocery> groceryOptional = groceryRepo.findById(groceryId);
            if (groceryOptional.isPresent()) {
                Grocery grocery = groceryOptional.get();
                grocery.setIsAvailable(true);
                groceryRepo.save(grocery);
                return "success";
            } else {
                return "not_found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    // New method to get all unavailable groceries
    public List<String> getUnavailableGroceries(int id) {
    	 List<String> list = new ArrayList<String>();
    	 try {
 		for(Grocery u:groceryRepo.findUnavailableGroceriesForUser(id) )
 			list.add(toJsonString(u));
 		return list;
    	 }
    	 catch(Exception e)
    	 {
             return List.of(e.toString());
    	 }
     }
    
    
     public String toJsonString(Object obj)
 	{
 		GsonBuilder gbuilder = new GsonBuilder();
 		Gson gson = gbuilder.create();
 		return gson.toJson(obj);
 	}
}