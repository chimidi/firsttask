package com.klu.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "groceries")
public class Grocery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;

    // The column definition has been changed to 'BOOLEAN' to be compatible with PostgreSQL.
    @Column(name = "is_available", columnDefinition = "BOOLEAN")
    private Boolean isAvailable;

    // The column definition has been changed to 'BOOLEAN' to be compatible with PostgreSQL.
    @Column(name = "visible_to_all", columnDefinition = "BOOLEAN")
    private Boolean visibleToAll;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchased_by_roomate_id")
    private Roomates purchasedBy;

    @OneToMany(mappedBy = "grocery", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<GroceryVisible> visibleToRoomates = new HashSet<>();

    // This column definition is correct for PostgreSQL.
    @Column(name = "created_at", updatable = false, columnDefinition = "TIMESTAMP")
    private LocalDateTime createdAt;

    // This column definition is correct for PostgreSQL.
    @Column(name = "updated_at", columnDefinition = "TIMESTAMP")
    private LocalDateTime updatedAt;

    // Constructors
    public Grocery() {
        this.isAvailable = true;
        this.visibleToAll = true;
    }

    public Grocery(String name, Boolean isAvailable, Boolean visibleToAll, Roomates purchasedBy) {
        this.name = name;
        this.isAvailable = isAvailable;
        this.visibleToAll = visibleToAll;
        this.purchasedBy = purchasedBy;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(Boolean available) { isAvailable = available; }
    public Boolean getVisibleToAll() { return visibleToAll; }
    public void setVisibleToAll(Boolean visibleToAll) { this.visibleToAll = visibleToAll; }
    public Roomates getPurchasedBy() { return purchasedBy; }
    public void setPurchasedBy(Roomates purchasedBy) { this.purchasedBy = purchasedBy; }
    public Set<GroceryVisible> getVisibleToRoomates() { return visibleToRoomates; }
    public void setVisibleToRoomates(Set<GroceryVisible> visibleToRoomates) { this.visibleToRoomates = visibleToRoomates; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Helper to add/remove roomates for specific visibility
    public void addVisibleRoomate(Roomates roomate) {
        GroceryVisible gv = new GroceryVisible(this, roomate);
        this.visibleToRoomates.add(gv);
    }

    public void removeVisibleRoomate(Roomates roomate) {
        this.visibleToRoomates.removeIf(gv -> gv.getRoomate().equals(roomate));
    }

    @Override
    public String toString() {
        return "Grocery{" +
               "id=" + id +
               ", name='" + name + '\'' +
               ", isAvailable=" + isAvailable +
               ", visibleToAll=" + visibleToAll +
               ", purchasedBy=" + (purchasedBy != null ? purchasedBy.getName() : "null") +
               '}';
    }
}
