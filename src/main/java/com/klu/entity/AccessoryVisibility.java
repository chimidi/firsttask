package com.klu.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "accessory_visibility") // Maps to the 'accessory_visibility' table
public class AccessoryVisibility {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne // Many visibility records for one accessory
    @JoinColumn(name = "accessory_id") // Foreign key to 'accessories' table
    private Accessory accessory;

    @ManyToOne // Many visibility records for one user
    @JoinColumn(name = "user_id") // Foreign key to 'roomates' table
    private Roomates user;

    // --- Getters and Setters ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Accessory getAccessory() {
        return accessory;
    }

    public void setAccessory(Accessory accessory) {
        this.accessory = accessory;
    }

    public Roomates getUser() {
        return user;
    }

    public void setUser(Roomates user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "AccessoryVisibility [id=" + id + ", accessory=" + accessory + ", user=" + user + "]";
    }
}