package com.klu.repository; // Note: Your package is com.klu.repository, not com.klu.repo based on the error. Please ensure consistency.

import com.klu.entity.Grocery; // Adjust package
import com.klu.entity.Items;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.security.PublicKey;
import java.util.List;

@Repository
public interface GroceryRepo extends JpaRepository<Grocery, Integer> {

    // Removed: List<Grocery> findByVisibleToAllTrueOrVisibleToRoomates_Roomate_Id(Boolean visibleToAll, Integer roomateId);

    // New method to find groceries where visibleToAll is true
    List<Grocery> findByVisibleToAllTrue();

    // New method to find groceries specifically visible to a given roomate ID
    List<Grocery> findByVisibleToRoomates_Roomate_Id(Integer roomateId);
    
    List<Grocery> findByIsAvailable(Boolean isAvailable);
	Integer countByIsAvailable(Boolean isAvailable);
    


    @Query("SELECT g FROM Grocery g WHERE g.isAvailable = false AND (g.visibleToAll = true OR EXISTS (SELECT gv FROM GroceryVisible gv WHERE gv.grocery.id = g.id AND gv.roomate.id = :userId))")
    List<Grocery> findUnavailableGroceriesForUser(@Param("userId") int userId);
 // Changed method name to be more descriptive

		
 
}