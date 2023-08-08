package Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Dao.AdminDAO;
import Dto.BlameTableDTO;
import Dto.BoardDTO;
import Dto.MemberDTO;

public interface AdminService {
    public List<MemberDTO> getAllMembers(); 
    void adjustBanDate(String memberId);
	void decreaseReportCount(String memberId);
	public List<BlameTableDTO> getAllBlames(); 
    public List<BoardDTO> getAllBoards(); 
    public void unbanMember(String memberId);
    public List<MemberDTO> getAllMembers(int offset, int size);
	public int getTotalMemberCount();
	public List<MemberDTO> getAllMembersWithPagination(HashMap<String, Object> paramMap);
	
	
   }


@Service
class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDAO adminDAO;
    
    @Override
    public List<MemberDTO> getAllMembers(int pageNo, int pageSize) {
        int offset = (pageNo - 1) * pageSize; // pageNo를 offset으로 변환합니다.
        return adminDAO.getAllMembers(offset, pageSize);
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
	
	@Override
	public void decreaseReportCount(String memberId) {
	    adminDAO.decreaseReportCount(memberId);  // 새로운 코드: DAO에서 리포트 카운트 감소
	}

	@Override
	public void adjustBanDate(String memberId) {
        adminDAO.adjustBanDate(memberId);
    }

	@Override
    public int getTotalMemberCount() {
        return adminDAO.getTotalMemberCount(); 
    }

    @Override
    public List<MemberDTO> getAllMembersWithPagination(HashMap<String, Object> paramMap) {
        return adminDAO.getAllMembersWithPagination(paramMap); 
    }
	@Override
	public List<MemberDTO> getAllMembers() {
		// TODO Auto-generated method stub
		return null;
	}
}