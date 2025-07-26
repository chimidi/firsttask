package com.klu.manger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klu.repository.RoomatesRepo;


@Service
public class Roomatesmodel {
	
	@Autowired
	RoomatesRepo pr;
	
	public String getname(int pass,String name)
	{
		return pr.getid(pass, name);
	}


}
