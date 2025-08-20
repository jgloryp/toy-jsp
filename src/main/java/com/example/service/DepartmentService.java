package com.example.service;

import com.example.mapper.DepartmentMapper;
import com.example.model.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> findAll() {
        return departmentMapper.findAll();
    }

    public Department findById(Long id) {
        return departmentMapper.findById(id);
    }

    public Department findByIdWithStudents(Long id) {
        return departmentMapper.findByIdWithStudents(id);
    }

    public Department save(Department department) {
        if (department.getId() == null) {
            departmentMapper.insert(department);
        } else {
            departmentMapper.update(department);
        }
        return department;
    }

    public boolean deleteById(Long id) {
        // Check if department has students
        int studentCount = departmentMapper.countStudentsByDepartmentId(id);
        if (studentCount > 0) {
            throw new RuntimeException("Cannot delete department with students. Move students first.");
        }
        return departmentMapper.deleteById(id) > 0;
    }

    public int getStudentCount(Long departmentId) {
        return departmentMapper.countStudentsByDepartmentId(departmentId);
    }
}