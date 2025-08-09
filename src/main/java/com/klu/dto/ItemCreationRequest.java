package com.klu.dto;

import java.util.Set;

public class ItemCreationRequest {
    private String name;
    private boolean isAvailable;
    private boolean visibleToAll;
    private Integer purchasedBy; 
    private Set<Integer> visibleToUsers; 

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
        isAvailable = true;
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
        return "ItemCreationRequest{" +
               "name='" + name + '\'' +
               ", isAvailable=" + isAvailable +
               ", visibleToAll=" + visibleToAll +
               ", purchasedBy=" + purchasedBy +
               ", visibleToUsers=" + visibleToUsers +
               '}';
    }
}