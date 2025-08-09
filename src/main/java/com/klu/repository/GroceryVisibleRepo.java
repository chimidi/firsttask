package com.klu.repository;
import com.klu.entity.GroceryVisible; // Adjust package
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GroceryVisibleRepo extends JpaRepository<GroceryVisible, Integer> { // Changed to Integer
}