package king.flyz.dao;

import java.util.List;

import king.flyz.pojo.Passage;

public interface PassageMapper {
	public List<Passage> selectPassageList();
	public Passage selectPassageById(int id);
	public int updatePassageById(Passage p);
	public int deletePassageById(int id);
	public List<Passage> getPassageLikely(String title);
	public int addPassage(Passage passage);
}
