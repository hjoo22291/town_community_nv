package Controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import Dto.ChatlistDTO;
import Dto.ChatroomDTO;
import Dto.GChatlistDTO;
import Dto.MessageDTO;
import Service.ChatService;
import Service.GChatService;
import jakarta.servlet.http.HttpSession;

@Controller

public class ChatController {
	
	@Autowired
	@Qualifier("ChatService")
	ChatService service;
	
	@Autowired
	@Qualifier("GChatService")
	GChatService service2;
	
	@RequestMapping("/testchat")
	public String testchat() {
		return "testchatbtn";
	}
	
	@RequestMapping("/chatstart")
	public ModelAndView chatstart(HttpSession session,@RequestParam(value="touser_id",required=false ,defaultValue="0")String touser_id) {
		MessageDTO dto3 = new MessageDTO();
	    ModelAndView mv = new ModelAndView();
	    
	    String member_id = String.valueOf(session.getAttribute("member_id"));
	    dto3.setMember_id(member_id);
	    dto3.setTouser_id(touser_id);
	    //String a = dto3.getTouser_id();
	    //session.setAttribute("aValue", a);
	    
	    List<MessageDTO> list = service.checkNull(dto3);
	    
	    mv.addObject("list",list);
	    mv.setViewName("/ChatViewVer2");
	    
	    if (list.size() == 0) {
	    	ChatroomDTO dto4 = new ChatroomDTO();
	    	ChatlistDTO dto44 = new ChatlistDTO();
	    	dto3.setMessage_content("채팅방이 생성되었습니다.");
	        int result = service.createChatroom(dto4);
	        int chatid = dto4.getChat_id();
	        dto3.setChat_id(chatid);
	        dto44.setChat_id(chatid);
	        dto44.setMember_id(member_id);
	        dto44.setTo_id(touser_id);
	        int result3 = service.createChatlist(dto44);
	        int result2 = service.insertMessage(dto3);
		    System.out.println(result);
		    System.out.println(result2);
		    System.out.println(result3);
	    }
	    else {
	    	System.out.println(list.get(0).getChat_id());
		   // session.setAttribute("thisChatId", list.get(0).getChat_id());
		    int result4 = service.readMessage(dto3);
		    System.out.println(result4);
	    }
		return mv;
	}
	
	@PostMapping("/sendChat")
	@ResponseBody
	public int sendChat(@RequestParam("message") String message, @RequestParam("touser_id") String touser_id, HttpSession session) {
		MessageDTO dto5 = new MessageDTO();
		String member_id = String.valueOf(session.getAttribute("member_id"));
		//String aValue = (String) session.getAttribute("aValue");
		//int thisChatId = (int) session.getAttribute("thisChatId");
		dto5.setMember_id(member_id);
		//dto5.setChat_id(12);
		//dto5.setTouser_id("abc");
		//dto5.setTouser_id(aValue);
		//dto5.setChat_id(thisChatId);
		
		dto5.setTouser_id(touser_id);
		List<Integer> chat_id = service.selectChatid(dto5);
		int firstchatid = chat_id.get(0);
		dto5.setChat_id(firstchatid);
		SimpleDateFormat dateFormat = new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String now = dateFormat.format(new Date());
		dto5.setMessage_sendAt(now);
		
		System.out.println(touser_id);
		System.out.println(firstchatid);
		dto5.setMessage_content(message);
		service.insertMessage(dto5);
		int messageid = service.selectMessageid(dto5);
		
		return messageid;
	}

	@RequestMapping("/chatlist")
	public ModelAndView chatlist(HttpSession session) {
		ChatlistDTO dto6 = new ChatlistDTO();
		GChatlistDTO dto888 = new GChatlistDTO();
		ModelAndView mv = new ModelAndView();
		String member_id = String.valueOf(session.getAttribute("member_id"));
		dto6.setMember_id(member_id);
		ArrayList<ChatlistDTO> list = service.selectChatlist(dto6);
		

		for(ChatlistDTO data : list) {
			String touser_id = data.getTo_id();
			int chat_id = data.getChat_id();
			String member_id2 = data.getMember_id();
			System.out.println(touser_id);
			System.out.println(member_id2);
			if (touser_id.equals(member_id)) {
				MessageDTO dto77 = new MessageDTO();
				dto77.setChat_id(chat_id);

				String latest_content = service.latestContent(dto77);
				data.setLatest_content(latest_content);
				
				dto77.setMember_id(member_id);
				dto77.setTouser_id(member_id2);
				int totalisread = service.countIsread(dto77);
				
				data.setTotalisread(totalisread);
				data.setTo_id(member_id2);
			}
			
			else {
				MessageDTO dto77 = new MessageDTO();
				dto77.setChat_id(chat_id);
				
				String latest_content = service.latestContent(dto77);
				data.setLatest_content(latest_content);
				
				dto77.setMember_id(member_id);
				dto77.setTouser_id(touser_id);
				int totalisread = service.countIsread(dto77);
				
				data.setTotalisread(totalisread);
				
			}
		}
		
		dto888.setMember_id(member_id);
		ArrayList<GChatlistDTO> list2 = service2.selectGchatlist(dto888);
		
		System.out.println(list2.size());
		
		mv.addObject("list",list);
		mv.addObject("list2",list2);
		mv.setViewName("chatList");
		return mv;
	}
	

}
