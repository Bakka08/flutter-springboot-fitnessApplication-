package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.Chat;
import com.example.demo.entity.User;

public interface ChatRepository extends JpaRepository<Chat, Integer> {

	User findById(int id);

	

}
