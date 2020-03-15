package com.SketchQuiz.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.SketchQuiz.Dao.TestDao;

@Service
public class TestService {
	@Autowired
	TestDao dao;
	
	
	public void test() {
		System.out.println(dao.test());
	}
}
