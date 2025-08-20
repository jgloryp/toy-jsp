package com.example.controller;

import com.example.model.Department;
import com.example.model.Student;
import com.example.service.DepartmentService;
import com.example.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/students")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String list(Model model, @RequestParam(required = false) String search) {
        List<Student> students;
        if (search != null && !search.trim().isEmpty()) {
            students = studentService.searchByEmail(search.trim());
            model.addAttribute("search", search);
        } else {
            students = studentService.findAll();
        }
        model.addAttribute("students", students);
        return "students/list";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String detail(@PathVariable Long id, Model model) {
        Student student = studentService.findByIdWithDepartment(id);
        if (student == null) {
            return "redirect:/students";
        }
        model.addAttribute("student", student);
        return "students/detail";
    }

    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("student", new Student());
        List<Department> departments = departmentService.findAll();
        model.addAttribute("departments", departments);
        return "students/form";
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public String create(@ModelAttribute Student student, 
                        RedirectAttributes redirectAttributes) {
        try {
            // Check if email already exists
            if (studentService.isEmailExists(student.getEmail(), null)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Email already exists!");
                return "redirect:/students/new";
            }
            
            studentService.save(student);
            redirectAttributes.addFlashAttribute("successMessage", "Student created successfully!");
            return "redirect:/students";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating student: " + e.getMessage());
            return "redirect:/students/new";
        }
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
    public String editForm(@PathVariable Long id, Model model) {
        Student student = studentService.findById(id);
        if (student == null) {
            return "redirect:/students";
        }
        model.addAttribute("student", student);
        List<Department> departments = departmentService.findAll();
        model.addAttribute("departments", departments);
        return "students/form";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public String update(@PathVariable Long id, 
                        @ModelAttribute Student student,
                        RedirectAttributes redirectAttributes) {
        try {
            // Check if email already exists (excluding current student)
            if (studentService.isEmailExists(student.getEmail(), id)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Email already exists!");
                return "redirect:/students/" + id + "/edit";
            }
            
            student.setId(id);
            studentService.save(student);
            redirectAttributes.addFlashAttribute("successMessage", "Student updated successfully!");
            return "redirect:/students/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating student: " + e.getMessage());
            return "redirect:/students/" + id + "/edit";
        }
    }

    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            studentService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Student deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting student: " + e.getMessage());
        }
        return "redirect:/students";
    }
}