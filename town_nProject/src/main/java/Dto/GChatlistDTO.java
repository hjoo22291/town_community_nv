package Dto;

import org.springframework.stereotype.Component;

@Component
public class GChatlistDTO {
	int gchat_id;
	String member_id;
	int board_id;
	String chatroom_name;
	
	public String getChatroom_name() {
		return chatroom_name;
	}
	public void setChatroom_name(String chatroom_name) {
		this.chatroom_name = chatroom_name;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getGchat_id() {
		return gchat_id;
	}
	public void setGchat_id(int gchat_id) {
		this.gchat_id = gchat_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
}
