package Dto;

import org.springframework.stereotype.Component;

@Component
public class MessageDTO {
	int message_id;
	String message_content, message_sendAt;
	String member_id;
	int chat_id;
	String touser_id;
	int isread;
	
	public int getIsread() {
		return isread;
	}
	public void setIsread(int isread) {
		this.isread = isread;
	}
	public String getTouser_id() {
		return touser_id;
	}
	public void setTouser_id(String touser_id) {
		this.touser_id = touser_id;
	}
	public int getMessage_id() {
		return message_id;
	}
	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public String getMessage_sendAt() {
		return message_sendAt;
	}
	public void setMessage_sendAt(String message_sendAt) {
		this.message_sendAt = message_sendAt;
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
