package com.klu.repository;

import java.util.List; 

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.klu.entity.Items;
@Repository
public interface ItemRepo extends JpaRepository<Items, Integer> {

	@Query("SELECT i FROM Items i " +
	           "LEFT JOIN ItemVisibility iv ON i.id = iv.item.id " +
	           "WHERE i.visibleToAll = true OR iv.user.id = :userId")
	    List<Items> findVisibleItemsForUser(@Param("userId") int userId);
	
	// In ItemRepo.java
	List<Items> findByIsAvailable(Boolean isAvailable);
	Integer countByIsAvailable(Boolean isAvailable);
	
	@Query("SELECT i FROM Items i " +
	           "LEFT JOIN ItemVisibility iv ON i.id = iv.item.id " +
	           "WHERE (i.visibleToAll = true OR iv.user.id = :userId) AND i.isAvailable = false")
	    List<Items> findUnavailableItemsForUser(@Param("userId") int userId); // Changed method name to be more descriptive

	
	
	
}