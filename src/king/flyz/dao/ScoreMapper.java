package king.flyz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import king.flyz.pojo.Score;

public interface ScoreMapper {
	public List<Score> getScoreByUidAndTid(@Param("user_id")Integer user_id,@Param("title_id")Integer title_id);
	public int updateScoreByUidAndTid(@Param("grades")Integer grades,@Param("user_id")Integer user_id,@Param("title_id")Integer title_id);
	public int addScore(@Param("grades")Integer grades,@Param("user_id")Integer user_id,@Param("title_id")Integer title_id,@Param("createAt")String createAt);
	public List<Score> getScoreByTitleId(int title_id);
	public List<Score> getScoreById(int user_id);
}
