package com.klu.dto; // Adjust package

import java.util.List;

public class GroceryRequest {
    private String name;
    private Boolean isAvailable;
    private Boolean visibleToAll;
    private Integer purchasedBy; // Changed to Integer (Roomate ID)
    private List<Integer> visibleToRoomates; // Changed to Integer (List of Roomate IDs)

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(Boolean available) { isAvailable = available; }
    public Boolean getVisibleToAll() { return visibleToAll; }
    public void setVisibleToAll(Boolean visibleToAll) { this.visibleToAll = visibleToAll; }
    public Integer getPurchasedBy() { return purchasedBy; } // Changed to Integer
    public void setPurchasedBy(Integer purchasedBy) { this.purchasedBy = purchasedBy; } // Changed to Integer
    public List<Integer> getVisibleToRoomates() { return visibleToRoomates; } // Changed to Integer
    public void setVisibleToRoomates(List<Integer> visibleToRoomates) { this.visibleToRoomates = visibleToRoomates; } // Changed to Integer
}