package Controller;

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
    
    @GetMapping("/members")
    @ResponseBody
    public List<MemberDTO> getAllMembers() {
        return adminService.getAllMembers();
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
        return "Unban successful";
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