package king.flyz.dao;

import java.util.List;

import king.flyz.pojo.Expert;

public interface ExpertMapper {
	public List<Expert> getExpertList();
	public Expert boolExpertRequest(int user_id);
	public int addExpert(Expert expert);
	public Expert getExpertById(int id);
	public int updateExpertStatusById(Expert expert);
	public List<Expert> getExpertLikely(String title);
	public String getExpertPrice(int user_id);
}
