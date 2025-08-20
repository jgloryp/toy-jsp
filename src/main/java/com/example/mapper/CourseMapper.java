package com.example.mapper;

import com.example.model.Course;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CourseMapper {
    
    List<Course> findAll();
    
    Course findById(@Param("id") Long id);
    
    Course findByIdWithStudents(@Param("id") Long id);
    
    Course findByCode(@Param("code") String code);
    
    List<Course> findByStudentId(@Param("studentId") Long studentId);
    
    int insert(Course course);
    
    int update(Course course);
    
    int deleteById(@Param("id") Long id);
    
    int countStudentsByCourseId(@Param("courseId") Long courseId);
}