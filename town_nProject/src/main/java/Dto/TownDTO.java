package Dto;

import org.springframework.stereotype.Component;

@Component
public class TownDTO {
	int town_id;
	String town_name, address;
	public int getTown_id() {
		return town_id;
	}
	public void setTown_id(int town_id) {
		this.town_id = town_id;
	}
	public String getTown_name() {
		return town_name;
	}
	public void setTown_name(String town_name) {
		this.town_name = town_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
