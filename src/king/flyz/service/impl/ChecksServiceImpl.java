package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import king.flyz.dao.ChecksMapper;
import king.flyz.pojo.Checks;
import king.flyz.service.ChecksService;

@Service("checksService")
public class ChecksServiceImpl implements ChecksService {
	@Resource
	private ChecksMapper checksMapper;
	@Override
	public List<Checks> getCheckByTitleID(int id) {
		return checksMapper.getCheckByTitleID(id);
	}

}
