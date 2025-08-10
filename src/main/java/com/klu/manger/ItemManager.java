package com.klu.manger;

import com.klu.dto.ItemCreationRequest;
import com.klu.entity.Items;
import com.klu.entity.ItemVisibility;
import com.klu.entity.Roomates;
import com.klu.repository.ItemRepo;
import com.klu.repository.ItemVisibilityRepo;
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
public class ItemManager {

    @Autowired
    private ItemRepo itemRepo;

    @Autowired
    private RoomatesRepo roomatesRepository;

    @Autowired
    private ItemVisibilityRepo itemVisibilityRepository;

    @Autowired
    private Roomatesmodel roomatesmodel;

    public String getname(int password, String name) {
        return roomatesmodel.getname(password, name);
    }

    public int getid(String name) {
        return roomatesmodel.getid(name);
    }

    public String itemlist(int userId) {
        List<Items> visibleItems = itemRepo.findVisibleItemsForUser(userId);
        
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(visibleItems);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "[]";
        }
    }

    public String update_visable(int itemId, boolean isAvailable) {
        Optional<Items> optionalItem = itemRepo.findById(itemId);
        if (optionalItem.isPresent()) {
            Items item = optionalItem.get();
            item.setAvailable(isAvailable);
            itemRepo.save(item);
            return "successfull";
        } else {
            return "NoSuchElementException: Item with ID " + itemId + " not found.";
        }
    }

    public String createItem(ItemCreationRequest request, Integer loggedInUserId) {
        try {
            Items newItem = new Items();
            newItem.setName(request.getName());
            newItem.setAvailable(request.isAvailable());
            newItem.setVisibleToAll(request.isVisibleToAll());

            Roomates purchaser = roomatesRepository.findById(request.getPurchasedBy())
                                                   .orElseThrow(() -> new NoSuchElementException("Purchaser not found with ID: " + request.getPurchasedBy()));
            newItem.setPurchasedBy(purchaser);

            Items savedItem = itemRepo.save(newItem);

            if (!request.isVisibleToAll() && request.getVisibleToUsers() != null && !request.getVisibleToUsers().isEmpty()) {
                Set<ItemVisibility> itemVisibilities = new HashSet<>();
                for (Integer userId : request.getVisibleToUsers()) {
                    Roomates visibleToUser = roomatesRepository.findById(userId)
                                                               .orElseThrow(() -> new NoSuchElementException("User for visibility not found with ID: " + userId));

                    ItemVisibility itemVisibility = new ItemVisibility();
                    itemVisibility.setItem(savedItem);
                    itemVisibility.setUser(visibleToUser);
                    itemVisibilities.add(itemVisibility);
                }
                itemVisibilityRepository.saveAll(itemVisibilities);
            }

            return "successfull";
        } catch (NoSuchElementException e) {
            return "Error: " + e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            return "Failed to create item: " + e.getMessage();
        }
    }
    
    @Transactional
    public String makeAvailable(int itemId) {
        try {
            Optional<Items> itemOptional = itemRepo.findById(itemId);
            if (itemOptional.isPresent()) {
                Items item = itemOptional.get();
                item.setAvailable(true);
                itemRepo.save(item);
                return "success";
            } else {
                return "not_found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    
    @Transactional
    public String makeAvailable1(int itemId, int userId) {
        try {
            Optional<Items> itemOptional = itemRepo.findById(itemId);
            Optional<Roomates> userOptional = roomatesRepository.findById(userId);

            if (itemOptional.isPresent() && userOptional.isPresent()) {
                Items item = itemOptional.get();
                Roomates purchasedBy = userOptional.get();
                
                // Set the item to be available and assign the purchaser
                item.setAvailable(true);
                item.setPurchasedBy(purchasedBy);
                
                itemRepo.save(item);
                return "success";
            } else {
                return "not_found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
    public List<String> getunv(int userId) {
        List<String> list = new ArrayList<String>();
		for(Items u:itemRepo.findUnavailableItemsForUser(userId) ) {
			list.add(toJsonString(u));
		}
		return list;
    }
    
    public String toJsonString(Object obj)
	{
		GsonBuilder gbuilder = new GsonBuilder();
		Gson gson = gbuilder.create();
		return gson.toJson(obj);
	}
    
    public int count(int userId)
    {
    	int c=0;
    	for(Items u:itemRepo.findUnavailableItemsForUser(userId) ) {
			c++;
		}
    	return c;
    }
	
}