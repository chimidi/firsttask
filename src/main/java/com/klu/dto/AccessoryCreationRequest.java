package com.klu.dto;

import java.util.Set;

public class AccessoryCreationRequest {
    private String name;
    private boolean isAvailable;
    private boolean visibleToAll;
    private Integer purchasedBy; // ID of the Roomate who purchased it
    private Set<Integer> visibleToUsers; // IDs of specific roommates for visibility

    // --- Getters and Setters ---
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public boolean isVisibleToAll() {
        return visibleToAll;
    }

    public void setVisibleToAll(boolean visibleToAll) {
        this.visibleToAll = visibleToAll;
    }

    public Integer getPurchasedBy() {
        return purchasedBy;
    }

    public void setPurchasedBy(Integer purchasedBy) {
        this.purchasedBy = purchasedBy;
    }

    public Set<Integer> getVisibleToUsers() {
        return visibleToUsers;
    }

    public void setVisibleToUsers(Set<Integer> visibleToUsers) {
        this.visibleToUsers = visibleToUsers;
    }

    @Override
    public String toString() {
        return "AccessoryCreationRequest{" +
               "name='" + name + '\'' +
               ", isAvailable=" + isAvailable +
               ", visibleToAll=" + visibleToAll +
               ", purchasedBy=" + purchasedBy +
               ", visibleToUsers=" + visibleToUsers +
               '}';
    }
}