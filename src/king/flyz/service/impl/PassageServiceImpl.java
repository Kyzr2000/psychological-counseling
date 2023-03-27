package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import king.flyz.dao.PassageMapper;
import king.flyz.pojo.Passage;
import king.flyz.service.PassageService;

@Service("passageService")
public class PassageServiceImpl implements PassageService {
	@Resource
	private PassageMapper passageMapper;
	@Override
	public List<Passage> selectPassageList() {
		return passageMapper.selectPassageList();
	}
	@Override
	public Passage selectPassageById(int id) {
		return passageMapper.selectPassageById(id);
	}
	@Override
	public int updatePassageById(Passage p) {
		return passageMapper.updatePassageById(p);
	}
	@Override
	public int deletePassageById(int id) {
		return passageMapper.deletePassageById(id);
	}
	@Override
	public List<Passage> getPassageLikely(String title) {
		return passageMapper.getPassageLikely(title);
	}
	@Override
	public int addPassage(Passage passage) {
		return passageMapper.addPassage(passage);
	}
	@Override
	public int passageNum() {
		List<Passage> list  = passageMapper.selectPassageList();
		return list.size();
	}

}
