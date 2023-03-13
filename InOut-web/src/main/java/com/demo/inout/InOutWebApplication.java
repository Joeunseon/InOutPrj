package com.demo.inout;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class InOutWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(InOutWebApplication.class, args);
	}

}
