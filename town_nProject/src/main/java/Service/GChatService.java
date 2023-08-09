package Service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import Dto.GChatlistDTO;
import Dto.GChatroomDTO;
import Dto.GMessageDTO;

@Service
public interface GChatService {
	public int createGchatroom (GChatroomDTO dto);
	public int insertGmessage (GMessageDTO dto);
	public int createGchatlist (GChatlistDTO dto);
	public List<Integer> selectGchat(GChatlistDTO dto);
	public int selectGchatonroom(GChatroomDTO dto);
	List<GChatlistDTO> checkGchat (GChatlistDTO dto);
	List<GMessageDTO> summonMessage (GMessageDTO dto);
	public ArrayList<GChatlistDTO> selectGchatlist (GChatlistDTO dto);
	public int selectGmessageid(GMessageDTO dto);
	public GMessageDTO selectGmessagebyid(int gmessage_id);
	public String selectchatroomname(GChatlistDTO dto);
	public int updatelatestgcontent(GChatroomDTO dto);
	public String selectlatestgcontent(GChatroomDTO dto);
	public int leavegchatroom(GChatlistDTO dto);
	public int changegchatroomname(GChatlistDTO dto);
	public int deletegchatmessage(GMessageDTO dto);
}
