package com.demo.inout.web.hist.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HistController {
    
    @GetMapping(value="/hist")
    public String histController(HttpServletRequest request) {
        return "web/hist/hist";
    }
    
}
