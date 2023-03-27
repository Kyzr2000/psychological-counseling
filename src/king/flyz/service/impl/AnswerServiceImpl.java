package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import king.flyz.dao.AnswerMapper;
import king.flyz.pojo.Answer;

@Service("answerService")
public class AnswerServiceImpl implements king.flyz.service.AnswerService {
	@Resource
	private AnswerMapper answerMapper;
	@Override
	public List<Answer> getAnswerList() {
		return answerMapper.getAnswerList();
	}
	@Override
	public Answer getAnswerByID(int id) {
		return answerMapper.getAnswerByID(id);
	}
	@Override
	public int addAnswer(Answer answer) {
		return answerMapper.addAnswer(answer);
	}
	@Override
	public List<Answer> getAnswerLikely(String title, String article, String name) {
		return answerMapper.getAnswerLikely(title, article, name);
	}
	@Override
	public int answerNum() {
		List<Answer> list = answerMapper.getAnswerList();
		return list.size();
	}
	@Override
	public List<Answer> getAnswerListById(int user_id) {
		return answerMapper.getAnswerListById(user_id);
	}

}
