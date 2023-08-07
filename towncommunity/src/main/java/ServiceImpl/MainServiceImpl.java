package ServiceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Dao.MainDAO;
import Dto.BoardDTO;
import Dto.MemberDTO;
import Dto.TownDTO;
import Service.MainService;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	MainDAO dao;

	
	@Override
	public MemberDTO memberInfo(String member_id) {
		// TODO Auto-generated method stub
		return dao.memberInfo(member_id);
	}

	@Override
	public TownDTO townView(int town_id) {
		// TODO Auto-generated method stub
		return dao.townView(town_id);
	}

	@Override
	public List<BoardDTO> popularArticles(int town_id) {
		// TODO Auto-generated method stub
		return dao.popularArticles(town_id);
	}

	@Override
	public List<BoardDTO> villageNews(int town_id) {
		// TODO Auto-generated method stub
		return dao.villageNews(town_id);
	}

	@Override
	public List<BoardDTO> placeOfMeeting(int town_id) {
		// TODO Auto-generated method stub
		return dao.placeOfMeeting(town_id);
	}

	@Override
	public BoardDTO todayPhoto(int town_id) {
		// TODO Auto-generated method stub
		return dao.todayPhoto(town_id);
	}

	@Override
	public List<BoardDTO> photoComment(int board_id) {
		// TODO Auto-generated method stub
		return dao.photoComment(board_id);
	}

	@Override
	public BoardDTO youKnow(int town_id) {
		// TODO Auto-generated method stub
		return dao.youKnow(town_id);
	}

	@Override
	public long getContentCountByKeyword(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.getContentCountByKeyword(map);
	}

	@Override
	public List<BoardDTO> getContentByKeyword(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.getContentByKeyword(map);
	}

	@Override
	public ArrayList<TownDTO> changeVillage(String town_name) {
		// TODO Auto-generated method stub
		return dao.changeVillage(town_name);
	}
	
	public MemberDTO profile(String member_id) {
		return dao.profile(member_id); 
	}

}
