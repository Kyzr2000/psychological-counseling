package king.flyz.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import com.alibaba.druid.support.json.JSONUtils;

import king.flyz.pojo.Checks;
import king.flyz.pojo.Score;
import king.flyz.pojo.User;
import king.flyz.service.ChecksService;
import king.flyz.service.ScoreService;
import king.flyz.service.UserService;

@Controller
@RequestMapping("/psyTest")
public class PsyTestController {
	@Resource
	private ChecksService checksService;
	@Resource
	private ScoreService scoreService;
	//�������������ҳ��
	@RequestMapping("/main")
	public String psyTest(HttpServletRequest request, HttpServletResponse response, User user,
			Model model,HttpSession session) {
		return "psychologicalTest";
	}
	//��ȡ���������ÿһ��������id������鿴ÿһ����������Ŀ
	@RequestMapping("/getTest/{id}")
	@ResponseBody
	public void getTest(@PathVariable("id")Integer id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		//��id
		session.setAttribute("myChecksID", id);
	}
	//ͨ��title_id��������
	@RequestMapping("/getTestList/{id}")
	@ResponseBody
	public List<Checks> getTestListByID(@PathVariable("id")Integer id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		List<Checks> list = checksService.getCheckByTitleID(id);
		return list;
	}
	//�û�������֮����score���ڲ����û��Ĳ�������                        
	@RequestMapping("/updateScore")
	@ResponseBody
	public void updateScore(Integer score,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		//System.out.println("�ɼ���"+score+"����̨�յ���");
		User user = (User) session.getAttribute("myUser");
		int user_id = user.getId();
		int title_id = (int) session.getAttribute("myChecksID");
		//Score s = (Score) scoreService.getScoreByUidAndTid(user_id, title_id);
		//���°汾��������������ж��Ƿ���ڣ�ֱ�Ӳ���
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		scoreService.addScore(score, user_id, title_id,dateFormat.format(date));
		//�жϸóɼ��Ƿ񲻴��ڣ��������������
		//1.�����ڣ�����Ҫinsertһ��������
		/*
		if(s == null) {
			//System.out.println("������");
			scoreService.addScore(score, user_id, title_id);
		}
		//2.���ڣ����ڵĻ�ֻ��Ҫ����grades���Լ���
		else {
			//System.out.println("����");
			scoreService.updateScoreByUidAndTid(score, user_id, title_id);
		}
		*/
	}
	//���û���ҳ�ġ�������¼���ڣ���ȡ���û����÷���
	@RequestMapping("/getScore")
	@ResponseBody
	public int getScore(Integer title_id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		User user = (User)session.getAttribute("myUser");
		int user_id = user.getId();
		//��ȡ�û������ļ�¼�б�
		List<Score> score = scoreService.getScoreByUidAndTid(user_id, title_id);
		int grades;
		//System.out.println(score);
		if (score.isEmpty()) {
			grades = 0 ;
		}
		else {
			//�Ӻ���ǰѡ�����ķ�������������ķ�����ʾ�����ϲ�
			Score myScore = score.get(score.size() - 1);
			grades = myScore.getGrades();
		}
		return grades;
	}
	//������
	@RequestMapping("/getSuggest")
	@ResponseBody
	public String getSuggest(Integer title_id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		User user = (User)session.getAttribute("myUser");
		int user_id = user.getId();
		List<Score> list = scoreService.getScoreByUidAndTid(user_id, title_id);
		//���û����µĵ÷�
		Score score = list.get(list.size() - 1);
		String suggest;
		if(title_id == 1) {
			if (score == null) {
				suggest = "" ;
			}
			else {
				int grades = score.getGrades();
				if(grades<=45 && grades>=36) {
					suggest = "���������ܴ���ø��ֵ�ѹ��������Ҳ�п��ܻᱻͻ�������Ļ���Ϣ�򵽣������������Ŷ���Ҫ�����Լ���������";
				}
				else {
					suggest = "������������Եĵ÷֣����Ժ����׵�֪������һ�������׽��ǵ��ˣ����ճ������о�������ΪһЩС�¶��о������գ�ϣ���������ճ������б���һ����Ϊ���õ���̬��������ϲ�����Լ�����̹̹����������󷽡�";
				}
			}
		}
		else if(title_id == 2) {
			if (score == null) {
				suggest = "" ;
			}
			else {
				int grades = score.getGrades();
				if(grades<=45 && grades>=36) {
					suggest = "��Ϊ����һ��ϲ�����ֵ��ˣ����䱻���ȴ������Ը������ش�һȺ�˵Ļ��⣬���˽���������˵����ʲô���⣬�෴�㻹��ӵ�������������м�ֵ��������������ܹ�ϵ�־�֢����ͦԶ�ġ�";
				}
				else {
					suggest = "����һ��׷�����������������Щ�Ա����ˣ��㺦������˵Ĺ�ϵ̫�����ܣ�����¶�Լ���Է���ȱ�㣬����֪�Լ��������뽻�����᲻���ڣ������������Ȼһ������Ҫһ����Ķ�����ˡ�";
				}
			}
		}
		else if(title_id == 3) {
			if (score == null) {
				suggest = "" ;
			}
			else {
				int grades = score.getGrades();
				if(grades<=45 && grades>=36) {
					suggest = "����һ���ر�Ե��ˣ��Ա���û��ʲô��ϲ���ĸо�����Ϊ�������Ƕ��Ǻ��������ˣ�û��Ҫ��������ʲô���⣬����Ҳ�Ͳ����������ʲô���ڣ���������̧�����������ˡ������������������ģ��ܹ������Լ�ϲ�����ˣ��Լ�ϲ������Ҳ�����ر�����ͣ��ⶼ��������Ʒ�µı��֡�";
				}
				else {
					suggest = "��Ȼ������˼Ҳ�����̧�ܣ�����Ҳ���ǻ�ȥ���ձ��ˣ���Ϊ����������鱾����Ƕ��˲����¡�һ��Ҫ���Է��������ġ���Ҳ�߱����ָ�����̧�ܵ���������Ȼ���Ǿ��������˼�̧�ܣ�����ҲҪ���������Ļ��ᣬ��Ȼ�Ժ���˻ῴ��ܲ�ˬ����ô�Ժ�����Ӿ�����ˡ�";
				}
			}	
		}
		else if(title_id == 4) {
			if (score == null) {
				suggest = "" ;
			}
			else {
				int grades = score.getGrades();
				if(grades<=90 && grades>=70) {
					suggest = "��Ȼ��һ�����꣬������������������������Ĳ�������ı�־���е���������Ҳ�ǿɰ������ӡ�����������Ҫ�����о�ֹ���壬�����Ǿܾ�����ģ�����ȥ������ķ���һ·�񱼣����ٻ����һ����ģ�Ҳ����ȥ��ʲô�ִ����������Լ���Ҫ��ôȥ˵�̣�ҲҪ�����Լ��Ķ�λ����Ҫ���ö���������";
				}
				else {
					suggest = "�ܶ���һ�����꣬���屾�ʾ��֣�������Ȼ��Ȼ�ģ�������ܾ����Լ���������İɣ���Ҳ����˵ѽ����Ҳ˵��������һЩ�����Ŷ�������ǰ����ִ�����˵�̣�����ʱ��ʱ��Ϸһ�³��úÿ�����ѽ����Ҳ������Ϊ�Լ���������ѽ����������ѽ������������ʶ����������������������ˡ�";
				}
			}	
		}
		else {
			suggest="";
		}
		//SSM����ֵ����JSON���͵ģ�ֱ�Ӵ�String���͵Ĳ��ᱻʶ��
		//������Ҫʹ��JSONUtilsǿ��ת����String��ʽ�ľͿ��Դ���ǰ��
		String s = JSONUtils.toJSONString(suggest);
		return s;
	}
	//ͳ�Ʒ����ڣ���ÿ�����������˵�����
	@RequestMapping("/scoreNum")
	@ResponseBody
	public int scoreNum(Integer title_id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = scoreService.scoreNum(title_id);
		return number;
	}
	//ͬʱ��4���ɼ�
	@RequestMapping("/getScoreList")
	@ResponseBody
	public List<Integer> getScoreList(Integer id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		List<Score> list1 = scoreService.getScoreByUidAndTid(id, 1);
		List<Score> list2 = scoreService.getScoreByUidAndTid(id, 2);
		List<Score> list3 = scoreService.getScoreByUidAndTid(id, 3);
		List<Score> list4 = scoreService.getScoreByUidAndTid(id, 4);
		List<Integer> list = new ArrayList<Integer>();
		if (list1.isEmpty()) {
			list.add(0);
		}
		else {
			Score score1 = list1.get(list1.size() - 1);
			list.add(score1.getGrades());
		}
		if (list2.isEmpty()) {
			list.add(0);
		}
		else {
			Score score2 = list2.get(list2.size() - 1);
			list.add(score2.getGrades());
		}
		if (list3.isEmpty()) {
			list.add(0);
		}
		else {
			Score score3 = list3.get(list3.size() - 1);
			list.add(score3.getGrades());
		}
		if (list4.isEmpty()) {
			list.add(0);
		}
		else {
			Score score4 = list4.get(list4.size() - 1);
			list.add(score4.getGrades());
		}
		return list;
	}
	//ͬʱ��4���ɼ�
	@RequestMapping("/getHisScoreList")
	@ResponseBody
	public List<Score> getHisScoreList(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		//��Ŀǰ��¼���û�id
		User user = (User)session.getAttribute("myUser");
		int id = user.getId();
		List<Score> list = scoreService.getScoreById(id);
		return list;
	}
	//ͬʱ��4���ɼ�
	@RequestMapping("/getHisScoreListById")
	@ResponseBody
	public List<Score> getHisScoreListById(Integer id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		//��Ŀǰ��¼���û�id
		List<Score> list = scoreService.getScoreById(id);
		return list;
	}
}
