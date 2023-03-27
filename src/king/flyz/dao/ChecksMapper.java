package king.flyz.dao;

import java.util.List;

import king.flyz.pojo.Checks;

public interface ChecksMapper {
	 public List<Checks> getCheckByTitleID(int id);
}
