package com.klu.entity;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "accessories") // Maps to the 'accessories' table
public class Accessory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    private boolean isAvailable;

    private boolean visibleToAll;
    
    @ManyToOne // Many accessories can be purchased by one roommate
    @JoinColumn(name = "purchased_by") // Foreign key column in 'accessories' table
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"}) // Avoid lazy loading issues in JSON
    private Roomates purchasedBy;

    @Transient // Not persisted in the database, used for frontend logic
    private boolean visibleToCurrentUser;

    // --- Getters and Setters ---
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isAvailable() {
		return isAvailable;
	}

	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

	public boolean isVisibleToAll() {
		return visibleToAll;
	}

	public void setVisibleToAll(boolean visibleToAll) {
		this.visibleToAll = visibleToAll;
	}

	public Roomates getPurchasedBy() {
		return purchasedBy;
	}

	public void setPurchasedBy(Roomates purchasedBy) {
		this.purchasedBy = purchasedBy;
	}

	public boolean isVisibleToCurrentUser() {
		return visibleToCurrentUser;
	}

	public void setVisibleToCurrentUser(boolean visibleToCurrentUser) {
		this.visibleToCurrentUser = visibleToCurrentUser;
	}
    
	@Override
	public String toString() {
		return "Accessory [id=" + id + ", name=" + name + ", isAvailable=" + isAvailable + ", visibleToAll=" + visibleToAll
				+ ", purchasedBy=" + purchasedBy + ", visibleToCurrentUser=" + visibleToCurrentUser + "]";
	}
}