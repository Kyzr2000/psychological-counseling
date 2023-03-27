package king.flyz.pojo;

public class Expert {
	private Integer id;
	private String name;
	private String introduction;
	private String img;
	private String value;
	private String tagOne;
	private String tagTwo;
	private String tagThree;
	private Integer user_id;
	private Integer status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getTagOne() {
		return tagOne;
	}
	public void setTagOne(String tagOne) {
		this.tagOne = tagOne;
	}
	public String getTagTwo() {
		return tagTwo;
	}
	public void setTagTwo(String tagTwo) {
		this.tagTwo = tagTwo;
	}
	public String getTagThree() {
		return tagThree;
	}
	public void setTagThree(String tagThree) {
		this.tagThree = tagThree;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "Expert [id=" + id + ", name=" + name + ", introduction=" + introduction + ", img=" + img + ", value="
				+ value + ", tagOne=" + tagOne + ", tagTwo=" + tagTwo + ", tagThree=" + tagThree + ", user_id="
				+ user_id + ", status=" + status + "]";
	}
	
}
