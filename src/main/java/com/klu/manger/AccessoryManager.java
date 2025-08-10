package com.klu.manger;

import com.klu.dto.AccessoryCreationRequest;
import com.klu.entity.Accessory;
import com.klu.entity.AccessoryVisibility;
import com.klu.entity.Items;
import com.klu.entity.Roomates;
import com.klu.repository.AccessoryRepo;
import com.klu.repository.AccessoryVisibilityRepository;
import com.klu.repository.RoomatesRepo;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.fasterxml.jackson.core.JsonProcessingException;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.Optional;

@Service
public class AccessoryManager {

    @Autowired
    private AccessoryRepo accessoryRepo;

    @Autowired
    private RoomatesRepo roomatesRepository;
    
    @Autowired
    private Roomatesmodel rm;

    @Autowired
    private AccessoryVisibilityRepository accessoryVisibilityRepository;

    public String getVisibleAccessories(int userId) {
        List<Accessory> visibleAccessories = accessoryRepo.findVisibleAccessoriesForUser(userId);
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(visibleAccessories);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "[]";
        }
    }

    // This method already exists and marks as unavailable.
    public String updateAccessoryAvailability(int accessoryId, boolean isAvailable) {
        Optional<Accessory> optionalAccessory = accessoryRepo.findById(accessoryId);
        if (optionalAccessory.isPresent()) {
            Accessory accessory = optionalAccessory.get();
            accessory.setAvailable(isAvailable);
            accessoryRepo.save(accessory);
            return "successfull";
        } else {
            return "NoSuchElementException: Accessory with ID " + accessoryId + " not found.";
        }
    }

    public String createAccessory(AccessoryCreationRequest request, Integer loggedInUserId) {
        try {
            Accessory newAccessory = new Accessory();
            newAccessory.setName(request.getName());
            newAccessory.setAvailable(request.isAvailable());
            newAccessory.setVisibleToAll(request.isVisibleToAll());

            Roomates purchaser = roomatesRepository.findById(request.getPurchasedBy())
                                                   .orElseThrow(() -> new NoSuchElementException("Purchaser not found with ID: " + request.getPurchasedBy()));
            newAccessory.setPurchasedBy(purchaser);

            Accessory savedAccessory = accessoryRepo.save(newAccessory);

            if (!request.isVisibleToAll() && request.getVisibleToUsers() != null && !request.getVisibleToUsers().isEmpty()) {
                Set<AccessoryVisibility> accessoryVisibilities = new HashSet<>();
                for (Integer userId : request.getVisibleToUsers()) {
                    Roomates visibleToUser = roomatesRepository.findById(userId)
                                                               .orElseThrow(() -> new NoSuchElementException("User for visibility not found with ID: " + userId));

                    AccessoryVisibility accessoryVisibility = new AccessoryVisibility();
                    accessoryVisibility.setAccessory(savedAccessory);
                    accessoryVisibility.setUser(visibleToUser);
                    accessoryVisibilities.add(accessoryVisibility);
                }
                accessoryVisibilityRepository.saveAll(accessoryVisibilities);
            }

            return "successfull";
        } catch (NoSuchElementException e) {
            return "Error: " + e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            return "Failed to create accessory: " + e.getMessage();
        }
    }

    @Transactional
    public String makeAvailable(int accessoryId) {
        try {
            Optional<Accessory> accessoryOptional = accessoryRepo.findById(accessoryId);
            if (accessoryOptional.isPresent()) {
                Accessory accessory = accessoryOptional.get();
                accessory.setAvailable(true);
                accessoryRepo.save(accessory);
                return "success";
            } else {
                return "not_found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    // New method to get all unavailable accessories
    public List<Accessory> getUnavailableAccessories() {
        return accessoryRepo.findByIsAvailable(false);
    }
    
    public List<String> getunv(int userId) {
        List<String> list = new ArrayList<String>();
		for(Accessory u:accessoryRepo.findUnavailableAccessoriesForUser(userId) )
			list.add(toJsonString(u));
		return list;
    }
    
    public int counta(int id)
    {
    	int i=0;
    	for(Accessory u:accessoryRepo.findUnavailableAccessoriesForUser(id) )
			i++;
    	return i;
    }
    
    public String toJsonString(Object obj)
	{
		GsonBuilder gbuilder = new GsonBuilder();
		Gson gson = gbuilder.create();
		return gson.toJson(obj);
	}
    
    @Transactional
    public String makeAvailableForAccessory(Integer accessoryId, Integer userId) {
        try {
            // Find the accessory item by its ID
            Optional<Accessory> accessoryOptional = accessoryRepo.findById(accessoryId);
            // Find the roomate by their ID
            Roomates roomate = rm.getroomate(userId);

            // Check if both the accessory item and the roomate exist
            if (accessoryOptional.isPresent() && roomate != null) {
                Accessory accessory = accessoryOptional.get();
                // Update the status and purchasedBy fields
                accessory.setAvailable(true);
                accessory.setPurchasedBy(roomate);
                // Save the updated accessory item to the database
                accessoryRepo.save(accessory);
                return "success";
            } else {
                return "not_found";
            }
        } catch (Exception e) {
            // Log the exception for debugging purposes
            e.printStackTrace();
            return "error";
        }
    }
    
    
}