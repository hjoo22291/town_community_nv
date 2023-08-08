package ServiceImpl;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Dao.ReportDAO;
import Dto.CommentDTO;
import Dto.ReportDTO;
import Pagination.Pagination;
import Pagination.PagingResponse;
import Pagination.SearchDTO;
import Service.ReportService;

@Service
public class ReportServiceImpl implements ReportService { //안휘주 작성
	

	@Autowired
	ReportDAO dao;

	@Override
	public int reportGChat(ReportDTO dto) {
		return dao.reportGChat(dto);
	}

	
	@Override
	public int reportChat(ReportDTO dto) {
		return dao.reportChat(dto);
	}
	
	//채팅 신고내용 조회-----------------------------------------------------------------------------------------------------------
  	public PagingResponse<ReportDTO> reportedChatList(SearchDTO dto){
  		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
  		int count = dao.reportedChatCnt(dto); //변경부분
  		if (count < 1) {
  			return new PagingResponse<>(Collections.emptyList(), null);
  		}
  		
  		// Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
  		Pagination pagination = new Pagination(count, dto);
  		dto.setPagination(pagination);
  		
  		// 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 반환
  		List<ReportDTO> list = dao.reportedChatList(dto); //변경부분
  		return new PagingResponse<>(list, pagination);	
  	};
  	
  	public PagingResponse<ReportDTO> reportedGChatList(SearchDTO dto) {
  		int count = dao.reportedGChatCnt(dto); //변경부분
  		if (count < 1) {
  			return new PagingResponse<>(Collections.emptyList(), null);
  		}
  		
  		Pagination pagination = new Pagination(count, dto);
  		dto.setPagination(pagination);
  		
  		List<ReportDTO> list = dao.reportedGChatList(dto); //변경부분
  		return new PagingResponse<>(list, pagination);
  	};
	//--------------------------------------------------------------------------------------------------------------------------
  	
  	
  	//글 신고
  	public int reportBoard(ReportDTO dto) {
  		return dao.reportBoard(dto);
  	};
  	//댓글 조회
  	public CommentDTO getCommentDetail(int comment_id) {
  		return dao.getCommentDetail(comment_id);
  	};
  	//댓글 신고
  	public int reportComment(ReportDTO dto) {
  		return dao.reportComment(dto);
  	};
  	
  	//신고목록
  	public PagingResponse<ReportDTO> reportedList(SearchDTO dto){
  		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
        int count = dao.reportedCnt(dto);
        if (count < 1) {
            return new PagingResponse<>(Collections.emptyList(), null);
        }

        // Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
        Pagination pagination = new Pagination(count, dto);
        dto.setPagination(pagination);

        // 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 반환
        List<ReportDTO> list = dao.reportedList(dto);
        return new PagingResponse<>(list, pagination);

  	};
  	
  	//신고+보드 테이블조인 리스트
  	public PagingResponse<ReportDTO> reportedBoardList(SearchDTO dto){
  		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
  		int count = dao.reportedBoardCnt(dto);
  		if (count < 1) {
  			return new PagingResponse<>(Collections.emptyList(), null);
  		}
  		
  		// Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
  		Pagination pagination = new Pagination(count, dto);
  		dto.setPagination(pagination);
  		
  		// 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 반환
  		List<ReportDTO> list = dao.reportedBoardList(dto);
  		return new PagingResponse<>(list, pagination);	
  	};
  	
  	//신고+댓글 테이블조인 리스트
  	public PagingResponse<ReportDTO> reportedCommentList(SearchDTO dto){
  		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
  		int count = dao.reportedCommentCnt(dto);
  		if (count < 1) {
  			return new PagingResponse<>(Collections.emptyList(), null);
  		}
  		
  		// Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
  		Pagination pagination = new Pagination(count, dto);
  		dto.setPagination(pagination);
  		
  		// 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 반환
  		List<ReportDTO> list = dao.reportedCommentList(dto);
  		return new PagingResponse<>(list, pagination);	
  	};
  	
  	//신고 결과 업데이트
  	public int updateReportResult(ReportDTO dto) {
  		return dao.updateReportResult(dto);
  	};

  	
}//class
