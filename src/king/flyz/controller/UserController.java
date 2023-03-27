package king.flyz.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javassist.compiler.ast.Visitor;
import javassist.expr.NewArray;
import king.flyz.pojo.Course;
import king.flyz.pojo.Expert;
import king.flyz.pojo.Passage;
import king.flyz.pojo.Purse;
import king.flyz.pojo.User;
import king.flyz.service.CourseService;
import king.flyz.service.ExpertService;
import king.flyz.service.PurseService;
import king.flyz.service.UserService;
import king.flyz.utils.MD5Util;

@Controller
@RequestMapping(value = "/user")
public class UserController {

	@Resource
	private UserService userService;
	@Resource
	private PurseService purseService;
	@Resource
	private ExpertService expertService;
	@Resource
	private CourseService courseService;
	//�û���ҳ
	@RequestMapping("/main")
	public String visit(HttpServletRequest request, HttpServletResponse response, User user,
			Model model,HttpSession session) {
		return "userHome";
	}
	//����ҳ��ѡ�񡰿γ̡� �����ҳ��
	@RequestMapping("/course")
	public String courseVisit(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		List<Course> list = courseService.getCourseList();
		//��session�������пγ̴���courseList��
		session.setAttribute("courseList", list);
		return "course";
	}
	@RequestMapping("/courseList")
	@ResponseBody
	public List<Course> courseVisit(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		List<Course> list = courseService.getCourseList();
		return list;
	}
	//�����һ���γ̽��йۿ�����ת 
	@RequestMapping("/getCourse/{id}")
	@ResponseBody
	public void getPassage(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Course course = courseService.getCourseByID(id);
		session.setAttribute("myCourse",course);
	}
	//����û�����
	@RequestMapping("/number")
	@ResponseBody
	public int selectUserNumber(HttpServletRequest request, HttpServletResponse response, User user,
			HttpSession session) {
		int number = userService.getUserNum();
		return number;
	}
	//��ȡ������ѯϵͳ����Ů�û�����
	@RequestMapping("/getNumberBySex")
	@ResponseBody
	public List<Integer> getNumberBySex(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(userService.getManNum());
		list.add(userService.getWomenNum());
		return list;
	}
	//�û���¼
	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response, User user,
			Model model,HttpSession session) throws Exception {
		String pwd = MD5Util.md5(user.getPassword());
		String password = userService.getUserPssword(user.getAccount());
		//System.out.println("������ܺ��ǣ�"+MD5Util.md5(password));
		if(pwd.equals(password)) {
			User myUser = userService.getUserByAccount(user.getAccount());
			String myName = myUser.getName();
			request.getSession().setAttribute("myUser", myUser);
			request.getSession().setAttribute("myName", myName);
			return "redirect:/index.jsp";
		}
		else {
			if(user.getAccount() == "") {
				model.addAttribute("loginInfo", "�û�������Ϊ��");
				return "forward:/jsp/main/login.jsp";
			}
			if(user.getPassword() == "") {
				model.addAttribute("loginInfo", "���벻��Ϊ��");
				return "forward:/jsp/main/login.jsp";
			}
		}
		model.addAttribute("loginInfo", "�û�����������������µ�¼��");
		return "forward:/jsp/main/login.jsp";
	}
	//�û��˳�
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, User user,
			Model model,HttpSession session) {
		session.removeAttribute("myUser");
		session.removeAttribute("myName");
		session.removeAttribute("myPurseStatus");
		return "redirect:/index.jsp";
	}
	//ע�ᣬ��֤�û�ע����Ϣ
	@RequestMapping("/checkRegister")
	public void checkRegister(HttpServletRequest request,HttpServletResponse response, User user) throws Exception {
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		System.out.println(user);
		String account = user.getAccount();
		User u = userService.getUserByAccount(account);
		//�ж��û����Ƿ��ظ�
		if(u == null) {
			//Ĭ���û��� ״̬��0
			user.setStatus(0);
			Date date = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			//���ô����û���ʱ��
			user.setCreateAt(dateFormat.format(date));
			//md5�������
			String pwd = user.getPassword();
			user.setPassword(MD5Util.md5(pwd));
			int num1 = userService.addUser(user);
			//Ϊ���û�����Ǯ��
			Purse purse = new Purse();
			//��Ϊ�հ�user�Ž����� ����Ǯ��ʱ���������Զ�������id������Ҫ�ڲ�һ��id
			User u2 = userService.getUserByAccount(user.getAccount());
			purse.setUser_id(u2.getId());
			purse.setMoney("0");
			int num2 = purseService.addPurse(purse);
			System.out.println("��ӳɹ��ˣ�����Ի����ݿ⿴��");
		}
		else {
			System.out.println("���ʧ�������㿴��զ����");
			throw new Exception();
		}
		
	}
	//��userhome����ͨ��ajax��ȡ�û�Ǯ�����ж���Ǯ
	@RequestMapping("/money")
	@ResponseBody
	public String getMoney(HttpSession session) {
		User user = (User) session.getAttribute("myUser");
		int id = user.getId();
		//����һ���õ�id��û
		//System.out.println(id);
		//ͨ���û�id��Ǯ
		String money = purseService.getMoneyByUserId(id); 
		//��Ǯ����������
		Purse p = purseService.getPurseByUserId(id);
		session.setAttribute("myPurseStatus", p.getStatus());
		return money;
	}
	//�û��ύ��ֵ����
	@RequestMapping("/cz")
	@ResponseBody
	public void cz(String czMoney,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		User user = (User) session.getAttribute("myUser");
		int user_id = user.getId();
		Purse p = purseService.getPurseByUserId(user_id);
		if(p.getStatus()==0) {
			//״̬��Ϊ���ڳ�ֵ
			p.setStatus(1);
			//��ӳ�ֵ���
			p.setInMoney(czMoney);
			//System.out.println("��̨�ǿ����õ����ݵİ�"+p);
			//�������ݿ�
			int num1 = purseService.updatePurseByUserId(p);
			//System.out.println(num1+"�ɹ���");
			session.setAttribute("myPurseStatus",1);
		}
		else {
			throw new Exception();
		}
	}
	//�û��ύ��������
	@RequestMapping("/tx")
	@ResponseBody
	public void tx(String txMoney,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		User user = (User) session.getAttribute("myUser");
		int user_id = user.getId();
		Purse p = purseService.getPurseByUserId(user_id);
		if(p.getStatus()==0) {
			//״̬��Ϊ��������
			p.setStatus(2);
			//������ֽ��
			p.setOutMoney(txMoney);
			//System.out.println("��̨�ǿ����õ����ݵİ�"+p);
			//�������ݿ�
			int num1 = purseService.updatePurseByUserId(p);
			//System.out.println(num1+"�ɹ���");
			session.setAttribute("myPurseStatus",2);
		}
		else {
			throw new Exception();
		}
	}
	//�û�ȡ����ֵ����������
	@RequestMapping("/cancelPurse")
	@ResponseBody
	public void cancel(HttpSession session) {
		User user = (User) session.getAttribute("myUser");
		int id = user.getId();
		Purse p = purseService.getPurseById(id);
		p.setInMoney("");
		p.setOutMoney("");
		p.setStatus(0);
		session.setAttribute("myPurseStatus",0);
		purseService.updatePurseByUserId(p);
	}
	//�û�ȷ�ϳ�ֵ����������
	@RequestMapping("/accpetPurse")
	@ResponseBody
	public void accpet(HttpSession session) {
		User user = (User) session.getAttribute("myUser");
		int id = user.getId();
		Purse p = purseService.getPurseById(id);
		p.setInMoney("");
		p.setOutMoney("");
		p.setStatus(0);
		session.setAttribute("myPurseStatus",0);
		purseService.updatePurseByUserId(p);
	}
	//��ͨ�û��ύ ע��������ѯʦ����Ϣ
	@RequestMapping("/expertRegist")
	public void expertRegist(HttpSession session,Expert expert,HttpServletRequest request,HttpServletResponse response) throws Exception {
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//��ȡ��ǰ��¼���û�
		User user = (User) session.getAttribute("myUser");
		int user_id = user.getId();
		//��˼��һ���ܲ����õ����е�����
		System.out.println(expert);
		//���ж�һ�µ�ǰ��¼���û��治���ڹ���Ա��û����������������ڵĻ��ͽ�ֹ�ύ
		if(expertService.boolExpertRequest(user_id) == null) {
			expert.setName(user.getName());
			expert.setUser_id(user_id);
			expertService.addExpert(expert);
		}
		else {
			throw new Exception();
		}
	}
	//���û���ҳ���������޸ĸ���������Ϣ
	@RequestMapping("/changeMessage")
	public void changeMessage(User user,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		User u = (User) session.getAttribute("myUser");
		user.setId(u.getId());
		//��Ϊ���µ�ʱ��Ҫ�õ�user��id�����Դ�session��ֻ�ø�id��ֵ��ǰ�˴�������user
		userService.updateUserMessage(user);
		//���º�ı����û�����
		u = userService.getUserById(user.getId());
		//��¼��sessionҲ��Ҫ����һ������
		session.removeAttribute("myUser");
		session.removeAttribute("myName");
		session.setAttribute("myUser",u);
		session.setAttribute("myName",u.getName());
		//�����ܲ����õ�
		System.out.println(u);
	}
	//���û�������ҳ�洦�޸��û�����
	@RequestMapping("/changePassword")
	public void changePassword(String pwd,String pwd1,String pwd2,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//�õ�ǰ�ǵ��û�
		User user = (User) session.getAttribute("myUser");
		String password = MD5Util.md5(pwd);
		//�ж�ԭ����͵�ǰ�û��������Ƿ�һ�£���һ�¾����쳣
		if(password.equals(user.getPassword())) {
			user.setPassword(MD5Util.md5(pwd1));
			userService.updateUserPassword(user);
		}
		else {
			throw new Exception();
		}
	}
	//������ѯʦ������
	@RequestMapping("/expertNum")
	@ResponseBody
	public int expertNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = userService.getExpertNum();
		return number;
	}
	//����Ա������
	@RequestMapping("/adminNum")
	@ResponseBody
	public int adminNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = userService.getAdminNum();
		return number;
	}
	//�γ̵�����
	@RequestMapping("/courseNum")
	@ResponseBody
	public int courseNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = courseService.courseNum();
		return number;
	}
	//ͨ��id��ȡ�û���Ϣ getUserById
	@RequestMapping("/getUserById")
	@ResponseBody
	public User getUserById(Integer id, HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		User user = userService.getUserById(id);
		return user;
	}
	//alipay ��ֵ
	@RequestMapping("/AlipayCZ")
	@ResponseBody
	public void AlipayCZ(String money,HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		//�ѱ��ν��浽session�У�����ǰ̨��ȡ
		session.setAttribute("alipayMoney", money);
	}
	//alipay ֧����ɳ���ֵ�ɹ��󣬽�Ǯ����ӵ��û�Ǯ����
	@RequestMapping("/alipaySuccess")
	public String alipaySuccess(HttpServletRequest request, HttpServletResponse response,
			Model model,HttpSession session) {
		User user = (User) session.getAttribute("myUser");
		int id = user.getId();
		Purse p = purseService.getPurseById(id);
		String money = (String)session.getAttribute("alipayMoney");
		int finalMoney = Integer.parseInt(p.getMoney()) + Integer.parseInt(money);
		p.setMoney(String.valueOf(finalMoney));
		purseService.updateIOPurse(p);
		return "userHome";
	}
}
