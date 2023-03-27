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
		//要进行一个判断，判断用户的status属性是否是2（管理员），是的话我可以让你访问，不是就出去
		//拿出用户登陆后的user
		User user = (User) session.getAttribute("myUser");
		//用户为空
		if(user == null)
			return "userHome";
		if(user.getStatus() == 1 || user.getStatus() == 0) 
			return "userHome";	
		return "manage";
	}
	/*
	//学习时候测试用的
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
	//管理员页面用的
	//拿所有用户信息
	@RequestMapping("/user")
	@ResponseBody
	public List<User> userManage(){
		List<User> list = userService.getUserList();
		System.out.println(list);
		return list;
	}
	//拿所有用户钱包模块的数据
	@RequestMapping("/purse")
	@ResponseBody
	public List<Purse> purseManage(){
		List<Purse> list = purseService.getPurseWithUserList();
		//System.out.println(list);
		return list;
	}
	//通过用户的充值或者提现请求
	@RequestMapping(value = "/pass/{passId}")
	@ResponseBody
	public void pass(@PathVariable("passId")Integer passId) throws Exception {
		Purse p = purseService.getPurseById(passId);
		int status = p.getStatus();
		//请求充值:1 ,请求提现:2
		if(status == 1 ) {
			int money = Integer.parseInt(p.getMoney());
			int inMoney = Integer.parseInt(p.getInMoney());
			//充钱
			money += inMoney;
			//重置数据库内的money和inMoney
			p.setMoney(String.valueOf(money));
			p.setInMoney("");
			p.setStatus(3);
			purseService.updatePurseByUserId(p);
		}
		else if(status == 2) {
			int money = Integer.parseInt(p.getMoney());
			int outMoney = Integer.parseInt(p.getOutMoney());
			//提钱
			money -= outMoney;
			//重置数据库内的money和outMoney
			p.setMoney(String.valueOf(money));
			p.setOutMoney("");
			p.setStatus(3);
			purseService.updatePurseByUserId(p);
		}
		else {
			throw new Exception();
		}
			
	}
	//拒绝用户的充值或者提现请求
	@RequestMapping(value = "/refuse/{refuseId}")
	@ResponseBody
	public void refuse(@PathVariable("refuseId")Integer refuseId) throws Exception {
		Purse p = purseService.getPurseById(refuseId);
		int status = p.getStatus();
		//请求充值:1 ,请求提现:2
		if(status == 1 ) {
			//重置数据库内的inMoney
			p.setInMoney("");
			p.setStatus(4);
			purseService.updatePurseByUserId(p);
		}
		else if(status == 2) {
			//重置数据库内的outMoney
			p.setOutMoney("");
			p.setStatus(4);
			purseService.updatePurseByUserId(p);
		}
		else {
			throw new Exception();
		}
	}
	//拿所有用户申请成为心理咨询师的数据
	@RequestMapping("/registExpert")
	@ResponseBody
	public List<Expert> getExpertList(){
		List<Expert> list = expertService.getExperts();
		//看看拿到没
		System.out.println(list);
		return list;
	}
	//通过用户申请成为心理咨询师的请求
	@RequestMapping(value = "/passRegist/{passId}")
	@ResponseBody
	public void passRegist(@PathVariable("passId")Integer passId) throws Exception {
		//根据expert的id查询整条expert数据
		Expert e = expertService.getExpertById(passId);
		User u = userService.getUserById(e.getUser_id());
		//首先判断该用户是不是已经成为了心理咨询师，若是，直接抛个异常；同时判断这条数据是不是处理过了，如果处理过了也抛个异常
		if(u.getStatus() == 1 || e.getStatus() == 1 || e.getStatus() == 2)
			throw new Exception();
		else {
			//通过用户申请成为心理咨询师后，expert表内该条数据的status改为1
			e.setStatus(1);
			expertService.updateExpertStatusById(e);
			//user表内该用户的status值改为1，用户在userHome.jsp内就已经变成咨询师了，不在弹注册页面，前端js直接过滤
			u.setStatus(1);
			userService.updateUserStatusById(u);
		}
	}
	//通过用户申请成为心理咨询师的请求
	@RequestMapping(value = "/refuseRegist/{refuseId}")
	@ResponseBody
	public void refuseRegist(@PathVariable("refuseId")Integer refuseId) throws Exception {
		//根据expert的id查询整条expert数据
		Expert e = expertService.getExpertById(refuseId);
		User u = userService.getUserById(e.getUser_id());
		//首先判断该用户是不是已经成为了心理咨询师，若是，直接抛个异常；同时判断这条数据是不是处理过了，如果处理过了也抛个异常
		if(u.getStatus() == 1 || e.getStatus() == 1 || e.getStatus() == 2)
			throw new Exception();
		else {
			//拒绝用户申请成为心理咨询师后，expert表内该条数据的status改为2
			e.setStatus(2);
			expertService.updateExpertStatusById(e);
		}
	}
	//读取所有的首页文章
	@RequestMapping("/passageList")
	@ResponseBody
	public List<Passage> passageList(){
		List<Passage> list = passageService.selectPassageList();
		return list;
	}
	//点击查看按钮 查看一个文章
	@RequestMapping("/getPassage/{id}")
	@ResponseBody
	public void getPassage(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Passage p = passageService.selectPassageById(id);
		session.setAttribute("myPassage", p);
	}
	//点击编辑按钮 通过id拿到当前文章的整条详细数据 并返回
	@RequestMapping("/changePassage/{id}")
	@ResponseBody
	public Passage changePassage(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Passage p = passageService.selectPassageById(id);
		return p;
	}
	//点击提交修改，提交修改单条首页文章的数据
	@RequestMapping("/submitChangePassage")
	public void submitChangePassage(Passage p,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//模拟一下看看能不能拿到文章
		//System.out.println(p);
		//更新本文章
		passageService.updatePassageById(p);
	}
	//点击删除按钮后删除掉整条passage数据
	@RequestMapping("/deletePassage/{id}")
	@ResponseBody
	public void deletePassage(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		passageService.deletePassageById(id);
	}
	//课程管理有关内容
	//读取所有的课程
	@RequestMapping("/courseList")
	@ResponseBody
	public List<Course> courseList(){
		List<Course> list = courseService.getCourseList();
		return list;
	}
	//在课程管理内点击查看按钮
	@RequestMapping("/getCourse/{id}")
	@ResponseBody
	public void getCourse(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Course course = courseService.getCourseByID(id);
		session.setAttribute("myCourse", course);
	}
	//点击编辑按钮 通过id拿到当前课程的整条详细数据 并返回
	@RequestMapping("/changeCourse/{id}")
	@ResponseBody
	public Course changeCourse(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Course course = courseService.getCourseByID(id);
		return course;
	}
	//点击提交修改，提交修改单条首页文章的数据
	@RequestMapping("/submitChangeCourse")
	public void submitChangeCourse(Course course,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//模拟一下看看能不能拿到本条课程
		//System.out.println(course);
		//更新本课程
		courseService.updateCourseById(course);
	}
	//点击删除按钮后删除掉整条course数据
	@RequestMapping("/deleteCourse/{id}")
	@ResponseBody
	public void deleteCourse(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		courseService.deleteCourseById(id);
	}
	//点击确认添加，添加一条首页文章到数据库表passage中
	@RequestMapping("/submitAddPassage")
	public void submitAddPassage(Passage passage,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//模拟一下看看能不能拿到本条课程
		//System.out.println(passage);
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//设置创建文章的时间
		passage.setCreateAt(dateFormat.format(date));
		passageService.addPassage(passage);
	}
	@RequestMapping("/searchPassageList")
	@ResponseBody
	public List<Passage> searchPassageList(String title,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {		
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
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
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
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
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
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
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
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
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
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
	//点击确认添加，添加一条课程到course表内
	@RequestMapping("/submitAddCourse")
	public void submitAddCourse(Course course,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//模拟一下看看能不能拿到本条课程
		//System.out.println(course);
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//设置创建课程的时间
		course.setCreateAt(dateFormat.format(date));
		courseService.addCourse(course);
	}
	//通过用户的id来删除用户，同时也删除掉用户的钱包
	@RequestMapping("/deleteUser")
	public void deleteUser(Integer id,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//System.out.println(id);
		//删掉用户
		userService.deleteUserById(id);
		//删掉用户的钱包
		purseService.deletePurseByUserId(id);
	}
	//点编辑用户之后，通过id提取当前用户信息
	@RequestMapping("/getUser")
	@ResponseBody
	public User getUser(Integer id,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		User user = userService.getUserById(id);
		return user;
	}
	//点击确认编辑
	@RequestMapping("/submitEditUser")
	public void submitEditUser(User user,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//System.out.println(user);
		if(user.getSex().equals("0"))
			user.setSex("女");
		if(user.getSex().equals("1"))
			user.setSex("男");
		//更新的时候只允许更新：姓名、性别、邮箱、联系方式
		userService.updateUserMessage(user);
	}
	//统计分析的内容
	//输出用户数量
	@RequestMapping("/userNum")
	@ResponseBody
	public int userNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = userService.getUserNum();
		return number;
	}
}
