package Dto;

import java.sql.Timestamp;

public class BlameTableDTO {
//
    private int blamecnt;
    private String boardname;
    private String write_id;
    private String comment;
    private String blame_id;
    private String blame_comment;
    private Timestamp blame_date;
    private String comment_id;
    private int board_id;


    public int getBlamecnt() {
        return blamecnt;
    }

    public void setBlamecnt(int blamecnt) {
        this.blamecnt = blamecnt;
    }

    public String getBoardname() {
        return boardname;
    }

    public void setBoardname(String boardname) {
        this.boardname = boardname;
    }

    public String getWrite_id() {
        return write_id;
    }

    public void setWrite_id(String write_id) {
        this.write_id = write_id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getBlame_id() {
        return blame_id;
    }

    public void setBlame_id(String blame_id) {
        this.blame_id = blame_id;
    }

    public String getBlame_comment() {
        return blame_comment;
    }

    public void setBlame_comment(String blame_comment) {
        this.blame_comment = blame_comment;
    }

    public Timestamp getBlame_date() {
        return blame_date;
    }

    public void setBlame_date(Timestamp blame_date) {
        this.blame_date = blame_date;
    }

    public String getComment_id() {
        return comment_id;
    }

    public void setComment_id(String comment_id) {
        this.comment_id = comment_id;
    }

    public int getBoard_id() {
        return board_id;
    }

    public void setBoard_id(int board_id) {
        this.board_id = board_id;
    }
}