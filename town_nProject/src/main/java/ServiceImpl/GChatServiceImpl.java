package ServiceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Dao.GChatDAO;
import Dto.GChatlistDTO;
import Dto.GChatroomDTO;
import Dto.GMessageDTO;
import Service.GChatService;

@Service("GChatService")
public class GChatServiceImpl implements GChatService {

	@Autowired
	GChatDAO dao;
	
	@Override
	public int selectGmessageid(GMessageDTO dto) {
		return dao.selectGmessageid(dto);
	}

	@Override
	public GMessageDTO selectGmessagebyid(int gmessage_id) {
		return dao.selectGmessagebyid(gmessage_id);
	}

	@Override
	public int createGchatroom(GChatroomDTO dto) {
		return dao.createGchatroom(dto);
	}

	@Override
	public int selectGchatonroom(GChatroomDTO dto) {
		return dao.selectGchatonroom(dto);
	}

	@Override
	public int insertGmessage(GMessageDTO dto) {
		return dao.insertGmessage(dto);
	}

	@Override
	public int createGchatlist(GChatlistDTO dto) {
		return dao.createGchatlist(dto);
	}

	@Override
	public List<Integer> selectGchat(GChatlistDTO dto) {
		return dao.selectGchat(dto);
	}

	@Override
	public List<GChatlistDTO> checkGchat(GChatlistDTO dto) {
		return dao.checkGchat(dto);
	}

	@Override
	public List<GMessageDTO> summonMessage(GMessageDTO dto) {
		return dao.summonMessage(dto);
	}

	@Override
	public ArrayList<GChatlistDTO> selectGchatlist(GChatlistDTO dto) {
		return dao.selectGchatlist(dto);
	}


}
