package king.flyz.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import king.flyz.pojo.Passage;
import king.flyz.service.PassageService;



@Controller
@RequestMapping("/index")
//创建这个Controller类的目的是为了方便操作首页的一些功能
public class IndexController {
	@Resource
	private PassageService passageService;
	//在首页左侧，获取数据库内所有文章并展示
	@RequestMapping("/passage")
	@ResponseBody
	public List<Passage> getPassageList(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		List<Passage> list = passageService.selectPassageList();
		return list;
	}
	//点首页左侧的文章，进入文章的详情页面
	@RequestMapping(value = "/article/{id}")
	public void article(@PathVariable("id")Integer id,HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) throws Exception {
		System.out.println("我测试一下passage的id是"+id);
		//通过id查数据库内的整条数据并且返回给前端页面
		Passage p = passageService.selectPassageById(id);
		System.out.println(p);
		//存session吧，暂时没想到更好的办法
		session.setAttribute("myPassage", p);
	}
	//模糊搜索
	@RequestMapping(value = "/searchList")
	@ResponseBody
	public List<Passage> searchList(String title,HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) throws Exception {
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<Passage> list = passageService.getPassageLikely(title);
		return list;
	}
	//文章数量
	@RequestMapping("/passageNum")
	@ResponseBody
	public int passageNum(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		int num = passageService.passageNum();
		return num;
	}
}
