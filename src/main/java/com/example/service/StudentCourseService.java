package com.example.service;

import com.example.mapper.StudentCourseMapper;
import com.example.model.StudentCourse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
@Transactional
public class StudentCourseService {

    @Autowired
    private StudentCourseMapper studentCourseMapper;

    public List<StudentCourse> findAll() {
        return studentCourseMapper.findAll();
    }

    public StudentCourse findById(Long id) {
        return studentCourseMapper.findById(id);
    }

    public StudentCourse findByStudentAndCourse(Long studentId, Long courseId) {
        return studentCourseMapper.findByStudentAndCourse(studentId, courseId);
    }

    public List<StudentCourse> findByStudentId(Long studentId) {
        return studentCourseMapper.findByStudentId(studentId);
    }

    public List<StudentCourse> findByCourseId(Long courseId) {
        return studentCourseMapper.findByCourseId(courseId);
    }

    public List<StudentCourse> findByStudentIdWithCourse(Long studentId) {
        return studentCourseMapper.findByStudentIdWithCourse(studentId);
    }

    public List<StudentCourse> findByCourseIdWithStudent(Long courseId) {
        return studentCourseMapper.findByCourseIdWithStudent(courseId);
    }

    public StudentCourse save(StudentCourse studentCourse) {
        if (studentCourse.getId() == null) {
            // Check if enrollment already exists
            StudentCourse existing = studentCourseMapper.findByStudentAndCourse(
                studentCourse.getStudentId(), studentCourse.getCourseId());
            if (existing != null) {
                throw new RuntimeException("Student is already enrolled in this course");
            }
            // Set enrollment date if not provided
            if (studentCourse.getEnrollmentDate() == null) {
                studentCourse.setEnrollmentDate(LocalDate.now());
            }
            studentCourseMapper.insert(studentCourse);
        } else {
            studentCourseMapper.update(studentCourse);
        }
        return studentCourse;
    }

    public boolean deleteById(Long id) {
        return studentCourseMapper.deleteById(id) > 0;
    }

    public boolean deleteByStudentAndCourse(Long studentId, Long courseId) {
        return studentCourseMapper.deleteByStudentAndCourse(studentId, courseId) > 0;
    }

    public boolean isEnrolled(Long studentId, Long courseId) {
        return studentCourseMapper.findByStudentAndCourse(studentId, courseId) != null;
    }

    public StudentCourse enrollStudent(Long studentId, Long courseId) {
        if (isEnrolled(studentId, courseId)) {
            throw new RuntimeException("Student is already enrolled in this course");
        }
        
        StudentCourse enrollment = new StudentCourse();
        enrollment.setStudentId(studentId);
        enrollment.setCourseId(courseId);
        enrollment.setEnrollmentDate(LocalDate.now());
        
        return save(enrollment);
    }

    public boolean updateGrade(Long studentId, Long courseId, String grade) {
        StudentCourse enrollment = findByStudentAndCourse(studentId, courseId);
        if (enrollment == null) {
            throw new RuntimeException("Enrollment not found");
        }
        
        enrollment.setGrade(grade);
        studentCourseMapper.update(enrollment);
        return true;
    }
}