package com.example.service;

import com.example.mapper.StudentMapper;
import com.example.mapper.StudentCourseMapper;
import com.example.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private StudentCourseMapper studentCourseMapper;

    public List<Student> findAll() {
        return studentMapper.findAll();
    }

    public Student findById(Long id) {
        return studentMapper.findById(id);
    }

    public Student findByIdWithDepartment(Long id) {
        return studentMapper.findByIdWithDepartment(id);
    }

    public Student findByIdWithCourses(Long id) {
        return studentMapper.findByIdWithCourses(id);
    }

    public List<Student> findByDepartmentId(Long departmentId) {
        return studentMapper.findByDepartmentId(departmentId);
    }

    public Student save(Student student) {
        if (student.getId() == null) {
            studentMapper.insert(student);
        } else {
            studentMapper.update(student);
        }
        return student;
    }

    public boolean deleteById(Long id) {
        // This will also delete related student_course records due to CASCADE
        return studentMapper.deleteById(id) > 0;
    }

    public List<Student> searchByEmail(String email) {
        return studentMapper.findByEmailLike("%" + email + "%");
    }

    public boolean isEmailExists(String email, Long excludeId) {
        List<Student> students = studentMapper.findByEmailLike(email);
        return students.stream().anyMatch(s -> !s.getId().equals(excludeId));
    }
}