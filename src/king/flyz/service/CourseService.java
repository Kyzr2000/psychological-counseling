package king.flyz.service;

import java.util.List;

import king.flyz.pojo.Course;

public interface CourseService {
	public int courseNum();
	public List<Course> getCourseList();
	public Course getCourseByID(int id);
	public int updateCourseById(Course course);
	public int deleteCourseById(int id);
	public List<Course> getCourseLikely(String title);
	public int addCourse(Course course);
}
