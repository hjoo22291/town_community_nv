package Dto;

import org.springframework.stereotype.Component;

@Component
public class ChatlistDTO {
	String member_id;
	int chat_id;
	String to_id;
	int totalisread;
	String latest_content;
	
	public int getTotalisread() {
		return totalisread;
	}
	public void setTotalisread(int totalisread) {
		this.totalisread = totalisread;
	}
	public String getLatest_content() {
		return latest_content;
	}
	public void setLatest_content(String latest_content) {
		this.latest_content = latest_content;
	}
	public String getTo_id() {
		return to_id;
	}
	public void setTo_id(String to_id) {
		this.to_id = to_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getChat_id() {
		return chat_id;
	}
	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}
}
