package Dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import Dto.BlameTableDTO;
import Dto.BoardDTO;
import Dto.MemberDTO;

@Repository
public class AdminDAO {
    @Autowired
    private SqlSession sqlSession;

    public List<MemberDTO> getAllMembers() {
        List<MemberDTO> members = sqlSession.selectList("Dao.AdminDAO.getAllMembers");
      
        if(members == null){
            throw new RuntimeException("Failed to fetch members data from Database");
        }
        return members;
    }

    public List<BlameTableDTO> getAllBlames() {
        return sqlSession.selectList("Dao.AdminDAO.getAllBlames");
       
    }
//
    public List<BoardDTO> getAllBoards() {
        return sqlSession.selectList("Dao.AdminDAO.getAllBoards");
        
    }
    public void unbanMember(String memberId) {
        sqlSession.update("unbanMember", memberId);
    }  
    
    
}