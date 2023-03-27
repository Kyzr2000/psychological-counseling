package king.flyz.pojo;

public class Checks {
	private Integer id;
	private Integer title_id;
	private Integer question_id;
	private String question;
	private String optionA;
	private String optionB;
	private String optionC;
	private Integer valueA;
	private Integer valueB;
	private Integer valueC;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getTitle_id() {
		return title_id;
	}
	public void setTitle_id(Integer title_id) {
		this.title_id = title_id;
	}
	public Integer getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(Integer question_id) {
		this.question_id = question_id;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getOptionA() {
		return optionA;
	}
	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}
	public String getOptionB() {
		return optionB;
	}
	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}
	public String getOptionC() {
		return optionC;
	}
	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}
	public Integer getValueA() {
		return valueA;
	}
	public void setValueA(Integer valueA) {
		this.valueA = valueA;
	}
	public Integer getValueB() {
		return valueB;
	}
	public void setValueB(Integer valueB) {
		this.valueB = valueB;
	}
	public Integer getValueC() {
		return valueC;
	}
	public void setValueC(Integer valueC) {
		this.valueC = valueC;
	}
	@Override
	public String toString() {
		return "Checks [id=" + id + ", title_id=" + title_id + ", question_id=" + question_id + ", question=" + question
				+ ", optionA=" + optionA + ", optionB=" + optionB + ", optionC=" + optionC + ", valueA=" + valueA
				+ ", valueB=" + valueB + ", valueC=" + valueC + "]";
	}
	
}
