package king.flyz.pojo;

//score是用来装用户测评得到的分数的！
public class Score {
	private Integer id;
	private Integer user_id;
	private Integer title_id;
	private Integer grades;
	private String createAt;
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
	public Integer getTitle_id() {
		return title_id;
	}
	public void setTitle_id(Integer title_id) {
		this.title_id = title_id;
	}
	public Integer getGrades() {
		return grades;
	}
	public void setGrades(Integer grades) {
		this.grades = grades;
	}
	public String getCreateAt() {
		return createAt;
	}
	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}
	@Override
	public String toString() {
		return "Score [id=" + id + ", user_id=" + user_id + ", title_id=" + title_id + ", grades=" + grades
				+ ", createAt=" + createAt + "]";
	}
	
}
