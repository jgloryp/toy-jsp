package com.example.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class Course {
    private Long id;
    private String name;
    private String code;
    private Integer credits;
    private String description;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Many-to-many relationship with Student through StudentCourse
    private List<StudentCourse> studentCourses;
    private List<Student> students;

    public Course() {}

    public Course(String name, String code, Integer credits, String description) {
        this.name = name;
        this.code = code;
        this.credits = credits;
        this.description = description;
    }


    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", credits=" + credits +
                ", description='" + description + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}