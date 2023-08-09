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
	public String selectchatroomname(GChatlistDTO dto) {
		return dao.selectchatroomname(dto);
	}

	@Override
	public int updatelatestgcontent(GChatroomDTO dto) {
		return dao.updatelatestgcontent(dto);
	}

	@Override
	public int leavegchatroom(GChatlistDTO dto) {
		return dao.leavegchatroom(dto);
	}

	@Override
	public int changegchatroomname(GChatlistDTO dto) {
		return dao.changegchatroomname(dto);
	}

	@Override
	public int deletegchatmessage(GMessageDTO dto) {
		return dao.deletegchatmessage(dto);
	}

	@Override
	public String selectlatestgcontent(GChatroomDTO dto) {
		return dao.selectlatestgcontent(dto);
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
