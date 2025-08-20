package com.example.controller;

import com.example.model.Course;
import com.example.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/courses")
public class CourseController {

    @Autowired
    private CourseService courseService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String list(Model model) {
        List<Course> courses = courseService.findAll();
        model.addAttribute("courses", courses);
        return "courses/list";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String detail(@PathVariable Long id, Model model) {
        Course course = courseService.findByIdWithStudents(id);
        if (course == null) {
            return "redirect:/courses";
        }
        model.addAttribute("course", course);
        return "courses/detail";
    }

    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("course", new Course());
        return "courses/form";
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public String create(@ModelAttribute Course course, 
                        RedirectAttributes redirectAttributes) {
        try {
            // Check if code already exists
            if (courseService.isCodeExists(course.getCode(), null)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Course code already exists!");
                return "redirect:/courses/new";
            }
            
            courseService.save(course);
            redirectAttributes.addFlashAttribute("successMessage", "Course created successfully!");
            return "redirect:/courses";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating course: " + e.getMessage());
            return "redirect:/courses/new";
        }
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
    public String editForm(@PathVariable Long id, Model model) {
        Course course = courseService.findById(id);
        if (course == null) {
            return "redirect:/courses";
        }
        model.addAttribute("course", course);
        return "courses/form";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public String update(@PathVariable Long id, 
                        @ModelAttribute Course course,
                        RedirectAttributes redirectAttributes) {
        try {
            // Check if code already exists (excluding current course)
            if (courseService.isCodeExists(course.getCode(), id)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Course code already exists!");
                return "redirect:/courses/" + id + "/edit";
            }
            
            course.setId(id);
            courseService.save(course);
            redirectAttributes.addFlashAttribute("successMessage", "Course updated successfully!");
            return "redirect:/courses/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating course: " + e.getMessage());
            return "redirect:/courses/" + id + "/edit";
        }
    }

    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            courseService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Course deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting course: " + e.getMessage());
        }
        return "redirect:/courses";
    }
}