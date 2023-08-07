package ServiceImpl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Dao.SignDAO;
import Dto.BoardDTO;
import Dto.MemberDTO;
import Service.SignService;

@Service("SignService")
public class SignServiceimple implements SignService{
	
	@Autowired
	SignDAO dao;
	
	@Override
	public int insertMember(MemberDTO memberDTO) {
		return dao.insertMember(memberDTO);
	}
	@Override
	public int dupliIDcheck(String member_id) {
		return dao.dupliIDcheck(member_id);
	}
	@Override
	public int dupliEmailcheck(String email) {
		return dao.dupliEmailcheck(email);
	}
	@Override
	public int dupliFindEmailcheck(String member_id,String email) {
		return dao.dupliFindEmailcheck(member_id,email);
	}
	@Override
	public int LoginMember(HashMap<String, ?> map) {
		return dao.LoginMember(map);
	}
	@Override
	public MemberDTO MyInfo(String member_id) {
		return dao.MyInfo(member_id);
	}
	@Override
	public int updatemember(MemberDTO MemberDTO) {
		return dao.updatemember(MemberDTO);
	}
	@Override
	public int Findpwupdate(MemberDTO MemberDTO) {
		return dao.Findpwupdate(MemberDTO);
	}
	@Override
	public int deletememberinsert(HashMap<String, ?> map) {
		return dao.deletememberinsert(map);
	}
	@Override
	public int deletemember(String member_id) {
		return dao.deletemember(member_id);
	}
	@Override
	public int getMyTotalArticleCount(HashMap<String, ?> map) {
		return dao.getMyArticleCount(map);
	}
	@Override
	public List<BoardDTO> getMyPagingBoardlist(HashMap<String, ?> map) {
		return dao.getMyPagingBoardlist(map);
	}
	@Override
	public int getMycommentTotalArticleCount(HashMap<String, ?> map) {
		return dao.getMycommentArticleCount(map);
	}
	@Override
	public List<BoardDTO> getMycommentPagingBoardlist(HashMap<String, ?> map) {
		return dao.getMycommentPagingBoardlist(map);
	}
	@Override
	public int getMygoodTotalArticleCount(HashMap<String, ?> map) {
		return dao.getMygoodArticleCount(map);
	}
	@Override
	public List<BoardDTO> getMygoodPagingBoardlist(HashMap<String, ?> map) {
		return dao.getMygoodPagingBoardlist(map);
	}
	@Override
	public int admincnt() {
		return dao.admincnt();
	}

}
