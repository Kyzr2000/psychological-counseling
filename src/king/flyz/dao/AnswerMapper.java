package king.flyz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import king.flyz.pojo.Answer;

public interface AnswerMapper {
	public List<Answer> getAnswerList();
	public Answer getAnswerByID(int id);
	public int addAnswer(Answer answer);
	public List<Answer> getAnswerLikely(@Param("title")String title,@Param("article")String article,@Param("name")String name);
	public List<Answer> getAnswerListById(int user_id);
}
