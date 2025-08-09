package com.klu.entity; // Adjust package

import com.klu.entity.Roomates; // Import your Roomates class
import jakarta.persistence.*;

@Entity
@Table(name = "groceries_visible")
public class GroceryVisible {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id; // Changed to Integer

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "grocery_id", nullable = false)
    private Grocery grocery;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "roomate_id", nullable = false) // Changed column name
    private Roomates roomate; // Changed to Roomates

    // Constructors
    public GroceryVisible() {}

    public GroceryVisible(Grocery grocery, Roomates roomate) { // Changed parameter type
        this.grocery = grocery;
        this.roomate = roomate;
    }

    // Getters and Setters
    public Integer getId() { return id; } // Changed to Integer
    public void setId(Integer id) { this.id = id; } // Changed to Integer
    public Grocery getGrocery() { return grocery; }
    public void setGrocery(Grocery grocery) { this.grocery = grocery; }
    public Roomates getRoomate() { return roomate; } // Changed to Roomates
    public void setRoomate(Roomates roomate) { this.roomate = roomate; } // Changed to Roomates

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        GroceryVisible that = (GroceryVisible) o;
        // Use getId() for comparison if Roomates's equals/hashCode isn't overridden based on ID
        return grocery.equals(that.grocery) && roomate.equals(that.roomate);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(grocery, roomate);
    }
}