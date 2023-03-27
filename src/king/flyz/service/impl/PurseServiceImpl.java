package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import king.flyz.dao.PurseMapper;
import king.flyz.pojo.Purse;
import king.flyz.service.PurseService;

@Service("purseService")
public class PurseServiceImpl implements PurseService {
	@Resource
	private PurseMapper purseMapper;
	@Override
	//通过用户的id来查看用户钱包里面有多少钱
	public String getMoneyByUserId(int user_id) {
		return purseMapper.getMoneyByUserId(user_id);
	}
	@Override
	public int addPurse(Purse purse) {
		return purseMapper.addPurse(purse);
	}
	@Override
	public Purse getPurseByUserId(int user_id) {
		return purseMapper.getPurseByUserId(user_id);
	}
	@Override
	public int updatePurseByUserId(Purse purse) {
		return purseMapper.updatePurseByUserId(purse);
	}
	@Override
	public List<Purse> getPurseWithUserList() {
		return purseMapper.getPurseWithUserList();
	}
	@Override
	public Purse getPurseById(int id) {
		return purseMapper.getPurseById(id);
	}
	@Override
	public List<Purse> getPurseLikely(String title) {
		return purseMapper.getPurseLikely(title);
	}
	@Override
	public int deletePurseByUserId(int user_id) {
		return purseMapper.deletePurseByUserId(user_id);
	}
	@Override
	public int updateIOPurse(Purse purse) {
		return purseMapper.updateIOPurse(purse);
	}

}
