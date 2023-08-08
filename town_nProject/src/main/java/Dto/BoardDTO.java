package Dto;

import org.springframework.stereotype.Component;

@Component
public class BoardDTO { //안휘주 작성
	
	int board_id;
	String board_name_inner, board_title, board_contents, board_preview, writing_time, update_time;
	int good_cnt, hate_cnt, view_cnt;
	String board_imgurl, board_videourl, board_fileurl, place_name, place_road_address, place_address, place_tel, place_lat, place_long, writer;
	int town_id, sum;
	boolean printout;
	String comment_writer, comment_contents, comment_time;
	TownDTO town;
	CommentDTO comment;
	
	
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
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
	public String getBoard_preview() {
		return board_preview;
	}
	public void setBoard_preview(String board_preview) {
		this.board_preview = board_preview;
	}
	public String getComment_time() {
		return comment_time;
	}
	public void setComment_time(String comment_time) {
		this.comment_time = comment_time;
	}
	public CommentDTO getComment() {
		return comment;
	}
	public void setComment(CommentDTO comment) {
		this.comment = comment;
	}
	public TownDTO getTown() {
		return town;
	}
	public void setTown(TownDTO town) {
		this.town = town;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getBoard_name_inner() {
		return board_name_inner;
	}
	public void setBoard_name_inner(String board_name_inner) {
		this.board_name_inner = board_name_inner;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_contents() {
		return board_contents;
	}
	public void setBoard_contents(String board_contents) {
		this.board_contents = board_contents;
	}
	public String getWriting_time() {
		return writing_time;
	}
	public void setWriting_time(String writing_time) {
		this.writing_time = writing_time;
	}
	public String getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(String update_time) {
		this.update_time = update_time;
	}
	public int getGood_cnt() {
		return good_cnt;
	}
	public void setGood_cnt(int good_cnt) {
		this.good_cnt = good_cnt;
	}
	public int getHate_cnt() {
		return hate_cnt;
	}
	public void setHate_cnt(int hate_cnt) {
		this.hate_cnt = hate_cnt;
	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public String getBoard_imgurl() {
		return board_imgurl;
	}
	public void setBoard_imgurl(String board_imgurl) {
		this.board_imgurl = board_imgurl;
	}
	public String getBoard_videourl() {
		return board_videourl;
	}
	public void setBoard_videourl(String board_videourl) {
		this.board_videourl = board_videourl;
	}
	public String getBoard_fileurl() {
		return board_fileurl;
	}
	public void setBoard_fileurl(String board_fileurl) {
		this.board_fileurl = board_fileurl;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public String getPlace_road_address() {
		return place_road_address;
	}
	public void setPlace_road_address(String place_road_address) {
		this.place_road_address = place_road_address;
	}
	public String getPlace_address() {
		return place_address;
	}
	public void setPlace_address(String place_address) {
		this.place_address = place_address;
	}
	public String getPlace_tel() {
		return place_tel;
	}
	public void setPlace_tel(String place_tel) {
		this.place_tel = place_tel;
	}
	public String getPlace_lat() {
		return place_lat;
	}
	public void setPlace_lat(String place_lat) {
		this.place_lat = place_lat;
	}
	public String getPlace_long() {
		return place_long;
	}
	public void setPlace_long(String place_long) {
		this.place_long = place_long;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getTown_id() {
		return town_id;
	}
	public void setTown_id(int town_id) {
		this.town_id = town_id;
	}
	public boolean isPrintout() {
		return printout;
	}
	public void setPrintout(boolean printout) {
		this.printout = printout;
	}
	
	
	
}
