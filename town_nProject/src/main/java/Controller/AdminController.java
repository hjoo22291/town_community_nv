package Controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import Dto.BlameTableDTO;
import Dto.BoardDTO;
import Dto.MemberDTO;
import Service.AdminService;

@Controller
public class AdminController {
    
    @Autowired
    AdminService adminService;
    
    static final int postCntPerPage = 20; // 한 페이지에 표시할 게시글 수
    static final int pageCntPerPage = 10; // 한번에 표시할 페이지 개수
   
    @GetMapping("/manager")
    public ModelAndView getAdminPage(
            @RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "signup_date") String orderCol) {
    	ModelAndView mv = new ModelAndView();
    	
    	HashMap<String, Object> response = new HashMap<>();

        // 전체 회원 수
        int totalMemberCount = adminService.getTotalMemberCount();

        // 페이징 정보
        if (page <= 0) page = 1;
        HashMap<String, Object> pagination = paging(page, totalMemberCount);

        // offset 계산
        int offset = (page - 1) * postCntPerPage;

        // 페이징 처리를 위한 준비
        HashMap<String, Object> paramMap = new HashMap<>(); 
        paramMap.put("limitIndex", offset); 
        paramMap.put("limitCount", postCntPerPage); 
        paramMap.put("orderCol", orderCol); 
        List<MemberDTO> members = adminService.getAllMembersWithPagination(paramMap); // 메서드 명을 알맞게 수정해야 합니다.
        
        for(MemberDTO member : members) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            format.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
            String str = format.format(member.getSignup_date());
            member.setSignup_date_str(str);
            
            format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            format.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
            str = format.format(member.getStopclear_date());
            member.setStopclear_date_str(str);

        }
        
        // 결과를 맵에 담기
//        response.put("pagination", pagination);
        mv.addObject("members", members);
        
        // 페이징 처리할 때 필요한 값 뿌리기
        mv.addObject("totalPageCnt", pagination.get("totalPageCnt"));
        mv.addObject("startPageNum", pagination.get("startPageNum"));
        mv.addObject("endPageNum", pagination.get("endPageNum"));
        mv.addObject("prev", pagination.get("prev"));
        mv.addObject("next", pagination.get("next"));
        mv.addObject("selectedPageNum", page);
        
    	
    	mv.setViewName("managerPage2");
        return mv;  
    }
    @PostMapping("/members")
    @ResponseBody
    public HashMap<String, Object> getAllMembersWithPagination(
            @RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "signup_date") String orderCol) {  // orderCol 추가

        HashMap<String, Object> response = new HashMap<>();

        // 전체 회원 수
        int totalMemberCount = adminService.getTotalMemberCount();

        // 페이징 정보
        if (page <= 0) page = 1;
        HashMap<String, Object> pagination = paging(page, totalMemberCount);

        // offset 계산
        int offset = (page - 1) * postCntPerPage;

        // 페이징 처리를 위한 준비
        HashMap<String, Object> paramMap = new HashMap<>(); 
        paramMap.put("limitIndex", offset); 
        paramMap.put("limitCount", postCntPerPage); 
        paramMap.put("orderCol", orderCol); 
        List<MemberDTO> members = adminService.getAllMembersWithPagination(paramMap); // 메서드 명을 알맞게 수정해야 합니다.

        // 결과를 맵에 담기
//        response.put("pagination", pagination);
        response.put("members", members);
        
        for(MemberDTO member : members) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            format.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
            String str = format.format(member.getSignup_date());
            member.setSignup_date_str(str);
            
            format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            format.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
            str = format.format(member.getStopclear_date());
            member.setStopclear_date_str(str);

        }
        
        // 페이징 처리할 때 필요한 값 뿌리기
        response.put("totalPageCnt", pagination.get("totalPageCnt"));
        response.put("startPageNum", pagination.get("startPageNum"));
        response.put("endPageNum", pagination.get("endPageNum"));
        response.put("prev", pagination.get("prev"));
        response.put("next", pagination.get("next"));
        response.put("selectedPageNum", page);
        
        
        return response;
    }

	public HashMap<String, Object> paging(int page, int totalPostCnt) {
		HashMap<String, Object> pagingResult = new HashMap<>();
		int totalPageCnt = 0; // 전체 페이지 개수
		int endPageNum = 0; // 현재 페이지에서 가장 끝 페이지 수
		int startPageNum = 0; // 현재 페이지에서 가장 첫 페이지 수
		boolean prev = true; // ◁, ◁◁ 버튼 표시 여부
		boolean next = true; // ▷, ▷▷ 버튼 표시 여부
		
		totalPageCnt = (int) Math.ceil((double) totalPostCnt / (double) postCntPerPage); // 총 게시판 페이지 개수
		if (page < 1 || page > totalPageCnt) {
			page = 1;
		}
		endPageNum = (int) (Math.ceil((double) page / (double) pageCntPerPage) * pageCntPerPage); // 표시되는 페이지 번호 중 마지막 번호
		startPageNum = endPageNum - (pageCntPerPage - 1);
		// 마지막 페이지 다시 계산
		int endPageNumTemp = (int) (Math.ceil((double) totalPostCnt / (double) postCntPerPage));
		if (endPageNum > endPageNumTemp) {
			endPageNum = endPageNumTemp;
		}
		prev = startPageNum == 1 ? false : true;
		next = endPageNum * postCntPerPage >= totalPostCnt ? false : true;
		
		pagingResult.put("totalPageCnt", totalPageCnt);
		pagingResult.put("endPageNum", endPageNum);
		pagingResult.put("startPageNum", startPageNum);
		pagingResult.put("prev", prev);
		pagingResult.put("next", next);
		
		return pagingResult;
	}


    @GetMapping("/blames")
    @ResponseBody
    public List<BlameTableDTO> getAllBlames() {
        return adminService.getAllBlames();
    }

    @GetMapping("/boards")
    @ResponseBody
    public List<BoardDTO> getAllBoards() {
        return adminService.getAllBoards();
    }
    @PostMapping("/unban/{memberId}")
    @ResponseBody
    public String unbanMember(@PathVariable("memberId") String memberId) {
        adminService.unbanMember(memberId);
        adminService.decreaseReportCount(memberId);  // 추가된 코드: 리포트 카운트 감소 메소드 호출

        return "Unban successful";
    }
    @PostMapping("/adjustBanDate/{memberId}")
    @ResponseBody
    public String adjustBanDate(@PathVariable("memberId") String memberId) {
        adminService.adjustBanDate(memberId);
        return "adjustBanDate successful";
    }
    
}

