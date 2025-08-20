package com.example.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class Student {
    private Long id;
    private String name;
    private String email;
    private String phone;
    private Long departmentId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Many-to-one relationship with Department
    private Department department;
    
    // Many-to-many relationship with Course through StudentCourse
    private List<StudentCourse> studentCourses;
    private List<Course> courses;

    public Student() {}

    public Student(String name, String email, String phone, Long departmentId) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.departmentId = departmentId;
    }


    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", departmentId=" + departmentId +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}