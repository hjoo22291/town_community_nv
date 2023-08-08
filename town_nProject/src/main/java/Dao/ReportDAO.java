package Dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import Dto.CommentDTO;
import Dto.ReportDTO;
import Pagination.SearchDTO;

@Mapper
@Repository
public interface ReportDAO { //안휘주 작성	
  	//글 신고
  	public int reportBoard(ReportDTO dto);
  	//댓글 조회
  	public CommentDTO getCommentDetail(int comment_id);
  	//댓글 신고
  	public int reportComment(ReportDTO dto);
  	
  	//신고 내용 불러오기
  	public int reportedCnt(SearchDTO dto);
  	public List<ReportDTO> reportedList(SearchDTO dto);
  	
  	//신고+보드 테이블조인 리스트
  	public int reportedBoardCnt(SearchDTO dto);
  	public List<ReportDTO> reportedBoardList(SearchDTO dto);
  	
  	//신고+댓글 테이블조인 리스트
  	public int reportedCommentCnt(SearchDTO dto);
  	public List<ReportDTO> reportedCommentList(SearchDTO dto);
  	
  	public int reportChat(ReportDTO dto);
  	public int reportGChat(ReportDTO dto);
  	//신고 결과 업데이트
  	public int updateReportResult(ReportDTO dto);
  	
  	//채팅 신고내용 조회-----------------------------------------------------------------------
  	public int reportedChatCnt(SearchDTO dto);
  	public List<ReportDTO> reportedChatList(SearchDTO dto);
  	
  	public int reportedGChatCnt(SearchDTO dto);
  	public List<ReportDTO> reportedGChatList(SearchDTO dto);
  	
  	
}
