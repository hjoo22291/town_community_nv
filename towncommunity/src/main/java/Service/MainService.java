package Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import Dto.BoardDTO;
import Dto.MemberDTO;
import Dto.TownDTO;

public interface MainService {
	public TownDTO townView(int town_id);
	public List<BoardDTO> popularArticles(int town_id);
	public List<BoardDTO> villageNews(int town_id);
	public List<BoardDTO> placeOfMeeting(int town_id);
	public BoardDTO todayPhoto(int town_id);
	public List<BoardDTO> photoComment(int town_id);
	public BoardDTO youKnow(int town_id);
	public long getContentCountByKeyword(Map<String, Object> map);
	public List<BoardDTO> getContentByKeyword(Map<String, Object> map);
	public MemberDTO memberInfo(String member_id);
	public ArrayList<TownDTO> changeVillage(String town_name);
	public MemberDTO profile(String member_id);
}
