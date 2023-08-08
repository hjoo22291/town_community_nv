package Dto;

import org.springframework.stereotype.Component;

@Component
public class PointDTO { //안휘주 작성
	
	int point_id;
	String member_id, point_method;
	int point_get;
	String point_time;
	public int getPoint_id() {
		return point_id;
	}
	public void setPoint_id(int point_id) {
		this.point_id = point_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPoint_method() {
		return point_method;
	}
	public void setPoint_method(String point_method) {
		this.point_method = point_method;
	}
	public int getPoint_get() {
		return point_get;
	}
	public void setPoint_get(int point_get) {
		this.point_get = point_get;
	}
	public String getPoint_time() {
		return point_time;
	}
	public void setPoint_time(String point_time) {
		this.point_time = point_time;
	}
	
	
	
	
}
