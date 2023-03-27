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
	//访问心理测评首页面
	@RequestMapping("/main")
	public String psyTest(HttpServletRequest request, HttpServletResponse response, User user,
			Model model,HttpSession session) {
		return "psychologicalTest";
	}
	//提取心理测评的每一个测评的id，方便查看每一个测评的题目
	@RequestMapping("/getTest/{id}")
	@ResponseBody
	public void getTest(@PathVariable("id")Integer id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		//存id
		session.setAttribute("myChecksID", id);
	}
	//通过title_id拿所有题
	@RequestMapping("/getTestList/{id}")
	@ResponseBody
	public List<Checks> getTestListByID(@PathVariable("id")Integer id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		List<Checks> list = checksService.getCheckByTitleID(id);
		return list;
	}
	//用户答完题之后，向score表内插入用户的测评分数                        
	@RequestMapping("/updateScore")
	@ResponseBody
	public void updateScore(Integer score,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		//System.out.println("成绩是"+score+"，后台收到！");
		User user = (User) session.getAttribute("myUser");
		int user_id = user.getId();
		int title_id = (int) session.getAttribute("myChecksID");
		//Score s = (Score) scoreService.getScoreByUidAndTid(user_id, title_id);
		//最新版本的心理测评无需判断是否存在，直接插入
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		scoreService.addScore(score, user_id, title_id,dateFormat.format(date));
		//判断该成绩是否不存在，可能有两种情况
		//1.不存在，所以要insert一条新数据
		/*
		if(s == null) {
			//System.out.println("不存在");
			scoreService.addScore(score, user_id, title_id);
		}
		//2.存在，存在的话只需要更新grades属性即可
		else {
			//System.out.println("存在");
			scoreService.updateScoreByUidAndTid(score, user_id, title_id);
		}
		*/
	}
	//在用户首页的“测评记录”内，获取本用户所得分数
	@RequestMapping("/getScore")
	@ResponseBody
	public int getScore(Integer title_id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		User user = (User)session.getAttribute("myUser");
		int user_id = user.getId();
		//获取用户测评的记录列表
		List<Score> score = scoreService.getScoreByUidAndTid(user_id, title_id);
		int grades;
		//System.out.println(score);
		if (score.isEmpty()) {
			grades = 0 ;
		}
		else {
			//从后往前选最后面的分数，就是最近的分数显示在最上层
			Score myScore = score.get(score.size() - 1);
			grades = myScore.getGrades();
		}
		return grades;
	}
	//给建议
	@RequestMapping("/getSuggest")
	@ResponseBody
	public String getSuggest(Integer title_id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		User user = (User)session.getAttribute("myUser");
		int user_id = user.getId();
		List<Score> list = scoreService.getScoreByUidAndTid(user_id, title_id);
		//拿用户最新的得分
		Score score = list.get(list.size() - 1);
		String suggest;
		if(title_id == 1) {
			if (score == null) {
				suggest = "" ;
			}
			else {
				int grades = score.getGrades();
				if(grades<=45 && grades>=36) {
					suggest = "基本上你能处理好各种的压力，但是也有可能会被突如其来的坏消息打到，让情绪产生扰动，要相信自己的能力。";
				}
				else {
					suggest = "根据您本项测试的得分，可以很容易的知道您是一个很容易焦虑的人，在日常生活中经常会因为一些小事而感觉到烦恼，希望您能在日常生活中保持一个较为良好的心态，不以物喜，不以己悲，坦坦荡荡，落落大方。";
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
					suggest = "因为你是一个喜欢热闹的人，与其被动等待，你更愿意积极地打开一群人的话题，与人交往对你来说不是什么难题，相反你还能拥有热络的情谊和有价值的人脉，因此亲密关系恐惧症离你挺远的。";
				}
				else {
					suggest = "你是一个追求完美，因而导致有些自卑的人，你害怕与别人的关系太过亲密，而暴露自己与对方的缺点，你深知自己与人深入交往后便会不自在，因此你宁可孑然一身，你需要一个真的懂你的人。";
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
					suggest = "你是一个特别乖的人，对别人没有什么不喜欢的感觉，因为觉得他们都是很善良的人，没必要对他们有什么敌意，所以也就不会跟别人有什么过节，更不用提抬杠这两个字了。所以你的生活都是完美的，能够遇到自己喜欢的人，自己喜欢的人也对你特别的欣赏，这都是你良好品德的表现。";
				}
				else {
					suggest = "虽然你跟别人家不经常抬杠，但是也还是会去惹恼别人，因为他干这件事情本身就是对人不对事。一定要跟对方唱反调的。你也具备这种跟人在抬杠的能力，虽然不是经常跟别人家抬杠，但是也要减少这样的机会，不然以后别人会看你很不爽，那么以后的日子就糟糕了。";
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
					suggest = "虽然人一到中年，身材难免会走样，但走样的身材不是油腻的标志！有的人是胖子也是可爱的胖子。中年油腻主要是言行举止油腻，而你是拒绝油腻的，不会去往油腻的方向一路狂奔，至少会管理一下身材，也不会去玩什么手串，更会让自己不要那么去说教，也要认清自己的定位，不要觉得多有魅力。";
				}
				else {
					suggest = "很多人一到中年，油腻本质尽现，这是自然而然的，而你可能觉得自己不会油腻的吧，但也很难说呀。你也说不定会有一些油腻的哦。不光是爱玩手串满口说教，还会时不时调戏一下长得好看的人呀，你也可能认为自己还很年轻呀，很有魅力呀。这种自我认识不清楚，最容易令你油腻了。";
				}
			}	
		}
		else {
			suggest="";
		}
		//SSM返回值，是JSON类型的，直接传String类型的不会被识别
		//所以需要使用JSONUtils强制转换成String格式的就可以传到前端
		String s = JSONUtils.toJSONString(suggest);
		return s;
	}
	//统计分析内，拿每道题做过的人的数量
	@RequestMapping("/scoreNum")
	@ResponseBody
	public int scoreNum(Integer title_id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		int number = scoreService.scoreNum(title_id);
		return number;
	}
	//同时拿4个成绩
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
	//同时拿4个成绩
	@RequestMapping("/getHisScoreList")
	@ResponseBody
	public List<Score> getHisScoreList(HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		//查目前登录的用户id
		User user = (User)session.getAttribute("myUser");
		int id = user.getId();
		List<Score> list = scoreService.getScoreById(id);
		return list;
	}
	//同时拿4个成绩
	@RequestMapping("/getHisScoreListById")
	@ResponseBody
	public List<Score> getHisScoreListById(Integer id,HttpServletRequest request, HttpServletResponse response, 
			HttpSession session) {
		//查目前登录的用户id
		List<Score> list = scoreService.getScoreById(id);
		return list;
	}
}
