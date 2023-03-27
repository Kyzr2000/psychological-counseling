package king.flyz.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.IIOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import king.flyz.pojo.Answer;
import king.flyz.pojo.Course;
import king.flyz.pojo.Expert;
import king.flyz.pojo.Passage;
import king.flyz.pojo.Purse;
import king.flyz.pojo.User;
import king.flyz.service.CourseService;
import king.flyz.service.ExpertService;
import king.flyz.service.PassageService;
import king.flyz.service.PurseService;
import king.flyz.service.UserService;

@Controller
@RequestMapping("/manage")
public class ManageController {
	@Resource
	private PurseService purseService;
	@Resource
	private UserService userService;
	@Resource
	private ExpertService expertService;
	@Resource
	private PassageService passageService;
	@Resource
	private CourseService courseService;
	@RequestMapping("/main")
	public String visit(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) throws IOException {
		//Ҫ����һ���жϣ��ж��û���status�����Ƿ���2������Ա�����ǵĻ��ҿ���������ʣ����Ǿͳ�ȥ
		//�ó��û���½���user
		User user = (User) session.getAttribute("myUser");
		//�û�Ϊ��
		if(user == null)
			return "userHome";
		if(user.getStatus() == 1 || user.getStatus() == 0) 
			return "userHome";	
		return "manage";
	}
	/*
	//ѧϰʱ������õ�
	@RequestMapping("/test1")
	public void ajaxTest1(String name,HttpServletResponse response)throws IOException {
		if("admin".equals(name)) {
			response.getWriter().print("true");
		}else {
			response.getWriter().print("false");
		}
	}
	@RequestMapping("/test2")
	@ResponseBody
	public List<User> ajaxTest2(){
		List<User> list = new ArrayList<User>();
		User u1 = new User();
		User u2 = new User();
		u1.setName("wang");
		u1.setSex("boy");
		u2.setName("wang");
		u2.setSex("boy");
		list.add(u1);
		list.add(u2);
		return list;
	}
	*/
	//����Աҳ���õ�
	//�������û���Ϣ
	@RequestMapping("/user")
	@ResponseBody
	public List<User> userManage(){
		List<User> list = userService.getUserList();
		System.out.println(list);
		return list;
	}
	//�������û�Ǯ��ģ�������
	@RequestMapping("/purse")
	@ResponseBody
	public List<Purse> purseManage(){
		List<Purse> list = purseService.getPurseWithUserList();
		//System.out.println(list);
		return list;
	}
	//ͨ���û��ĳ�ֵ������������
	@RequestMapping(value = "/pass/{passId}")
	@ResponseBody
	public void pass(@PathVariable("passId")Integer passId) throws Exception {
		Purse p = purseService.getPurseById(passId);
		int status = p.getStatus();
		//�����ֵ:1 ,��������:2
		if(status == 1 ) {
			int money = Integer.parseInt(p.getMoney());
			int inMoney = Integer.parseInt(p.getInMoney());
			//��Ǯ
			money += inMoney;
			//�������ݿ��ڵ�money��inMoney
			p.setMoney(String.valueOf(money));
			p.setInMoney("");
			p.setStatus(3);
			purseService.updatePurseByUserId(p);
		}
		else if(status == 2) {
			int money = Integer.parseInt(p.getMoney());
			int outMoney = Integer.parseInt(p.getOutMoney());
			//��Ǯ
			money -= outMoney;
			//�������ݿ��ڵ�money��outMoney
			p.setMoney(String.valueOf(money));
			p.setOutMoney("");
			p.setStatus(3);
			purseService.updatePurseByUserId(p);
		}
		else {
			throw new Exception();
		}
			
	}
	//�ܾ��û��ĳ�ֵ������������
	@RequestMapping(value = "/refuse/{refuseId}")
	@ResponseBody
	public void refuse(@PathVariable("refuseId")Integer refuseId) throws Exception {
		Purse p = purseService.getPurseById(refuseId);
		int status = p.getStatus();
		//�����ֵ:1 ,��������:2
		if(status == 1 ) {
			//�������ݿ��ڵ�inMoney
			p.setInMoney("");
			p.setStatus(4);
			purseService.updatePurseByUserId(p);
		}
		else if(status == 2) {
			//�������ݿ��ڵ�outMoney
			p.setOutMoney("");
			p.setStatus(4);
			purseService.updatePurseByUserId(p);
		}
		else {
			throw new Exception();
		}
	}
	//�������û������Ϊ������ѯʦ������
	@RequestMapping("/registExpert")
	@ResponseBody
	public List<Expert> getExpertList(){
		List<Expert> list = expertService.getExperts();
		//�����õ�û
		System.out.println(list);
		return list;
	}
	//ͨ���û������Ϊ������ѯʦ������
	@RequestMapping(value = "/passRegist/{passId}")
	@ResponseBody
	public void passRegist(@PathVariable("passId")Integer passId) throws Exception {
		//����expert��id��ѯ����expert����
		Expert e = expertService.getExpertById(passId);
		User u = userService.getUserById(e.getUser_id());
		//�����жϸ��û��ǲ����Ѿ���Ϊ��������ѯʦ�����ǣ�ֱ���׸��쳣��ͬʱ�ж����������ǲ��Ǵ�����ˣ�����������Ҳ�׸��쳣
		if(u.getStatus() == 1 || e.getStatus() == 1 || e.getStatus() == 2)
			throw new Exception();
		else {
			//ͨ���û������Ϊ������ѯʦ��expert���ڸ������ݵ�status��Ϊ1
			e.setStatus(1);
			expertService.updateExpertStatusById(e);
			//user���ڸ��û���statusֵ��Ϊ1���û���userHome.jsp�ھ��Ѿ������ѯʦ�ˣ����ڵ�ע��ҳ�棬ǰ��jsֱ�ӹ���
			u.setStatus(1);
			userService.updateUserStatusById(u);
		}
	}
	//ͨ���û������Ϊ������ѯʦ������
	@RequestMapping(value = "/refuseRegist/{refuseId}")
	@ResponseBody
	public void refuseRegist(@PathVariable("refuseId")Integer refuseId) throws Exception {
		//����expert��id��ѯ����expert����
		Expert e = expertService.getExpertById(refuseId);
		User u = userService.getUserById(e.getUser_id());
		//�����жϸ��û��ǲ����Ѿ���Ϊ��������ѯʦ�����ǣ�ֱ���׸��쳣��ͬʱ�ж����������ǲ��Ǵ�����ˣ�����������Ҳ�׸��쳣
		if(u.getStatus() == 1 || e.getStatus() == 1 || e.getStatus() == 2)
			throw new Exception();
		else {
			//�ܾ��û������Ϊ������ѯʦ��expert���ڸ������ݵ�status��Ϊ2
			e.setStatus(2);
			expertService.updateExpertStatusById(e);
		}
	}
	//��ȡ���е���ҳ����
	@RequestMapping("/passageList")
	@ResponseBody
	public List<Passage> passageList(){
		List<Passage> list = passageService.selectPassageList();
		return list;
	}
	//����鿴��ť �鿴һ������
	@RequestMapping("/getPassage/{id}")
	@ResponseBody
	public void getPassage(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Passage p = passageService.selectPassageById(id);
		session.setAttribute("myPassage", p);
	}
	//����༭��ť ͨ��id�õ���ǰ���µ�������ϸ���� ������
	@RequestMapping("/changePassage/{id}")
	@ResponseBody
	public Passage changePassage(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Passage p = passageService.selectPassageById(id);
		return p;
	}
	//����ύ�޸ģ��ύ�޸ĵ�����ҳ���µ�����
	@RequestMapping("/submitChangePassage")
	public void submitChangePassage(Passage p,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//ģ��һ�¿����ܲ����õ�����
		//System.out.println(p);
		//���±�����
		passageService.updatePassageById(p);
	}
	//���ɾ����ť��ɾ��������passage����
	@RequestMapping("/deletePassage/{id}")
	@ResponseBody
	public void deletePassage(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		passageService.deletePassageById(id);
	}
	//�γ̹����й�����
	//��ȡ���еĿγ�
	@RequestMapping("/courseList")
	@ResponseBody
	public List<Course> courseList(){
		List<Course> list = courseService.getCourseList();
		return list;
	}
	//�ڿγ̹����ڵ���鿴��ť
	@RequestMapping("/getCourse/{id}")
	@ResponseBody
	public void getCourse(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Course course = courseService.getCourseByID(id);
		session.setAttribute("myCourse", course);
	}
	//����༭��ť ͨ��id�õ���ǰ�γ̵�������ϸ���� ������
	@RequestMapping("/changeCourse/{id}")
	@ResponseBody
	public Course changeCourse(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Course course = courseService.getCourseByID(id);
		return course;
	}
	//����ύ�޸ģ��ύ�޸ĵ�����ҳ���µ�����
	@RequestMapping("/submitChangeCourse")
	public void submitChangeCourse(Course course,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//ģ��һ�¿����ܲ����õ������γ�
		//System.out.println(course);
		//���±��γ�
		courseService.updateCourseById(course);
	}
	//���ɾ����ť��ɾ��������course����
	@RequestMapping("/deleteCourse/{id}")
	@ResponseBody
	public void deleteCourse(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		courseService.deleteCourseById(id);
	}
	//���ȷ����ӣ����һ����ҳ���µ����ݿ��passage��
	@RequestMapping("/submitAddPassage")
	public void submitAddPassage(Passage passage,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//ģ��һ�¿����ܲ����õ������γ�
		//System.out.println(passage);
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//���ô������µ�ʱ��
		passage.setCreateAt(dateFormat.format(date));
		passageService.addPassage(passage);
	}
	@RequestMapping("/searchPassageList")
	@ResponseBody
	public List<Passage> searchPassageList(String title,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {		
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<Passage> list = new ArrayList<Passage>();
		if(title == "") {
			list = passageService.selectPassageList();
		}
		else {
			list = passageService.getPassageLikely(title);
		}
		return list;
	}
	@RequestMapping("/searchExpertList")
	@ResponseBody
	public List<Expert> searchExpertList(String title,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {		
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<Expert> list = new ArrayList<Expert>();
		if(title == "") {
			list = expertService.getExperts();
		}
		else {
			list = expertService.getExpertLikely(title);
		}
		return list;
	}
	@RequestMapping("/searchPurseList")
	@ResponseBody
	public List<Purse> searchPurseList(String title,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {		
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<Purse> list = new ArrayList<Purse>();
		if(title == "") {
			list = purseService.getPurseWithUserList();
		}
		else {
			list = purseService.getPurseLikely(title);
		}
		return list;
	}
	@RequestMapping("/searchCourseList")
	@ResponseBody
	public List<Course> searchCourseList(String title,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {		
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<Course> list = new ArrayList<Course>();
		if(title == "") {
			list = courseService.getCourseList();
		}
		else {
			list = courseService.getCourseLikely(title);
		}
		return list;
	}
	@RequestMapping("/searchUserList")
	@ResponseBody
	public List<User> searchUserList(String title,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {		
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<User> list = new ArrayList<User>();
		if(title == "") {
			list = userService.getUserList();
		}
		else {
			list = userService.getUserLikely(title);
		}
		return list;
	}
	//���ȷ����ӣ����һ���γ̵�course����
	@RequestMapping("/submitAddCourse")
	public void submitAddCourse(Course course,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//ģ��һ�¿����ܲ����õ������γ�
		//System.out.println(course);
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//���ô����γ̵�ʱ��
		course.setCreateAt(dateFormat.format(date));
		courseService.addCourse(course);
	}
	//ͨ���û���id��ɾ���û���ͬʱҲɾ�����û���Ǯ��
	@RequestMapping("/deleteUser")
	public void deleteUser(Integer id,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//System.out.println(id);
		//ɾ���û�
		userService.deleteUserById(id);
		//ɾ���û���Ǯ��
		purseService.deletePurseByUserId(id);
	}
	//��༭�û�֮��ͨ��id��ȡ��ǰ�û���Ϣ
	@RequestMapping("/getUser")
	@ResponseBody
	public User getUser(Integer id,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		User user = userService.getUserById(id);
		return user;
	}
	//���ȷ�ϱ༭
	@RequestMapping("/submitEditUser")
	public void submitEditUser(User user,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//System.out.println(user);
		if(user.getSex().equals("0"))
			user.setSex("Ů");
		if(user.getSex().equals("1"))
			user.setSex("��");
		//���µ�ʱ��ֻ������£��������Ա����䡢��ϵ��ʽ
		userService.updateUserMessage(user);
	}
	//ͳ�Ʒ���������
	//����û�����
	@RequestMapping("/userNum")
	@ResponseBody
	public int userNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = userService.getUserNum();
		return number;
	}
}
