package Dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import Dto.BlameTableDTO;
import Dto.BoardDTO;
import Dto.MemberDTO;

@Repository
public class AdminDAO {
    @Autowired
    private SqlSession sqlSession;

    public List<MemberDTO> getAllMembers(int offset, int size) {
        RowBounds rowBounds = new RowBounds(offset, size);
        return sqlSession.selectList("Dao.AdminDAO.getAllMembers", null, rowBounds);
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
    public void decreaseReportCount(String memberId) {
        sqlSession.update("decreaseReportCount", memberId); 
    }
    
    public void adjustBanDate(String memberId) {
        sqlSession.update("Dao.AdminDAO.adjustBanDate", memberId);
    }

    public int getTotalMemberCount() {
        return sqlSession.selectOne("Dao.AdminDAO.getTotalMemberCount");
    }

    public List<MemberDTO> getAllMembersWithPagination(HashMap<String, Object> paramMap) {
        return sqlSession.selectList("Dao.AdminDAO.getAllMembersWithPagination", paramMap);
    }
}
