package com.klu.manger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klu.entity.Roomates;
import com.klu.repository.RoomatesRepo;


@Service
public class Roomatesmodel {
	
	@Autowired
	RoomatesRepo pr;
	
	public String getname(int pass,String name)
	{
		return pr.getid(pass, name);
	}
	
	public int getid(String name)
	{
		return pr.fid(name);
	}
    
	public Roomates getroomate(Integer userId) {
        // The findById method returns an Optional, so we use orElse(null)
        // to return the Roomates object or null if it's not present.
        return pr.findById(userId).orElse(null);
    }

}
