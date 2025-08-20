package com.example.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class StudentCourse {
    private Long id;
    private Long studentId;
    private Long courseId;
    private LocalDate enrollmentDate;
    private String grade;
    private LocalDateTime createdAt;
    
    // Many-to-one relationships
    private Student student;
    private Course course;

    public StudentCourse() {}

    public StudentCourse(Long studentId, Long courseId, LocalDate enrollmentDate, String grade) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.enrollmentDate = enrollmentDate;
        this.grade = grade;
    }


    @Override
    public String toString() {
        return "StudentCourse{" +
                "id=" + id +
                ", studentId=" + studentId +
                ", courseId=" + courseId +
                ", enrollmentDate=" + enrollmentDate +
                ", grade='" + grade + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}