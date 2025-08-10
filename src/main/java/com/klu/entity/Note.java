package com.klu.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Entity representing a note that is visible on the home page.
 * The note is automatically deleted 24 hours after creation.
 */
@Entity
@Table(name = "notes")
public class Note {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Use @Lob to allow for a large text field (more than 255 characters)
    @Lob
    private String text;

    // Fix the SQLSyntaxErrorException by specifying the column definition
    // to use the standard DATETIME type without precision.
    @Column(columnDefinition = "DATETIME")
    private LocalDateTime creationTimestamp;

    // Default constructor
    public Note() {
        this.creationTimestamp = LocalDateTime.now();
    }

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public LocalDateTime getCreationTimestamp() {
        return creationTimestamp;
    }

    public void setCreationTimestamp(LocalDateTime creationTimestamp) {
        this.creationTimestamp = creationTimestamp;
    }
}
