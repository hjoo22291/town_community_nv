package Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.websocket.PojoHolder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import Dto.BoardDTO;
import Dto.MemberDTO;
import Dto.TownDTO;
import Service.BoardService;
import Service.MainService;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {
	@Autowired
	@Qualifier("mainServiceImpl")
	MainService service;
	
	@RequestMapping("/main")
	public ModelAndView main(HttpSession session, @RequestParam(value="ti",required=false ,defaultValue="0")int ti) {
		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("member_id") == null) {
			mv.setViewName("/Signin");
			return mv;
		}
		int town_id = (int)session.getAttribute("town_id");
		if (ti == 0) {
			ti = town_id;
		}
		String profile = service.profile((String)session.getAttribute("member_id")).getProfile_image();
		session.setAttribute("profile", profile);
		TownDTO town = service.townView(ti); 
		session.setAttribute("town_name", town.getTown_name());
		List<BoardDTO> popular = service.popularArticles(ti);
		List<BoardDTO> news = service.villageNews(ti);
		List<BoardDTO> placeOfMeeting = service.placeOfMeeting(ti);
		BoardDTO photo = service.todayPhoto(ti);
		if(photo != null) {
		int result = service.photoExhibitionCheck(photo.getBoard_contents());
		if(result <= 1) {
			Document doc2 = Jsoup.parse(photo.getBoard_contents());
			photo.setBoard_preview(doc2.text());
			service.photoExhibition(photo);		
		}
		}
		int board_id = 0;
		if(photo != null) {
			board_id = photo.getBoard_id();
			Document doc2 = Jsoup.parse(photo.getBoard_contents());
			photo.setBoard_contents(doc2.text());
			if(photo.getBoard_fileurl() == null) {
				photo.setBoard_fileurl("img/displayimg.png");
			}			
		}
		List<BoardDTO> photoComment = service.photoComment(board_id);
		BoardDTO youKnow = service.youKnow(ti);
		for(BoardDTO data : popular) {
			Document doc = Jsoup.parse(data.getBoard_contents());
			data.setBoard_contents(doc.text());
			if(data.getBoard_imgurl() == null) {
				int i = (int)((Math.random()*3)+1);
				data.setBoard_imgurl("img/basic_image"+i+".jpg");
			}
		}
		if(youKnow != null) {
			Document doc3 = Jsoup.parse(youKnow.getBoard_contents());
			youKnow.setBoard_contents(doc3.text());	
		}
        try {
            String url = "https://search.naver.com/search.naver?query="+town.getTown_name()+"날씨";
            Document doc = Jsoup.connect(url).get();
            Element icon = doc.selectFirst("div.status_wrap i");
            String iconVal = icon.className();
            Element nowTemp = doc.selectFirst("div.temperature_text strong");
            String nowTempVal = nowTemp.text().substring(5);
            Element compTemp = doc.selectFirst("p.summary span.temperature");
            String compTempVal =compTemp.text();
            String[] words = compTempVal.split("\\s");
            String compDe = words[0];
            String comp = words[1];
            Element weather = doc.selectFirst("p.summary span.weather");
            String weatherVal =weather.text();
            Element bodyTemp = doc.selectFirst("div.sort:nth-child(1) dd.desc");
            String bodyTempVal =bodyTemp.text();
            Element humidity = doc.selectFirst("div.sort:nth-child(2) dd.desc");
            String humidityVal =humidity.text();            
            Element winddirec = doc.selectFirst("div.sort:last-child dt.term");
            String winddirecVal =winddirec.text();
            Element wind = doc.selectFirst("div.sort:last-child dd.desc");
            String windVal =wind.text();
    		mv.addObject("iconVal",iconVal);
    		mv.addObject("nowTempVal",nowTempVal);
    		mv.addObject("compTempVal",compTempVal);
    		mv.addObject("compDe",compDe);
    		mv.addObject("comp",comp);
    		mv.addObject("weatherVal",weatherVal);
    		mv.addObject("bodyTempVal",bodyTempVal);
    		mv.addObject("humidityVal",humidityVal);
    		mv.addObject("winddirecVal",winddirecVal);
    		mv.addObject("windVal",windVal);
    		mv.addObject("town",town);
    		mv.addObject("popular",popular);
    		mv.addObject("news",news);
    		mv.addObject("placeOfMeeting",placeOfMeeting);
    		mv.addObject("photo",photo);
    		mv.addObject("photoComment",photoComment);
    		mv.addObject("youKnow",youKnow);
    		mv.addObject("ti",ti);
    		mv.addObject("town_id",town_id);
    		mv.addObject("profile",profile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mv.setViewName("Main");	
		return mv;
	}
	
	@RequestMapping("/searchAll")
	public ModelAndView search(@RequestParam(value="ti",required=false ,defaultValue="0")int ti,@RequestParam(value="keyword",required=false)String keyword, HttpSession session) {
		ModelAndView mv  = new ModelAndView();
		if (session.getAttribute("member_id") == null) {
			mv.setViewName("/Signin");
			return mv;
		}
		Map<String,Object>map = new HashMap<String,Object>();
		if(ti == 0)
			map.put("town_id", "");
		else
		map.put("town_id", ti);
		if(keyword == null)
			map.put("keyword", "");
		else
			map.put("keyword", keyword);
		String member_id = (String)session.getAttribute("member_id");
		int town_id = (int)session.getAttribute("town_id");
		long resultCount =  service.getContentCountByKeyword(map);
		List<BoardDTO> result =  service.getContentByKeyword(map);
			for(BoardDTO data : result) {
				if(data.getBoard_contents() != null) {
					Document doc3 = Jsoup.parse(data.getBoard_contents());
					data.setBoard_contents(doc3.text());	
				}
			}			
		mv.addObject("keyword",keyword);
		mv.addObject("resultCount",resultCount);
		mv.addObject("result",result);
		mv.addObject("town_id",town_id);
		mv.addObject("ti",ti);
		mv.setViewName("SearchResult");
		return mv;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return ("/Signin");
	}
	
	@RequestMapping("/changeVillage")
	public ModelAndView changeVillage(HttpSession session, @RequestParam(value="ti",required=false ,defaultValue="0")int ti) {
		ModelAndView mv  = new ModelAndView();
		if (session.getAttribute("member_id") == null) {
			mv.setViewName("/Signin");
			return mv;
		}
		String member_id = (String)session.getAttribute("member_id");
		mv.addObject("ti",ti);
		mv.setViewName("ChangeVillage");
		return mv;
	}
	
	@RequestMapping("/ajaxResult")
	@ResponseBody
	public Object loginform(String town_name) {
		ArrayList<TownDTO> town = service.changeVillage(town_name); 
		return town;
	}
}
