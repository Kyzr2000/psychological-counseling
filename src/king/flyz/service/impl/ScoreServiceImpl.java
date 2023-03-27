package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import king.flyz.dao.ScoreMapper;
import king.flyz.pojo.Score;
import king.flyz.service.ScoreService;
@Service("scoreService")
public class ScoreServiceImpl implements ScoreService {
	@Resource
	private ScoreMapper scoreMapper;

	@Override
	public List<Score> getScoreByUidAndTid(int user_id, int title_id) {
		return scoreMapper.getScoreByUidAndTid(user_id, title_id);
	}

	@Override
	public int updateScoreByUidAndTid(Integer grades, Integer user_id, Integer title_id) {
		return scoreMapper.updateScoreByUidAndTid(grades, user_id, title_id);
	}

	@Override
	public int addScore(Integer grades, Integer user_id, Integer title_id,String createAt) {
		return scoreMapper.addScore(grades, user_id, title_id,createAt);
	}

	@Override
	public int scoreNum(int title_id) {
		List<Score> list = scoreMapper.getScoreByTitleId(title_id);
		return list.size();
	}

	@Override
	public List<Score> getScoreById(int user_id) {
		return scoreMapper.getScoreById(user_id);
	}
	
}
