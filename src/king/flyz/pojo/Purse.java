package king.flyz.pojo;

//Ç®°ü
public class Purse {
	private Integer id;
	private Integer user_id;
	private String money;
	private String inMoney;
	private String outMoney;
	private Integer status;
	private User user;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getInMoney() {
		return inMoney;
	}
	public void setInMoney(String inMoney) {
		this.inMoney = inMoney;
	}
	public String getOutMoney() {
		return outMoney;
	}
	public void setOutMoney(String outMoney) {
		this.outMoney = outMoney;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@Override
	public String toString() {
		return "Purse [id=" + id + ", user_id=" + user_id + ", money=" + money + ", inMoney=" + inMoney + ", outMoney="
				+ outMoney + ", status=" + status + ", user=" + user + "]";
	}
}
