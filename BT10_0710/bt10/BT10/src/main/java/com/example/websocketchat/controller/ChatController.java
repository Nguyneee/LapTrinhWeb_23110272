package com.example.websocketchat.controller;

import com.example.websocketchat.dto.ChatMessageDTO;
import com.example.websocketchat.entity.ChatMessage;
import com.example.websocketchat.entity.User;
import com.example.websocketchat.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
public class ChatController {

    @Autowired
    private ChatService chatService;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatMessageDTO sendMessage(@Payload ChatMessageDTO chatMessage) {
        // Save message to database
        ChatMessage savedMessage = chatService.saveMessage(chatMessage);
        
        // Set timestamp for response
        chatMessage.setTimestamp(savedMessage.getCreatedAt().format(formatter));
        
        return chatMessage;
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public ChatMessageDTO addUser(@Payload ChatMessageDTO chatMessage,
                                  SimpMessageHeaderAccessor headerAccessor) {
        // Add username in web socket session
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        headerAccessor.getSessionAttributes().put("role", chatMessage.getSenderRole());
        
        // Create or get user
        chatService.createOrGetUser(
            chatMessage.getSender(), 
            chatMessage.getSender(), 
            chatMessage.getSenderRole()
        );
        
        // Set user online
        chatService.setUserOnlineStatus(chatMessage.getSender(), true);
        
        // Set message type and timestamp
        chatMessage.setMessageType(ChatMessage.MessageType.JOIN);
        chatMessage.setTimestamp(LocalDateTime.now().format(formatter));
        
        return chatMessage;
    }

    @MessageMapping("/chat.privateMessage")
    public void sendPrivateMessage(@Payload ChatMessageDTO chatMessage) {
        // Save message to database
        ChatMessage savedMessage = chatService.saveMessage(chatMessage);
        
        // Set timestamp
        chatMessage.setTimestamp(savedMessage.getCreatedAt().format(formatter));
        
        // Send to specific chat room
        messagingTemplate.convertAndSend("/topic/chat/" + chatMessage.getChatRoom(), chatMessage);
    }
}
