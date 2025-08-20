package com.example.mapper;

import com.example.model.StudentCourse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StudentCourseMapper {
    
    List<StudentCourse> findAll();
    
    StudentCourse findById(@Param("id") Long id);
    
    StudentCourse findByStudentAndCourse(@Param("studentId") Long studentId, 
                                       @Param("courseId") Long courseId);
    
    List<StudentCourse> findByStudentId(@Param("studentId") Long studentId);
    
    List<StudentCourse> findByCourseId(@Param("courseId") Long courseId);
    
    List<StudentCourse> findByStudentIdWithCourse(@Param("studentId") Long studentId);
    
    List<StudentCourse> findByCourseIdWithStudent(@Param("courseId") Long courseId);
    
    int insert(StudentCourse studentCourse);
    
    int update(StudentCourse studentCourse);
    
    int deleteById(@Param("id") Long id);
    
    int deleteByStudentAndCourse(@Param("studentId") Long studentId, 
                               @Param("courseId") Long courseId);
}