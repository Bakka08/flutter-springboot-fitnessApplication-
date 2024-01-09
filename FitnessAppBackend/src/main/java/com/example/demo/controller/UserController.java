package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.idao.PasswordHash;
import com.example.demo.repository.UserRepository;
import com.example.demo.requests.LoginRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@RestController
@RequestMapping("/users")
@CrossOrigin
public class UserController {

	@Autowired
	private UserRepository userRepository;

	@PostMapping("/signup")
	public ResponseEntity<Integer> signUp(@RequestBody User user) {
		// Hash the password before saving
		String hashedPassword = PasswordHash.generateHash(user.getPassword());
		user.setPassword(hashedPassword);

		// Save the user and return the user ID
		User savedUser = userRepository.save(user);

		// Check if the user was saved successfully
		if (savedUser != null && savedUser.getId() > 0) {
			return ResponseEntity.ok(savedUser.getId());
		} else {
			return ResponseEntity.badRequest().body(-1); // Failed to save user or invalid user ID
		}
	}

	@PostMapping("/login")
	public ResponseEntity<Integer> login(@RequestBody LoginRequest loginRequest) {
		User user = userRepository.findByEmail(loginRequest.getEmail());

		if (user != null) {
			String hashedRequestPassword = PasswordHash.generateHash(loginRequest.getPassword());
			if (hashedRequestPassword != null && hashedRequestPassword.equals(user.getPassword())) {
				return ResponseEntity.ok(user.getId());
			}
		}

		return ResponseEntity.badRequest().body(-1);
	}

	@PutMapping("/update-goal/{userId}/{goal}")
    public ResponseEntity<String> updateGoal(@PathVariable int userId, @PathVariable String goal) {
        User user = userRepository.findById(userId);

        if (user != null) {
            user.setGoal(goal);
            userRepository.save(user);
            return ResponseEntity.ok("Goal updated successfully");
        }

        return ResponseEntity.badRequest().body("User not found");
    }

    @PutMapping("/update-age/{userId}/{age}")
    public ResponseEntity<String> updateAge(@PathVariable int userId, @PathVariable int age) {
        User user = userRepository.findById(userId);

        if (user != null) {
            user.setAge(age);
            userRepository.save(user);
            return ResponseEntity.ok("Age updated successfully");
        }

        return ResponseEntity.badRequest().body("User not found");
    }

    @PutMapping("/update-weight/{userId}/{weight}")
    public ResponseEntity<String> updateWeight(@PathVariable int userId, @PathVariable float weight) {
        User user = userRepository.findById(userId);

        if (user != null) {
            user.setWeight(weight);
            userRepository.save(user);
            return ResponseEntity.ok("Weight updated successfully");
        }

        return ResponseEntity.badRequest().body("User not found");
    }

    @PutMapping("/update-height/{userId}/{height}")
    public ResponseEntity<String> updateHeight(@PathVariable int userId, @PathVariable float height) {
        User user = userRepository.findById(userId);

        if (user != null) {
            user.setHeight(height);
            userRepository.save(user);
            return ResponseEntity.ok("Height updated successfully");
        }

        return ResponseEntity.badRequest().body("User not found");
    }

    @PutMapping("/update-activity-level/{userId}/{activityLevel}")
    public ResponseEntity<String> updateActivityLevel(@PathVariable int userId, @PathVariable int activityLevel) {
        User user = userRepository.findById(userId);

        if (user != null) {
            user.setActivitylevel(activityLevel);
            userRepository.save(user);
            return ResponseEntity.ok("Activity level updated successfully");
        }

        return ResponseEntity.badRequest().body("User not found");
    }

    @PutMapping("/update-gender/{userId}/{gender}")
    public ResponseEntity<String> updateGender(@PathVariable int userId, @PathVariable String gender) {
        User user = userRepository.findById(userId);

        if (user != null) {
            user.setGender(gender);
            userRepository.save(user);
            return ResponseEntity.ok("Gender updated successfully");
        }

        return ResponseEntity.badRequest().body("User not found");
    }

    @GetMapping("/get-macro/{userId}")
    public ResponseEntity<String> getMacro(@PathVariable int userId) {
        User user = userRepository.findById(userId);

        if (user != null && user.getAge() > 0 && user.getGender() != null && user.getHeight() > 0.0
                && user.getWeight() > 0.0 && user.getActivitylevel() > 0 && user.getGoal() != null) {

            String apiKey = "b2cc6e6436mshc704214ed1fdf01p160953jsn6478dd86608a";
            String apiUrl = "https://fitness-calculator.p.rapidapi.com/macrocalculator";

            // Build the URI for the external API using user information
            URI uri = URI.create(apiUrl + "?age=" + user.getAge() + "&gender=" + user.getGender() + "&height="
                    + user.getHeight() + "&weight=" + user.getWeight() + "&activitylevel=" + user.getActivitylevel()
                    + "&goal=" + user.getGoal());

            // Create the HttpRequest
            HttpRequest request = HttpRequest.newBuilder().uri(uri).header("X-RapidAPI-Key", apiKey)
                    .header("X-RapidAPI-Host", "fitness-calculator.p.rapidapi.com")
                    .method("GET", HttpRequest.BodyPublishers.noBody()).build();

            try {
                // Send the request and get the response
                HttpResponse<String> response = HttpClient.newHttpClient().send(request,
                        HttpResponse.BodyHandlers.ofString());

                // Parse the response JSON and return only the "balanced" data
                // You may want to use a JSON library (e.g., Jackson, Gson) for better handling
                String responseBody = response.body();
                // Extract the "balanced" data from the response
                // For simplicity, this example returns the entire response body
                return ResponseEntity.ok(responseBody);

            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
                return ResponseEntity.badRequest().body("Error fetching macro data");
            }
        }

        return ResponseEntity.badRequest().body("User or user details not found");
    }
    
    @GetMapping("/get-full-name/{userId}")
    public ResponseEntity<String> getFullName(@PathVariable int userId) {
        User user = userRepository.findById(userId);

        if (user != null) {
            String fullName = user.getFullname();
            return ResponseEntity.ok(fullName);
        }

        return ResponseEntity.badRequest().body("User not found");
    }

    @PutMapping("/update-password/{userId}/{oldPassword}/{newPassword}")
    public ResponseEntity<String> updatePassword(@PathVariable int userId, @PathVariable String oldPassword, @PathVariable String newPassword) {
        User user = userRepository.findById(userId);

        if (user != null) {
            // Verify the old password before updating
            String hashedOldPassword = PasswordHash.generateHash(oldPassword);
            if (hashedOldPassword != null && hashedOldPassword.equals(user.getPassword())) {
                // Hash and update the new password
                String hashedNewPassword = PasswordHash.generateHash(newPassword);
                user.setPassword(hashedNewPassword);

                userRepository.save(user);
                return ResponseEntity.ok("Password updated successfully");
            } else {
                return ResponseEntity.badRequest().body("Incorrect old password");
            }
        }

        return ResponseEntity.badRequest().body("User not found");
    }

}
