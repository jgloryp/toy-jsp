package com.example.controller;

import com.example.model.Course;
import com.example.model.Student;
import com.example.model.StudentCourse;
import com.example.service.CourseService;
import com.example.service.StudentCourseService;
import com.example.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/enrollments")
public class EnrollmentController {

    @Autowired
    private StudentCourseService studentCourseService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private CourseService courseService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String list(Model model) {
        List<StudentCourse> enrollments = studentCourseService.findAll();
        model.addAttribute("enrollments", enrollments);
        return "enrollments/list";
    }

    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("enrollment", new StudentCourse());
        List<Student> students = studentService.findAll();
        List<Course> courses = courseService.findAll();
        model.addAttribute("students", students);
        model.addAttribute("courses", courses);
        return "enrollments/form";
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public String create(@ModelAttribute StudentCourse enrollment, 
                        RedirectAttributes redirectAttributes) {
        try {
            studentCourseService.save(enrollment);
            redirectAttributes.addFlashAttribute("successMessage", "Enrollment created successfully!");
            return "redirect:/enrollments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating enrollment: " + e.getMessage());
            return "redirect:/enrollments/new";
        }
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
    public String editForm(@PathVariable Long id, Model model) {
        StudentCourse enrollment = studentCourseService.findById(id);
        if (enrollment == null) {
            return "redirect:/enrollments";
        }
        model.addAttribute("enrollment", enrollment);
        List<Student> students = studentService.findAll();
        List<Course> courses = courseService.findAll();
        model.addAttribute("students", students);
        model.addAttribute("courses", courses);
        return "enrollments/form";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public String update(@PathVariable Long id, 
                        @ModelAttribute StudentCourse enrollment,
                        RedirectAttributes redirectAttributes) {
        try {
            enrollment.setId(id);
            studentCourseService.save(enrollment);
            redirectAttributes.addFlashAttribute("successMessage", "Enrollment updated successfully!");
            return "redirect:/enrollments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating enrollment: " + e.getMessage());
            return "redirect:/enrollments/" + id + "/edit";
        }
    }

    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            studentCourseService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Enrollment deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting enrollment: " + e.getMessage());
        }
        return "redirect:/enrollments";
    }

    @RequestMapping(value = "/student/{studentId}", method = RequestMethod.GET)
    public String studentEnrollments(@PathVariable Long studentId, Model model) {
        Student student = studentService.findById(studentId);
        if (student == null) {
            return "redirect:/students";
        }
        List<StudentCourse> enrollments = studentCourseService.findByStudentIdWithCourse(studentId);
        model.addAttribute("student", student);
        model.addAttribute("enrollments", enrollments);
        return "enrollments/student";
    }

    @RequestMapping(value = "/course/{courseId}", method = RequestMethod.GET)
    public String courseEnrollments(@PathVariable Long courseId, Model model) {
        Course course = courseService.findById(courseId);
        if (course == null) {
            return "redirect:/courses";
        }
        List<StudentCourse> enrollments = studentCourseService.findByCourseIdWithStudent(courseId);
        model.addAttribute("course", course);
        model.addAttribute("enrollments", enrollments);
        return "enrollments/course";
    }

    @RequestMapping(value = "/enroll", method = RequestMethod.POST)
    public String enroll(@RequestParam Long studentId, 
                        @RequestParam Long courseId,
                        RedirectAttributes redirectAttributes) {
        try {
            studentCourseService.enrollStudent(studentId, courseId);
            redirectAttributes.addFlashAttribute("successMessage", "Student enrolled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error enrolling student: " + e.getMessage());
        }
        return "redirect:/students/" + studentId;
    }

    @RequestMapping(value = "/grade", method = RequestMethod.POST)
    public String updateGrade(@RequestParam Long studentId, 
                             @RequestParam Long courseId,
                             @RequestParam String grade,
                             RedirectAttributes redirectAttributes) {
        try {
            studentCourseService.updateGrade(studentId, courseId, grade);
            redirectAttributes.addFlashAttribute("successMessage", "Grade updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating grade: " + e.getMessage());
        }
        return "redirect:/enrollments/student/" + studentId;
    }
}