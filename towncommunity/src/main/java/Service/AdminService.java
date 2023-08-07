package Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Dao.AdminDAO;
import Dto.BlameTableDTO;
import Dto.BoardDTO;
import Dto.MemberDTO;

public interface AdminService {
    public List<MemberDTO> getAllMembers(); 
    public List<BlameTableDTO> getAllBlames(); 
    public List<BoardDTO> getAllBoards(); 
    public void unbanMember(String memberId);
    
   }


@Service
class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDAO adminDAO;

    @Override
    public List<MemberDTO> getAllMembers() {
        return adminDAO.getAllMembers();
    }

    @Override
    public List<BlameTableDTO> getAllBlames() {
        return adminDAO.getAllBlames();
    }
//
    @Override
    public List<BoardDTO> getAllBoards() {
        return adminDAO.getAllBoards();
    }

    @Override
    public void unbanMember(String memberId) {
        adminDAO.unbanMember(memberId);
    }
    
}