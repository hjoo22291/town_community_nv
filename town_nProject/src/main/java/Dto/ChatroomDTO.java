package Dto;

import org.springframework.stereotype.Component;

@Component
public class ChatroomDTO {
	int chat_id;
	String chatroom_createdAt, chatroom_updatedAt;
	
	public int getChat_id() {
		return chat_id;
	}
	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}
	
	public String getChatroom_createdAt() {
		return chatroom_createdAt;
	}
	public void setChatroom_createdAt(String chatroom_createdAt) {
		this.chatroom_createdAt = chatroom_createdAt;
	}
	public String getChatroom_updatedAt() {
		return chatroom_updatedAt;
	}
	public void setChatroom_updatedAt(String chatroom_updatedAt) {
		this.chatroom_updatedAt = chatroom_updatedAt;
	}
}
