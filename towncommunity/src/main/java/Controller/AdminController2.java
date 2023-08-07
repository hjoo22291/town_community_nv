//관리자컨트롤러생성
package Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController2 {
	
	@RequestMapping("/manager")
	public ModelAndView manager() {	
		ModelAndView mv = new ModelAndView();
		mv.setViewName("managerPage");
		return mv;
	}
	
	@RequestMapping("/manager2")
	public ModelAndView manager2() {	
		ModelAndView mv = new ModelAndView();
		mv.setViewName("managerPage2");
		return mv;
	}
	
}