package com.klu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.klu.entity.Roomates;

@Repository
public interface RoomatesRepo extends JpaRepository<Roomates, Integer> {
    
    @Query("SELECT m.name FROM Roomates m WHERE m.password = :pass AND m.name = :nm")
    String getid(@Param("pass") int pass, @Param("nm") String nm);
    
    @Query("SELECT m.id FROM Roomates m WHERE m.name = :nm")
    Integer fid(@Param("nm") String nm);
    
}