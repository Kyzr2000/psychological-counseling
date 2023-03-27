package king.flyz.service;

import java.util.List;

import king.flyz.pojo.User;

public interface UserService {
	public int getUserNum();
	public int getManNum();
	public int getWomenNum();
	public int getExpertNum();
	public int getAdminNum();
	public String getUserPssword(String account);
	public User getUserByAccount(String account);
	public int addUser(User user);
	public User getUserById(int id);
	public int updateUserStatusById(User u);
	public int updateUserMessage(User u);
	public int updateUserPassword(User u);
	public List<User> getUserList();
	public List<User> getUserLikely(String title);
	public int deleteUserById(int id);
}
