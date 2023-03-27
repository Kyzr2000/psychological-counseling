package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;



import king.flyz.dao.UserMapper;
import king.flyz.pojo.User;
import king.flyz.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{
	@Resource
	private UserMapper userMapper;
	//获取用户数量
	public int getUserNum() {
        List<User> users = userMapper.getUserList();
        return users.size();
    }
	@Override
	public String getUserPssword(String account) {
		String pwd = userMapper.getPwdByUsername(account);
		return pwd;
	}
	@Override
	public User getUserByAccount(String account) {
		User user = userMapper.getUserByUsername(account);
		return user;
	}
	//添加用户
	@Override
	public int addUser(User user) {
		return 	userMapper.addUser(user);
	}
	@Override
	public User getUserById(int id) {
		return userMapper.getUserById(id);
	}
	@Override
	public int updateUserStatusById(User u) {
		return userMapper.updateUserStatusById(u);
	}
	@Override
	public int updateUserMessage(User u) {
		return userMapper.updateUserMessage(u);
	}
	@Override
	public int updateUserPassword(User u) {
		return userMapper.updateUserPassword(u);
	}
	@Override
	public List<User> getUserList() {
		return userMapper.getUserList();
	}
	@Override
	public int getManNum() {
		List<User> users = userMapper.getUserManList();
		return users.size();
	}
	@Override
	public int getWomenNum() {
		List<User> users = userMapper.getUserWomenList();
		return users.size();
	}
	@Override
	public List<User> getUserLikely(String title) {
		return userMapper.getUserLikely(title);
	}
	@Override
	public int deleteUserById(int id) {
		return userMapper.deleteUserById(id);
	}
	@Override
	public int getExpertNum() {
		List<User> users = userMapper.getExpertList();
        return users.size();
	}
	@Override
	public int getAdminNum() {
		List<User> users = userMapper.getAdminList();
        return users.size();
	}
}
