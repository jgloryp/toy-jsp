package com.example.service;

import com.example.mapper.CourseMapper;
import com.example.model.Course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CourseService {

    @Autowired
    private CourseMapper courseMapper;

    public List<Course> findAll() {
        return courseMapper.findAll();
    }

    public Course findById(Long id) {
        return courseMapper.findById(id);
    }

    public Course findByIdWithStudents(Long id) {
        return courseMapper.findByIdWithStudents(id);
    }

    public Course findByCode(String code) {
        return courseMapper.findByCode(code);
    }

    public List<Course> findByStudentId(Long studentId) {
        return courseMapper.findByStudentId(studentId);
    }

    public Course save(Course course) {
        if (course.getId() == null) {
            courseMapper.insert(course);
        } else {
            courseMapper.update(course);
        }
        return course;
    }

    public boolean deleteById(Long id) {
        // Check if course has students enrolled
        int studentCount = courseMapper.countStudentsByCourseId(id);
        if (studentCount > 0) {
            throw new RuntimeException("Cannot delete course with enrolled students. Remove enrollments first.");
        }
        return courseMapper.deleteById(id) > 0;
    }

    public int getEnrolledStudentCount(Long courseId) {
        return courseMapper.countStudentsByCourseId(courseId);
    }

    public boolean isCodeExists(String code, Long excludeId) {
        Course course = courseMapper.findByCode(code);
        return course != null && !course.getId().equals(excludeId);
    }
}