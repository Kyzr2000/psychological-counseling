package king.flyz.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.support.json.JSONUtils;

import king.flyz.pojo.Answer;
import king.flyz.pojo.Expert;
import king.flyz.service.ExpertService;

@Controller
@RequestMapping("/expert")
public class ExpertController {
	@Resource
	private ExpertService expertService;
	@RequestMapping("/list")
	public String getExpertList(HttpServletRequest request, HttpServletResponse response,
			Model model,HttpSession session) {
		return "expertAppoint";
	}
	@RequestMapping("/price")
	@ResponseBody
	public String getExpertPrice(int id,HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		//SSM����ֵ����JSON���͵ģ�ֱ�Ӵ�String���͵Ĳ��ᱻʶ��
		//������Ҫʹ��JSONUtilsǿ��ת����String��ʽ�ľͿ��Դ���ǰ��
		String price =	JSONUtils.toJSONString(expertService.getExpertPrice(id));
		return price;
	}
	@RequestMapping("/getList")
	@ResponseBody
	public List<Expert> getList(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		List<Expert> list = expertService.getExperts();
		for(int i=0;i<list.size();i++) {
			System.out.println(list.get(i));
			if(list.get(i).getStatus() == 0 || list.get(i).getStatus() == 2) {
				System.out.println(list.get(i)+"ɾ����");
				list.remove(i);
				//list��removeɾ��Ԫ�غ���һ�������ϲ�λ��������Ҫi--
				i--;
			}
		}
		return list;
	}
	@RequestMapping("/searchList")
	@ResponseBody
	public List<Expert> searchList(String content,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		//ǰ��ajax���л�form������������ݴ�������,�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<Expert> list = new ArrayList<Expert>();
		if(content == "") {
			list = expertService.getExperts();
		}
		else {
			list = expertService.getExpertLikely(content);
		}
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getStatus() == 0 || list.get(i).getStatus() == 2) {
				System.out.println(list.get(i)+"ɾ����");
				list.remove(i);
				//list��removeɾ��Ԫ�غ���һ�������ϲ�λ��������Ҫi--
				i--;
			}
		}
		return list;
	}
}
