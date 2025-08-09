package com.klu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.klu.entity.Accessory;
import com.klu.entity.AccessoryVisibility;

@Repository
public interface AccessoryRepo extends JpaRepository<Accessory, Integer> {

    @Query("SELECT a FROM Accessory a WHERE a.visibleToAll = true OR EXISTS (SELECT av FROM AccessoryVisibility av WHERE av.accessory.id = a.id AND av.user.id = :userId)")
    List<Accessory> findVisibleAccessoriesForUser(@Param("userId") int userId);

    // New method to find accessories by their availability status
    List<Accessory> findByIsAvailable(Boolean isAvailable);
    
    
}