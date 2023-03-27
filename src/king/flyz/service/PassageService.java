package king.flyz.service;

import java.util.List;

import king.flyz.pojo.Passage;

public interface PassageService {
	public int passageNum();
	public List<Passage> selectPassageList();
	public Passage selectPassageById(int id);
	public int updatePassageById(Passage p);
	public int deletePassageById(int id);
	public List<Passage> getPassageLikely(String title);
	public int addPassage(Passage passage);
}
