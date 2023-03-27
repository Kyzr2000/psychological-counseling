package king.flyz.service;

import java.util.List;

import king.flyz.pojo.Answer;

public interface AnswerService {
	public int answerNum();
	public List<Answer> getAnswerList();
	public Answer getAnswerByID(int id);
	public int addAnswer(Answer answer);
	public List<Answer> getAnswerLikely(String title,String article,String name);
	public List<Answer> getAnswerListById(int user_id);
}
