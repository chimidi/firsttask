package com.klu.manger;

import com.klu.repository.NoteRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

/**
 * Service for managing notes, including a scheduled task for deletion.
 */
@Service
public class NoteService {

    @Autowired
    private NoteRepo noteRepo;

    /**
     * Scheduled task to delete notes older than 24 hours.
     * This method runs once every hour.
     */
    @Scheduled(fixedRate = 3600000) // 1 hour in milliseconds
    public void deleteOldNotes() {
        LocalDateTime twentyFourHoursAgo = LocalDateTime.now().minusHours(24);
        noteRepo.deleteByCreationTimestampBefore(twentyFourHoursAgo);
        System.out.println("Deleted old notes at: " + LocalDateTime.now());
    }
}
