package com.cnasoft.acr_demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {
    @GetMapping
    public long getTime(){
        return System.currentTimeMillis();
    }
}
