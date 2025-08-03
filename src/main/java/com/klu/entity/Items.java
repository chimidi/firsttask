package com.klu.entity;

import jakarta.persistence.*;
@Entity
@Table(name = "items")
public class Items {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    private boolean isAvailable;

    private boolean visibleToAll;

    
    @ManyToOne
    @JoinColumn(name = "purchased_by")
    private Roomates purchasedBy;

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
    @Transient
    private boolean visibleToCurrentUser;

	@Override
	public String toString() {
		return "Items [id=" + id + ", name=" + name + ", isAvailable=" + isAvailable + ", visibleToAll=" + visibleToAll
				+ ", purchasedBy=" + purchasedBy + ", visibleToCurrentUser=" + visibleToCurrentUser + "]";
	}
    
    
    
}
