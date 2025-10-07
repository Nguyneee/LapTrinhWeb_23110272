package com.example.websocketchat.controller;

import com.example.websocketchat.dto.ChatMessageDTO;
import com.example.websocketchat.entity.User;
import com.example.websocketchat.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class WebController {

    @Autowired
    private ChatService chatService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/customer")
    public String customerChat() {
        return "customer";
    }

    @GetMapping("/support")
    public String supportChat() {
        return "support";
    }

    @GetMapping("/api/chat/history/{chatRoom}")
    @ResponseBody
    public ResponseEntity<List<ChatMessageDTO>> getChatHistory(@PathVariable String chatRoom) {
        List<ChatMessageDTO> messages = chatService.getChatHistory(chatRoom);
        return ResponseEntity.ok(messages);
    }

    @GetMapping("/api/users/online")
    @ResponseBody
    public ResponseEntity<List<User>> getOnlineUsers() {
        List<User> onlineUsers = chatService.getOnlineUsers();
        return ResponseEntity.ok(onlineUsers);
    }

    @GetMapping("/api/users/support-agents")
    @ResponseBody
    public ResponseEntity<List<User>> getSupportAgents() {
        List<User> supportAgents = chatService.getSupportAgents();
        return ResponseEntity.ok(supportAgents);
    }
}
