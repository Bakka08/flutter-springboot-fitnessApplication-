package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.Support;

public interface SupportRepository extends JpaRepository<Support, Integer> {

	List<Support> findAll();

	Support findById(int id);

	Support findByEmail(String email);

}