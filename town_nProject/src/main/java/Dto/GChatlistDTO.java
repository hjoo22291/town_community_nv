package Dto;

import org.springframework.stereotype.Component;

@Component
public class GChatlistDTO {
	int gchat_id;
	String member_id;
	int board_id;
	String chatroom_name;
	String latest_gcontent;
	int gchat_list_uuid;
	
	public int getGchat_list_uuid() {
		return gchat_list_uuid;
	}
	public void setGchat_list_uuid(int gchat_list_uuid) {
		this.gchat_list_uuid = gchat_list_uuid;
	}
	public String getLatest_gcontent() {
		return latest_gcontent;
	}
	public void setLatest_gcontent(String latest_gcontent) {
		this.latest_gcontent = latest_gcontent;
	}
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
