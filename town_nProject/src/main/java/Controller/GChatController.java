package Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import Dto.GChatlistDTO;
import Dto.GChatroomDTO;
import Dto.GMessageDTO;
import Service.GChatService;
import jakarta.servlet.http.HttpSession;

@Controller

public class GChatController {
	
	@Autowired
	@Qualifier("GChatService")
	GChatService service;
	
	@RequestMapping("/testchat2")
	public String testchat2() {
		return "testchatbtn2";
	}
	
	@RequestMapping("/gchatstart")
	@ResponseBody
	public ModelAndView gchatstart (HttpSession session, @RequestParam int board_id) {
		ModelAndView mv = new ModelAndView();
		GChatroomDTO dto1 = new GChatroomDTO();
		GChatlistDTO dto2 = new GChatlistDTO();
		GMessageDTO dto3 = new GMessageDTO();
		
		String member_id = String.valueOf(session.getAttribute("member_id"));
		
		dto1.setBoard_id(board_id);
		int result1 = service.createGchatroom(dto1);
		System.out.println(result1);
		
		int gchatid = service.selectGchatonroom(dto1);
		System.out.println(gchatid);
		dto2.setMember_id(member_id);
		dto2.setBoard_id(board_id);
		dto2.setGchat_id(gchatid);
		String chatroom_name = "그룹채팅 " + gchatid;
		dto2.setChatroom_name(chatroom_name);
		int result2 = service.createGchatlist(dto2);
		System.out.println(result2);
		
		dto3.setMember_id(member_id);
		dto3.setGchat_id(gchatid);
		dto3.setGmessage_content("채팅방이 생성되었습니다.");
		int result3 = service.insertGmessage(dto3);
		System.out.println(result3);
		
		mv.setViewName("/GChatView");
		return mv;
	}
	
	@RequestMapping("/entergchat")
	@ResponseBody
	public ModelAndView entergchat (HttpSession session, @RequestParam(value="board_id",required=false ,defaultValue="0") int board_id) {
		ModelAndView mv = new ModelAndView();
		GChatlistDTO dto1 = new GChatlistDTO();
		GMessageDTO dto2 = new GMessageDTO();
		
		String member_id = String.valueOf(session.getAttribute("member_id"));
		dto1.setBoard_id(board_id);
		dto1.setMember_id(member_id);
		List<Integer> gchat_id = service.selectGchat(dto1);
		System.out.println(gchat_id);
		
		List<GChatlistDTO> list2 = service.checkGchat(dto1);
		
		if (list2.size() == 0) {
			dto1.setGchat_id(gchat_id.get(0));
			int result1 = service.createGchatlist(dto1);
			System.out.println(result1);
		}

		dto2.setGchat_id(gchat_id.get(0));
		List<GMessageDTO> list = service.summonMessage(dto2);
		
		mv.addObject("list", list);
		mv.setViewName("/GChatView");
		return mv;
	}
	
	@PostMapping("/sendGChat")
	@ResponseBody
	public int sendGChat (@RequestParam("message") String message, @RequestParam("board_id") int board_id, HttpSession session) {
		GMessageDTO dto1 = new GMessageDTO();
		GChatlistDTO dto2 = new GChatlistDTO();
		
		String member_id = String.valueOf(session.getAttribute("member_id"));
		
		dto2.setMember_id(member_id);
		dto2.setBoard_id(board_id);
		List<Integer> gchat_id = service.selectGchat(dto2);
		
		dto1.setMember_id(member_id);
		dto1.setGmessage_content(message);
		dto1.setGchat_id(gchat_id.get(0));
		SimpleDateFormat dateFormat = new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String now = dateFormat.format(new Date());
		dto1.setGmessage_sendAt(now);
		service.insertGmessage(dto1);
		int result = service.selectGmessageid(dto1);
		return result;
	}
	

}