package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import king.flyz.dao.ExpertMapper;
import king.flyz.pojo.Expert;
import king.flyz.service.ExpertService;

@Service("expertService")
public class ExpertServiceImpl implements ExpertService {
	@Resource
	private ExpertMapper expertMapper;
	@Override
	public List<Expert> getExperts() {
		return expertMapper.getExpertList();
	}
	@Override
	public Expert boolExpertRequest(int user_id) {
		return expertMapper.boolExpertRequest(user_id);
	}
	@Override
	public int addExpert(Expert expert) {
		return expertMapper.addExpert(expert);
	}
	@Override
	public Expert getExpertById(int id) {
		return expertMapper.getExpertById(id);
	}
	@Override
	public int updateExpertStatusById(Expert expert) {
		return expertMapper.updateExpertStatusById(expert);
	}
	@Override
	public List<Expert> getExpertLikely(String title) {
		return expertMapper.getExpertLikely(title);
	}
	@Override
	public String getExpertPrice(int user_id) {
		return expertMapper.getExpertPrice(user_id);
	}

}
