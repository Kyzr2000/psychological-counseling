package king.flyz.controller;

import java.io.UnsupportedEncodingException;
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

import king.flyz.pojo.Answer;
import king.flyz.pojo.Comment;
import king.flyz.pojo.Passage;
import king.flyz.pojo.User;
import king.flyz.service.AnswerService;
import king.flyz.service.CommentService;

@Controller
@RequestMapping("/answer")
public class AnswerController {
	@Resource
	private AnswerService answerService;
	@Resource
	private CommentService commentService;
	@RequestMapping("/main")
	public String answerVisit(HttpServletRequest request, HttpServletResponse response,Model model,HttpSession session) {
		return "answer";
	}
	@RequestMapping("/list")
	@ResponseBody
	public List<Answer> answerList(HttpServletRequest request, HttpServletResponse response,HttpSession session) {		
		List<Answer> list = answerService.getAnswerList();
		return list;
	}
	@RequestMapping("/searchList")
	@ResponseBody
	public List<Answer> searchList(String content,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {		
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ 
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<Answer> list = new ArrayList<Answer>();
		if(content == "") {
			list = answerService.getAnswerList();
		}
		else {
			list = answerService.getAnswerLikely(content,content,content);
			System.out.println(content);
			System.out.println(list);
		}
		return list;
	}
	//Ϊ��ǰ��򿪵���������һ��session��myAnswer
	@RequestMapping("/getAnswer/{id}")
	@ResponseBody
	public void getAnswer(@PathVariable("id")Integer id,HttpSession session)throws Exception{
		Answer answer = answerService.getAnswerByID(id);
		session.setAttribute("myAnswer", answer);
	}
	//����������ҳ�����Լ�������
	@RequestMapping("/getAnswerListById")
	@ResponseBody
	public List<Answer> getAnswerListById(Integer id,HttpSession session)throws Exception{
		List<Answer> list = answerService.getAnswerListById(id);
		return list;
	}
	//Ϊ��������
	@RequestMapping("/comment")
	public void comment(String article,HttpSession session,HttpServletRequest request, HttpServletResponse response)throws Exception{
		//ǰ��ajax���л�form������������ݴ������룬�øı����ʽ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		Comment comment = new Comment();
		User user = (User) session.getAttribute("myUser");
		Answer answer = (Answer) session.getAttribute("myAnswer");
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		System.out.println(article);
		System.out.println(user.getId());
		System.out.println(answer.getId());
		System.out.println(dateFormat.format(date));
		if(user != null) {
			comment.setArticle(article);
			comment.setUser_id(user.getId());
			comment.setAnswer_id(answer.getId());
			comment.setCreateAt(dateFormat.format(date));
			commentService.addComment(comment);
		}
		else 
			throw new Exception();
		
	}
	//���ص�ǰ���ӵ���������   commentList
	@RequestMapping("/commentList")
	@ResponseBody
	public List<Comment> commentList(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		Answer answer = (Answer) session.getAttribute("myAnswer");
		int answer_id = answer.getId();
		List<Comment> list = commentService.getCommentListByAnswerID(answer_id);
		return list;
	}
	//uploadAnswer�ϴ���answer���ݿ����
	@RequestMapping("/uploadAnswer")
	public void uploadAnswer(Answer answer,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		String title = answer.getTitle();
		String article = answer.getArticle();
		if(title!="" && article!="") {
			User user = (User) session.getAttribute("myUser");
			//System.out.println(answer);
			answer.setUser_id(user.getId());
			answer.setStatus(0);
			//����ʱ��
			Date date = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			answer.setCreateAt(dateFormat.format(date));
			//System.out.println(answer);
			answerService.addAnswer(answer);
		}
		else {
			throw new Exception();
		}
	}
	//���ӵ�����
	@RequestMapping("/answerNum")
	@ResponseBody
	public int answerNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = answerService.answerNum();
		return number;
	}
	//��������
	@RequestMapping("/commentNum")
	@ResponseBody
	public int commentNum(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = commentService.commentNum();
		return number;
	}
}
