package ServiceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import Dao.BoardDAO1;
import Dto.BoardDTO;
import Service.BoardService1;
import jakarta.servlet.http.HttpSession;

@Service
public class BoardServiceImpl1 implements BoardService1 { //김종인 작성
	
	@Autowired
	@Qualifier("boardDAO1")
	BoardDAO1 dao;

	@Override
	public int insertBoard(BoardDTO dto) {
		return dao.insertBoard(dto);
	}
	
	@Override
	public List<Integer> getCurrentNoticeBoardId(HashMap<String, Object> noticemap) {
		return dao.getCurrentNoticeBoardId(noticemap);
	}

	@Override
	public int insertNoticeBoard(HashMap<String, Object> noticemap) {
		return dao.insertNoticeBoard(noticemap);
	}
	
	@Override
	public int getMemberTownId(String member_id) {
		return dao.getMemberTownId(member_id);
	}

	@Override
	public int getTotalArticleCount(HashMap<String, Object> map) {
		return dao.getArticleCount(map);
	}

	@Override
	public List<BoardDTO> getPagingBoardlist(HashMap<String, Object> map) {
		return dao.getPagingBoardlist(map);
	}

	@Override
	public int getBoardSearchCount(HashMap<String, Object> searchmap) {
		return dao.getBoardSearchCount(searchmap);
	}

	@Override
	public List<BoardDTO> getBoardSearchList(HashMap<String, Object> searchmap) {
		return dao.getBoardSearchList(searchmap);
	}
	
	@Override
	public int getNoticeCnt() {
		return dao.getNoticeCnt();
	}

	@Override
	public List<BoardDTO> getNoticeList(HashMap<String, Object> map) {
		return dao.getNoticeList(map);
	}

	@Override
	public String getNoticeTownIds(int board_id) {
		return dao.getNoticeTownIds(board_id);
	}

	@Override
	public int getNoticeSearchCnt(HashMap<String, Object> searchmap) {
		String sort = String.valueOf(searchmap.get("sort"));
		List<String> sortList = new ArrayList<>();
		int result = 0;
		if (sort.equals("board_title") || sort.equals("board_preview") || sort.equals("writer")) {
			sortList.add(sort);
			searchmap.put("sortList", sortList);
			result = dao.getNoticeSearchCnt1(searchmap);
		} else if (sort.equals("town_id")) {
			result = dao.getNoticeSearchCnt2(searchmap);
		} else if (sort.equals("town_name")) {
			result = dao.getNoticeSearchCnt3(searchmap);
		} else if (sort.equals("board_all")){
			result = dao.getNoticeSearchCnt4(searchmap);
		}
		return result;
	}

	@Override
	public List<BoardDTO> getNoticeSearchList(HashMap<String, Object> searchmap) {
		String sort = String.valueOf(searchmap.get("searchsort"));
		List<String> sortList = new ArrayList<>();
		List<BoardDTO> result = null;
		if (sort.equals("board_title") || sort.equals("board_preview") || sort.equals("writer")) {
			sortList.add(sort);
			searchmap.put("sortList", sortList);
			result = dao.getNoticeSearchList1(searchmap);
		} else if (sort.equals("town_id")) {
			result = dao.getNoticeSearchList2(searchmap);
		} else if (sort.equals("town_name")) {
			result = dao.getNoticeSearchList3(searchmap);
		} else if (sort.equals("board_all")){
			result = dao.getNoticeSearchList4(searchmap);
		}
		return result;
	}

	@Override
	public String getMemberDongAddress(int member_town_id) {
		return dao.getMemberDongAddress(member_town_id);
	}

	@Override
	public int updateProfileImage(String member_id, String profile_image) {
		return dao.updateProfileImage(member_id, profile_image);
	}

	@Override
	public List<String> getAllTownName() {
		return dao.getAllTownName();
	}

	@Override
	public boolean addMemberPointOrNot(HashMap<String, Object> pointmap) {
		int writeBoardCnt = dao.getWriteBoardCnt(pointmap);
		if (writeBoardCnt < 10) {
			dao.insertWriteBoardPoint(pointmap);
			dao.updateMemberPoint(pointmap);
			return true;
		} 
		return false;
	}
	
	// 공지사항 수정 폼에 보여줄 내용 가져오기
	@Override
	public BoardDTO getNoticeDetail(int board_id) {
		return dao.getNoticeDetail(board_id);
	}

	@Override
	public int updateNotice(BoardDTO dto, HashMap<String, Object> noticemap) {
		return dao.updateNoticeDetail(dto) + dao.updateNoticeTownIds(noticemap);
	}
	
	// 회원 포인트에 따라 등급 업 시키는 서비스
	@Override
	public boolean memberGradeUp(String member_id) {
		boolean result = false; // 등급 업 결과 반환할 변수
		List<HashMap<String, Object>> gradeTable = dao.getGradeTable(); // grade 테이블 내용
		HashMap<String, Object> memberGradeAndPoint = dao.getMemberGradeAndPoint(member_id); // 회원의 현재 등급과 포인트
		String memberCurGrade = (String) memberGradeAndPoint.get("grade_name"); // 회원의 현재 등급
		int memberCurPoint = (int) memberGradeAndPoint.get("point"); // 회원의 현재 포인트
		
		// grade 테이블의 각 행을 돌면서 검사
		for (int i = 0; i < gradeTable.size(); i++) {
			HashMap<String, Object> temp = gradeTable.get(i);
			int limitLeft = (int) temp.get("grade_cut_left");
			int limitRight = (int) temp.get("grade_cut_right");
			String grade_name = (String) temp.get("grade_name");
			if (memberCurPoint >= limitLeft && memberCurPoint < limitRight) {
				if (!memberCurGrade.equals(grade_name)) {
					HashMap<String, Object> gradeUpMap = new HashMap<>();
					gradeUpMap.put("member_id", member_id);
					gradeUpMap.put("grade_name", grade_name);
					dao.updateMemberGrade(gradeUpMap);
					result = true;
					break;
				}
			}
		}
		return result;
	}

	
	
	
}
