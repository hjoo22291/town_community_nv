package Dto;

import org.springframework.stereotype.Component;

@Component
public class CommentDTO {
	int comment_id;
	String comment_writer, comment_contents, comment_time, comment_updateTime, comment_imgurl;
	boolean printout, comment_secret;
	int parent_id, board_id;
	
	
	public boolean isComment_secret() {
		return comment_secret;
	}
	public void setComment_secret(boolean comment_secret) {
		this.comment_secret = comment_secret;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public String getComment_writer() {
		return comment_writer;
	}
	public void setComment_writer(String comment_writer) {
		this.comment_writer = comment_writer;
	}
	public String getComment_contents() {
		return comment_contents;
	}
	public void setComment_contents(String comment_contents) {
		this.comment_contents = comment_contents;
	}
	public String getComment_time() {
		return comment_time;
	}
	public void setComment_time(String comment_time) {
		this.comment_time = comment_time;
	}
	public String getComment_updateTime() {
		return comment_updateTime;
	}
	public void setComment_updateTime(String comment_updateTime) {
		this.comment_updateTime = comment_updateTime;
	}
	public String getComment_imgurl() {
		return comment_imgurl;
	}
	public void setComment_imgurl(String comment_imgurl) {
		this.comment_imgurl = comment_imgurl;
	}
	public boolean isPrintout() {
		return printout;
	}
	public void setPrintout(boolean printout) {
		this.printout = printout;
	}
	public int getParent_id() {
		return parent_id;
	}
	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	
	

	
	
}
