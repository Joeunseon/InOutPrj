package com.demo.inout.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {
    
    /** logger */
    private final Log logger = LogFactory.getLog(getClass());
    
    /**
     * Web 페이지 (초기 진입 및 로그인페이지)
     */
    @GetMapping(value = {"/", "/login"})
    public String login(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
        
        if ( request != null ) {
            
        }
        
        /** 로그인 페이지 */
        return "web/login/login";
    }
}
