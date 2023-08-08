package Service;

import java.util.HashMap;
import java.util.List;

import Dto.BoardDTO;
import Dto.CommentDTO;
import Dto.GoodHateDTO;
import Dto.MemberDTO;
import Dto.PointDTO;
import Dto.ReportDTO;
import Pagination.PagingResponse;
import Pagination.SearchDTO;

public interface BoardService { //안휘주 작성
	
	public int updateViewcnt(int board_id);
	public int getTotalCommentcnt(int board_id);
	public List<CommentDTO> commentPagingList(HashMap<String, String> map);
	public MemberDTO boardWriterProfile(String writer);
	public List<CommentDTO> oneBoardComments(int board_id);
	public int insertComment(CommentDTO dto);
	public int deleteComment(int comment_id);
	//내타운+사진게시판 글 갯수, 글 목록 조회
	public int getCountMyTownPhotoBoard(HashMap<String, String> map);
	public List<BoardDTO> getMyTownPhotoBoardList(HashMap<String, String> map);
	//글 좋아요,싫어요 관련
  	public GoodHateDTO isGoodOrHate(GoodHateDTO dto);
  	public int addGoodPlusCnt(GoodHateDTO dto);
  	public int addHatePlusCnt(GoodHateDTO dto);
  	public int deleteGoodMinusCnt(GoodHateDTO dto);
  	public int deleteHateMinusCnt(GoodHateDTO dto);
  	//paging(보드)
  	public PagingResponse<BoardDTO> getBoardList(SearchDTO dto);  	
  	//보드 삭제
  	public int deleteBoard(int board_id);
  	//대댓글작성
  	public int insertRecomment(CommentDTO dto);
  //댓글 수정
  	public int updateComment(CommentDTO dto);
  	
  	//paging(댓글)
  	public PagingResponse<CommentDTO> getCommentList(SearchDTO dto);  	
  	
  //대댓글 존재 여부
  	public int getRecommentCnt(int comment_id);
  //댓글 삭제(인듯 업데이트로 내용지우기)
  	public int deleteUpdateComment(CommentDTO dto);
  	
  	//글 하나 조회
  	public BoardDTO getDetail(int board_id);
  	
  	//글 수정
  	public int updateBoard(BoardDTO dto);
  	
  	//포토보드 검색
  	public PagingResponse<BoardDTO> searchPhotoBoardList(SearchDTO dto);
  	
  	//글 존재여부
  	public int existBoard(int board_id);
  	
  	//회원이 작성한 글, 댓글 모두 출력안되도록
  	public int deleteAllBoard(String member_id);
  	public int deleteAllComment(String member_id);
  	
  	//댓글 쓰면 포인트부여
  	public int insertPointComment(PointDTO dto);
  	public int updateMemberPointComment(PointDTO dto);
  	
  	//멤버 등급 이미지 가져오기
  	public String getMemberGrdaeImg(String member_id);
  	
  	//소모임 채팅 생성 여부 확인
  	public int Check(int board_id);
  	
}
