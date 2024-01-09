package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.demo.entity.Plan;
import com.example.demo.repository.PlanRepository;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/plans")
@CrossOrigin
public class PlanController {

	@Autowired
	private PlanRepository planRepository;

	@PostMapping("/create")
	public ResponseEntity<Integer> createPlan(@RequestBody Plan plan) {

		Plan savedPlan = planRepository.save(plan);

		if (savedPlan != null && savedPlan.getId() > 0) {
			return ResponseEntity.ok(savedPlan.getId());
		} else {
			return ResponseEntity.badRequest().body(-1); 
		}
	}

	@GetMapping("/get-user-plans/{userId}")
	public ResponseEntity<List<Plan>> getUserPlans(@PathVariable int userId) {
		List<Plan> allPlans = planRepository.findAll();
		List<Plan> userPlans = new ArrayList<>();

		for (Plan plan : allPlans) {
			if (plan.getUserid() == userId) {
				userPlans.add(plan);
			}
		}

		if (!userPlans.isEmpty()) {
			return ResponseEntity.ok(userPlans);
		} else {
			return ResponseEntity.notFound().build(); 
		}
	}

}
