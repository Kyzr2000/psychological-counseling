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
//�������Controller���Ŀ����Ϊ�˷��������ҳ��һЩ����
public class IndexController {
	@Resource
	private PassageService passageService;
	//����ҳ��࣬��ȡ���ݿ����������²�չʾ
	@RequestMapping("/passage")
	@ResponseBody
	public List<Passage> getPassageList(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		List<Passage> list = passageService.selectPassageList();
		return list;
	}
	//����ҳ�������£��������µ�����ҳ��
	@RequestMapping(value = "/article/{id}")
	public void article(@PathVariable("id")Integer id,HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) throws Exception {
		System.out.println("�Ҳ���һ��passage��id��"+id);
		//ͨ��id�����ݿ��ڵ��������ݲ��ҷ��ظ�ǰ��ҳ��
		Passage p = passageService.selectPassageById(id);
		System.out.println(p);
		//��session�ɣ���ʱû�뵽���õİ취
		session.setAttribute("myPassage", p);
	}
	//ģ������
	@RequestMapping(value = "/searchList")
	@ResponseBody
	public List<Passage> searchList(String title,HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) throws Exception {
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<Passage> list = passageService.getPassageLikely(title);
		return list;
	}
	//��������
	@RequestMapping("/passageNum")
	@ResponseBody
	public int passageNum(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		int num = passageService.passageNum();
		return num;
	}
}
