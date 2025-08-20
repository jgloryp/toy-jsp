package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.sql.DataSource;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

@Controller
public class HealthController {

    @Autowired
    private DataSource dataSource;

    @RequestMapping(value = "/health", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> health() {
        Map<String, Object> health = new HashMap<>();
        
        try {
            // Database connection test
            Connection connection = dataSource.getConnection();
            health.put("database", "UP");
            health.put("database_url", connection.getMetaData().getURL());
            connection.close();
        } catch (Exception e) {
            health.put("database", "DOWN");
            health.put("database_error", e.getMessage());
        }
        
        // Application status
        health.put("application", "UP");
        health.put("timestamp", System.currentTimeMillis());
        
        return health;
    }
}