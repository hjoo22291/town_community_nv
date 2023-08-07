package Dto;

import org.springframework.stereotype.Component;

@Component
public class ReportDTO { //안휘주 작성
	
	int report_id, board_id, comment_id, message_id, gmessage_id;
	String reported_member_id, reporter, reported_contents, report_reason, report_detail, report_time, report_result, result_time;
	BoardDTO boarddto;
	CommentDTO commentdto;
	MessageDTO messagedto;
	
	public String getResult_time() {
		return result_time;
	}
	public void setResult_time(String result_time) {
		this.result_time = result_time;
	}
	public String getReport_result() {
		return report_result;
	}
	public void setReport_result(String report_result) {
		this.report_result = report_result;
	}
	public BoardDTO getBoarddto() {
		return boarddto;
	}
	public void setBoarddto(BoardDTO boarddto) {
		this.boarddto = boarddto;
	}
	public CommentDTO getCommentdto() {
		return commentdto;
	}
	public void setCommentdto(CommentDTO commentdto) {
		this.commentdto = commentdto;
	}
	public MessageDTO getMessagedto() {
		return messagedto;
	}
	public void setMessagedto(MessageDTO messagedto) {
		this.messagedto = messagedto;
	}
	public int getReport_id() {
		return report_id;
	}
	public void setReport_id(int report_id) {
		this.report_id = report_id;
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
	public int getMessage_id() {
		return message_id;
	}
	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}
	public int getGmessage_id() {
		return gmessage_id;
	}
	public void setGmessage_id(int gmessage_id) {
		this.gmessage_id = gmessage_id;
	}
	public String getReported_member_id() {
		return reported_member_id;
	}
	public void setReported_member_id(String reported_member_id) {
		this.reported_member_id = reported_member_id;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public String getReported_contents() {
		return reported_contents;
	}
	public void setReported_contents(String reported_contents) {
		this.reported_contents = reported_contents;
	}
	public String getReport_reason() {
		return report_reason;
	}
	public void setReport_reason(String report_reason) {
		this.report_reason = report_reason;
	}
	public String getReport_detail() {
		return report_detail;
	}
	public void setReport_detail(String report_detail) {
		this.report_detail = report_detail;
	}
	public String getReport_time() {
		return report_time;
	}
	public void setReport_time(String report_time) {
		this.report_time = report_time;
	}

	
	
}
