package Dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import Dto.BoardDTO;
import Dto.CommentDTO;
import Dto.GoodHateDTO;
import Dto.MemberDTO;
import Dto.PointDTO;
import Dto.ReportDTO;
import Pagination.SearchDTO;

@Mapper
@Repository
public interface BoardDAO { //안휘주 작성

	//선택된 게시물 조회수 +1
	public int updateViewcnt(int board_id);
	
	//선택된 게시물 조회
	public BoardDTO getDetail(int board_id);
	
	//해당글의 댓글, 대댓글 전체 개수 가져오기
	public int getTotalCommentcnt(int board_id);
	
	//해당글의 댓글, 대댓글 전체조회 + 페이징처리
	public List<CommentDTO> commentPagingList(HashMap<String, String> map);
	
	//글쓴사람 정보
	public MemberDTO boardWriterProfile(String writer);
	
	//댓글,대댓글 전체 불러오기
	public List<CommentDTO> oneBoardComments(int board_id);
	
	//댓글쓰기(사진X)
	public int insertComment(CommentDTO dto);
	
	//댓글 삭제
	public int deleteComment(int comment_id);
	
	// 내 타운 + 사진게시판 글 갯수
	public int getCountMyTownPhotoBoard(HashMap<String, String> map);
	
	// 내 타운 + 사진게시판 글 갯수
	public List<BoardDTO> getMyTownPhotoBoardList(HashMap<String, String> map);
	
	//좋아요,싫어요 되어있는지
  	public GoodHateDTO isGoodOrHate(GoodHateDTO dto);
  	
  	//좋아요 추가
  	public int addGood(GoodHateDTO dto);
	
  	//싫어요 추가
  	public int addHate(GoodHateDTO dto);
  	
  	//좋아요, 싫어요 삭제
  	public int deleteGoodOrHate(GoodHateDTO dto);
	
	//보드에 반영
  	public int plusGoodCnt(int board_id);
  	public int minusGoodCnt(int board_id);
  	public int plusHateCnt(int board_id);
  	public int minusHateCnt(int board_id);
  	
  	//paging
  	public int getBoardCnt(SearchDTO dto);
  	public List<BoardDTO> getBoardList(SearchDTO dto);
  	
  	//보드 삭제
  	public int deleteBoard(int board_id);
  	
  	//대댓글작성
  	public int insertRecomment(CommentDTO dto);
  	
  	//댓글 수정
  	public int updateComment(CommentDTO dto);
  	
  	//paging(댓글)
  	public int getCommentCnt(SearchDTO dto);
  	public List<CommentDTO> getCommentList(SearchDTO dto);
  	
  	//대댓글 존재 여부
  	public int getRecommentCnt(int comment_id);
  	
  	//댓글 삭제(인듯 업데이트로 내용지우기)
  	public int deleteUpdateComment(CommentDTO dto);
  	
  	//글 수정
  	public int updateBoard(BoardDTO dto);
  	
  	//포토보드 검색
  	public int searchPhotoBoardCnt(SearchDTO dto);
  	public List<BoardDTO> searchPhotoBoardList(SearchDTO dto);
  	
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

}
