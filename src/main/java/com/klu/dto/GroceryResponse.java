package com.klu.dto; // Adjust package

public class GroceryResponse {
    private Integer id; // Changed to Integer
    private String name;
    private Boolean isAvailable;
    private String purchasedBy; // Name of the purchaser

    // Constructor
    public GroceryResponse(Integer id, String name, Boolean isAvailable, String purchasedBy) { // Changed to Integer
        this.id = id;
        this.name = name;
        this.isAvailable = isAvailable;
        this.purchasedBy = purchasedBy;
    }

    // Getters and Setters
    public Integer getId() { return id; } // Changed to Integer
    public void setId(Integer id) { this.id = id; } // Changed to Integer
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(Boolean available) { isAvailable = available; }
    public String getPurchasedBy() { return purchasedBy; }
    public void setPurchasedBy(String purchasedBy) { this.purchasedBy = purchasedBy; }
}