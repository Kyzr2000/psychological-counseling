package king.flyz.dao;

import java.util.List;

import king.flyz.pojo.User;

public interface UserMapper {
	 public List<User> getUserList();//获取所有用户
	 public List<User> getExpertList();
	 public List<User> getUserManList();
	 public List<User> getUserWomenList();
	 public List<User> getAdminList();
	 public String getPwdByUsername(String account);
	 public User getUserByUsername(String account);
	 public int addUser(User user);
	 public User getUserById(int id);
	 public int updateUserStatusById(User u);
	 public int updateUserMessage(User u);
	 public int updateUserPassword(User u);
	 public List<User> getUserLikely(String title);
	 public int deleteUserById(int id);
}
