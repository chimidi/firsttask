package com.klu.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "item_visibility")
public class ItemVisibility {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "item_id")
    private Items item;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private Roomates user;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Items getItem() {
        return item;
    }

    public void setItem(Items item) {
        this.item = item;
    }

    public Roomates getUser() {
        return user;
    }

    public void setUser(Roomates user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "ItemVisibility [id=" + id + ", item=" + item + ", user=" + user + "]";
    }
}
