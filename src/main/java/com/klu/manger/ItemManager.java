package com.klu.manger;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.klu.entity.Items;
import com.klu.repository.ItemRepo;

@Service
public class ItemManager {
	
	
	@Autowired
	ItemRepo ir;
	
	public List<String> itemlist(int id) {
		List<String> list = new ArrayList<String>();
		for(Items u:ir.findVisibleItemsForUser(id))
			list.add(toJsonString(u));
		return list;
	}
	
	public String toJsonString(Object obj)
	{
		GsonBuilder gbuilder = new GsonBuilder();
		Gson gson = gbuilder.create();
		return gson.toJson(obj);
	}

}
