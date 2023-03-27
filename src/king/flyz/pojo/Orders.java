package king.flyz.pojo;

public class Orders {
	private int id;
	private int house_id;
	private int customer_id;
	private int expert_id;
	private int status;
	private String createAt;
	private String price;
	private User user;
	private String myInfo;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHouse_id() {
		return house_id;
	}
	public void setHouse_id(int house_id) {
		this.house_id = house_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getExpert_id() {
		return expert_id;
	}
	public void setExpert_id(int expert_id) {
		this.expert_id = expert_id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getCreateAt() {
		return createAt;
	}
	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getMyInfo() {
		return myInfo;
	}
	public void setMyInfo(String myInfo) {
		this.myInfo = myInfo;
	}
	@Override
	public String toString() {
		return "Orders [id=" + id + ", house_id=" + house_id + ", customer_id=" + customer_id + ", expert_id="
				+ expert_id + ", status=" + status + ", createAt=" + createAt + ", price=" + price + ", user=" + user
				+ ", myInfo=" + myInfo + "]";
	}
	

}
