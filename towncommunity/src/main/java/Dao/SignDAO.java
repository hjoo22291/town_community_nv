package Dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import Dto.BoardDTO;
import Dto.MemberDTO;

@Mapper
@Repository
public interface SignDAO {
	
	public int insertMember(MemberDTO MemberDTO);
	public int dupliIDcheck(String member_id);
	public int dupliEmailcheck(String email);
	public int dupliFindEmailcheck(String member_id,String email);
	public int LoginMember(HashMap<String, ?> map);
	public MemberDTO MyInfo(String member_id);
	public int updatemember(MemberDTO MemberDTO);
	public int Findpwupdate(MemberDTO MemberDTO);
	public int deletememberinsert(HashMap<String, ?> map);
	public int deletemember(String member_id);
	// 게시판 카테고리 선택시
	int getMyArticleCount(HashMap<String, ?> map);
	List<BoardDTO> getMyPagingBoardlist(HashMap<String, ?> map);
	int getMycommentArticleCount(HashMap<String, ?> map);
	List<BoardDTO> getMycommentPagingBoardlist(HashMap<String, ?> map);
	int getMygoodArticleCount(HashMap<String, ?> map);
	List<BoardDTO> getMygoodPagingBoardlist(HashMap<String, ?> map);
	public int admincnt();
}
