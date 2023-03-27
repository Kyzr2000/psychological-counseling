package king.flyz.service;

import java.util.List;

import king.flyz.pojo.Checks;

public interface ChecksService {
	public List<Checks> getCheckByTitleID(int id);
}
