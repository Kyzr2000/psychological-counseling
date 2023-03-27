package king.flyz.service;


import java.util.List;

import king.flyz.pojo.Score;

public interface ScoreService {
	public List<Score> getScoreByUidAndTid(int user_id,int title_id);
	public int updateScoreByUidAndTid(Integer grades,Integer user_id,Integer title_id);
	public int addScore(Integer grades,Integer user_id,Integer title_id,String createAt);
	public int scoreNum(int title_id);
	public List<Score> getScoreById(int user_id);
}
