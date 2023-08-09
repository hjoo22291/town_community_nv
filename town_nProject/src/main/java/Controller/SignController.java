package Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import Dto.BoardDTO;
import Dto.MemberDTO;
import Service.BoardService;
import Service.BoardService1;
import Service.SignService;
import ServiceImpl.hashService;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;

@Controller
public class SignController {
	
	@Autowired
	@Qualifier("SignService")
	SignService Ss;
	
	@Autowired
	@Qualifier("boardServiceImpl1")
	BoardService1 service;
	
	@Autowired
	@Qualifier("boardServiceImpl")
	BoardService service2;
	
	@Autowired
	private hashService hashService;

	@Value("${hash.bcrypt.number}")
	private int HashNum;
	
	@Value("${admin.role}")
	int admin_role;
	
	
	@RequestMapping("/")
	public ModelAndView in(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("Signin");
		session.invalidate();
		return mv;
	}
	
	@RequestMapping("/Signin")
	public ModelAndView signin() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("Signin");	
		return mv;
	}
	@RequestMapping("/alert")
	public ModelAndView alert() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("alert");	
		return mv;
	}
	//로그인구현
	@PostMapping("/Login")
	public String loginprocess(String member_id, String password,HttpSession session) {
		HashMap<String, Object> map = null;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH시mm분ss초");
		MemberDTO my_info = Ss.MyInfo(member_id);
		Date today = new Date();
		Date date = my_info.getStopclear_date(); 
		String stopdate = simpleDateFormat.format(date);
		int compare = date.compareTo(today); 
		if(my_info != null) {
			if(compare>0) {
				session.setAttribute("msg", "회원님은 "+stopdate+" 까지 정지된 회원입니다");
				session.setAttribute("url", "/");
				return "redirect:/alert";
			}
			if(hashService.matchesBcrypt(password, my_info.getPassword(), HashNum)) {
				if (my_info.getMember_role()==admin_role) {
					session.setAttribute("member_id",my_info.getMember_id());
					session.setAttribute("town_id", my_info.getTown_id());
					session.setAttribute("member_role", my_info.getMember_role());
					return "redirect:/adminManager";
				}
				
				HashMap<String, Object> pointmap = new HashMap<>(); // 포인트 부여 sql에 사용할 파라미터
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String formatDate = sdf.format(today); 
				pointmap.put("member_id", my_info.getMember_id());
				pointmap.put("point_method", "로그인");
				pointmap.put("point_time", formatDate);
				pointmap.put("point_get", 3);
				boolean pointResult = service.addMemberLoginPointOrNot(pointmap); // 포인트를 부여했는지 안 했는지
				boolean gradeUpResult = false; // 회원이 등급 업 했는지 안 했는지
				if (pointResult) { // 포인트가 부여 됐을 때
					gradeUpResult = service.memberGradeUp(my_info.getMember_id());
				}
				map = new HashMap<>();
				session.setAttribute("member_id",my_info.getMember_id());
				session.setAttribute("town_id", my_info.getTown_id());
				session.setAttribute("member_role", my_info.getMember_role());
				int plus_invite = my_info.getInvite_sum();
				plus_invite += 1;
				map.put("member_id", my_info.getMember_id());
				map.put("invite_sum", plus_invite);
				Ss.LoginMember(map);
				return "redirect:/main" ;
			}
	}
		
		session.setAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
		session.setAttribute("url", "/");
		return "redirect:/alert";

	}
	//회원가입
	@RequestMapping("/Signup")
	public ModelAndView signup() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("Signup");	
		return mv;
	}
	
	@PostMapping("/signup")
	public String signup(MemberDTO MemberDTO) {
		
		String password = MemberDTO.getPassword();
		String hashPassword = hashService.encodeBcrypt(password, HashNum);
		MemberDTO.setPassword(hashPassword);
		if(Ss.insertMember(MemberDTO)>0) {
			return "redirect:/Signin";
		}
		else return "Signup";
	}
	//회원가입시 중복체크
	@PostMapping("/dupliIDCheck")
	@ResponseBody
	public int duplieIDcheck(@RequestParam("member_id") String member_id) {
			int cnt=Ss.dupliIDcheck(member_id);
			return cnt;
	}
	
	@PostMapping("/dupliEmailCheck")
	@ResponseBody
	public int duplieEmailcheck(@RequestParam("email") String email) {
			int cnt=Ss.dupliEmailcheck(email);
			return cnt;
	}
	//비밀번호찾기시 id와 이메일 대조 
	@PostMapping("/dupliFindEmailCheck")
	@ResponseBody
	public int duplieFindEmailcheck(@RequestParam("member_id") String member_id,@RequestParam("email") String email) {
			int cnt=Ss.dupliFindEmailcheck(member_id,email);
			return cnt;
	}
	//정보수정 
	@GetMapping("/myinform")
	public ModelAndView myinform(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("member_id") != null) {
			String my_id = session.getAttribute("member_id").toString();
			MemberDTO my_info = Ss.MyInfo(my_id);
			mv.addObject("my_info", my_info);
			
			mv.setViewName("myinform");
		}

		return mv;
	}
	//비밀번호 변경
	@GetMapping("/Updatepassword")
	public ModelAndView updatepassword(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("member_id") != null) {
			
		}
		session.setAttribute("error_message", "");
		mv.setViewName("Updatepassword");
		return mv;
	}
	
	@PostMapping("/Updatepassword2")
	public String updatepassword2(MemberDTO MemberDTO,HttpSession session) {
		
		String my_id = session.getAttribute("member_id").toString();
		MemberDTO my_info = Ss.MyInfo(my_id);
		if(hashService.matchesBcrypt(MemberDTO.getNowpassword(), my_info.getPassword(), HashNum)) {
			if(MemberDTO.getNowpassword().equals(MemberDTO.getPassword())) {
				session.setAttribute("error_message", "현재비밀번호와 새 비밀번호가 같습니다.");
			}
			String password = MemberDTO.getPassword();
			String hashPassword = hashService.encodeBcrypt(password, HashNum);
			MemberDTO.setPassword(hashPassword);
			MemberDTO.setMember_id(my_id);
			Ss.Findpwupdate(MemberDTO);
			return "/Updatepasswordend";
		}
		else {
			session.setAttribute("error_message", "비밀번호를 확인해주세요");
		}
		return "/Updatepassword";
	}	
	
	@PostMapping("/update")
	public String updatemember(MemberDTO MemberDTO) {
		Ss.updatemember(MemberDTO);	
		return"redirect:/myPage";
	}
	//비밀번호 찾기 
	@RequestMapping("/Findpassword")
	public ModelAndView Findpassword() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("Findpassword");	
		return mv;
	}
	
	//비밀번호찾기시 임시비밀번호 변경
	@PostMapping("/Findpwupdate")
	public String Findpwupdate(MemberDTO MemberDTO) {
		String password = MemberDTO.getPassword();
		String hashPassword = hashService.encodeBcrypt(password, HashNum);
		MemberDTO.setPassword(hashPassword);
		Ss.Findpwupdate(MemberDTO);
		
		return"/Findpasswordend";
	}
	//회원삭제
	
	@GetMapping("/deletemember")
	public String deletemember(HttpSession session) {
		HashMap<String, Object> map = new HashMap<>();
		String member_id = String.valueOf(session.getAttribute("member_id"));
		MemberDTO my_info =Ss.MyInfo(member_id);		
		map.put("member_id", member_id);
		map.put("name",my_info.getName());
		map.put("phone", my_info.getPhone());
		map.put("email", my_info.getEmail());
		map.put("signup_date", my_info.getSignup_date());
		Ss.deletememberinsert(map);
		Ss.deletemember(member_id);
		service2.deleteAllBoard(member_id);
		service2.deleteAllComment(member_id);
		session.invalidate();
		return "redirect:/Signin";
	}
	
	
	
	
	
	//마이페이지 구현단 -종인/영우같이 구현
	@RequestMapping("/myPage")
	public ModelAndView mypage(HttpSession session) {
	
	ModelAndView mv = new ModelAndView();
	// session으로 전달된 회원 아이디가 null이면 로그인 화면으로 이동
	if (session.getAttribute("member_id") == null) {
		mv.setViewName("/Signin");
		return mv;
	}
	
	HashMap<String, Object> map = new HashMap<>();
	String my_id = session.getAttribute("member_id").toString();
	MemberDTO my_info = Ss.MyInfo(my_id);
	SimpleDateFormat formater = new SimpleDateFormat("yyyy년 MM월 dd일");
	Date my_signup_date =my_info.getSignup_date();
	String Signup_date= formater.format(my_signup_date);
	
	map.put("member_id", session.getAttribute("member_id"));
	int MyTotalArticleCount = Ss.getMyTotalArticleCount(map); //내가 쓴 글 갯수
	int MycommentTotalArticleCount = Ss.getMycommentTotalArticleCount(map);//내가 쓴 댓글 갯수
	int getMygoodTotalArticleCount = Ss.getMygoodTotalArticleCount(map);//내가 좋아요 한 글 갯수
	int getmyphotocnt=Ss.getmyphotocnt(map);
	
	// 마이페이지 경험치 바 구현
	HashMap<String, Object> memberGradeInfo = Ss.getMemberGradeInfo(my_id);
	int grade_cut_left = (int) memberGradeInfo.get("grade_cut_left");
	int grade_cut_right = (int) memberGradeInfo.get("grade_cut_right");
	String gradeImage = (String) memberGradeInfo.get("grade_image");
	int point = my_info.getPoint();
	int gradeRange = grade_cut_right - grade_cut_left;
	int gradeProgress = point - grade_cut_left;
	String gradePercent = String.format("%.1f", ((double) gradeProgress) / gradeRange * 100);
	mv.addObject("gradeRange", gradeRange);
	mv.addObject("gradeProgress", gradeProgress);
	mv.addObject("gradePercent", gradePercent);
	mv.addObject("gradeImage", gradeImage);
	// 마이페이지 경험치 바 구현 끝
	
	mv.addObject("getmyphotocnt",getmyphotocnt);
	mv.addObject("MyTotalArticleCount",MyTotalArticleCount);
	mv.addObject("MycommentTotalArticleCount",MycommentTotalArticleCount);
	mv.addObject("getMygoodTotalArticleCount",getMygoodTotalArticleCount);
	mv.addObject("Signup_date",Signup_date);
	mv.addObject("my_info", my_info);
	
	mv.setViewName("myPage");
	
	return mv;
	}
	
	//마이페이지 구현단 
		@RequestMapping("/myPage2")
		public ModelAndView mypage2(
			HttpSession session,
			@RequestParam(value="ctgy", required=false, defaultValue="My page") String ctgy,
			@RequestParam(value="page", required=false, defaultValue="1") int page
		) {
		
		ModelAndView mv = new ModelAndView();
		// session으로 전달된 회원 아이디가 null이면 로그인 화면으로 이동
		if (session.getAttribute("member_id") == null) {
			mv.setViewName("/Signin");
			return mv;
		}
		mv.setViewName("myPage2");
		
		
		// 페이징 처리
		int postCntPerPage = 20; // 한 페이지에 표시할 게시글 수
		int pageCntPerPage = 10; // 한번에 표시할 페이지 개수
		int totalPostCnt = 0; // 전체 게시글 개수
		int totalPageCnt = 0; // 전체 페이지 개수
		int endPageNum = 0; // 현재 페이지에서 가장 끝 페이지 수
		int startPageNum = 0; // 현재 페이지에서 가장 첫 페이지 수
		boolean prev = true; // ◁, ◁◁ 버튼 표시 여부
		boolean next = true; // ▷, ▷▷ 버튼 표시 여부
		HashMap<String, Object> map = null; // 검색 안 했을 때 sql에 사용할 변수
		
		 // 게시판 검색을 하지 않은 경우 총 게시글 수
		map = new HashMap<>();
		map.put("member_id", session.getAttribute("member_id"));
		
		if (ctgy.equals("내가 쓴 글")) {
			totalPostCnt = Ss.getMyTotalArticleCount(map);
		} else if (ctgy.equals("내가 쓴 댓글")) {
			totalPostCnt = Ss.getMycommentTotalArticleCount(map);
		} else if (ctgy.equals("좋아요 한 글")) {
			totalPostCnt = Ss.getMygoodTotalArticleCount(map);
		}
		
		
		totalPageCnt = (int) Math.ceil((double) totalPostCnt / (double) postCntPerPage); // 총 게시판 페이지 개수
		if (page < 1 || page > totalPageCnt) {
			page = 1;
		}
		endPageNum = (int) (Math.ceil((double) page / (double) pageCntPerPage) * pageCntPerPage); // 표시되는 페이지 번호 중 마지막 번호
		startPageNum = endPageNum - (pageCntPerPage - 1);
		// 마지막 페이지 다시 계산
		int endPageNumTemp = (int) (Math.ceil((double) totalPostCnt / (double) postCntPerPage));
		if (endPageNum > endPageNumTemp) {
			endPageNum = endPageNumTemp;
		}
		prev = startPageNum == 1 ? false : true;
		next = endPageNum * postCntPerPage >= totalPostCnt ? false : true;
		
		// sql limit절에 들어갈 숫자 List
		int limitindex = (page - 1) * postCntPerPage;
		int limitcount = postCntPerPage;
		
		
		// 페이징 처리된 게시글 리스트
		List<BoardDTO> boardlist = null;
		map.put("limitindex", limitindex);
		map.put("limitcount", limitcount);
		if (ctgy.equals("내가 쓴 글")) {
			boardlist = Ss.getMyPagingBoardlist(map);
		} else if (ctgy.equals("내가 쓴 댓글")) {
			boardlist = Ss.getMycommentPagingBoardlist(map);
		} else if (ctgy.equals("좋아요 한 글")) {
			boardlist = Ss.getMygoodPagingBoardlist(map);
		}
		
		mv.addObject("ctgy", ctgy);
		mv.addObject("selectedPageNum", page);
		mv.addObject("postCntPerPage", postCntPerPage);
		mv.addObject("totalPostCnt", totalPostCnt);
		mv.addObject("totalPageCnt", totalPageCnt);
		mv.addObject("pageCntPerPage", pageCntPerPage);
		mv.addObject("endPageNum", endPageNum);
		mv.addObject("startPageNum", startPageNum);
		mv.addObject("prev", prev);
		mv.addObject("next", next);
		mv.addObject("boardlist", boardlist);
		return mv;
		}
	
	//이메일 구현단
	@Autowired
	JavaMailSender javaMailSender;
	
	@PostMapping("/CheckMail") 
	@ResponseBody  
	//회원가입시 이메일 인증번호 발송
	public String SendMail(String email) {
		Random random=new Random(); 
		String key=""; 
		for(int i =0; i<3;i++) {
			int index=random.nextInt(25)+65; 
			key+=(char)index;
		}
		int numIndex=random.nextInt(99999)+10000; 
		key+=numIndex;
		
		MimeMessage message = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, "utf-8");
		String mail = "kakaoclone@naver.com";
		try {
			helper.setFrom(mail);
			helper.setTo(email);
			
			helper.setSubject("인증번호 입력을 위한 메일 전송");
			helper.setText("[동네일보] 인증번호["+key+"]를 입력해 주세요." ,true);
			javaMailSender.send(message);
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		
        return key;
	}
	
	@PostMapping("/FindpwSendEmail")
	@ResponseBody
	//비밀번호 찾기시 이메일로 임시 비밀번호 전송
	public String FindSendMail(String email) {
		Random random=new Random(); 
		String key="!@";  

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email); 
		for(int i =0; i<4;i++) {
			int index=random.nextInt(25)+65; 
			key+=(char)index;
		}
		int numIndex=random.nextInt(99999)+10000; 
		key+=numIndex;
		message.setSubject("임시비밀번호을 위한 메일 전송");
		message.setText("[동네일보] 임시비밀번호는: "+key+"입니다.");
		message.setFrom("kakaoclone@naver.com");
		javaMailSender.send(message);
		
		
        return key;	
        }
}
