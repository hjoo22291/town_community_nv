package ServiceImpl;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Dao.BoardDAO;
import Dto.BoardDTO;
import Dto.CommentDTO;
import Dto.GoodHateDTO;
import Dto.MemberDTO;
import Dto.PointDTO;
import Dto.ReportDTO;
import Pagination.Pagination;
import Pagination.PagingResponse;
import Pagination.SearchDTO;
import Service.BoardService;

@Service
public class BoardServiceImpl implements BoardService { //안휘주 작성
	
	@Autowired
	BoardDAO dao;
	
	//선택된 게시물 조회수 증가
	public int updateViewcnt(int board_id) {
		return dao.updateViewcnt(board_id);
	}
	
	//해당글의 댓글, 대댓글 전체 개수 가져오기
	public int getTotalCommentcnt(int board_id) {
		return dao.getTotalCommentcnt(board_id);
	}
	
	//해당글의 댓글, 대댓글 전체조회 + 페이징처리
	public List<CommentDTO> commentPagingList(HashMap<String, String> map){
		return dao.commentPagingList(map);
	}
	
	//글쓴사람 정보
	public MemberDTO boardWriterProfile(String writer) {
		return dao.boardWriterProfile(writer); 
	}
	
	//댓글,대댓글 전체 불러오기
	public List<CommentDTO> oneBoardComments(int board_id) {
		return dao.oneBoardComments(board_id);
	}
	
	//댓글쓰기(사진X)
	public int insertComment(CommentDTO dto) {
		return dao.insertComment(dto);
	}
	
	//댓글 삭제
	public int deleteComment(int comment_id) {
		return dao.deleteComment(comment_id);
	}
	
	// 내 타운 + 사진게시판 글 갯수
	public int getCountMyTownPhotoBoard(HashMap<String, String> map) {
		return dao.getCountMyTownPhotoBoard(map);
	}
	
	// 내 타운 + 사진게시판 글 갯수
	public List<BoardDTO> getMyTownPhotoBoardList(HashMap<String, String> map){
		return dao.getMyTownPhotoBoardList(map);
	}
	
	//좋아요 되어있는지
  	public GoodHateDTO isGoodOrHate(GoodHateDTO dto) {
  		return dao.isGoodOrHate(dto);
  	} 	
  	//좋아요 추가
  	public int addGoodPlusCnt(GoodHateDTO dto) {
  		int a = dao.addGood(dto);
  		int b = dao.plusGoodCnt(dto.getBoard_id());
  		return a+b;
  	}
  	public int addHatePlusCnt(GoodHateDTO dto) {
  		int a = dao.addHate(dto);
  		int b = dao.plusHateCnt(dto.getBoard_id());
  		return a+b;  		
  	}
  	public int deleteGoodMinusCnt(GoodHateDTO dto) {
  		int a = dao.deleteGoodOrHate(dto);
  		int b = dao.minusGoodCnt(dto.getBoard_id());
  		return a+b;  		  		
  	}
  	public int deleteHateMinusCnt(GoodHateDTO dto) {
  		int a = dao.deleteGoodOrHate(dto);
  		int b = dao.minusHateCnt(dto.getBoard_id());
  		return a+b;  		  		
  	}
  	
  	//-------paging
  	public PagingResponse<BoardDTO> getBoardList(SearchDTO dto){
  		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
        int count = dao.getBoardCnt(dto);
        if (count < 1) {
            return new PagingResponse<>(Collections.emptyList(), null);
        }

        // Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
        Pagination pagination = new Pagination(count, dto);
        dto.setPagination(pagination);

        // 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 반환
        List<BoardDTO> list = dao.getBoardList(dto);
        return new PagingResponse<>(list, pagination);

  	};
  	
  	//보드 삭제
  	public int deleteBoard(int board_id) {
  		return dao.deleteBoard(board_id);
  	}
  	//대댓글작성
  	public int insertRecomment(CommentDTO dto) {
  		return dao.insertRecomment(dto);
  	}
  	//댓글 수정
  	public int updateComment(CommentDTO dto) {
  		return dao.updateComment(dto);
  	};
  	
  	//-------paging(댓글)
  	public PagingResponse<CommentDTO> getCommentList(SearchDTO dto){
  		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
  		int count = dao.getCommentCnt(dto);
  		if (count < 1) {
  			return new PagingResponse<>(Collections.emptyList(), null);
  		}
  		
  		// Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
  		Pagination pagination = new Pagination(count, dto);
  		dto.setPagination(pagination);
  		
  		// 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 반환
  		List<CommentDTO> list = dao.getCommentList(dto);
  		return new PagingResponse<>(list, pagination);
  		
  	};
  	
  	//대댓글 존재 여부
  	public int getRecommentCnt(int comment_id) {
  		return dao.getRecommentCnt(comment_id);
  	};
  	//댓글 삭제(인듯 업데이트로 내용지우기)
  	public int deleteUpdateComment(CommentDTO dto) {
  		return dao.deleteUpdateComment(dto);
  	};
  	
  //글 하나 조회
  	public BoardDTO getDetail(int board_id) {
  		return dao.getDetail(board_id);
  	}
  	
  	//글 수정
  	public int updateBoard(BoardDTO dto) {
  		return dao.updateBoard(dto);
  	};
  	
  	//포토보드 검색 -------paging
  	public PagingResponse<BoardDTO> searchPhotoBoardList(SearchDTO dto) {
  		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
  		int count = dao.searchPhotoBoardCnt(dto);
  		if (count < 1) {
  			return new PagingResponse<>(Collections.emptyList(), null);
  		}
  		
  		// Pagination 객체를 생성해서 페이지 정보 계산 후 SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
  		Pagination pagination = new Pagination(count, dto);
  		dto.setPagination(pagination);
  		
  		// 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 리스트 데이터 조회 후 응답 데이터 반환
  		List<BoardDTO> list = dao.searchPhotoBoardList(dto);
  		return new PagingResponse<>(list, pagination);
  		
  	};
  	
  	//글 존재여부
  	public int existBoard(int board_id) {
  		return dao.existBoard(board_id);
  	}
  	
  	//회원이 작성한 글, 댓글 모두 출력안되도록
  	public int deleteAllBoard(String member_id) {
  		return dao.deleteAllBoard(member_id);
  	};
  	public int deleteAllComment(String member_id) {
  		return dao.deleteAllComment(member_id);
  	};
  	
  	//댓글 쓰면 포인트부여
  	public int insertPointComment(PointDTO dto) {
  		return dao.insertPointComment(dto);
  	};
  	public int updateMemberPointComment(PointDTO dto) {
  		return dao.updateMemberPointComment(dto);
  	};
  	
  	//멤버 등급 이미지 가져오기
  	public String getMemberGrdaeImg(String member_id) {
  		return dao.getMemberGrdaeImg(member_id);
  	};
}//class
