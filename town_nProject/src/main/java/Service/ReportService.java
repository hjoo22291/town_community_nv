package Service;

import java.util.HashMap;
import java.util.List;

import Dto.CommentDTO;
import Dto.ReportDTO;
import Pagination.PagingResponse;
import Pagination.SearchDTO;

public interface ReportService { //안휘주 작성
  	
  	//글 신고
  	public int reportBoard(ReportDTO dto);
  	//댓글 조회
  	public CommentDTO getCommentDetail(int comment_id);
  	//댓글 신고
  	public int reportComment(ReportDTO dto);
  	
  	//신고 목록 불러오기
  	public PagingResponse<ReportDTO> reportedList(SearchDTO dto);  	
  	
  	//신고+보드 테이블조인 리스트
  	public PagingResponse<ReportDTO> reportedBoardList(SearchDTO dto);
  	
  	//신고+댓글 테이블조인 리스트
  	public PagingResponse<ReportDTO> reportedCommentList(SearchDTO dto);
  	
  	public int reportChat(ReportDTO dto);
  	public int reportGChat(ReportDTO dto);
  	//신고 결과 업데이트
  	public int updateReportResult(ReportDTO dto);
  	
  	//채팅 신고내용 조회 -----------------------------------------------------------------------
  	public PagingResponse<ReportDTO> reportedChatList(SearchDTO dto);
  	public PagingResponse<ReportDTO> reportedGChatList(SearchDTO dto);
  	
  	//회원 정지
  	public int updateMemberStopDate(HashMap<String, Object> map);
}
