package com.example.mapper;

import com.example.model.Student;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StudentMapper {
    
    List<Student> findAll();
    
    Student findById(@Param("id") Long id);
    
    Student findByIdWithDepartment(@Param("id") Long id);
    
    Student findByIdWithCourses(@Param("id") Long id);
    
    List<Student> findByDepartmentId(@Param("departmentId") Long departmentId);
    
    int insert(Student student);
    
    int update(Student student);
    
    int deleteById(@Param("id") Long id);
    
    List<Student> findByEmailLike(@Param("email") String email);
}