package Dto;

import org.springframework.stereotype.Component;

@Component
public class GoodHateDTO {
	boolean good, hate;
	int board_id, comment_id;
	String member_id;
	
	public boolean isGood() {
		return good;
	}
	public void setGood(boolean good) {
		this.good = good;
	}
	public boolean isHate() {
		return hate;
	}
	public void setHate(boolean hate) {
		this.hate = hate;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	
}
