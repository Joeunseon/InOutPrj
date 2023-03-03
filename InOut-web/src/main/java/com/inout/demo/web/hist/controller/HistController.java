package com.inout.demo.web.hist.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class HistController {
    
    /**
     * hist
     * @param request
     * @param response
     * @return string
     */
    @GetMapping("/hist")
    public String getHist(HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session) {
        
        return "";
    }
}
