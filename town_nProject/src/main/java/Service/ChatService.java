package Service;

import java.util.ArrayList;
import java.util.List;

import Dto.ChatlistDTO;
import Dto.ChatroomDTO;
import Dto.MessageDTO;

public interface ChatService {
	public List<MessageDTO> checkNull(MessageDTO dto);
	public int createChatroom(ChatroomDTO dto);
	public int insertMessage(MessageDTO dto);
	public int createChatlist(ChatlistDTO dto);
	public ArrayList<ChatlistDTO> selectChatlist(ChatlistDTO dto);
	public int countIsread(MessageDTO dto);
	public String latestContent(MessageDTO dto);
	public int readMessage(MessageDTO dto);
	public List<Integer> selectChatid(MessageDTO dto);
	public int selectMessageid(MessageDTO dto);
	public MessageDTO selectMessagebyid(int message_id);
	public int deletechatmessage(MessageDTO dto);
	public String doestouseridexist(String touser_id);
}
