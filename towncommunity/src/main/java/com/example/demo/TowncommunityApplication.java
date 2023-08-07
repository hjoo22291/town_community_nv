package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = "com.example.demo")
@ComponentScan(basePackages = "Controller")
@ComponentScan(basePackages = "Dao")
@ComponentScan(basePackages = "Dto")
@ComponentScan(basePackages = "Service")
@ComponentScan(basePackages = "ServiceImpl")
@ComponentScan(basePackages = "Websocket")
@MapperScan(basePackages = "Dao")
@SpringBootApplication
public class TowncommunityApplication {

	public static void main(String[] args) {
		SpringApplication.run(TowncommunityApplication.class, args);
	}

}
