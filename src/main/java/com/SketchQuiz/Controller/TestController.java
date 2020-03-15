package com.SketchQuiz.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.SketchQuiz.Service.TestService;

@Controller
public class TestController {
	
	@Autowired
	TestService service;
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public ModelAndView test(ModelAndView model) {
		model.setViewName("index");
		service.test();
		return model;
	}
}
