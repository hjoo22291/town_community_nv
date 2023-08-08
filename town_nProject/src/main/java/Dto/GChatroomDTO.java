package Dto;

import org.springframework.stereotype.Component;

@Component
public class GChatroomDTO {
	int gchat_id;
	String gchatroom_createdAt;
	int board_id;
	
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
	public String getGchatroom_createdAt() {
		return gchatroom_createdAt;
	}
	public void setGchatroom_createdAt(String gchatroom_createdAt) {
		this.gchatroom_createdAt = gchatroom_createdAt;
	}
}
