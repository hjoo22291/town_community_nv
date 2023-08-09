package Controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import Dto.BoardDTO;
import Dto.CommentDTO;
import Dto.GMessageDTO;
import Dto.MemberDTO;
import Dto.MessageDTO;
import Dto.ReportDTO;
import Pagination.PagingResponse;
import Pagination.SearchDTO;
import Service.BoardService;
import Service.ChatService;
import Service.GChatService;
import Service.ReportService;
import Service.SignService;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReportController { //안휘주 작성

	@Autowired
	@Qualifier("reportServiceImpl")
	ReportService service;
	
	@Autowired
	@Qualifier("boardServiceImpl")
	BoardService service2;
	
	@Autowired
	@Qualifier("ChatService")
	ChatService service3;
	
	@Autowired
	@Qualifier("GChatService")
	GChatService service4;

	@Autowired
	@Qualifier("SignService")
	SignService Ss;
	
  	//글 신고 폼 열기
	@RequestMapping("/boardReportForm")
	public ModelAndView boardReportForm (int bi) {
		BoardDTO dto = service2.getDetail(bi);
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.setViewName("reportForm_board");
		return mv;			
	}
	
	//글 신고
	@RequestMapping(value="/reportBoard", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int reportBoard (ReportDTO dto) {
		return service.reportBoard(dto);
	}
	
	//댓글 신고 폼 열기
	@RequestMapping("/commentReportForm")
	public ModelAndView commentReportForm (int ci) {
		CommentDTO dto = service.getCommentDetail(ci);
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.setViewName("reportForm_comment");
		return mv;			
	}
	
	//댓글 신고
	@RequestMapping(value="/reportComment", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int reportComment (ReportDTO dto) {
		return service.reportComment(dto);
	}
	
	//관리자페이지 들어가기
	@RequestMapping("/adminManager")
	public ModelAndView manager3(HttpSession session) {	
		ModelAndView main = new ModelAndView();
		if ((Integer)session.getAttribute("member_role") != 1) {
			main.setViewName("main");
			return main;
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("managerPage3");
		return mv;
	}
	
	//신고 글 목록
	@PostMapping("/reportedBoardList")
	public ModelAndView reportedBoardList(String search, @RequestParam(value="page", required=false, defaultValue="1" ) int page, HttpSession session) {
//			ModelAndView signin = new ModelAndView();
//			if (session.getAttribute("member_id") == null) {
//				signin.setViewName("/Signin");
//				return signin;
//			}
		
		String adminMenu = "신고된 글";

		SearchDTO searchdto = new SearchDTO();
		searchdto.setSearchType1(search);
	    searchdto.setRecordSize(20);
	    searchdto.setPage(page);
	    
		PagingResponse<ReportDTO> list = service.reportedBoardList(searchdto);
		  
		ModelAndView mv = new ModelAndView();
		mv.addObject("searchdto", searchdto);
		mv.addObject("adminMenu", adminMenu);
		mv.addObject("response", list);
		mv.setViewName("reportedBoardList");
		return mv;
	}	
	
	//신고 댓글 목록
	@PostMapping("/reportedCommentList")
	public ModelAndView reportedCommentList(String search, @RequestParam(value="page", required=false, defaultValue="1" ) int page, HttpSession session) {
//			ModelAndView signin = new ModelAndView();
//			if (session.getAttribute("member_id") == null) {
//				signin.setViewName("/Signin");
//				return signin;
//			}
		
		String adminMenu = "신고된 댓글";
		
		SearchDTO searchdto = new SearchDTO();
		searchdto.setSearchType1(search);
		searchdto.setRecordSize(20);
		searchdto.setPage(page);
		
		PagingResponse<ReportDTO> list = service.reportedCommentList(searchdto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("searchdto", searchdto);
		mv.addObject("adminMenu", adminMenu);
		mv.addObject("response", list);
		mv.setViewName("reportedCommentList");
		return mv;
	}

	//1:1 채팅 신고 폼 열기
	@RequestMapping("/reportForm_chat")
	public ModelAndView reportForm_chat(int message_id) {
		ModelAndView mv = new ModelAndView();
		MessageDTO dto = service3.selectMessagebyid(message_id);
		
		mv.addObject("dto",dto);
		mv.setViewName("reportForm_chat");
		return mv;
	}
	
	//그룹 채팅 신고 폼 열기
	@RequestMapping("/reportForm_gchat")
	public ModelAndView reportForm_gchat(int gmessage_id, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		GMessageDTO dto = service4.selectGmessagebyid(gmessage_id);
	
		mv.addObject("dto",dto);
		mv.setViewName("reportForm_gchat");
		return mv;
	}
	
	@RequestMapping(value="/reportChat", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int reportChat (ReportDTO dto) {
		return service.reportChat(dto);
	}
	
	@RequestMapping(value="/reportGChat", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int reportGChat (ReportDTO dto) {
		return service.reportGChat(dto);
	}
	
	//신고된 채팅목록------------------------------------------------------------------------------------------------------------------------
	@PostMapping("/reportedChatList")
	public ModelAndView reportedChatList(String search, @RequestParam(value="page", required=false, defaultValue="1" ) int page, HttpSession session) {
	//		ModelAndView signin = new ModelAndView();
	//		if (session.getAttribute("member_id") == null) {
	//			signin.setViewName("/Signin");
	//			return signin;
	//		}
		
		String adminMenu = "신고된 채팅(개인)";
		
		SearchDTO searchdto = new SearchDTO();
		searchdto.setSearchType1(search);
		searchdto.setRecordSize(20);
		searchdto.setPage(page);
		
		PagingResponse<ReportDTO> list = service.reportedChatList(searchdto); //변경
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("searchdto", searchdto);
		mv.addObject("adminMenu", adminMenu);
		mv.addObject("response", list);
		mv.setViewName("reportedChatList"); //변경
		return mv;
	}
	
	@PostMapping("/reportedGChatList")
	public ModelAndView reportedGChatList(String search, @RequestParam(value="page", required=false, defaultValue="1" ) int page, HttpSession session) {
		
		String adminMenu = "신고된 채팅(그룹)";
		
		SearchDTO searchdto = new SearchDTO();
		searchdto.setSearchType1(search);
		searchdto.setRecordSize(20);
		searchdto.setPage(page);
		
		PagingResponse<ReportDTO> list = service.reportedGChatList(searchdto); //변경
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("searchdto", searchdto);
		mv.addObject("adminMenu", adminMenu);
		mv.addObject("response", list);
		mv.setViewName("reportedGChatList"); //변경
		return mv;
	}
	//-----------------------------------------------------------------------------------------------------------------------
	
  	//신고 결과 업데이트
	@PostMapping(value="/updateReportResult", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int updateReportResult (ReportDTO dto) {
		return service.updateReportResult(dto);
	}
	
	//회원 탈퇴시키기
	@PostMapping(value="/admindeletemember", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int admindeletemember(String member_id) {
		HashMap<String, Object> map = new HashMap<>();
		MemberDTO my_info =Ss.MyInfo(member_id);		
		map.put("member_id", member_id);
		map.put("name",my_info.getName());
		map.put("phone", my_info.getPhone());
		map.put("email", my_info.getEmail());
		map.put("signup_date", my_info.getSignup_date());
		int a = Ss.deletememberinsert(map);
		int b = Ss.deletemember(member_id);
		//이 회원이 작성한 글, 댓글 모두 감추기
		service2.deleteAllBoard(member_id);
		service2.deleteAllComment(member_id);
		return a+b;
	}
	

	@RequestMapping("/deletechatmessage")
	@ResponseBody
	public int deletechatmessage(int message_id) {
		MessageDTO dto = new MessageDTO();
		dto.setMessage_id(message_id);
		dto.setMessage_content("채팅이 관리자에 의해 삭제되었습니다.");
		
		service3.deletechatmessage(dto);
		return 0;
	}

	//회원 정지(글)
	@PostMapping(value="/adminBoardStopMember", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int adminBoardStopMember(String member_id, int stopDateNum, int board_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("member_id", member_id);
		map.put("stopDateNum",stopDateNum);
		int a = service.updateMemberStopDate(map);
		int b = service2.deleteBoard(board_id);
		return a+b;
	}
	
	//회원 정지(댓글)
	@PostMapping(value="/adminCommentStopMember", produces = {"application/json;charset=utf-8"})
	public @ResponseBody int adminCommentStopMember(String member_id, int stopDateNum, int comment_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("member_id", member_id);
		map.put("stopDateNum",stopDateNum);
		int a = service.updateMemberStopDate(map);
		int b = service2.deleteComment(comment_id);
		return a+b;
	}

	@RequestMapping("/deletegchatmessage")
	@ResponseBody
	public int deletegchatmessage(int gmessage_id) {
		GMessageDTO dto = new GMessageDTO();
		dto.setGmessage_id(gmessage_id);
		dto.setGmessage_content("채팅이 관리자에 의해 삭제되었습니다.");
		
		service4.deletegchatmessage(dto);
		return 0;
	}
	
}//class
