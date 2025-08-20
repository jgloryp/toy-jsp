package com.example.controller;

import com.example.model.Department;
import com.example.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/departments")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String list(Model model) {
        List<Department> departments = departmentService.findAll();
        model.addAttribute("departments", departments);
        return "departments/list";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String detail(@PathVariable Long id, Model model) {
        Department department = departmentService.findByIdWithStudents(id);
        if (department == null) {
            return "redirect:/departments";
        }
        model.addAttribute("department", department);
        return "departments/detail";
    }

    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public String createForm(Model model) {
        model.addAttribute("department", new Department());
        return "departments/form";
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public String create(@ModelAttribute Department department, 
                        RedirectAttributes redirectAttributes) {
        try {
            departmentService.save(department);
            redirectAttributes.addFlashAttribute("successMessage", "Department created successfully!");
            return "redirect:/departments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating department: " + e.getMessage());
            return "redirect:/departments/new";
        }
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
    public String editForm(@PathVariable Long id, Model model) {
        Department department = departmentService.findById(id);
        if (department == null) {
            return "redirect:/departments";
        }
        model.addAttribute("department", department);
        return "departments/form";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    public String update(@PathVariable Long id, 
                        @ModelAttribute Department department,
                        RedirectAttributes redirectAttributes) {
        try {
            department.setId(id);
            departmentService.save(department);
            redirectAttributes.addFlashAttribute("successMessage", "Department updated successfully!");
            return "redirect:/departments/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating department: " + e.getMessage());
            return "redirect:/departments/" + id + "/edit";
        }
    }

    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            departmentService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Department deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting department: " + e.getMessage());
        }
        return "redirect:/departments";
    }
}