package com.example.demo.controller;

import com.example.demo.entity.Chat;
import com.example.demo.entity.Support;
import com.example.demo.entity.User;
import com.example.demo.repository.ChatRepository;
import com.example.demo.repository.SupportRepository;
import com.example.demo.repository.UserRepository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/chats")
@CrossOrigin
public class ChatController {

	@Autowired
	private ChatRepository chatRepository;

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private SupportRepository supportRepository;

	// API to create a chat
	@PostMapping("/create/user")
	public ResponseEntity<String> createChatuser(@RequestBody Chat chatRequest) {
		// Assuming ChatRequest is a DTO class with necessary fields
		// You can validate and process the request, then save the chat
		User sender = userRepository.findById(chatRequest.getSender());
		Support receiver = supportRepository.findById(chatRequest.getReceiver());
		if (sender != null && receiver != null) {
			Chat chat = new Chat(chatRequest.getData(), chatRequest.getSender(), chatRequest.getReceiver());
			chatRepository.save(chat);
			return new ResponseEntity<>("Chat created successfully", HttpStatus.CREATED);
		} else {
			return new ResponseEntity<>("Invalid sender or receiver ", HttpStatus.BAD_REQUEST);
		}
	}

	// API to create a chat
	@PostMapping("/create/support")
	public ResponseEntity<String> createChatsupport(@RequestBody Chat chatRequest) {
		// Assuming ChatRequest is a DTO class with necessary fields
		// You can validate and process the request, then save the chat
		Support sender = supportRepository.findById(chatRequest.getSender());
		User receiver = userRepository.findById(chatRequest.getReceiver());
		if (sender != null && receiver != null) {
			Chat chat = new Chat(chatRequest.getData(), chatRequest.getSender(), chatRequest.getReceiver());
			chatRepository.save(chat);
			return new ResponseEntity<>("Chat created successfully", HttpStatus.CREATED);
		} else {
			return new ResponseEntity<>("Invalid sender or receiver ", HttpStatus.BAD_REQUEST);
		}
	}

	// API to get all chats for a user
	@GetMapping("/user/{userId}")
	public ResponseEntity<List<Chat>> getUserChats(@PathVariable int userId) {
		User user = userRepository.findById(userId);
		if (user != null) {
			List<Chat> allChats = chatRepository.findAll();
			List<Chat> userChats = new ArrayList<>();

			for (Chat chat : allChats) {
				// Check if the user is the sender or receiver in the chat
				if (chat.getSender() == user.getId() || chat.getReceiver() == user.getId()) {
					userChats.add(chat);
				}
			}

			return new ResponseEntity<>(userChats, HttpStatus.OK);
		}
		return null;
	}

}