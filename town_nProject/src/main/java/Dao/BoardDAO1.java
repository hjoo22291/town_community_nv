package Dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import Dto.BoardDTO;

@Mapper
@Repository
public interface BoardDAO1 { //김종인 작성
	// 게시글 작성
	int insertBoard(BoardDTO dto);
	// 게시판 카테고리 선택시
	int getArticleCount(HashMap<String, Object> map);
	List<BoardDTO> getPagingBoardlist(HashMap<String, Object> map);
	// 게시판에서 검색시
	int getBoardSearchCount(HashMap<String, Object> searchmap);
	List<BoardDTO> getBoardSearchList(HashMap<String, Object> searchmap);
	
	// 회원 동네 아이디 가져오기
	int getMemberTownId(String member_id);
	// 회원 동네 아이디에 해당하는 동 이름 가져오기
	String getMemberDongAddress(int member_town_id);
	// 동네 이름 모두 가져오기(동네 아이디 오름차순으로)
	List<String> getAllTownName();
	
	// 공지사항 작성
	List<Integer> getCurrentNoticeBoardId(HashMap<String, Object> noticemap);
	int insertNoticeBoard(HashMap<String, Object> noticemap);
	// 관리자 페이지 공지사항 목록
	int getNoticeCnt();
	List<BoardDTO> getNoticeList(HashMap<String, Object> map);
	String getNoticeTownIds(int board_id);
	// 관리자 페이지 공지사항 검색시
	int getNoticeSearchCnt1(HashMap<String, Object> searchmap); // 제목, 내용, 작성자
	int getNoticeSearchCnt2(HashMap<String, Object> searchmap); // 동네 아이디
	int getNoticeSearchCnt3(HashMap<String, Object> searchmap); // 동네 이름
	int getNoticeSearchCnt4(HashMap<String, Object> searchmap); // 전체
	List<BoardDTO> getNoticeSearchList1(HashMap<String, Object> searchmap);
	List<BoardDTO> getNoticeSearchList2(HashMap<String, Object> searchmap);
	List<BoardDTO> getNoticeSearchList3(HashMap<String, Object> searchmap);
	List<BoardDTO> getNoticeSearchList4(HashMap<String, Object> searchmap);
	// 공지사항 수정 폼에 보여줄 내용 가져오기
	BoardDTO getNoticeDetail(int board_id);
	// 공지사항 수정 완료시 board, notice_board 테이블 update
	int updateNoticeDetail(BoardDTO dto);
	int updateNoticeTownIds(HashMap<String, Object> noticemap);
	
	// 회원 프로필 사진 변경
	int updateProfileImage(String member_id, String profile_image);
	
	// 글 작성시 포인트 횟수 제한에 따라 부여하거나 안함
	int getWriteBoardCnt(HashMap<String, Object> map);
	int insertWriteBoardPoint(HashMap<String, Object> map);
	int updateMemberPoint(HashMap<String, Object> map);
	
	// 회원 등급 업 관련 sql
	List<HashMap<String, Object>> getGradeTable(); // grade 테이블에서 필요한 컬럼 가져오기
	HashMap<String, Object> getMemberGradeAndPoint(String member_id); // 회원의 현재 등급과 포인트 가져오기
	int updateMemberGrade(HashMap<String, Object> gradeUpMap); // 회원의 등급을 업데이터
	
}
