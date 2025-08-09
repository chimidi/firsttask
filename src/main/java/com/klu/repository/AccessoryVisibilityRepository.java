package com.klu.repository;

import com.klu.entity.AccessoryVisibility; // Using the new AccessoryVisibility entity
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccessoryVisibilityRepository extends JpaRepository<AccessoryVisibility, Integer> {
}