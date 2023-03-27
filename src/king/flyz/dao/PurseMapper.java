package king.flyz.dao;

import java.util.List;

import king.flyz.pojo.Purse;

public interface PurseMapper {
	public String getMoneyByUserId(int user_id);
	public int addPurse(Purse purse);
	public Purse getPurseByUserId(int user_id);
	public int updatePurseByUserId(Purse purse);
	public List<Purse> getPurseWithUserList();
	public Purse getPurseById(int id);
	public List<Purse> getPurseLikely(String title);
	public int deletePurseByUserId(int user_id);
	public int updateIOPurse(Purse purse);
}
