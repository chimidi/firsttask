package com.klu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.klu.entity.ItemVisibility;
import com.klu.entity.Items;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import jakarta.transaction.Transactional;


@Repository
public interface ItemVisibilityRepo extends JpaRepository<ItemVisibility, Integer> {
    @Modifying
    @Transactional
    @Query("DELETE FROM ItemVisibility iv WHERE iv.item = :item")
    void deleteByItem(@Param("item") Items item);
}