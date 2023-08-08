package Controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import Dto.BlameTableDTO;
import Dto.BoardDTO;
import Dto.MemberDTO;
import Service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    AdminService adminService;
    
    @GetMapping
    public String getAdminPage() {
        return "managerPage";  
    }

    @PostMapping("/members")
    @ResponseBody
    public HashMap<String, Object> getAllMembersWithPagination(
            @RequestParam(defaultValue = "1") int page, 
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "signup_date") String orderCol) {  // orderCol 추가

        HashMap<String, Object> response = new HashMap<>();

        // 전체 회원 수
        int totalMemberCount = adminService.getTotalMemberCount();

        // 페이징 정보
        HashMap<String, Object> pagination = paging(page, size, totalMemberCount);

        // offset 계산
        int offset = (page - 1) * size;

        // 페이징 처리를 위한 준비
        HashMap<String, Object> paramMap = new HashMap<>(); 
        paramMap.put("limitIndex", offset); 
        paramMap.put("limitCount", size); 
        paramMap.put("orderCol", orderCol); 
        List<MemberDTO> members = adminService.getAllMembersWithPagination(paramMap); // 메서드 명을 알맞게 수정해야 합니다.

        // 결과를 맵에 담기
        response.put("pagination", pagination);
        response.put("members", members);

        return response;
    }

    public HashMap<String, Object> paging(int currentPage, int itemsPerPage, int totalItems) {
        HashMap<String, Object> pagingResult = new HashMap<>();

        // 총 페이지 수
        int totalPages = (int) Math.ceil((double) totalItems / (double) itemsPerPage);

        // 현재 페이지 번호 보정
        if (currentPage < 1) currentPage = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        // 시작 페이지와 끝 페이지
        int endPage = (int) (Math.ceil((double) currentPage / (double) itemsPerPage) * itemsPerPage);
        int startPage = endPage - (itemsPerPage - 1);
        
        if (endPage > totalPages) endPage = totalPages;

        // 이전, 다음 버튼 활성화 여부
        boolean prev = startPage > 1;
        boolean next = endPage < totalPages;

        pagingResult.put("totalPages", totalPages);
        pagingResult.put("endPage", endPage);
        pagingResult.put("startPage", startPage);
        pagingResult.put("prev", prev);
        pagingResult.put("next", next);

        return pagingResult;
    }
//    @PostMapping("/members")
//    @ResponseBody
//    public List<MemberDTO> getAllMembers(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "20") int size) {
//        int offset = (page - 1) * size;
//        return adminService.getAllMembers(offset, size);
//    }

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

//    @GetMapping("/members/paged")
//    @ResponseBody
//    public List<MemberDTO> getAllMembers(
//    	    @RequestParam(value = "page", required = false) Integer page,
//    	    @RequestParam(value = "size", required = false) Integer size) {
//        
//        List<MemberDTO> members = adminService.getPaginatedMembers(page, size);
//        if(members == null){
//            throw new RuntimeException("Failed to fetch members data");
//        }
//        return members;
//    }
//}