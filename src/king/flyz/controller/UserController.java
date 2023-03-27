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
	//用户首页
	@RequestMapping("/main")
	public String visit(HttpServletRequest request, HttpServletResponse response, User user,
			Model model,HttpSession session) {
		return "userHome";
	}
	//在首页内选择“课程” 进入的页面
	@RequestMapping("/course")
	public String courseVisit(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		List<Course> list = courseService.getCourseList();
		//设session，把所有课程传到courseList内
		session.setAttribute("courseList", list);
		return "course";
	}
	@RequestMapping("/courseList")
	@ResponseBody
	public List<Course> courseVisit(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		List<Course> list = courseService.getCourseList();
		return list;
	}
	//随便点击一个课程进行观看，跳转 
	@RequestMapping("/getCourse/{id}")
	@ResponseBody
	public void getPassage(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Course course = courseService.getCourseByID(id);
		session.setAttribute("myCourse",course);
	}
	//输出用户数量
	@RequestMapping("/number")
	@ResponseBody
	public int selectUserNumber(HttpServletRequest request, HttpServletResponse response, User user,
			HttpSession session) {
		int number = userService.getUserNum();
		return number;
	}
	//获取心理咨询系统的男女用户数量
	@RequestMapping("/getNumberBySex")
	@ResponseBody
	public List<Integer> getNumberBySex(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(userService.getManNum());
		list.add(userService.getWomenNum());
		return list;
	}
	//用户登录
	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response, User user,
			Model model,HttpSession session) throws Exception {
		String pwd = MD5Util.md5(user.getPassword());
		String password = userService.getUserPssword(user.getAccount());
		//System.out.println("密码加密后是："+MD5Util.md5(password));
		if(pwd.equals(password)) {
			User myUser = userService.getUserByAccount(user.getAccount());
			String myName = myUser.getName();
			request.getSession().setAttribute("myUser", myUser);
			request.getSession().setAttribute("myName", myName);
			return "redirect:/index.jsp";
		}
		else {
			if(user.getAccount() == "") {
				model.addAttribute("loginInfo", "用户名不能为空");
				return "forward:/jsp/main/login.jsp";
			}
			if(user.getPassword() == "") {
				model.addAttribute("loginInfo", "密码不能为空");
				return "forward:/jsp/main/login.jsp";
			}
		}
		model.addAttribute("loginInfo", "用户名或密码错误，请重新登录！");
		return "forward:/jsp/main/login.jsp";
	}
	//用户退出
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, User user,
			Model model,HttpSession session) {
		session.removeAttribute("myUser");
		session.removeAttribute("myName");
		session.removeAttribute("myPurseStatus");
		return "redirect:/index.jsp";
	}
	//注册，验证用户注册信息
	@RequestMapping("/checkRegister")
	public void checkRegister(HttpServletRequest request,HttpServletResponse response, User user) throws Exception {
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		System.out.println(user);
		String account = user.getAccount();
		User u = userService.getUserByAccount(account);
		//判断用户名是否重复
		if(u == null) {
			//默认用户组 状态码0
			user.setStatus(0);
			Date date = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			//设置创建用户的时间
			user.setCreateAt(dateFormat.format(date));
			//md5密码加密
			String pwd = user.getPassword();
			user.setPassword(MD5Util.md5(pwd));
			int num1 = userService.addUser(user);
			//为新用户创建钱包
			Purse purse = new Purse();
			//因为刚把user放进表里 创建钱包时来不及拿自动递增的id，所以要在查一次id
			User u2 = userService.getUserByAccount(user.getAccount());
			purse.setUser_id(u2.getId());
			purse.setMoney("0");
			int num2 = purseService.addPurse(purse);
			System.out.println("添加成功了，你可以回数据库看看");
		}
		else {
			System.out.println("添加失败了捏，你看看咋回事");
			throw new Exception();
		}
		
	}
	//在userhome里面通过ajax读取用户钱包内有多少钱
	@RequestMapping("/money")
	@ResponseBody
	public String getMoney(HttpSession session) {
		User user = (User) session.getAttribute("myUser");
		int id = user.getId();
		//测试一下拿到id了没
		//System.out.println(id);
		//通过用户id拿钱
		String money = purseService.getMoneyByUserId(id); 
		//拿钱包整体数据
		Purse p = purseService.getPurseByUserId(id);
		session.setAttribute("myPurseStatus", p.getStatus());
		return money;
	}
	//用户提交充值申请
	@RequestMapping("/cz")
	@ResponseBody
	public void cz(String czMoney,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		User user = (User) session.getAttribute("myUser");
		int user_id = user.getId();
		Purse p = purseService.getPurseByUserId(user_id);
		if(p.getStatus()==0) {
			//状态改为正在充值
			p.setStatus(1);
			//添加充值金额
			p.setInMoney(czMoney);
			//System.out.println("后台是可以拿到数据的奥"+p);
			//更新数据库
			int num1 = purseService.updatePurseByUserId(p);
			//System.out.println(num1+"成功？");
			session.setAttribute("myPurseStatus",1);
		}
		else {
			throw new Exception();
		}
	}
	//用户提交提现申请
	@RequestMapping("/tx")
	@ResponseBody
	public void tx(String txMoney,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		User user = (User) session.getAttribute("myUser");
		int user_id = user.getId();
		Purse p = purseService.getPurseByUserId(user_id);
		if(p.getStatus()==0) {
			//状态改为正在提现
			p.setStatus(2);
			//添加提现金额
			p.setOutMoney(txMoney);
			//System.out.println("后台是可以拿到数据的奥"+p);
			//更新数据库
			int num1 = purseService.updatePurseByUserId(p);
			//System.out.println(num1+"成功？");
			session.setAttribute("myPurseStatus",2);
		}
		else {
			throw new Exception();
		}
	}
	//用户取消充值和提现申请
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
	//用户确认充值和提现申请
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
	//普通用户提交 注册心理咨询师的信息
	@RequestMapping("/expertRegist")
	public void expertRegist(HttpSession session,Expert expert,HttpServletRequest request,HttpServletResponse response) throws Exception {
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//获取当前登录的用户
		User user = (User) session.getAttribute("myUser");
		int user_id = user.getId();
		//后端检测一下能不能拿到表单中的数据
		System.out.println(expert);
		//先判断一下当前登录的用户存不存在管理员还没审批的请求，如果存在的话就禁止提交
		if(expertService.boolExpertRequest(user_id) == null) {
			expert.setName(user.getName());
			expert.setUser_id(user_id);
			expertService.addExpert(expert);
		}
		else {
			throw new Exception();
		}
	}
	//在用户首页的设置内修改个人资料信息
	@RequestMapping("/changeMessage")
	public void changeMessage(User user,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		User u = (User) session.getAttribute("myUser");
		user.setId(u.getId());
		//因为更新的时候要用到user的id，所以从session内只拿个id赋值给前端传过来的user
		userService.updateUserMessage(user);
		//更新后的本条用户数据
		u = userService.getUserById(user.getId());
		//登录的session也需要更新一下内容
		session.removeAttribute("myUser");
		session.removeAttribute("myName");
		session.setAttribute("myUser",u);
		session.setAttribute("myName",u.getName());
		//试试能不能拿到
		System.out.println(u);
	}
	//在用户的设置页面处修改用户密码
	@RequestMapping("/changePassword")
	public void changePassword(String pwd,String pwd1,String pwd2,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		//前端ajax序列化form表单会把中文数据传成乱码，得改编码格式
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//拿当前登的用户
		User user = (User) session.getAttribute("myUser");
		String password = MD5Util.md5(pwd);
		//判断原密码和当前用户的密码是否一致，不一致就抛异常
		if(password.equals(user.getPassword())) {
			user.setPassword(MD5Util.md5(pwd1));
			userService.updateUserPassword(user);
		}
		else {
			throw new Exception();
		}
	}
	//心理咨询师的数量
	@RequestMapping("/expertNum")
	@ResponseBody
	public int expertNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = userService.getExpertNum();
		return number;
	}
	//管理员的数量
	@RequestMapping("/adminNum")
	@ResponseBody
	public int adminNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = userService.getAdminNum();
		return number;
	}
	//课程的数量
	@RequestMapping("/courseNum")
	@ResponseBody
	public int courseNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = courseService.courseNum();
		return number;
	}
	//通过id获取用户信息 getUserById
	@RequestMapping("/getUserById")
	@ResponseBody
	public User getUserById(Integer id, HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		User user = userService.getUserById(id);
		return user;
	}
	//alipay 充值
	@RequestMapping("/AlipayCZ")
	@ResponseBody
	public void AlipayCZ(String money,HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		//把本次金额存到session中，用于前台读取
		session.setAttribute("alipayMoney", money);
	}
	//alipay 支付宝沙箱充值成功后，将钱数添加到用户钱包内
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
