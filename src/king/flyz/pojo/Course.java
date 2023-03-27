package king.flyz.pojo;

public class Course {
	private Integer id;
	private String img;
	private String title;
	private String createAt;
	private String price;
	private String courseURL;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreateAt() {
		return createAt;
	}
	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getCourseURL() {
		return courseURL;
	}
	public void setCourseURL(String courseURL) {
		this.courseURL = courseURL;
	}
	@Override
	public String toString() {
		return "Course [id=" + id + ", img=" + img + ", title=" + title + ", createAt=" + createAt + ", price=" + price
				+ ", courseURL=" + courseURL + "]";
	}
	
}
