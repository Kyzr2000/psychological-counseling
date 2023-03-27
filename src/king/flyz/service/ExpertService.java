package king.flyz.service;

import java.util.List;

import king.flyz.pojo.Expert;

public interface ExpertService {
	public List<Expert> getExperts();
	public Expert boolExpertRequest(int user_id);
	public int addExpert(Expert expert);
	public Expert getExpertById(int id);
	public int updateExpertStatusById(Expert expert);
	public List<Expert> getExpertLikely(String title);
	public String getExpertPrice(int user_id);
}
