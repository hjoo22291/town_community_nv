package ServiceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Dao.ChatDAO;
import Dto.ChatlistDTO;
import Dto.ChatroomDTO;
import Dto.MessageDTO;
import Service.ChatService;

@Service("ChatService")
public class ChatServiceImpl implements ChatService {
	


	@Autowired
	ChatDAO dao;
	
	@Override
	public int selectMessageid(MessageDTO dto) {
		return dao.selectMessageid(dto);
	}


	@Override
	public MessageDTO selectMessagebyid(int message_id) {
		return dao.selectMessagebyid(message_id);
	}


	@Override
	public List<MessageDTO> checkNull(MessageDTO dto) {
		System.out.println(dto);
		return dao.checkNull(dto);
	}

	@Override
	public int createChatroom(ChatroomDTO dto) {
		dao.createChatroom(dto);
        int result = dto.getChat_id();
        return result;
	}

	@Override
	public int insertMessage(MessageDTO dto) {
		return dao.insertMessage(dto);
	}

	@Override
	public int createChatlist(ChatlistDTO dto) {
		return dao.createChatlist(dto);
	}

	@Override
	public ArrayList<ChatlistDTO> selectChatlist(ChatlistDTO dto) {
		return dao.selectChatlist(dto);
	}

	@Override
	public int countIsread(MessageDTO dto) {
		return dao.countIsread(dto);
	}

	@Override
	public String latestContent(MessageDTO dto) {
		return dao.latestContent(dto);
	}

	@Override
	public int readMessage(MessageDTO dto) {
		return dao.readMessage(dto);
	}

	@Override
	public List<Integer> selectChatid(MessageDTO dto) {
		return dao.selectChatid(dto);
	}




}
