package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import king.flyz.dao.CourseMapper;
import king.flyz.pojo.Course;
import king.flyz.service.CourseService;

@Service("courseService")
public class CourseServiceImpl implements CourseService {
	@Resource
	private CourseMapper courseMapper;
	@Override
	public List<Course> getCourseList() {
		return courseMapper.getCourseList();
	}
	@Override
	public Course getCourseByID(int id) {
		return courseMapper.getCourseByID(id);
	}
	@Override
	public int updateCourseById(Course course) {
		return courseMapper.updateCourseById(course);
	}
	@Override
	public int deleteCourseById(int id) {
		return courseMapper.deleteCourseById(id);
	}
	@Override
	public List<Course> getCourseLikely(String title) {
		return courseMapper.getCourseLikely(title);
	}
	@Override
	public int addCourse(Course course) {
		return courseMapper.addCourse(course);
	}
	@Override
	public int courseNum() {
		List<Course> list = courseMapper.getCourseList();
		return list.size();
	}

}
