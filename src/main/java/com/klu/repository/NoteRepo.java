package com.klu.repository;

import com.klu.entity.Note;

import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;

/**
 * Repository for the Note entity.
 * Provides methods for standard CRUD operations and a custom query to delete
 * notes older than a specific timestamp.
 */
@Repository
public interface NoteRepo extends JpaRepository<Note, Long> {

    /**
     * Deletes all notes whose creation timestamp is before the specified time.
     * @param timestamp The timestamp to compare against.
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM Note n WHERE n.creationTimestamp < :timestamp")
    void deleteByCreationTimestampBefore(LocalDateTime timestamp);
}
